From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 8 Sep 2017 14:54:32 +0100
Subject: [PATCH v2 5/7] arm: efi: split zImage code and data into separate
 PE/COFF sections
In-Reply-To: <87r2vhs3il.fsf@free-electrons.com>
References: <20170629081849.15081-1-ard.biesheuvel@linaro.org>
 <20170629081849.15081-6-ard.biesheuvel@linaro.org>
 <87r2vhs3il.fsf@free-electrons.com>
Message-ID: <CAKv+Gu9DVRE6jGEvdkfWwaJDhmTeaF2-CMi=JdFx3GS2Qqdy3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2017 at 14:50, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Ard,
>
>  On jeu., juin 29 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> To prevent unintended modifications to the kernel text (malicious or
>> otherwise) while running the EFI stub, describe the kernel image as
>> two separate sections: a .text section with read-execute permissions,
>> covering .text, .rodata, .piggytext and the GOT sections (which the
>> stub does not care about anyway), and a .data section with read-write
>> permissions, covering .data and .bss.
>>
>> This relies on the firmware to actually take the section permission
>> flags into account, but this is something that is currently being
>> implemented in EDK2, which means we will likely start seeing it in
>> the wild between one and two years from now.
>
> This patch had been merged in mainline yesterday and now prevent the
> Marvell Armada 370 and the Armada XP based SoC to boot. I also suspect
> that more Socs are impacted because the number of boot fail exploded
> according to kci:
> https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.13-8899-g8dc5b3a6cb2f/
>

Ouch.

> I found this patch after bisecting (I can provide the bisect log if
> needed).
>
> The kernel failed to boot only if CONFIG_EFI is enabled so it occurs in
> multi_v7_defconfig but not with mvebu_v7_defconfig.
>
> Currently the solution is to revert this patch.
>
> Have you a better option?
>

I will investigate.
