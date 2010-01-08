From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2010 16:39:05 +0000
Subject: [PATCH 3/3] arm: export arm_add_memory
In-Reply-To: <1262835561.888252.461260980683.3.gpush@pororo>
References: <1262835561.887063.943450380979.0.gpush@pororo>
	<1262835561.888252.461260980683.3.gpush@pororo>
Message-ID: <20100108163905.GF32558@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2010 at 02:39:21PM +1100, Jeremy Kerr wrote:
> We'd like to add memory from the device tree, so make arm_add_memory
> non-static and add a prototype in setup.h
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

I've been thinking about this a bit, and rather than indirecting the
DT stuff through an inline function, I think we should rename the
function instead to something that's compatible with DT.  Yes, that
means changing the arguments, but in the longer term, we're likely
to need to pass more than 32-bits of memory start/size to the kernel.
