From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 11 Jan 2010 08:32:44 +1100
Subject: [PATCH 3/3] arm: export arm_add_memory
In-Reply-To: <20100108163905.GF32558@n2100.arm.linux.org.uk>
References: <1262835561.887063.943450380979.0.gpush@pororo>
	<1262835561.888252.461260980683.3.gpush@pororo>
	<20100108163905.GF32558@n2100.arm.linux.org.uk>
Message-ID: <201001110832.44274.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
 
> I've been thinking about this a bit, and rather than indirecting the
> DT stuff through an inline function, I think we should rename the
> function instead to something that's compatible with DT.  Yes, that
> means changing the arguments, but in the longer term, we're likely
> to need to pass more than 32-bits of memory start/size to the kernel.

Any thoughts on using the generic LMB infrastructure to manage this instead?

The DT code is written for arches that have LMB support, so the main reason 
for this patch is to provide a hook into non-LMB arches.

Cheers,


Jeremy 
