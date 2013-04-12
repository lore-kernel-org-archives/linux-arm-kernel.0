From: agraf@suse.de (Alexander Graf)
Date: Fri, 12 Apr 2013 15:35:38 +0200
Subject: [PATCH] ARM: KVM: fix L_PTE_S2_RDWR to actually be Read/Write
In-Reply-To: <51680D3C.9090602@arm.com>
References: <1365771616-7380-1-git-send-email-marc.zyngier@arm.com>
 <69741C13-FAA5-45D3-87D5-FF082E87192A@suse.de> <51680D3C.9090602@arm.com>
Message-ID: <0F293D19-E658-48A2-B0D0-47A728CE8785@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12.04.2013, at 15:33, Marc Zyngier wrote:

> On 12/04/13 14:26, Alexander Graf wrote:
>> 
>> On 12.04.2013, at 15:00, Marc Zyngier wrote:
>> 
>>> Looks like our L_PTE_S2_RDWR definition is slightly wrong,
>>> and is actually write only (see ARM ARM Table B3-9, Stage 2 control
>>> of access permissions). Didn't make a difference for normal pages,
>>> as we OR the flags together, but I'm still wondering how it worked
>>> for Stage-2 mapped devices, such as the GIC.
>>> 
>>> Brown paper bag time, again.
>>> 
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> 
>> CC stable?
> 
> Only if this doesn't make it into the final 3.9, which will be the first
> version with KVM/arm.

Given that we're at rc6, I'd presume that's rather likely if you don't make a fuss about it :)


Alex
