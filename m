From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Dec 2011 13:44:15 +0000
Subject: [PATCH] regulator: max8925: fix enabled/disabled judgement mistake
In-Reply-To: <CAN1soZy+hgW2iaQad9gbis7bHLCnfQhMKx-JTJc1j2++eRrJyw@mail.gmail.com>
References: <1324543892-32540-1-git-send-email-haojian.zhuang@marvell.com>
 <20111222105357.GC4546@opensource.wolfsonmicro.com>
 <CAN1soZy+hgW2iaQad9gbis7bHLCnfQhMKx-JTJc1j2++eRrJyw@mail.gmail.com>
Message-ID: <20111222134415.GU4546@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 09:31:22PM +0800, Haojian Zhuang wrote:
> On Thu, Dec 22, 2011 at 6:53 PM, Mark Brown

> > Does this mean that the register for enabling and disabling the register
> > doesn't always work? ?If it does then doesn't that mean that the enable
> > and disable functions need to be updated as well to either put the
> > regulator into I2C mode or return an error when it isn't in I2C mode?

> According to the logic in above, we need check both registers to figure out
> whether LDO is on or off.
> Return error if it isn't in I2C mode doesn't make sense. If sequence is in one
> of power-on sequence, the LDO is already ON by default.

I don't understand how your reply follows on from my comment here?  If
the enable register doesn't control if the regulator is enabled and
disabled and it's always on then it seems fairly clear that the enable
and disable functions ought to know about this.
