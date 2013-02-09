From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 09 Feb 2013 13:37:27 +0100
Subject: [GIT PULL 4/4] mach-virt platform code for 3.9
In-Reply-To: <510FF8DC.6080202@arm.com>
References: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
 <1359986131-13034-4-git-send-email-will.deacon@arm.com>
 <510FF8DC.6080202@arm.com>
Message-ID: <0696c7229c3499755984da15b64a877a@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 04 Feb 2013 18:07:24 +0000, Marc Zyngier <marc.zyngier@arm.com>
wrote:
> On 04/02/13 13:55, Will Deacon wrote:
>> NOTE: I'm not suggesting you pull this one as it stands -- see below!
>> 
>> This is the last batch from me (Marc is dealing with vgic and virtual
>> timers) and introduces support for mach-virt. This depends on:
>> 
>>         - for-arm-soc/arch-timers (third pull request in this series)
>>         - for-rmk/virt/psci (already pulled)
>>         - irqchip/gic-vic-move (an arm-soc branch)
>> 
>> As a result, the diffstat is atrocious so it would be better if you
>> could create a branch merging the above dependendies, which I could
>> rebase onto (there's actually only two patches here).
> 
> The remaining of the KVM/ARM code (vgic and timer) has exactly the same
> problem, plus an additional dependency on the actual kvm/core branch
> that Russell just pulled.
> 
> I can either send you two pull requests that will basically look like
> this one (actually, a lot worse), or you could create a stable branch
> containing:
> 
> 	- for-rmk/virt/kvm/core (first pull request in the series)
> 	- for-arm-soc/arch-timers (third pull request in the series)
> 	- irqchip/gic-vic-move (already in arm-soc)
> 
> You could either create two stable branches (one for mach-virt and one
> for kvm-arm/{vgic,timer}), or a single one containing all the
> prerequisites.
> 
> What do you think?

Arnd, Olof,

Any hope we can get branches for these? Now that the KVM core code is in
Russell's devel-stable branch, it would be a shame not to have the complete
thing...

Thanks,

        M.
-- 
Fast, cheap, reliable. Pick two.
