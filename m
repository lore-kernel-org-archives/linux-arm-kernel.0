From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Jan 2013 23:01:49 +0000
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130110230148.GA11628@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, Jan 10, 2013 at 12:20:35AM +0000, Nicolas Pitre wrote:
> This is the initial public posting of the initial support for big.LITTLE.
> Included here is the code required to safely power up and down CPUs in a
> b.L system, whether this is via CPU hotplug, a cpuidle driver or the
> Linaro b.L in-kernel switcher[*] on top of this.  Only  SMP secondary
> boot and CPU hotplug support is included at this time.  Getting to this
> point already represents a significcant chunk of code as illustrated by
> the diffstat below.

I've just started going through this, so I have some comments on the first
few patches. I'll try and get through the rest of it soon (but Christoffer
is kicking me to look at kvm again too :)

> Low-level support code:
> [PATCH 01/16] ARM: b.L: secondary kernel entry code
> [PATCH 02/16] ARM: b.L: introduce the CPU/cluster power API
> [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
> [PATCH 04/16] ARM: b.L: Add baremetal voting mutexes
> [PATCH 05/16] ARM: bL_head: vlock-based first man election

I got this far, so I'll send my comments as replies to those.

> Adaptation layer to hook with the generic kernel infrastructure:
> [PATCH 06/16] ARM: b.L: generic SMP secondary bringup and hotplug
> [PATCH 07/16] ARM: bL_platsmp.c: close the kernel entry gate before
> [PATCH 08/16] ARM: bL_platsmp.c: make sure the GIC interface of a
> [PATCH 09/16] ARM: vexpress: Select the correct SMP operations at
> 
> Fast Models support:
> [PATCH 10/16] ARM: vexpress: introduce DCSCB support
> [PATCH 11/16] ARM: vexpress/dcscb: add CPU use counts to the power
> [PATCH 12/16] ARM: vexpress/dcscb: do not hardcode number of CPUs
> [PATCH 13/16] drivers: misc: add ARM CCI support
> [PATCH 14/16] ARM: TC2: ensure powerdown-time data is flushed from
> [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
> [PATCH 16/16] ARM: vexpress/dcscb: probe via device tree

These last six really need Pawel Moll on CC. He's on holiday at the moment,
but he'll be back at the end of the month so I suggest pinging him then so
they don't get lost.

Will
