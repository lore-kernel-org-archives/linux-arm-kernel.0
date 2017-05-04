From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Thu, 4 May 2017 10:57:46 +0000
Subject: [PATCH 0/3] Add eSDHC UHS-I/HS200 mode support for
 ls1012a/ls1046a/ls208xa
In-Reply-To: <20170503131408.GC24392@dragon>
References: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
 <20170503131408.GC24392@dragon>
Message-ID: <DB6PR0401MB2536617B412E3B469BA0CE23F8EA0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Wednesday, May 03, 2017 9:14 PM
> To: Y.B. Lu
> Cc: linux-arm-kernel at lists.infradead.org; ulf.hansson at linaro.org; Catalin
> Marinas; Xiaobo Xie
> Subject: Re: [PATCH 0/3] Add eSDHC UHS-I/HS200 mode support for
> ls1012a/ls1046a/ls208xa
> 
> On Fri, Apr 21, 2017 at 11:52:33AM +0800, Yangbo Lu wrote:
> > This patch is to add eSDHC UHS-I/HS200 mode support for
> ls1012a/ls1046a/ls208xa.
> > Because eSDHC is not a standard SD controller, the specific speed mode
> > support depends on board's peripheral circuit for eSDHC. So, we have
> > to add these speed modes support on board dts file.
> >
> > In additon, these dts patches depends on esdhc driver patches which
> > just had been merged on mmc.git. Otherwise, the UHS-I SD card and eMMC
> > HS200 card would fail to be initialized, but other cards still could
> work fine.
> 
> So it sounds like just a new feature development which doesn't cause any
> regression, even if driver and dts changes are merged independently.
> For such case, we can just merge patches in their natural path separately.
> 

[Lu Yangbo-B47093] The dts patches affect cards which support uhs-i/hs200 modes.
Without driver patches, these card couldn't work. But they work on high speed mode on your current kernel.

Other legacy high speed cards always work fine.
I think it's ok to apply them now(affect uhs-i/hs200 cards, but legacy high speed cards work), or wait for driver patches pulled.

Thanks :)

> Shawn
