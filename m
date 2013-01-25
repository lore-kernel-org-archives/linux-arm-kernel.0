From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 25 Jan 2013 12:06:41 +0000
Subject: [PATCH v2 1/2] clk: divider: prepare for minimum divider
In-Reply-To: <20130124170630.10623.78749@quantum>
References: <6dc1c48cac5b2646a55da3079afb72f88e40c3bc.1358937138.git.afzal@ti.com>
 <20130123214053.9205.49804@quantum>
 <C8443D0743D26F4388EA172BF4E2A7A93EA92ABC@DBDE01.ent.ti.com>
 <20130124170630.10623.78749@quantum>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA93851@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, Jan 24, 2013 at 22:36:30, Mike Turquette wrote:
> Quoting Mohammed, Afzal (2013-01-24 03:29:15)

> > It is a functional constraint: divider has 8 bits and it can have
> > all possible values (0 to 255) and divider value corresponds to
> > value set in the 8 bits. But depending on the modes the minimum
> > value that can be configured (to get display working) varies.
> > Eg. For raster mode (which the driver is presently supporting), it
> > can take a minimum value of 2, while in LIDD (LCD interface display
> > driver) mode it can take a min value of 1.
> > 
> > Here min rate is not a constraint w.r.t divider in LCDC IP, but
> > rather min divider.

> Just so I understand correctly... you are saying that the functional
> constraint is not caused by the clock rate, but instead by the divider
> value?  For the different modes (raster vs LIDD) is the clock rate the
> same, or is the clock rate different?

> What is the clock output rate of the divider in raster mode?  What is
> the clock output rate of the divider in LIDD mode?

Yes, functional constraint in caused by divider value.

clock output rate can defined for both modes as follows,

p_clk (clock output rate) = lcd_clk (input clock rate) / div,

to configure "div", we have r/w 8 bits, so div values can
range from 0-255,

And IP spec says value "0" and "1" should not be written, in
raster mode. Further it says if in LIDD mode it can have values
from 0-255, but effect of writing "0" is same as "1".

Effect of divider value on output rate is in the same way for
both modes as per above expression (except for writing "0" in
LIDD mode).

The driver supports only raster mode.

Regards
Afzal

Note: link to trm has been mentioned in the earlier reply.
