From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 14 Dec 2015 22:46:02 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Rockchip generic power
 domain.
In-Reply-To: <CAFqH_53DQ8GH+sq7PYeyDMT3qXJDBq+9P_4bCctMt_Sa_aXQBQ@mail.gmail.com>
References: <1450113435-32443-1-git-send-email-enric.balletbo@collabora.com>
 <CAFqH_53DQ8GH+sq7PYeyDMT3qXJDBq+9P_4bCctMt_Sa_aXQBQ@mail.gmail.com>
Message-ID: <2469375.zETa3aloK0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

defconfig changes are supposed to be applied by the armsoc maintainers, so you 
should probably also include arm at kernel.org as real "To"


Am Montag, 14. Dezember 2015, 18:22:15 schrieben Sie:
> cc'ing: Heiko Stuebner (rockchip maintainer)
> 
> 2015-12-14 18:17 GMT+01:00 Enric Balletbo i Serra <eballetbo@gmail.com>:
> > In order to meet high performance an low power requirement for Rockchip
> > enable the power domain support.
> > 

I guess this should also mention the drm/kms issue (driver deferring until 
power-domains are available) as further justification.


Otherwise, as I had experienced this myself while testing after we talked 
about it:
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > 
> >  arch/arm/configs/multi_v7_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/multi_v7_defconfig
> > b/arch/arm/configs/multi_v7_defconfig index 69a22fd..81314ec 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -655,6 +655,7 @@ CONFIG_QCOM_PM=y
> > 
> >  CONFIG_QCOM_SMD=y
> >  CONFIG_QCOM_SMD_RPM=y
> >  CONFIG_QCOM_SMEM=y
> > 
> > +CONFIG_ROCKCHIP_PM_DOMAINS=y
> > 
> >  CONFIG_COMMON_CLK_QCOM=y
> >  CONFIG_CHROME_PLATFORMS=y
> >  CONFIG_CROS_EC_CHARDEV=m
> > 
> > --
> > 2.1.0
