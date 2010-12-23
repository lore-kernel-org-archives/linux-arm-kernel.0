From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Dec 2010 10:06:42 +0000
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
Message-ID: <20101223100642.GD3636@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 06:30:57PM +0900, Kyungmin Park wrote:
> Hi Andrew,
> 
> any comments? what's the next step to merge it for 2.6.38 kernel. we
> want to use this feature at mainline kernel.

Has anyone addressed my issue with it that this is wide-open for
abuse by allocating large chunks of memory, and then remapping
them in some way with different attributes, thereby violating the
ARM architecture specification?

In other words, do we _actually_ have a use for this which doesn't
involve doing something like allocating 32MB of memory from it,
remapping it so that it's DMA coherent, and then performing DMA
on the resulting buffer?
