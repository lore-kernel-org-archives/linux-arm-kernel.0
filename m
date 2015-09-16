From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Sep 2015 15:06:57 +0100
Subject: [PATCH] arm64: KVM: Fix user access for debug registers
In-Reply-To: <20150916134141.GA15903@cbox>
References: <1442400070-23316-1-git-send-email-marc.zyngier@arm.com>
 <20150916134141.GA15903@cbox>
Message-ID: <55F97781.1060502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/15 14:41, Christoffer Dall wrote:
> On Wed, Sep 16, 2015 at 11:41:10AM +0100, Marc Zyngier wrote:
>> When setting the debug register from userspace, make sure that
>> copy_from_user() is called with its parameters in the expected
>> order. It otherwise doesn't do what you think.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Alex Benn?e <alex.bennee@linaro.org>
>> Fixes: 84e690bfbed1 ("KVM: arm64: introduce vcpu->arch.debug_ptr")
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>
> yikes!
>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>

Thanks. Merged and pushed out to -next, together with the physaddr_t patch.

        M.
--
Jazz is not dead. It just smells funny...

________________________________

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
