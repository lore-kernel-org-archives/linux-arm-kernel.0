From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Sep 2009 12:47:12 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1252922773.16853.62.camel@pc1117.cambridge.arm.com>
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
Message-ID: <1252928832.16853.96.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-14 at 11:06 +0100, Catalin Marinas wrote:
> On Mon, 2009-09-14 at 11:00 +0100, Russell King - ARM Linux wrote:
> > It doesn't matter though - consider two threads using LDREX on the same
> > location:
> > 
> > 	T1		T2
> > 	LDREX
> > 			LDREX
> > 			STREXEQ (not satsified)
> > 	STREX
> 
> As I replied to Jamie on a similar issue, you can have:
> 
> T1			T2
> LDREX
> 			LDREX
> 			STREXEQ (satisfied, succeeds)
> 			LDREX
> 			STREXEQ (not satisfied)
> STREX (succeeds)
> 
> Though this may be an unlikely sequence.

Searching for STREXEQ, it looks like there are several other locking
functions using it in spinlock.h. Do we have a real problem with these?

-- 
Catalin
