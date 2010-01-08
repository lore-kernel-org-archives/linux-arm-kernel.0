From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2010 16:37:38 +0000
Subject: [PATCH 2/3] arm: change command_line to cmd_line, and export it
In-Reply-To: <1262835561.887931.658428747865.2.gpush@pororo>
References: <1262835561.887063.943450380979.0.gpush@pororo>
	<1262835561.887931.658428747865.2.gpush@pororo>
Message-ID: <20100108163738.GE32558@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2010 at 02:39:21PM +1100, Jeremy Kerr wrote:
> drivers/of/fdt expects a cmd_line symbol, while arm uses command_line.
> Change to the former and make accessible from setup.h, so that we can
> share with the fdt code.

Until the dt code gets merged, I'd prefer to keep the 'command_line'
or 'cmd_line' static.  Also, please leave 'COMMAND_LINE_SIZE' visible
to stuff outside kernel-space (it could be used by boot loaders, which
borrow this file.)

In other words, can I have a patch in the patch system which just does
the renaming?
