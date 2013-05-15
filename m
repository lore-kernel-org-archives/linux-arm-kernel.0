From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 May 2013 17:48:54 +0100
Subject: [PATCHv2] arm: mm: Use phys_addr_t properly for ioremap functions
In-Reply-To: <201305151615.39752.arnd@arndb.de>
References: <1368560031-19367-1-git-send-email-lauraa@codeaurora.org>
 <201305151615.39752.arnd@arndb.de>
Message-ID: <20130515164854.GM18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 04:15:39PM +0200, Arnd Bergmann wrote:
> On Tuesday 14 May 2013, Laura Abbott wrote:
> > Several of the ioremap functions use unsigned long in places
> > resulting in truncation if physical addresses greater than
> > 4G are passed in. Change the types of the functions and the
> > callers accordingly.
> 
> Looks good to me. I wonder a bit whether resource_size_t or phys_addr_t
> is the right type here, but they are always defined to the same type
> these days.
> 
> FWIW, x86 and tile use resource_size_t, while a couple of other architectures
> use phys_addr_t.

Maybe there's a project there for someone to remove phys_addr_t or
resource_size_t then - but I suspect Linus won't like the churn
caused by that...

So, let's just go by the one which takes less typing and save our
fingers.  phys_addr_t.
