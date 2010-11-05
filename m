From: zonque@gmail.com (Daniel Mack)
Date: Fri, 05 Nov 2010 10:14:32 -0400
Subject: CONFIG_FORCE_MAX_ZONEORDER settable for all ARM architectures
In-Reply-To: <20101105140716.GC23828@n2100.arm.linux.org.uk>
References: <4CD40976.1080009@gmail.com>
	<AANLkTikjQhKXgYzczAx70R3JkQ=DoE-xFNux=s6jUeLB@mail.gmail.com>
	<20101105140716.GC23828@n2100.arm.linux.org.uk>
Message-ID: <4CD41148.2040803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2010 10:07 AM, Russell King - ARM Linux wrote:
> On Fri, Nov 05, 2010 at 09:59:41PM +0800, Eric Miao wrote:
>> However, I'm not really sure about how the size of the memory region is chosen
>> and if the MAX_ORDER issue can be solved as well. So I guess before that
>> happens in mainline, would be acceptable to adjust MAX_ZONEORDER in a
>> hackish way.
> 
> Even if you increase MAX_ZONEORDER, the chances of being able to allocate
> such a large page at runtime will be fairly low due to fragmentation.
> It's something the normal page allocator has never been very good with.

Well, for us, this does work when we increase this number to 12, and as
we build the pxafb statically into the kernel, I would expect the memory
fragmentation situation to be deterministic at each boot. I agree we
couldn't rely on this when loading the driver as module at some later point.

Thanks,
Daniel
