From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 29 Jun 2016 11:54:49 -0700
Subject: [PATCH 20/21] phy: Add support for Qualcomm's USB HSIC phy
In-Reply-To: <57739203.9000601@baylibre.com>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-21-stephen.boyd@linaro.org>
 <57723A21.3060602@baylibre.com>
 <146715109651.31418.4819151138932336863@sboyd-linaro>
 <57739203.9000601@baylibre.com>
Message-ID: <146722648915.16253.2287256112087912402@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Neil Armstrong (2016-06-29 02:16:51)
> On 06/28/2016 11:58 PM, Stephen Boyd wrote:
> > Quoting Neil Armstrong (2016-06-28 01:49:37)
> >> On 06/26/2016 09:28 AM, Stephen Boyd wrote:
> >>> +     uphy->cal_sleep_clk = clk = devm_clk_get(&ulpi->dev, "cal_sleep");
> >>> +     if (IS_ERR(clk))
> >>> +             return PTR_ERR(clk);
> >>
> >> Hi Stephen,
> >>
> >> In the bindings the cal_sleep is marked optional, and I think should be since AFAIK
> >> it's not present on MDM9615 for example.
> > 
> > The cal_sleep clk is just the sleep clk then (should be a board clk in
> > DT). Sometimes there's a gate in GCC to allow us to turn it off, other
> > times there isn't. Either way, it's always wired there so I'll update
> > the binding to say it isn't optional.
> 
> Sorry I don't understand !
> What should I do if GCC does not provide a gate here ? And looking at the driver, it could be optional.

You should set the property to point to &sleep_clk which should be under
the "clocks" node at the root of the OF tree. For example, see the
sleep_clk node in arch/arm/boot/dts/qcom-apq8064.dtsi.
