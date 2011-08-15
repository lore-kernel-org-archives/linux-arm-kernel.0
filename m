From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 15 Aug 2011 19:13:35 -0400 (EDT)
Subject: [RFC PATCH 0/5] Fix Thumb-2 undef handling for mixed-arch kernels
In-Reply-To: <20110811131054.GB2336@arm.com>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
	<1312975897.7800.20.camel@computer2>
	<20110811131054.GB2336@arm.com>
Message-ID: <alpine.LFD.2.00.1108151910030.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Aug 2011, Dave Martin wrote:

> On Wed, Aug 10, 2011 at 12:31:37PM +0100, Tixy wrote:
> > An alternative to defend against this is to make cpu_architecture() an
> > inline function returning the value of the global variable like:
> > 
> > inline int cpu_architecture(void)
> > {
> > 	BUG_ON(the_cpu_architecture == CPU_ARCH_UNKNOWN);
> > 	return the_cpu_architecture;
> > }
> > 
> > This has the bonus of not needing to change users of the the function.
> 
> Sounds like a good idea.  I got rid of the function because I didn't like
> calling a function from the undef handler entry code, but an inline
> function which just reads the variable seems like the best of both worlds.

While at it, you could mark the function with __attribute__((pure)).


Nicolas
