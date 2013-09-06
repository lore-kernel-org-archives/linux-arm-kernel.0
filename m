From: anup@brainfault.org (Anup Patel)
Date: Fri, 6 Sep 2013 15:43:35 +0530
Subject: [RFC PATCH 3/3] KVM: ARM: Update documentation for
 KVM_ARM_VCPU_INIT ioctl
In-Reply-To: <52298CB7.6060501@huawei.com>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
 <1378392362-6773-4-git-send-email-anup.patel@linaro.org>
 <52298CB7.6060501@huawei.com>
Message-ID: <CAAhSdy0aGnX6wrYbM-81MgtVOW4Pr_eCr2uZZqsr9P55wuyxLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 6, 2013 at 1:35 PM, Claudio Fontana
<claudio.fontana@huawei.com> wrote:
> Hi Anup,
>
> I am no native English speaker, but this is my attempt at improving the descriptions:
>
> On 05.09.2013 16:46, Anup Patel wrote:
>> To implement target type KVM_ARM_TARGET_HOST we make the
>> KVM_ARM_VCPU_INIT ioctl bi-direction so that KVM ARM/ARM64
>> can return appropriate target type to user space via
>> struct kvm_vcpu_init.
>
> If I understood correctly:
>
> To implement target type KVM_ARM_TARGET_HOST we change
> the "struct kvm_cpu_init" input parameter into an in/out
> parameter, so that KVM ARM/ARM64 can inform user space about
> the chosen target type.

Yes, you got it right.

Actually, KVM will return back both VCPU target type and VCPU
features that KVM will be emulating for the VCPU.

>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  Documentation/virtual/kvm/api.txt |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index ef925ea..c0a3a05 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -2283,7 +2283,7 @@ current state.  "addr" is ignored.
>>  Capability: basic
>>  Architectures: arm, arm64
>>  Type: vcpu ioctl
>> -Parameters: struct struct kvm_vcpu_init (in)
>> +Parameters: struct kvm_vcpu_init (in/out)
>>  Returns: 0 on success; -1 on error
>>  Errors:
>>    EINVAL:    the target is unknown, or the combination of features is invalid.
>> @@ -2303,6 +2303,9 @@ Possible features:
>>       - KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
>>         Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
>>
>> +This ioctl returns updated struct kvm_vcpu_init showing VCPU target
>> +type and VCPU features that will be available.
>> +
>
> This ioctl returns an updated struct kvm_vcpu_init informing about the
> chosen VCPU target type and available VCPU features.
>
>>
>>  4.83 KVM_GET_REG_LIST
>>
>>
>
> Ciao,
>
> Claudio
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards,
Anup
