From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 15 Mar 2012 07:56:31 +0100
Subject: [PATCH v4 09/10] pwm: Add PXA support
In-Reply-To: <4F61343A.80103@gmail.com>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-10-git-send-email-thierry.reding@avionic-design.de>
 <4F61343A.80103@gmail.com>
Message-ID: <20120315065631.GB20502@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ryan Mallon wrote:
> On 15/03/12 02:56, Thierry Reding wrote:
> 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Changes in v3:
> >   - update PWM ops for changes in patch 2
> 
> Couple of quick notes, mostly for future work.
> 
> > +	/* NOTE: the clock to PWM has to be enabled first
> > +	 * before writing to the registers
> > +	 */
> > +	clk_enable(pc->clk);
> 
> 
> Should be fixed to also call clk_prepare (and clk_unprepare after
> clk_disable). Could be done in a follow up patch.
> 
> > +	__raw_writel(prescale, pc->mmio_base + offset + PWMCR);
> > +	__raw_writel(dc, pc->mmio_base + offset + PWMDCR);
> > +	__raw_writel(pv, pc->mmio_base + offset + PWMPCR);
> 
> 
> Should we fix this driver to use readl/writel instead of the __raw
> variants? The memory is properly ioremaped, and to my understanding the
> __raw memory accessors should be avoided outside of core code. This
> could be done in a follow up patch if you want to keep this patch as
> mostly just a move of the code.

Actually I wasn't planning on keeping this patch at all. Sascha already has
the existing PWM providers converted to his original framework and offered to
rebase them onto this series once the dust settles. I only used them as
testbed to see how the driver interface works out for different hardware. But
I also think that if Sascha hasn't cleaned the driver up yet it should either
be done in his conversion patches or as follow ups.

Sascha: how do you plan on going forward with this? It seems like the driver
interface is pretty much done now and I expect the next round to be the last,
unless I forget to properly work through the TODO list again. If you are busy
with other stuff I can probably find some time to help with porting your
converted drivers.

I'm also wondering which tree this will go in through. Does it make sense to
have an extra tree just for the PWM framework or can it go in via some other
general purpose tree? Who do I need to prod?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/b37c86ec/attachment.sig>
