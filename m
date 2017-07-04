From: kevin.wangtao@hisilicon.com (Wangtao (Kevin, Kirin))
Date: Tue, 4 Jul 2017 10:50:35 +0000
Subject: =?utf-8?B?562U5aSNOiBbUGF0Y2ggdjIgMy8zXSBhcm02NDogZHRzOiByZWdpc3RlciBI?=
 =?utf-8?Q?i3660's_thermal_sensor?=
In-Reply-To: <20170701030613.GC11424@localhost.localdomain>
References: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
 <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1498102923-68481-3-git-send-email-kevin.wangtao@hisilicon.com>
 <20170701030613.GC11424@localhost.localdomain>
Message-ID: <68C6844FB78C6946B9DB8EACE2D237B0985B5A0D@dggeml507-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/7/1 11:06, "Eduardo Valentin" <edubezval@gmail.com> wrote:> 
> On Thu, Jun 22, 2017 at 11:42:03AM +0800, Tao Wang wrote:
> > Bind thermal sensor driver for Hi3660.
> >
> > Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> > Changes in v2:
> > - rebase changes on linux next
> >
> >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > index c6a1961..a6a1e01 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > @@ -848,5 +848,11 @@
> >  				     &sdio_cfg_func>;
> >  			status = "disabled";
> >  		};
> > +
> > +		tsensor: tsensor {
> > +			compatible = "hisilicon,hi3660-thermal";
> > +			reg = <0x0 0xfff30000 0x0 0x1000>;
> > +			#thermal-sensor-cells = <1>;
> > +		};
> 
> Are you planning to also add thermal zone entries?
Yes, after cpufreq enabled.
> 
> >  	};
> >  };
> > --
> > 1.7.9.5
> >
