From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 3 Apr 2014 10:07:30 -0700
Subject: [PATCH] ARM: KVM: Handle IPA unmapping on memory region deletion
In-Reply-To: <533D7D8B.2030806@arm.com>
References: <1396538266-13245-1-git-send-email-eric.auger@linaro.org>
 <533D7D8B.2030806@arm.com>
Message-ID: <CAMJs5B-YP8dsiapL=wpue5zhH1DruKENvAPtzNnvvRbCvqU-HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2014 08:26, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Eric,
>
> On 03/04/14 16:17, Eric Auger wrote:
>> Currently when a KVM region is removed using
>> kvm_vm_ioctl_set_memory_region (with memory region size equal to 0), the
>> corresponding intermediate physical memory is not unmapped.
>>
>> This patch unmaps the region's IPA range in
>> kvm_arch_commit_memory_region using unmap_stage2_range.
>>
>> The patch was tested on QEMU VFIO based use case where RAM memory region
>> creation/deletion frequently happens for IRQ handling.
>>
>> Notes:
>> - the KVM_MR_MOVE case shall request some similar addition but I cannot test
>>   this currently
>
> I think you should try to handle it anyway. I'm sure you could hack QEMU
> to do this test it, but even if you don't, better plug that hole right now.
>
I don't think we want untested code in the kernel if we can avoid it,
so I would say, either test it somehow (kvm-unit-tests ?) or print a
warning...?

-Christoffer
