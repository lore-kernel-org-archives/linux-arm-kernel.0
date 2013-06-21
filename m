From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 20:44:26 +0200
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <CAD=GYpbhBAaSkMtcJaPtVpWar7AcW37QpAk3A0qgwX6G5PDoZg@mail.gmail.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <201306211632.12577.arnd@arndb.de>
 <CAD=GYpbhBAaSkMtcJaPtVpWar7AcW37QpAk3A0qgwX6G5PDoZg@mail.gmail.com>
Message-ID: <201306212044.26677.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Joel A Fernandes wrote:
> I think we are talking about different things, I agree the 'select
> DMADEVICES' can be dropped but lets please keep the default y option
> (not adding new select statements, just saying that if someone select
> DMADEVICES in menuconfig and if they're ARCH_OMAP=1 , then default to
> EDMA). This will simply allow people to have a default. Thanks.

Yes, that's ok.

Also, if the driver doesn't strictly depend on these platforms but
can build on anything, I would write it as

config TI_EDMA
        tristate "TI EDMA support"
        default m if 'ARCH_DAVINCI || ARCH_OMAP1 || ARCH_OMAP2
        select DMA_ENGINE
        select DMA_VIRTUAL_CHANNELS

	Arnd
