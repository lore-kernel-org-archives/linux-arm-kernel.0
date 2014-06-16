From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 16 Jun 2014 10:04:53 -0400
Subject: [PATCH V3 00/16] irqchip: crossbar: driver fixes
In-Reply-To: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Message-ID: <539EF985.3080705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sricharan,

On Monday 16 June 2014 07:23 AM, Sricharan R wrote:
> This series does some cleanups, fixes for handling two interrupts
> getting mapped twice to same crossbar and provides support for
> hardwired IRQ and crossbar definitions.
> 
> On certain platforms such as DRA7, SPIs 0, 1, 2, 3, 5, 6, 10,
> 131, 132, 133 are direct wired to hardware blocks bypassing
> crossbar. This quirky implementation is *NOT* supposed to be the
> expectation of crossbar hardware usage. This series adds support
> to represent such hard-wired irqs through DT and avoid generic
> allocation/programming of crossbar in the driver.
> 
> This way of supporting hard-wired irqs was a result of
> the below discussions.
> http://www.spinics.net/lists/arm-kernel/msg329946.html
> 
> Based on 3.15 mainline.
> 
> All the patches are available here
>  git at github.com:Sricharanti/sricharan.git crossbar_updates
> 
> The fixes series[1] earlier posted is merged in to this.
> [1] http://www.spinics.net/lists/arm-kernel/msg328273.html
> 
> [V2] Merged the above series and rebased on 3.15 mainline
> 
> [V3] Modified patch#3 to get irqs-skip properties from DT,
>      merged path#8 for checkpatch warning to other relevant
>      patches and fixed comments for other patches.
>
I scanned entire series again including your updates on Jason's
comments. All look good to my eyes.

Hopefully after this series now, we can actually enable the crossbar
support on those machines.

FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
