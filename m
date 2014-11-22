From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 22 Nov 2014 12:25:49 +0900
Subject: [1/2] ARM: dts: Fix bootup issue on smdk5250
In-Reply-To: <546D67A1.1080804@samsung.com>
References: <1416312509-11530-1-git-send-email-yadi.brar@samsung.com>
 <546D67A1.1080804@samsung.com>
Message-ID: <038501d00604$034a9640$09dfc2c0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pankaj Dubey wrote:
> 
> Hi,
> 
Hi,

Yadwinder, please don't miss [PATCH 1/2] in subject, so that my e-mail client
can't filter wrong ;)

> On Tuesday 18 November 2014 05:38 PM, Yadwinder Singh Brar wrote:
> > With default config on smdk5250 latest tree throws below message :
> >
> > [    2.226049] thermal thermal_zone0: critical temperature reached(224 C),shutting down
> > [    2.227840] reboot: Failed to start orderly shutdown: forcing the issue
> >
> > and hangs randomly because it reads wrong temperature value.
> >
> > I can't figure out any direct relation between LDO10 and TMU from board
> > schematics which I have. So making LDO10 always-on to fix issue for now.
> >
Hmm...strange, I also can't see any relations now...but I need to contact to
hardware guy before applying this, this fixes the problem though.

Thanks,
Kukjin

> > Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> >
> 
> Tested this on SMDK5250 board, system boot is fine now, hence
> 
> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> > ---
> > arch/arm/boot/dts/exynos5250-smdk5250.dts |    1 +
> >   1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> > index bc27cc2..95b5b51 100644
> > --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> > +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> > @@ -190,6 +190,7 @@
> >   				regulator-name = "P1.8V_LDO_OUT10";
> >   				regulator-min-microvolt = <1800000>;
> >   				regulator-max-microvolt = <1800000>;
> > +				regulator-always-on;
> >   			};
> >
> >   			ldo11_reg: LDO11 {
> >
