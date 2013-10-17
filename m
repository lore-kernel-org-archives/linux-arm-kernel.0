From: anup@brainfault.org (Anup Patel)
Date: Thu, 17 Oct 2013 11:55:54 +0530
Subject: [RFC PATCH 1/5] ARM/ARM64: KVM: Update user space API header for
 PSCI emulation
In-Reply-To: <20131016203051.GD24837@cbox>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-2-git-send-email-anup.patel@linaro.org>
 <20131016203051.GD24837@cbox>
Message-ID: <CAAhSdy0pKiWG=2q7JMkdfRDiT91b46bighDP3yqcaBoTFckRUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 2:00 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Wed, Oct 16, 2013 at 10:32:30PM +0530, Anup Patel wrote:
>> Update user space API interface headers for providing information to
>> user space needed to emulate PSCI function calls in user space (i.e.
>> QEMU or KVMTOOL).
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  include/uapi/linux/kvm.h |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index e32e776..dae2664 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -171,6 +171,7 @@ struct kvm_pit_config {
>>  #define KVM_EXIT_WATCHDOG         21
>>  #define KVM_EXIT_S390_TSCH        22
>>  #define KVM_EXIT_EPR              23
>> +#define KVM_EXIT_PSCI             24
>>
>>  /* For KVM_EXIT_INTERNAL_ERROR */
>>  /* Emulate instruction failed. */
>> @@ -301,6 +302,12 @@ struct kvm_run {
>>               struct {
>>                       __u32 epr;
>>               } epr;
>> +             /* KVM_EXIT_PSCI */
>> +             struct {
>> +                     __u32 fn;
>> +                     __u64 args[7];
>> +                     __u64 ret[4];
>> +             } psci;
>>               /* Fix the size of the union. */
>>               char padding[256];
>>       };
>> --
>> 1.7.9.5
>>
>
> I think you'd need a KVM_CAP_PSCI or something here so that QEMU can
> know to mmap this much, no?
>
> Also, it would be easier if you just added the documentation for this
> change together with this patch IMHO.

Yes, I think its good atleast advertise KVM_CAP_PSCI to QEMU. I'll add it
in revised patch.

>
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

--
Anup
