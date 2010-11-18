From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 18 Nov 2010 15:43:28 +0900
Subject: [PATCH] ARM: mach-shmobile: Initial AG5 and AG5EVM support
In-Reply-To: <20101117105931.21300.89918.sendpatchset@t400s>
References: <20101117105931.21300.89918.sendpatchset@t400s>
Message-ID: <20101118064328.GA18543@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 07:59:31PM +0900, Magnus Damm wrote:
> This patch adds initial support for Renesas SH-Mobile AG5.
> 
> At this point the AG5 CPU support is limited to the ARM
> core, SCIF serial and a CMT timer together with L2 cache
> and the GIC. The AG5EVM board also supports Ethernet.
> 
> Future patches will add support for GPIO, INTCS, CPGA
> and platform data / driver updates for devices such as
> IIC, LCDC, FSI, KEYSC, CEU and SDHI among others.
> 
Looks pretty harmless at first glance.

> The code in entry-macro.S will be cleaned up when the
> ARM IRQ demux code improvements have been merged.
> 
The current code is way too ugly to live, I'll split out as per MSM and
some of the others, which should make it pretty easy to layer on top of
when your demux changes are merged.

> As the AG5EVM board comes with 512MiB memory it is
> recommended to turn on HIGHMEM.
> 
You're also missing a defconfig. Preferably with HIGHMEM enabled.
