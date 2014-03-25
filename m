From: agnel.joel@gmail.com (Joel Fernandes)
Date: Tue, 25 Mar 2014 08:43:39 -0500
Subject: [Qemu-devel] [PATCH] QEMU: ARM: boot: Load kernel at an Image
 friendly address
In-Reply-To: <533176B1.9060103@codeaurora.org>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <533176B1.9060103@codeaurora.org>
Message-ID: <CAD=GYpaiksus3_9q=KYPFA8WPDqOphYj7oaB2PAfj6Om_VO72w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 7:29 AM, Christopher Covington
<cov@codeaurora.org> wrote:
> Hi Joel,
>
> On 03/24/2014 11:34 PM, Joel Fernandes wrote:
>> Loading kernel at offset 0x10000 works only for zImage, but not for Image,
>> because the kernel expect the start of decompressed kernel (.head.text) to be
>
> Nit: expects
>
>> at an address that's a distance that's 16MB aligned from  PAGE_OFFSET +
>> TEXT_OFFSET (see vmlinux.lds.S). This check is enfornced in __fixup_pv_table in
>
> Nit: enforced
>
>> arch/arm/kernel/head.S TEXT_OFFSET is 0x00008000, so a 16MB alignment needs to
>> have a "0x8000" in the lower 16 bits so that they cancel out. Currently the
>> offset Qemu loads it at is 0x10000.
>>
>> With zImage, this need is met because zImage loads the uncompressed Image
>> correctly, however when loading an Image and executing directly Qemu is
>> required it to load it at the correct location. Doing so, doesn't break Qemu's
>> zImage loading. With this patch, both zImage and Image work correctly.
>
> I had just been playing with my own version of this change. Glad to see it
> going upstream.
>
> Tested-by: Christopher Covington <cov@codeaurora.org>
>

Thanks, I updated the patch with these changes.

-Joel
