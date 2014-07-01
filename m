From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Jul 2014 14:35:39 +0200
Subject: [PATCH 08/17] ARM: S5PC100: no more support S5PC100 SoC
In-Reply-To: <03ef01cf9526$83e93b70$8bbbb250$@samsung.com>
References: <1404210076-2362-1-git-send-email-kgene.kim@samsung.com>
 <5806444.UHVgoFeOY3@wuerfel> <03ef01cf9526$83e93b70$8bbbb250$@samsung.com>
Message-ID: <5607904.sLYTrVXTVU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 21:18:07 Kukjin Kim wrote:
> > 
> > >  config SAMSUNG_DMADEV
> > >        bool "Use legacy Samsung DMA abstraction"
> > > -       depends on CPU_S5PV210 || CPU_S5PC100 || ARCH_S3C64XX
> > > +       depends on CPU_S5PV210 || ARCH_S3C64XX
> > >         select DMADEVICES
> > >         default y
> > >        help
> > 
> > It would be good to just kill this one off now, as nothing uses it
> > any more, but that's also a separate patch.
> > 
> Maybe it is still used for s5pv210 and s3c64xx? If I misunderstand your
> comments, please kindly let me know.

samsung-dmadev used to be used in a number of device drivers, but I believe
they have all been converted to using dmaengine interfaces now.

	Arnd
