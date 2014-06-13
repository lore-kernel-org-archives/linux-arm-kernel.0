From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 13 Jun 2014 11:01:22 -0400
Subject: [PATCH V2 00/19] irqchip: crossbar: driver fixes
In-Reply-To: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20140613150122.GP8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 05:23:08PM +0530, Sricharan R wrote:
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
> Nishanth Menon (16):
>   irqchip: crossbar: dont use '0' to mark reserved interrupts
>   irqchip: crossbar: check for premapped crossbar before allocating
>   irqchip: crossbar: Skip some irqs from getting mapped to crossbar
>   irqchip: crossbar: Initialise the crossbar with a safe value
>   irqchip: crossbar: Change allocation logic by reversing search for
>     free irqs
>   irqchip: crossbar: remove IS_ERR_VALUE check
>   irqchip: crossbar: fix sparse warnings
>   irqchip: crossbar: fix checkpatch warning
>   irqchip: crossbar: fix kerneldoc warning
>   irqchip: crossbar: fix memory leak incase of invalid entry
>   irqchip: crossbar: return proper error value
>   irqchip: crossbar: change the goto naming
>   irqchip: crossbar: introduce ti,max-crossbar-sources to identify
>     valid crossbar mapping
>   irqchip: crossbar: introduce centralized check for crossbar write
>   Documentation: dt: OMAP: crossbar: add description for interrupt
>     consumer
>   irqchip: crossbar allow for quirky hardware with direct hardwiring of
>     GIC
> 
> Rajendra Nayak (1):
>   irqchip: crossbar: DRA7: Fix unused crossbar list
> 
> Sricharan R (2):
>   irqchip: crossbar: set cb pointer to null in case of error
>   irqchip: crossbar: Add kerneldoc for crossbar_domain_unmap callback

Also, I just noticed this when I decided to look at the history of this
driver: Please format the subject lines like so:

  irqchip: crossbar: Set cb pointer ...
                     ^
                     |
                     \-- note the capitalization

thx,

Jason.
