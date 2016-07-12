From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue, 12 Jul 2016 10:10:56 +0100
Subject: [PATCH 1/2] arm64: Refactor vDSO time functions
In-Reply-To: <20160711174224.GA21493@arm.com>
References: <1462797421-33103-1-git-send-email-kevin.brodsky@arm.com>
 <1462797421-33103-2-git-send-email-kevin.brodsky@arm.com>
 <20160708141143.GB6493@arm.com>
 <a3eda01b-b835-c20c-a39d-efc8853b00f8@arm.com>
 <20160711174224.GA21493@arm.com>
Message-ID: <27e33fe7-00aa-dc6a-a668-508a85e3beb5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/16 18:42, Will Deacon wrote:
> On Mon, Jul 11, 2016 at 06:31:16PM +0100, Kevin Brodsky wrote:
>> On 08/07/16 15:11, Will Deacon wrote:
>>> Fixup patch below. If you fold it in, then:
>>>
>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>>
>>> for the series.
>> I just have one small concern with your fixup patch: the ALIGN macro from
>> linkage.h (not the one from kernel.h, which is for C, not assembly) uses
>> 0x90 as padding, which apparently is NOP on x86 but does not make much sense
>> on ARM64 (or ARM for that matter). It is not currently used in arm{,64}. I
>> am not sure if it could decode to a valid instruction on ARM64, but maybe
>> using simply 0x0 as a padding byte would be less arbitrary. I also don't
>> like this ALIGN macro too much, because the "4" argument means something
>> different depending on the architecture (4 bytes on x86, 2^4 on arm*:
>> https://sourceware.org/binutils/docs/as/Align.html).
> ALIGN expands to __ALIGN which is defined in
> arch/arm64/include/asm/linkage.h as .align 4.
>
> You're 4 years late ;)
>
> http://git.kernel.org/linus/aeed41a9371e
>
> Will
>

Oh, sorry, didn't pay attention to the #ifndef __ALIGN in linux/linkage.h... All good
for me then, I will repost it.

Thanks,
Kevin
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
