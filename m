From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 02 Dec 2015 15:23:56 +0000
Subject: [PATCH v2 16/21] arm64: KVM: Add compatibility aliases
In-Reply-To: <20151202114920.GB18376@cbox>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
 <1448650215-15218-17-git-send-email-marc.zyngier@arm.com>
 <20151202114920.GB18376@cbox>
Message-ID: <565F0D0C.9010801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/15 11:49, Christoffer Dall wrote:
> On Fri, Nov 27, 2015 at 06:50:10PM +0000, Marc Zyngier wrote:
>> So far, we've implemented the new world switch with a completely
>> different namespace, so that we could have both implementation
>> compiled in.
>>
>> Let's take things one step further by adding weak aliases that
>> have the same names as the original implementation. The weak
>> attributes allows the new implementation to be overriden by the
>> old one, and everything still work.
> 
> Do I understand correctly that the whole point of this is to keep
> everything compiling nicely while at the same time being able to split
> the patches so that you can have an isolated "remove old code" patch
> that doesn't have to change the callers?

Exactly.

> If so, I think explaining this rationale would be helpful in the commit
> message in case we have to go back and track these changes in connection
> with a regression and don't remember why we did things this way.

Fair enough. I'll update the commit message (possibly by stealing a
large part of the above text!).

> Maybe I'm being over-cautious though...
> 
> Otherwise:
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
