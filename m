From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 19 Nov 2014 16:18:34 +0200
Subject: [PATCH] i2c: designware: prevent early stop on TX FIFO empty
In-Reply-To: <20141119092122.GC1439@katana>
References: <545CB6C4.8010201@arm.com>
 <20141119092122.GC1439@katana>
Message-ID: <20141119141834.GJ1309@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 10:21:22AM +0100, Wolfram Sang wrote:
> On Fri, Nov 07, 2014 at 12:10:44PM +0000, Andrew Jackson wrote:
> > If the Designware core is configured with IC_EMPTYFIFO_HOLD_MASTER_EN
> > set to zero, allowing the TX FIFO to become empty causes a STOP
> > condition to be generated on the I2C bus. If the transmit FIFO
> > threshold is set too high, an erroneous STOP condition can be
> > generated on long transfers - particularly where the interrupt
> > latency is extended.

Makes sense to give some slack so that the interrupt handler is still
able to fill the FIFO.

> > 
> > Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> So, what do other designware users think of this change (nice CC list
> BTW, Andrew). Adding Mika, too.

I quickly tested this on Haswell machine with touch screen connected to
the I2C bus and it still works fine, so

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
