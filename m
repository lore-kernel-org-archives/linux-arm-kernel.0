From: dianders@chromium.org (Doug Anderson)
Date: Thu, 7 Aug 2014 14:17:24 -0700
Subject: [PATCH v4 3/4] ARM: dts: add rk3288 dwc2 controller support
In-Reply-To: <1407404095-3265-4-git-send-email-kever.yang@rock-chips.com>
References: <1407404095-3265-1-git-send-email-kever.yang@rock-chips.com>
 <1407404095-3265-4-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=WubCx0yn7FV_qpiW31hrOgaa4Qv0N7TdRyTtKshooYgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Thu, Aug 7, 2014 at 2:34 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
> rk3288 has two kind of usb controller, this add the dwc2 controller
> for otg and host1.
>
> Controller can works with usb PHY default setting and Vbus on.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>
> ---
>
> Changes in v4: None
> Changes in v3:
> - EHCI and HSIC move new for version 3.
>
> Changes in v2: None
>
>  arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

This looks good to me.  I haven't been able to personally test the OTG
port (since my board doesn't have vbus wired), but I've tested the
Host port.

I would request that you re-sort by base address (ignoring uart2,
which apparently is in the wrong place).  Please make sure you base
atop my patch that fixes the sort order of OHCI and EHCI.  I think
that's supposed to land any day now.

After changing the sort order:

Tested-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
