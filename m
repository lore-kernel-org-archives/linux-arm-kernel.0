From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Sep 2009 13:57:32 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <4AAE3A81.5010101@billgatliff.com>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
	<20090914014353.GA4762@shareable.org>
	<20090914100056.GC16644@n2100.arm.linux.org.uk>
	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>
	<1252928832.16853.96.camel@pc1117.cambridge.arm.com>
	<1252930881.16853.99.camel@pc1117.cambridge.arm.com>
	<4AAE3A81.5010101@billgatliff.com>
Message-ID: <1252933052.16853.114.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-14 at 07:43 -0500, Bill Gatliff wrote:
> Catalin Marinas wrote:
> > And here's an untested patch to clear the exclusive monitor on the
> > exception return path. If you are OK with the idea, I'll do some testing
> > before pushing it for upstream:
> 
> How are you going to "test" for this one? It's such a corner case, it's 
> going to be tricky to validate that your changes are actually getting 
> test coverage methinks...

I'm just testing it to make sure it doesn't break the compilation :-). I
can do a few more tests like running LTP in parallel but it may not find
any problems. It's strange that we haven't hit a bug yet (and we run
some intensive testing for CPU validation in ARM) or maybe we blamed
something else.

Apart from the switch_to and atomic_set modifications, the patch cannot
do more harm. As for these functions, I don't see any reason why the
modifications would not be correct but we can delay the merging until we
are sure (anyway, the more people looking at the patch, the better).

-- 
Catalin
