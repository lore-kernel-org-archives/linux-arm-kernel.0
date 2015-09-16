From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 16 Sep 2015 15:35:55 +0100
Subject: [PATCH] arm64: KVM: Fix user access for debug registers
In-Reply-To: <20150916134141.GA15903@cbox>
References: <1442400070-23316-1-git-send-email-marc.zyngier@arm.com>
 <20150916134141.GA15903@cbox>
Message-ID: <87wpvqmnxw.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Christoffer Dall <christoffer.dall@linaro.org> writes:

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

OK I'm now muchly confused as to how it could have worked...

>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

-- 
Alex Benn?e
