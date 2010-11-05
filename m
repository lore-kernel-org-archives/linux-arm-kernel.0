From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Nov 2010 14:07:16 +0000
Subject: CONFIG_FORCE_MAX_ZONEORDER settable for all ARM architectures
In-Reply-To: <AANLkTikjQhKXgYzczAx70R3JkQ=DoE-xFNux=s6jUeLB@mail.gmail.com>
References: <4CD40976.1080009@gmail.com>
	<AANLkTikjQhKXgYzczAx70R3JkQ=DoE-xFNux=s6jUeLB@mail.gmail.com>
Message-ID: <20101105140716.GC23828@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 09:59:41PM +0800, Eric Miao wrote:
> However, I'm not really sure about how the size of the memory region is chosen
> and if the MAX_ORDER issue can be solved as well. So I guess before that
> happens in mainline, would be acceptable to adjust MAX_ZONEORDER in a
> hackish way.

Even if you increase MAX_ZONEORDER, the chances of being able to allocate
such a large page at runtime will be fairly low due to fragmentation.
It's something the normal page allocator has never been very good with.
