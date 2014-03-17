From: anup@brainfault.org (Anup Patel)
Date: Mon, 17 Mar 2014 11:41:14 +0530
Subject: [PATCH v4 00/10] In-kernel PSCI v0.2 emulation for KVM ARM/ARM64
In-Reply-To: <20140317033926.GA20648@cbox>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <20140317033926.GA20648@cbox>
Message-ID: <CAAhSdy1FaSL_cE7hLm9DNTApHAq-ZQbcAvsPCNG_Rnx=SbPG-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 9:09 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Feb 06, 2014 at 05:01:32PM +0530, Anup Patel wrote:
>> Currently, KVM ARM/ARM64 only provides in-kernel emulation of Power State
>> and Coordination Interface (PSCI) v0.1.
>>
>> This patchset aims at providing newer PSCI v0.2 for KVM ARM/ARM64 VCPUs
>> such that it does not break current KVM ARM/ARM64 ABI. Also, the patchset
>> provides emulation of only few PSCI v0.2 functions such as PSCI_VERSION,
>> CPU_ON, and CPU_OFF. Emulation of other PSCI v0.2 functions will be added
>> later.
>
> This doesn't seem to be true any longer does it?

Copy-Paste Error !!!!

I will correct this.

>
>>
>> The user space tools (i.e. QEMU or KVMTOOL) will have to explicitly enable
>> KVM_ARM_VCPU_PSCI_0_2 feature using KVM_ARM_VCPU_INIT ioctl for providing
>> PSCI v0.2 to VCPUs.
>>
>
> Besides the stuff you already added, I think you need to also add
> returning ALREADY_ON for the CPU_ON call if the VCPU requested is
> already on.

OK, I will add it. Thanks for pointing.

>
> Thanks,
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--
Anup
