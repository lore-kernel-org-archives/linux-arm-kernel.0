From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 04 Aug 2010 20:41:04 +1000
Subject: memblock glitch
In-Reply-To: <20100804085447.GB4927@n2100.arm.linux.org.uk>
References: <1280882307.1902.124.camel@pasglop>
	<1280885890.1902.134.camel@pasglop>
	<20100804085447.GB4927@n2100.arm.linux.org.uk>
Message-ID: <1280918464.1902.148.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-08-04 at 09:54 +0100, Russell King - ARM Linux wrote:
> 
> You could do, but do we want to introduce size checks for pfn_valid?
> I'm slightly concerned because it can be a hot path.
> 
> If all entries in memblock are already page aligned, if addr falls
> within a memblock, it must cover the entire page so checking the size
> seems redundant for this case. 

Ok, I've done a separate function for single address and range for now.
Feel free to look at my memblock branch in powerpc.git.

I'm still thinking however whether I should just expose a
memblock_pfn_valid() that can be directly hooked up to arch that wants
it to limit the overhead to a minimum..

Cheers,
Ben.
