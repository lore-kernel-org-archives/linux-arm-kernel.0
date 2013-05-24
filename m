From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 24 May 2013 18:52:54 +0200
Subject: [PATCH] ARM: at91: Fix: Change internal SRAM memory type to
 "MT_MEMORY_SO"
In-Reply-To: <20130524164055.GA18614@n2100.arm.linux.org.uk>
References: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
 <1369011979-21354-1-git-send-email-wenyou.yang@atmel.com>
 <20130522001457.GA18614@n2100.arm.linux.org.uk>
 <B256D81BAE5131468A838E5D7A243641687BB93C@penmbx01>
 <20130524112029.GW18614@n2100.arm.linux.org.uk>
 <20130524140322.GD24476@game.jcrosoft.org>
 <20130524164055.GA18614@n2100.arm.linux.org.uk>
Message-ID: <20130524165254.GF24476@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:40 Fri 24 May     , Russell King - ARM Linux wrote:
> On Fri, May 24, 2013 at 04:03:22PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:20 Fri 24 May     , Russell King - ARM Linux wrote:
> > > On Fri, May 24, 2013 at 07:11:04AM +0000, Yang, Wenyou wrote:
> > > > The story is: for sama5d3x with Cortex-A5 core, if not so, when copying
> > > > code snippet to the internal SRAM, then jump to run this code, but fail
> > > > to run.
> > > 
> > > And that is where your mistake is - you forgot that you're working with
> > > a CPU with harvard caches which will require some cache maintanence
> > > between copying the code and executing it.
> > > 
> > > You want to look at flush_icache_range() rather than making this memory
> > > strongly ordered.
> > 
> > I understand your point but today we map a SRAM as MT_DEVICE
> 
> If you map SRAM as MT_DEVICE then you won't be able to execute code from
> it.  It needs to be a normal memory mapping.

Yeah that a bug on AT91, by luck it work on armv3/v4 with MT_DEVICE, I should
have spot it earlier when cleanning the at91 but did not

That's why Yang change the SRAM mapping as MT_MEMORY_SO

I agree the commit message need to be re-done

Best Regards,
J.
