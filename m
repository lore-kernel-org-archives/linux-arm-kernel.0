From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Apr 2014 15:27:34 +0100
Subject: [PATCH v10 05/12] ARM/ARM64: KVM: Make kvm_psci_call() return
 convention more flexible
In-Reply-To: <20140428141743.GG2868@lvm> (Christoffer Dall's message of "Mon,
 28 Apr 2014 15:17:43 +0100")
References: <1398085206-30555-1-git-send-email-anup.patel@linaro.org>
 <1398085206-30555-6-git-send-email-anup.patel@linaro.org>
 <20140428141743.GG2868@lvm>
Message-ID: <87ha5dttpl.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28 2014 at  3:17:43 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Mon, Apr 21, 2014 at 06:29:59PM +0530, Anup Patel wrote:
>> Currently, the kvm_psci_call() returns 'true' or 'false' based on whether
>> the PSCI function call was handled successfully or not. This does not help
>> us emulate system-level PSCI functions where the actual emulation work will
>> be done by user space (QEMU or KVMTOOL). Examples of such system-level PSCI
>> functions are: PSCI v0.2 SYSTEM_OFF and SYSTEM_RESET.
>> 
>> This patch updates kvm_psci_call() to return three types of values:
>> 1) > 0 (success)
>> 2) = 0 (success but exit to user space)
>> 3) < 0 (errors)
>> 
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>
> Marc, do you still have comments on this one?

No, this one is OK:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
