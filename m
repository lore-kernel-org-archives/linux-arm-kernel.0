From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 7 Sep 2014 12:06:34 +0200
Subject: [PATCH v3 2/2] arm/arm64: KVM: Support KVM_CAP_READONLY_MEM
In-Reply-To: <CAKv+Gu-ph_eRvX=bCcryQHx02fTXcaXeHWxyUeyhbhsD2VJ5gg@mail.gmail.com>
References: <1409053393-13768-1-git-send-email-christoffer.dall@linaro.org>
 <1409053393-13768-2-git-send-email-christoffer.dall@linaro.org>
 <CAKv+Gu-ph_eRvX=bCcryQHx02fTXcaXeHWxyUeyhbhsD2VJ5gg@mail.gmail.com>
Message-ID: <CAMJs5B__CFvVHU46_m6H3kNp4rXqQdEZmAP2=j4sCjcJLDG1OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 7, 2014 at 11:36 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 26 August 2014 13:43, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> When userspace loads code and data in a read-only memory regions, KVM
>> needs to be able to handle this on arm and arm64.  Specifically this is
>> used when running code directly from a read-only flash device; the
>> common scenario is a UEFI blob loaded with the -bios option in QEMU.
>>
>> Note that the MMIO exit on writes to a read-only memory is ABI and can
>> be used to emulate block-erase style flash devices.
>>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>

Thanks!

> Are these on track for 3.18?
>
yes, already in kvmarm/next.

-Christoffer
