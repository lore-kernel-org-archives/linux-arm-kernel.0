From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 Jun 2014 17:56:43 -0500
Subject: [PATCH 0/5] ARM: Centralize the access to the SCU register
In-Reply-To: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAL_JsqL9w0oxxM0zTAVioh0Uf3PNO3TfhxzOLV6KhBOoS4Fdiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 5:43 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hello,
>
> Following the feedback I go on the patch "ARM: mvebu: Enable SCU
> Speculative linefills to L2 for Armada 375/38x" :
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/335961/focus=335993
>
> I take the opportunity of adding new functions in smp_scu.c to
> centralize the other access done on the SCU register from C file in
> this file.
>
> The first patch is a preliminary clean-up in smp_scu.c.
>
> The second and the third patches add functions to manipulate the SCU
> control register.
>
> The forth patch use the new scu_spec_linefills_enable()
> function. Enabling SCU Speculative linefills to L2 for Armada 375/38x
> was the reason of this series.
>
> The last patch removed a direct access to the SCU register by an
> access through the new scu_standby_enable() function. For this one I
> have just checked that the kernel can be built using the
> imx_v6_v7_defconfig config, but I didn't test it on an imx6 hardware.

Why would we not just turn on these 2 features unconditionally? If we
don't know of any platform where they are broken, then we should just
enable them. We can add these functions only if necessary later.

Rob
