From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 06 Oct 2015 11:49:27 +0300
Subject: [PATCH 2/2] ARM: dts: Use architected timer on Exynos 5410
In-Reply-To: <56138772.5030302@samsung.com>
References: <cover.1444119342.git.p.fedin@samsung.com>
 <57f3491726014e3817bdf9988b1aa30436b45e00.1444119342.git.p.fedin@samsung.com>
 <56138772.5030302@samsung.com>
Message-ID: <00d101d10013$e9e6f120$bdb4d360$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > +
> > +			arch_timer {
> > +				compatible = "arm,armv7-timer";
> > +				interrupt-parent = <&gic>;
> 
> You don't need to add 'interrupt-parent' because exynos5410.dtsi already includes
> it on top.

 I do, because otherwise it tries to use interrupt-map, written for MCT (which is specified as interrupt-parent for its node), and looks like interrupt-map specifies totally different things.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
