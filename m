From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Jul 2014 08:13:24 +0800
Subject: [PATCH 0/6] vf610: Add USB support
In-Reply-To: <cover.1405702442.git.stefan@agner.ch>
References: <cover.1405702442.git.stefan@agner.ch>
Message-ID: <20140722001322.GA6636@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 07:01:36PM +0200, Stefan Agner wrote:
> This patchset adds USB support for Vybrid VF610 SoC. It extends the
> clock framework to support the USB PHY cocks, extends the device
> tree files and adds support for the non-core registers in the
> usbmisc_imx driver.
> 
> This patchset needs the eSDHC length fix available in Shawn's
> for-next branch.
> 

Why it is related to USB patchset?

> The whole patchset proved to be working on a Colibri VF61. The
> first USB controller runs in peripheral mode. I could successfully
> use RNDIS, however with some stability issues: Suddenly the other
> side was not reachable anymore and the interface needed to brought
> down and back up again. I'm still investigating this.

Do you use ubuntu as host distribution? I find ubuntu will lost the
first connection for usb-ethernet-gadget(usb0) as network interface,
but once you re-config usb0 again (ifconfig usb0 ip up), it should work
and will not lose connection any more.

> 
> The second USB controller, running in USB host mode, showed no
> issues so far.
> 
> Stefan Agner (6):
>   ARM: dts: vf610: add USB PHY and controller
>   ARM: imx: clk-vf610: add USBPHY clocks
>   ARM: dts: vf610: Add usbmisc for non-core registers
>   chipidea: usbmisc_imx: Add USB support for VF610 SoCs
>   usb: phy: mxs: Add VF610 USB PHY support
>   ARM: dts: vf610-colibri: add USB support
> 
>  arch/arm/boot/dts/vf610-colibri.dts     | 10 +++++
>  arch/arm/boot/dts/vf610.dtsi            | 55 ++++++++++++++++++++++--
>  arch/arm/mach-imx/clk-vf610.c           | 12 +++++-
>  drivers/usb/chipidea/usbmisc_imx.c      | 76 +++++++++++++++++++++++----------
>  drivers/usb/phy/phy-mxs-usb.c           |  5 +++
>  include/dt-bindings/clock/vf610-clock.h |  5 ++-
>  6 files changed, 135 insertions(+), 28 deletions(-)
> 
> -- 
> 2.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
