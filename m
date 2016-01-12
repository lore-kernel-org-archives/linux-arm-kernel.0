From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 12 Jan 2016 12:55:21 +0100
Subject: [PATCH] arm64: split elf relocs into a separate header.
In-Reply-To: <20160108155932.GE11228@arm.com>
References: <20160108123614.GC3097@leverpostej>
 <1452256909-30881-1-git-send-email-mark.rutland@arm.com>
 <20160108155932.GE11228@arm.com>
Message-ID: <CAKv+Gu9ZP-wUhusEq3bJ2i5fou3-g63sWdFDtm-puL_O+VRvWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2016 at 16:59, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jan 08, 2016 at 12:41:49PM +0000, Mark Rutland wrote:
>> Currently asm/elf.h contains a mixture of simple constants, C structure
>> definitions, and some constants defined terms of constants from other
>> headers (which are themselves mixtures).
>>
>> To enable the use of AArch64 ELF reloc constants from assembly code (s
>> we will need for relocatable kernel support), we need an include without
>> C structure definitions or incldues of other files with such
>> definitions.
>>
>> This patch factors out the relocs into a new header specifically for ELF
>> reloc types.
>
> Does #ifdef __ASSEMBLY__ not do the trick?
>

Actually, it does. The includes in asm/elf.h are guarded that way
themselves, so it is simply a matter of moving the C declarations
inside a #ifndef __ASSEMBLY__ block
