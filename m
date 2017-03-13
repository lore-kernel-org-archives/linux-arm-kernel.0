From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Mar 2017 18:03:00 +0000
Subject: [PATCH v3 02/25] arm64: KVM: Implement HVC_RESET_VECTORS stub
 hypercall
In-Reply-To: <58C6DCB7.1010705@arm.com> (James Morse's message of "Mon, 13 Mar
 2017 17:53:59 +0000")
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <20170306142458.8875-3-marc.zyngier@arm.com>
 <58C6DCB7.1010705@arm.com>
Message-ID: <87a88pt5pn.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13 2017 at  5:53:59 pm GMT, James Morse <james.morse@arm.com> wrote:
> On 06/03/17 14:24, Marc Zyngier wrote:
>> In order to restore HYP mode to its original condition, KVM currently
>> implements __kvm_hyp_reset(). As we're moving towards a hyp-stub
>> defined API, it becomes necessary to implement HVC_RESET_VECTORS.
>> 
>> This patch adds the HVC_RESET_VECTORS hypercall to the KVM init
>> code, which so far lacked any form of hypercall support.
>
> (Nit: other patches to the init code in this series have 'init' in the subject,
> this one doesn't.)

Good point, I'll update the series locally to reflect this.

> Reviewed-by: James Morse <james.morse@arm.com>

Thanks!

	M.
-- 
Jazz is not dead, it just smell funny.
