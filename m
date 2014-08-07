From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 7 Aug 2014 09:07:51 +0200
Subject: [PATCH 1/2] UEFI arm64: add noefi boot param
In-Reply-To: <20140807012847.GB20295@darkstar.nay.redhat.com>
References: <20140806083825.GA31711@dhcp-16-198.nay.redhat.com>
 <CAKv+Gu83+OtTkM+tEkB4AKpqHg2qGXtfAxC-pQq0u9ez+VjwaA@mail.gmail.com>
 <20140807012847.GB20295@darkstar.nay.redhat.com>
Message-ID: <7F205346-C978-4FC1-8812-2A37AFA06312@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 7 aug. 2014, at 03:28, Dave Young <dyoung@redhat.com> wrote:
> 
>> On 08/06/14 at 02:40pm, Ard Biesheuvel wrote:
>>> On 6 August 2014 10:38, Dave Young <dyoung@redhat.com> wrote:
>>> 
>>> Adding a noefi boot param like in X86 to disable efi runtime services support.
>>> 
>>> This will be useful for debugging uefi problems. Also it will be useful
>>> for later kexec/kdump work. Kexec on uefi support in X86 depends on a fixed vm
>>> area specific for uefi runtime 1:1 mapping, kernel will switch to a different
>>> page table for any uefi runtime callback in virtual mode. In arm64 similar
>>> work probably is necessary. But kexec boot will just works with 'noefi' with
>>> the limitaion of lacking runtime services. The runtime services is not critical
>>> for kdump kernel for now. So as for kexec/kdump just leave the 1:1 mapping a
>>> future work.
>> 
>> Can we find a better name? You will still be using the UEFI memory map
>> rather than the DT memory nodes (which will have been deleted by the
>> stub), and things like SMBIOS and ACPI that hinge off UEFI remain
>> enabled as well.
> Hi, Ard
> 
> Leif suggested efi=noruntime, I think that will be better to you?
> 

Yes, that sounds perfect to me

Ard.

> Thanks for review.
> Dave
