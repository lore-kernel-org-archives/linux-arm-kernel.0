From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 30 Jun 2011 16:38:33 +0300
Subject: [PATCH] mtd: OneNAND: samsung: Write DMA support
In-Reply-To: <20110630112354.GW21898@n2100.arm.linux.org.uk>
References: <20110608101804.GA5527@july> <1309420530.23597.153.camel@sauron>
	<20110630091951.GQ21898@n2100.arm.linux.org.uk>
	<1309430735.23597.165.camel@sauron>
	<20110630112354.GW21898@n2100.arm.linux.org.uk>
Message-ID: <1309441118.23597.198.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-06-30 at 12:23 +0100, Russell King - ARM Linux wrote:
> It's probably going to be better to have a MTD block API for DMA which
> provides a scatterlist to the MTD block driver, and which knows whether
> the memory is from vmalloc.  When it is, it takes care of the flushing
> via those two functions I referred to in cachetlb.txt.
> 
> This keeps the magic out of the individual MTD block drivers, and stops
> them replicating the same mistakes time and time again - and also means
> that you won't have to teach everyone about this.

Yeah, something like this. The MTD API is not very suitable for this and
would need some rework to make sure we achieve 2 goals:

1. No need to change current MTD API users
2. Keep the vmalloced memory handling in one place and not replicate it
   in each driver.

Currently only OneNAND drivers do these hacks, so I guess Kyungmin will
suffer most...

> It doesn't make sense for the DMA API to deal with vmalloc - MTD is
> one of the very few (the only?) subsystems which does this.

OK, thank you!

-- 
Best Regards,
Artem Bityutskiy
