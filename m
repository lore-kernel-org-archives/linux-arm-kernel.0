From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 9 Jan 2017 20:17:03 +0200
Subject: [PATCH 0/4] ARM: exynos: Fix Odroid U3 USB/LAN when TFTP booting
 (power sequence)
In-Reply-To: <CANAwSgSEZvxHje65Kk13fvD9NZGB+iHCJtoGJdQrUdS42ei_WA@mail.gmail.com>
References: <20170107085203.4431-1-krzk@kernel.org>
 <CANAwSgSEZvxHje65Kk13fvD9NZGB+iHCJtoGJdQrUdS42ei_WA@mail.gmail.com>
Message-ID: <20170109181703.436gv7bq76xuv35q@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 11:34:48PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> On 7 January 2017 at 14:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Hi,
> >
> > Thanks to Markus Reichl, I got an Odroid U3 to work with. Thanks to Peter
> > Chen, we got a power sequence generic library which solves my long
> > standing Odroid U3 problem - no LAN9730 if it was enabled by bootloader.
> >
> > My previous attempts for this can be found here [0].
> >
> > This patchset is based on Peter's v11 of power sequence [1].
> > Patchset is available also on my Github [2].
> >
> > More detailed analysis is described in patch 2/4 ("ARM: dts: exynos: Fix
> > LAN9730 on Odroid U3 after tftpboot").
> >
> >
> 
> [snip]
> 
> On which u-boot should this be tested.
> 
> On HK u-boot tftp boot is not supported.

... so you gave an answer: you cannot test it on HK. How many other
U-Boot flavors you know? :)

Best regards,
Krzysztof


> ----------------------------------------------------------
> U-Boot 2010.12-00000-g9777ca6-dirty (Nov 26 2015 - 10:10:11) for Exynox4412
> 
> 
> CPU: S5PC220 [Samsung SOC on SMP Platform Base on ARM CortexA9]
> APLL = 1000MHz, MPLL = 800MHz
> DRAM:  2 GiB
> 
> PMIC VERSION : 0x00, CHIP REV : 2
> TrustZone Enabled BSP
> BL1 version: 20121128
> 
> 
> Checking Boot Mode ... SDMMC
> MMC Device 0: 14804 MB
> MMC Device 1 not found
> *** Warning - using default environment
> 
> USB3503 NINT = OUTPUT LOW!
> ModeKey Check... run normal_boot
> No ethernet found.
> Hit any key to stop autoboot:  0
> Exynos4412 #
> Exynos4412 #
> Exynos4412 #
> Exynos4412 # usb start
> (Re)start USB...
> USB0:   Exynos4412-ehci: init hccr 12580000 and hcor 12580010 hc_length 16
> usb: usb_refclk_enable is active low: NO
> ProTIP: If usb doesn't work - try playing with 'usb_invert_clken' environment
> USB EHCI 1.00
> scanning bus 0 for devices... EHCI timed out on TD - token=0x80008c80
> EHCI fail timeout STS_ASS set
> 
>       USB device not accepting new address (error=80000000)
> EHCI fail timeout STS_ASS set
> 1 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
>        scanning usb for ethernet devices... 0 Ethernet Device(s) found
> Exynos4412 #
> 
> Best Regards
> -Anand
