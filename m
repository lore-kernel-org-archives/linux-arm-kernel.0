From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Dec 2014 22:03:31 +0100
Subject: [PATCH] optimize ktime_divns for constant divisors
In-Reply-To: <alpine.LFD.2.11.1412051251280.470@knanqh.ubzr>
References: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
 <alpine.LFD.2.11.1412051251280.470@knanqh.ubzr>
Message-ID: <2110446.Lbe6oKjkNj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 December 2014 13:00:22 Nicolas Pitre wrote:
> 
> BTW this is worth applying despite the on-going discussion with Arnd 
> on a separate optimization.

Agreed

> On Wed, 3 Dec 2014, Nicolas Pitre wrote:
> 
> > At least on ARM, do_div() is optimized to turn constant divisors into
> > an inline multiplication by the reciprocal value at compile time. 
> > However this optimization is missed entirely whenever ktime_divns() is
> > used and the slow out-of-line division code is used all the time.
> > 
> > Let ktime_divns() use do_div() inline whenever the divisor is constant
> > and small enough.  This will make things like ktime_to_us() and 
> > ktime_to_ms() much faster.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
