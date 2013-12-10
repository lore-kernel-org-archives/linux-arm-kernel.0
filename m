From: anup@brainfault.org (Anup Patel)
Date: Tue, 10 Dec 2013 21:01:39 +0530
Subject: [PATCH 2/2] ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and
 SYSTEM_RESET to user space
In-Reply-To: <52A6F38D.4000109@arm.com>
References: <1385394599-15439-1-git-send-email-anup.patel@linaro.org>
 <1385394599-15439-3-git-send-email-anup.patel@linaro.org>
 <20131209225156.GD22760@cbox>
 <CAAhSdy2zM49tOon9x41JNbw4w_UROXNm1pFE0ku_whs+LddhWA@mail.gmail.com>
 <52A6F38D.4000109@arm.com>
Message-ID: <CAAhSdy2owBU3rh2g-KJXbKqp-Cy5Zm699Te_23Wo7-C5sHfN6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 4:27 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 10/12/13 05:05, Anup Patel wrote:
>> On Tue, Dec 10, 2013 at 4:21 AM, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>>> On Mon, Nov 25, 2013 at 09:19:59PM +0530, Anup Patel wrote:
>>>> @@ -39,9 +44,6 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>>>
>>>>  static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>>>  {
>>>> -     if (kvm_psci_call(vcpu))
>>>> -             return 1;
>>>> -
>>>
>>> Isn't this an unrelated change, which should go in a separate patch with
>>> some justification text for the change?
>>
>> Actually, handle_smc() was already using kvm_psci_call() so I had to change
>> it anyway because of changes in kvm_psic_call(). Also, user space emulation
>> of SMC-based PSCI is going to be different from in-kernel HVC-based PSCI
>> emulation hence, for now it seemed more appropriate to inject undefined
>> exception for KVM arm64 (just like KVM arm).
>
> Doh. I though I got rid of that.
>
> That chunk should have been been removed ages ago (probably before
> merging the arm64 code), as per 24a7f6757.
>
> Please make it a separate patch, and I'll merge that independently.

Sure, I'll make this a separate patch and send it soon.

--
Anup

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
