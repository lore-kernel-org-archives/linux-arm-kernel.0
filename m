From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Oct 2011 14:31:33 +0100
Subject: [GIT PULL] genirq support for GIC PPIs
In-Reply-To: <20111020130449.GC21648@n2100.arm.linux.org.uk>
References: <4E9FF695.10604@arm.com>
	<20111020112724.GZ21648@n2100.arm.linux.org.uk>
	<4EA00E7F.8060007@arm.com>
	<20111020130449.GC21648@n2100.arm.linux.org.uk>
Message-ID: <4EA022B5.1080702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/11 14:04, Russell King - ARM Linux wrote:
> On Thu, Oct 20, 2011 at 01:05:19PM +0100, Marc Zyngier wrote:
>> On 20/10/11 12:27, Russell King - ARM Linux wrote:
>>> On Thu, Oct 20, 2011 at 11:23:17AM +0100, Marc Zyngier wrote:
>>>> The following changes since commit 5a567d78c437e3be1c512734cdfe64b4ae6b82d7:
>>>>   Jamie Iles (1):
>>>>         ARM: 7115/4: move __exception and friends to asm/exception.h
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://github.com/mzyngier/arm-platforms.git ppi-for-rmk
>>>>
>>>> Marc Zyngier (4):
>>>>       genirq: Add support for per-cpu dev_id interrupts
>>>>       genirq: percpu: allow interrupt type to be set at enable time
>>>>       ARM: gic: consolidate PPI handling
>>>>       ARM: gic, local timers: use the request_percpu_irq() interface
>>>>
>>>> Thomas Gleixner (1):
>>>>       genirq: Fix fatfinered fixup really
>>>
>>> I thought you said some of these were in Thomas' tree already?
>>
>> The first three patches are in Thomas' tree indeed. I could drop them
>> from my branch, but the resulting tree would not compile anymore.
>>
>> What strategy would cause the least merging pain?
> 
> The only thing I can think is that you need to start off with a tree
> with 5a567d78c437e3be1c512734cdfe64b4ae6b82d7 as the top commit,
> merge into that the last commit which you need from Thomas' tree
> (iow, "genirq: percpu: allow interrupt type to be set at enable time"
> or maybe "genirq: Fix fatfinered fixup really") and then apply the
> last two GIC patches on top of that merge commit.
> 
> However, I guess Thomas already has many other commits queued up for
> mainline before these changes - which would make those commits become
> part of my tree.
> 
> That causes problems because if Thomas pushes first, my tree ends up
> with multiple ancestors, which makes it impossible to generate a
> diffstat for my push to Linus.  The flip-side is if I push before
> Thomas, then I'm pushing Thomas' commits into mainline myself (which
> means I then need to explain Thomas' generic changes to Linus and why
> they're part of my tree.)
> 
> Cross-tree dependencies like this really suck.
> 
> I'm really tempted to postpone this to the following merge window to
> 'solve' these dependencies (because by that time their dependencies
> should all be merged into mainline, which makes things nice and simple.)

Could we just wait until Thomas' branch has reached mainline, and then
try another pull request with only the last two patches?

I understand this is tricky, but waiting another merge window may lead
to another bunch of conflicts and cross-tree madness (there's some
MULTI_IRQ_HANDLER stuff coming from a number of parties as well RobH's
GIC DT work).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
