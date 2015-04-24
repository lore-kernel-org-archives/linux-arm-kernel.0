From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 24 Apr 2015 14:28:41 +0200
Subject: [PATCH] ARM: dts: imx6: Add Embest MarS Board
In-Reply-To: <CABH3fy_YWYoQZL4E_i1FWaY+rOgidxBVcUNo15GrXfcoS2or0A@mail.gmail.com>
References: <1427875809-10444-1-git-send-email-vianney.leclement@essensium.com>
 <1427876156.24886.1.camel@pengutronix.de>
 <1427877126.2449.0@mail.essensium.com>
 <CABH3fy_YWYoQZL4E_i1FWaY+rOgidxBVcUNo15GrXfcoS2or0A@mail.gmail.com>
Message-ID: <1429878521.2872.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

This may as well be a signaling issue. You could try to slow down the
the MMC bus speed or play a bit with the pin drive strength values. Note
that in those cases _reducing_ the drive strength may be the right thing
to do.

Regards,
Lucas

Am Freitag, den 24.04.2015, 15:22 +0300 schrieb Catalin Crenguta:
> This is still not working on 4.0 with this devicetree and eMMC enabled.
> 
> [    1.467617] Driver 'mmcblk' needs updating - please use bus_type methods
> [    1.474581] sdhci: Secure Digital Host Controller Interface driver
> [    1.480776] sdhci: Copyright(c) Pierre Ossman
> [    1.485229] sdhci-pltfm: SDHCI platform and OF driver helper
> [    1.491920] sdhci-esdhc-imx 2194000.usdhc: could not get ultra high
> speed state, work on normal mode
> [    1.502624] sdhci-esdhc-imx 2194000.usdhc: No vqmmc regulator found
> [    1.553863] mmc0: SDHCI controller on 2194000.usdhc [2194000.usdhc]
> using ADMA
> [    1.562020] sdhci-esdhc-imx 2198000.usdhc: could not get ultra high
> speed state, work on normal mode
> [    1.572519] sdhci-esdhc-imx 2198000.usdhc: No vqmmc regulator found
> [    1.623290] mmc1: SDHCI controller on 2198000.usdhc [2198000.usdhc]
> using ADMA
> [    1.632466] usbcore: registered new interface driver usbhid
> [    1.638080] usbhid: USB HID core driver
> [    1.648923] TCP: cubic registered
> [    1.653864] NET: Registered protocol family 10
> [    1.661093] sit: IPv6 over IPv4 tunneling driver
> [    1.667826] NET: Registered protocol family 17
> [    1.672323] can: controller area network core (rev 20120528 abi 9)
> [    1.678754] NET: Registered protocol family 29
> [    1.683259] can: raw protocol (rev 20120528)
> [    1.683659] usb 1-1: new high-speed USB device number 2 using ci_hdrc
> [    1.694117] can: broadcast manager protocol (rev 20120528 t)
> [    1.699821] can: netlink gateway (rev 20130117) max_hops=1
> [    1.705994] Key type dns_resolver registered
> [    1.715425] Registering SWP/SWPB emulation handler
> [    1.728171] snvs_rtc 20cc034.snvs-rtc-lp: setting system clock to
> 1970-01-01 00:00:00 UTC (0)
> [    1.773338] usb_otg_vbus: disabling
> [    1.776858] 2P5V: disabling
> [    1.780066] ALSA device list:
> [    1.783043]   No soundcards found.
> [    1.787866] Waiting for root device /dev/mmcblk0p1...
> [    1.836367] hub 1-1:1.0: USB hub found
> [    1.840349] hub 1-1:1.0: 4 ports detected
> [    1.879136] mmc1: MAN_BKOPS_EN bit is not set
> [    1.893823] mmc1: new high speed MMC card at address 0001
> [    1.901285] mmcblk0: mmc1:0001 NCard  3.71 GiB
> [    1.906172] mmcblk0boot0: mmc1:0001 NCard  partition 1 2.00 MiB
> [    1.912424] mmcblk0boot1: mmc1:0001 NCard  partition 2 2.00 MiB
> [    1.918676] mmcblk0rpmb: mmc1:0001 NCard  partition 3 128 KiB
> [    1.928406]  mmcblk0: p1
> [   12.033443] mmc1: Timeout waiting for hardware interrupt.
> [   12.039193] mmcblk0: error -110 transferring data, sector 20482, nr
> 2, cmd response 0x900, card status 0xb00
> [   12.049118] mmc1: tried to reset card
> [   12.052804] mmcblk0: retrying using single block read
> [   22.073257] mmc1: Timeout waiting for hardware interrupt.
> [   22.078969] mmcblk0: error -110 transferring data, sector 20480, nr
> 8, cmd response 0x900, card status 0xb00
> [   22.088897] mmc1: tried to reset card
> [   22.092585] mmcblk0: retrying using single block read
> [   22.100654] EXT3-fs (mmcblk0p1): error: magic mismatch
> [   32.113294] mmc1: Timeout waiting for hardware interrupt.
> [   32.119153] mmcblk0: error -110 transferring data, sector 20482, nr
> 2, cmd response 0x900, card status 0xb00
> [   32.129070] mmc1: tried to reset card
> [   32.132758] mmcblk0: retrying using single block read
> [   32.138719] EXT2-fs (mmcblk0p1): error: couldn't mount because of
> unsupported optional features (4)
> 
> On Wed, Apr 1, 2015 at 11:32 AM, Vianney le Cl?ment
> <vianney.leclement@essensium.com> wrote:
> > On Wed, Apr 1, 2015 at 10:15 , Lucas Stach <l.stach@pengutronix.de> wrote:
> >>
> >> Am Mittwoch, den 01.04.2015, 10:10 +0200 schrieb Vianney le Cl?ment de
> >> Saint-Marcq:
> >>>
> >>>  Add device tree for the Embest/Element 14 MarS Board [1], an i.MX6 Dual
> >>>  based development board.
> >>>
> >>>  The e-MMC chip is disabled because initialization fails (error -110).
> >>>  A possible cause is described in [2].
> >>
> >>
> >> So if the problem is that there are only 4 connected data lines one the
> >> board, couldn't you simply add the property bus-width = <4>; to the emmc
> >> node?
> >
> >
> > It is already the case (imx6qdl.dtsi, line 929), but to no avail.  That is
> > why I wrote "possible" cause as I did not find any evidence of the described
> > behaviour in my (admittedly limited) investigations.
> >
> >
> > Vianney le Cl?ment de Saint-Marcq
> > Embedded Software Developper ? +32 485 84 55 05
> > Essensium, Mind division ? www.mind.be
> > GPG: 727B CFE9 355F 1B02 0820 EE1C 9042 3E07 A804 0316
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
