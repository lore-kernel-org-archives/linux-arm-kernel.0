From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 26 Jan 2015 04:07:18 +0000
Subject: [PATCH] ARM: shmobile: Select CONFIG_REGULATOR in defconfig once
 again
In-Reply-To: <20150126035942.GC1215@verge.net.au>
References: <1422239176-978-1-git-send-email-horms+renesas@verge.net.au>
 <878ugqb7al.wl%kuninori.morimoto.gx@renesas.com>
 <20150126035942.GC1215@verge.net.au>
Message-ID: <87386yb2vl.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > > eb4513482d1c4882e3633528ccc48d77581b7bb1
> > > (ARM: shmobile: Enable kzm9g board in multiplatform defconfig)
> > > dropped CONFIG_REGULATOR from shmobile_defconfig as it was
> > > generated using a tree where CONFIG_REGULATOR is indirectly
> > > selected by ARCH_SH73A0.
> > > 
> > > ARCH_SH73A0 is not queued up for v3.20 and thus, baring unforeseen
> > > changes, CONFIG_REGULATOR will not be selected by shmobile_defconfig
> > > in that release. This causes at least SDHI to stop working on
> > > R-Car Gen2 SoCs.
> > > 
> > > Reported-by: Magnus Damm <damm+renesas@opensource.se>
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > [horms: minimal patch targeted as a fix]
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > >  arch/arm/configs/shmobile_defconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> 
> For the record, this patch is based on
> renesas-next-20150122-v3.19-rc1.

Thank you

> > > diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> > > index 4f9868d..b553e2c 100644
> > > --- a/arch/arm/configs/shmobile_defconfig
> > > +++ b/arch/arm/configs/shmobile_defconfig
> > > @@ -118,6 +118,7 @@ CONFIG_WATCHDOG=y
> > >  CONFIG_DA9063_WATCHDOG=y
> > >  CONFIG_MFD_AS3711=y
> > >  CONFIG_MFD_DA9063=y
> > > +CONFIG_REGULATOR=y
> > >  CONFIG_REGULATOR_AS3711=y
> > >  CONFIG_REGULATOR_DA9210=y
> > >  CONFIG_REGULATOR_GPIO=y
> > 
> > Oh.. Thank you for your help
> > (I have sent other question mail)
> > It looks good :)
> 
> Thanks. I have tried to address your questions in an answer to your
> other email. Can you confirm me know if the above patch is ok for you or not.
> I'd like to get this one right :)

It OK in my quick check
Thank you

Best regards
---
Kuninori Morimoto
