From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Sep 2013 12:24:37 +0200
Subject: [PATCH v3 0/5] kernel mode NEON support
In-Reply-To: <20130922101155.GP12758@n2100.arm.linux.org.uk>
References: <1373321521-15485-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130922101155.GP12758@n2100.arm.linux.org.uk>
Message-ID: <EE9C6CC6-FB18-483F-9AC7-66FD40E2BA77@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 22 sep. 2013, at 12:11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
>> On Mon, Jul 08, 2013 at 11:11:56PM +0100, Ard Biesheuvel wrote:
>> This is version 3 of the kernel mode NEON patch set.
> 
> I've noticed some of the randconfigs are failing due to trying to mix
> VFP and FPA objects together, which causes the linker to complain.
> 
> I thought about adding -Wa,-mfpu=softvfp, but this overrides your
> -mfpu=neon resulting in the neon code failing to build.  -mfpu=softvfp
> doesn't work because GCC and binutils don't take the same -mfpu=
> option names (GCC rejects softvfp, whereas the assembler accepts it.)
> 
> This only happens when AEABI is not selected, so I think the only
> solution to this is to make KERNEL_MODE_NEON depend on AEABI - and
> this is what I've committed to my tree today.

This makes perfect sense, especially as neon code may assume an 8 byte aligned stack, which i suppose is not guaranteed when !AEABI.

Regards,
Ard.
