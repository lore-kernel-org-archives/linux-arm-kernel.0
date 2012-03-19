From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Mon, 19 Mar 2012 09:47:19 +0100
Subject: [RFC/PATCH 4/4] pxa: convert to common clock framework
In-Reply-To: <20120317160744.GE29317@pengutronix.de>
References: <1331919483.31118.23.camel@flow>
 <CAJOA=zN2dxgjQ8EZYAwE=OLO1GLdArqy1Xf18F82en9QvFi4cw@mail.gmail.com>
 <CA+gwMcdzHpGhLXXh5QTYid+rBtj8cGqFS9Te4QB3rpR9B8hXUw@mail.gmail.com>
 <20120317160744.GE29317@pengutronix.de>
Message-ID: <CA+gwMceR=iPpt0Ca=nWEDuR3Y3yp=LTVOrRD--qO4QOnUwKUHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2012 at 5:07 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Sat, Mar 17, 2012 at 11:24:25AM +0100, Philipp Zabel wrote:
>> If there was a fixed fractional divider clk element, a lot of the
>> peripheral clocks could be derived from a fixed clk representing the
>> 312 MHz PPLL on PXA27x (fixed -> divider -> gate), using just the
>> basic clock templates.
>
> You could try the following. It is not thoroughly tested but may be a
> starting point. I need this aswell for i.MX so I will continue to work
> on it soon.

Thanks, this is exactly what I was looking for.

I'm a bit wary of adding so many clocks that just represent fixed
hardware, especially with the amount of function calls needed.
But describing the clock tree correctly appeals to my sense of order.

What is the take of the PXA maintainers on this?
Are there maybe plans to add device tree support for PXA?

regards
Philipp
