From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Mar 2013 11:54:53 +0000
Subject: [PATCH 16/29] arm64: KVM: HYP mode world switch implementation
In-Reply-To: <514A1641.6030709@codeaurora.org>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-17-git-send-email-marc.zyngier@arm.com>
 <5140DA96.3070403@codeaurora.org> <514A1641.6030709@codeaurora.org>
Message-ID: <514AF50D.8060206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/13 20:04, Christopher Covington wrote:
> Hi Marc,
> 
> On 03/13/2013 03:59 PM, Christopher Covington wrote:
> 
> [...]
> 
>> Alternatively, you could consider storing the host registers in a
>> slimmed-down vcpu structure for hosts, rather than on the stack.

I am actively implementing this (I'm turning the vfp_host pointer into a
full blown CPU context). It looks promising so far, stay tuned.

> One potential argument for storing the host in the same sort of vcpu structure
> as the guest rather than on the hypervisor stack is that snapshot and
> migration support initially intended for guests might more easily be extended
> to work for hosts as well.

Not sure I'm following you here. Are you thinking of snapshoting both
host and guests, and migrating the whole thing? Ambitious... ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
