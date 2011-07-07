From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 7 Jul 2011 20:51:11 +0400
Subject: [PATCH] ARM: cns3xxx: Add support for L2 Cache Controller
In-Reply-To: <4E14A51F.4030108@gmail.com>
References: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
	<4E14A51F.4030108@gmail.com>
Message-ID: <20110707165111.GA1242@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 01:10:39PM -0500, Rob Herring wrote:
[...]
> > +	 * 1 cycle of setup latency, 2 cycles of read and write accesses latency
> > +	 */
> > +	val = readl(base + L2X0_DATA_LATENCY_CTRL);
> > +	val &= 0xfffff888;
> 
> You're missing a "val |= 0x110" or your comment is wrong.

Thanks for spotting this.

These values were taken from the BSP* code, which was tested
the most (and apparently works), I tend to leave the value as is
and fixup the comment.

Thanks!

* The BSP does not use L2X0 driver, instead, it contains 'L2CC'
  driver with these values hard-coded. But nowadays the L2CC driver
  is unneeded as L2X0 supports PL310 controllers.

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
