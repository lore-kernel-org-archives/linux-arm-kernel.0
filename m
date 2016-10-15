From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 15 Oct 2016 18:16:05 +0200 (CEST)
Subject: Low network throughput on i.MX28
In-Reply-To: <8C3BD5BA-252F-4A95-B938-50356A23974E@embedded.rocks>
References: <1476313753.2065.11.camel@embedded.rocks>
 <20161013084807.6a231fdb@ipc1.ka-ro>
 <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
 <20161014081349.1afb22c6@ipc1.ka-ro>
 <1476521171.1670.2.camel@embedded.rocks>
 <2131339088.8778.d47a56f6-921e-4d6c-9a5c-2e77bfd5d281.open-xchange@email.1und1.de>
 <8C3BD5BA-252F-4A95-B938-50356A23974E@embedded.rocks>
Message-ID: <2003579366.391192.0cc5acd0-af27-4ef7-892f-3c2dd86176ba.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> J?rg Krause <joerg.krause@embedded.rocks> hat am 15. Oktober 2016 um 11:41
> geschrieben:
> 
> 
> 
> 
> Hi Stefan,
> 
> Am 15. Oktober 2016 10:59:41 MESZ, schrieb Stefan Wahren
> <stefan.wahren@i2se.com>:
> >Hi J?rg,
> >
> >> J?rg Krause <joerg.krause@embedded.rocks> hat am 15. Oktober 2016 um
> >10:46
> >> geschrieben:
> >> 
> >> 
> >> Thanks!
> >> 
> >> 
> >> For the record:
> >> 
> >> Note, this is the result for the wireless interface.
> >> 
> >> I got one of my custom boards running the legacy Linux Kernel 2.6.35
> >> officially supported from Freescale (NXP) and the bcmdhd driver from
> >> the Wiced project, where I get >20Mbps TCP throughput. The firmware
> >> version reported is:
> >> 
> >> # wl ver
> >> 5.90 RC115.2
> >> wl0: Apr 24 2014 14:08:41 version 5.90.195.89.24 FWID 01-bc2d0891
> >> 
> >> 
> >> I got it also running with the Linux Kernel 4.1.15 from Freescale
> >[2],
> >> which is not officially supported for the i.MX28 target, with the
> >> latest bcmdhd version where I get <7Mbps TCP throughput (which is
> >much
> >> the same I get with the brcmfmac driver). The firmware version
> >reported
> >> is:
> >> 
> >> # wl ver
> >> 1.107 RC5.0
> >> wl0: Aug??8 2016 02:17:48 version 5.90.232 FWID 01-0
> >> 
> >> So, probably something is missing in the newer Kernel version, which
> >is
> >> present in the legacy Kernel 2.6.35.
> >> 
> >> [1]
> >http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=
> >> imx_2.6.35_1.1.0
> >> [2]
> >http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=
> >> imx_4.1.15_1.0.0_ga
> >
> >during implementation of DDR mode for the mmc driver [1] i noticed a
> >performance
> >gap between the vendor kernel and mainline by a factor of 2. I expect
> >that your
> >wireless interface is connected via SDIO.
> 
> Yes, it is. I had the suspicion that the MMC or the DMA driver is the
> bootleneck, too.
> 
> >
> >[1] -
> >http://linux-arm-kernel.infradead.narkive.com/GNkqjvo8/patch-rfc-0-3-mmc-mxs-mmc-implement-ddr-support
> 
> Looks like the patches might help.

Unfortunately not, the performance gain is smaller than expected.

> Have you tried SDIO wifi so far?

No.

> 
> J?rg
>
