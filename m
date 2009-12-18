From: chripell@gmail.com (christian pellegrin)
Date: Fri, 18 Dec 2009 09:08:41 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <4B2A1693.6020000@denx.de>
References: <309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<4B1CF3ED.9080307@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<4B2A1693.6020000@denx.de>
Message-ID: <cabda6420912180008l27349a9bs3a13460d3a6454d6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 12:31 PM, Heiko Schocher <hs@denx.de> wrote:
> Hello Christian,
>

Hi

> As we have problems with shared memory, if using more than one
> mapping, do we have this problems also when using other "standard"
> Linux IPC, like for example semaphores, queues, ... ?
>

AFAIK no. The problem you discovered is caused by the access of the
same physical memory area via a cached and an uncached mapping without
proper L2 cache flushing. The only way that I know about how to create
an uncached one in user space is by mapping the same physical memory
to different virtual address (so triggering the L1 VIVT cache aliasing
avoidance mechanism).

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
