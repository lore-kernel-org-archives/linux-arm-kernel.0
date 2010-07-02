From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jul 2010 18:23:17 +0100
Subject: [patch 2/2] arm: Implement l2x0 cache disable function
In-Reply-To: <1278089680.10162.279.camel@e102109-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1007021658300.2525@localhost.localdomain>
	<1278087010.10162.271.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007021835512.2525@localhost.localdomain>
	<1278089680.10162.279.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100702172317.GB2978@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 05:54:40PM +0100, Catalin Marinas wrote:
> On Fri, 2010-07-02 at 17:39 +0100, Thomas Gleixner wrote:
> > Simply because you need to flush the cache in the decompressor of the
> > new kernel before jumping into it and I doubt that Russell will be
> > happy about adding an utter L2 mess to the decompressor.
> 
> The decompressor can create mappings as inner cacheable outer
> non-cacheable and it would not pollute the L2 cache.

Doesn't solve the problem of boot loaders.  Doesn't solve the problem
that there may be dirty cache lines left in the L2 cache which could
be searched.

There's too many "implementation" possibilities to bite us.  The only
safe thing to do is to disable the L2 cache.
