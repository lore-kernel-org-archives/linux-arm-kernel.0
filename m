From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Mon, 19 Feb 2018 11:44:22 +0100
Subject: [PATCH v3 6/7] arm: dts: sun8i: a83t: Fix undefined offset with
 virtual timer
In-Reply-To: <20180219085205.jh6bcmbzcxqffkhk@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-7-mylene.josserand@bootlin.com>
 <20180219085205.jh6bcmbzcxqffkhk@flea.lan>
Message-ID: <20180219114422.37977175@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 19 Feb 2018 09:52:05 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi,
> 
> On Mon, Feb 19, 2018 at 09:18:36AM +0100, Myl?ne Josserand wrote:
> > The ARM architected timers use an offset between their physical and
> > virtual counters. That offset should be configured by the bootloader
> > in CNTVOFF.
> > 
> > However, the A83t bootloader fails to do so, and we end up with an
> > undefined offset (which in our case is random), meaning that each CPU
> > will have a different time, which isn't working very well.
> > 
> > Fix that by setting the arm,cpu-registers-not-fw-configured that will
> > make Linux use the physical timers instead of the virtual ones. One
> > possible side effect would be that the virtualization features would
> > be disabled. However, due to the way the GIC has been integrated in
> > the system, it is already unusable so we're effectively not losing any
> > feature.
> > 
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>  
> 
> One small nitpick on this one (and the previous one), arm in the
> subject prefix should be uppercase.

Okay, I will fix that in V4.

Myl?ne

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
