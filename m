From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 22 Dec 2011 21:26:47 -0500 (EST)
Subject: [PATCH v2] ARM: net: JIT compiler for packet filters
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AF25@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AF25@saturn3.aculab.com>
Message-ID: <alpine.LFD.2.02.1112222122100.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Dec 2011, David Laight wrote:

> > In principle, the condition could be __LINUX_ARM_ARCH__ < 5, since the
> > bx instruction is guaranteed to be available on all ARMv5 CPUs and
> > later (ARMv5T is not required).
> 
> Can't this code look at the actual cpu being used, and
> generate the relevant 'return' instruction?
> (Instead of trying to use some compile-time value.)

There is really no point doing so.  We intend to ultimately have a 
kernel that may support ARMv5 and lower, and another kernel to support 
ARMv6 and ARMv7.  So in a given context, either bx is always available 
(ARMv6+) or never required (ARMv5-).


Nicolas
