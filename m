From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 21:19:28 +0100
Subject: [PATCH] ARM: report present cpus in /proc/cpuinfo
In-Reply-To: <4E0241D3.4060303@nvidia.com>
References: <4E012198.6010405@nvidia.com>
	<20110621230512.GL23234@n2100.arm.linux.org.uk>
	<4E012820.2090208@nvidia.com>
	<20110621233619.GM23234@n2100.arm.linux.org.uk>
	<4E01326C.1060808@nvidia.com>
	<20110622093623.GP23234@n2100.arm.linux.org.uk>
	<4E0241D3.4060303@nvidia.com>
Message-ID: <20110622201928.GW23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 12:26:11PM -0700, Jon Mayo wrote:
> On 06/22/2011 02:36 AM, Russell King - ARM Linux wrote:
>> Think about it - if you have real hot-pluggable CPUs (servers do), do
>> you _really_ want to try to bring online a possible CPU (iow, there's
>> a socket on the board) but one which isn't present (iow, the socket is
>> empty.)
>>
>> That's what the possible + !present case caters for.  Possible tells
>> the kernel how many CPUs to allocate per-cpu data structures for.
>> present tells it whether a CPU can be onlined or not.
>>
>
> Yes, that's the difference between present and possible. I'm not  
> suggesting we report cpus that do not exist. I'm suggesting we report  
> cpus that are present, online or not.

Which is _what_ we do.  The problem is that mach-tegra is causing
the established well defined APIs to mean something else, and then
you're complaining that those APIs don't mean what they were defined
to be.

You're really shooting yourself in the foot here, and at this point
there is nothing left to discuss.

I can't help you.  You need to discuss this with folk who look after
the hotplug CPU stuff.

You no longer have an ARM architecture problem, your problem is that
you're abusing stuff to get what you want and then complaining that
stuff doesn't work as you want it.
