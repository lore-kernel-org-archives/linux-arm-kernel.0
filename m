From: schwab@linux-m68k.org (Andreas Schwab)
Date: Fri, 06 Apr 2012 13:51:14 +0200
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map;
 use irq_alloc_desc() instead
In-Reply-To: <1333409927.30734.62.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Tue, 03 Apr 2012 09:38:47 +1000")
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost>
 <20120402215524.GM24211@n2100.arm.linux.org.uk>
 <1333406005.30734.61.camel@pasglop>
 <20120402225223.GN24211@n2100.arm.linux.org.uk>
 <1333409927.30734.62.camel@pasglop>
Message-ID: <m24nsx9iz1.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Ok. Doesn't matter anyway, this shouldn't be the problem in this
> specific case. IE. we shouldn't be setting that interrupt to NONE.

After removinge the call to irq_set_irq_type in mpic_host_map the irq
problem disappears.

Instead of the irq_set_irq_type(,NONE) calls from mpic_host_map I see
corresponding irq_set_irq_type(,LEVEL_LOW) calls now.

Andreas.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
