From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Sep 2015 15:46:17 +0100
Subject: [PATCH] arm64: KVM: Fix user access for debug registers
In-Reply-To: <87wpvqmnxw.fsf@linaro.org>
References: <1442400070-23316-1-git-send-email-marc.zyngier@arm.com>
 <20150916134141.GA15903@cbox> <87wpvqmnxw.fsf@linaro.org>
Message-ID: <55F980B9.6080601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/15 15:35, Alex Benn?e wrote:
> 
> Christoffer Dall <christoffer.dall@linaro.org> writes:
> 
>> On Wed, Sep 16, 2015 at 11:41:10AM +0100, Marc Zyngier wrote:
>>> When setting the debug register from userspace, make sure that
>>> copy_from_user() is called with its parameters in the expected
>>> order. It otherwise doesn't do what you think.
>>>
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: Alex Benn?e <alex.bennee@linaro.org>
>>> Fixes: 84e690bfbed1 ("KVM: arm64: introduce vcpu->arch.debug_ptr")
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> yikes!
> 
> OK I'm now muchly confused as to how it could have worked...

Well, we only write the registers at boot time, and corrupting userspace
did go unnoticed. I was only able to reproduce this on a model with PAN
enabled.

Copy-paste bug.

	M.
-- 
Jazz is not dead. It just smells funny...
