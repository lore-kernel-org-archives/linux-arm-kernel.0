From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 01 Dec 2015 13:34:47 +0000
Subject: [PATCH v2 08/21] arm64: KVM: Implement debug save/restore
In-Reply-To: <871tb6b92b.fsf@linaro.org>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
 <1448650215-15218-9-git-send-email-marc.zyngier@arm.com>
 <20151201125639.GP11704@cbox> <565D9B57.2080005@arm.com>
 <871tb6b92b.fsf@linaro.org>
Message-ID: <565DA1F7.7060900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 13:19, Alex Benn?e wrote:
> 
> Marc Zyngier <marc.zyngier@arm.com> writes:
> 
>> On 01/12/15 12:56, Christoffer Dall wrote:
>>> On Fri, Nov 27, 2015 at 06:50:02PM +0000, Marc Zyngier wrote:
>>>> Implement the debug save restore as a direct translation of
>>>> the assembly code version.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  arch/arm64/kvm/hyp/Makefile   |   1 +
>>>>  arch/arm64/kvm/hyp/debug-sr.c | 130 ++++++++++++++++++++++++++++++++++++++++++
>>>>  arch/arm64/kvm/hyp/hyp.h      |   9 +++
>>>>  3 files changed, 140 insertions(+)
>>>>  create mode 100644 arch/arm64/kvm/hyp/debug-sr.c
> <snip>
>>>> +void __hyp_text __debug_cond_save_host_state(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +	if ((vcpu->arch.ctxt.sys_regs[MDSCR_EL1] & DBG_MDSCR_KDE) ||
>>>> +	    (vcpu->arch.ctxt.sys_regs[MDSCR_EL1] & DBG_MDSCR_KDE))
> 
> I've just noticed I'm seeing double here. Did a DBG_MDSCR_MDE can
> transliterated here?

Quite probably! Guess there is a small hole in your test suite! ;-)

Thanks for noticing this.

	M.
-- 
Jazz is not dead. It just smells funny...
