From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 1 Jul 2014 15:42:56 +0800
Subject: [PATCH 0/5] ARM: Centralize the access to the SCU register
In-Reply-To: <53ACA62F.1090802@free-electrons.com>
References: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>
 <CAL_JsqL9w0oxxM0zTAVioh0Uf3PNO3TfhxzOLV6KhBOoS4Fdiw@mail.gmail.com>
 <53ACA62F.1090802@free-electrons.com>
Message-ID: <20140701074255.GF14471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 01:01:03AM +0200, Gregory CLEMENT wrote:
> >> The last patch removed a direct access to the SCU register by an
> >> access through the new scu_standby_enable() function. For this one I
> >> have just checked that the kernel can be built using the
> >> imx_v6_v7_defconfig config, but I didn't test it on an imx6 hardware.
> > 
> > Why would we not just turn on these 2 features unconditionally? If we
> 
> You mean in scu_enbale() ?
> 
> > don't know of any platform where they are broken, then we should just
> 
> At least on some imx6 SCU standby is broken according to the code and
> the comments.

Hi Gregory,

What's broken on particular revisions of some i.MX6 SoC is WAIT mode
support, not SCU standby.  I think the SCU standby can just be
unconditionally enabled in scu_enbale().

Shawn
