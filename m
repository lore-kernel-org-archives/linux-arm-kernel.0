From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 17 Jan 2014 16:26:50 +0100
Subject: [PATCH v2 resend 1/5] ARM: add support for AT_HWCAP2 ELF auxv
 entry
In-Reply-To: <20140117150725.GK16003@mudshark.cambridge.arm.com>
References: <1389950591-4212-1-git-send-email-ard.biesheuvel@linaro.org>
 <1389950591-4212-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140117150725.GK16003@mudshark.cambridge.arm.com>
Message-ID: <CAKv+Gu-dZZ4yzkDoHoHVRgW1KQ7H3PLy-OV731Es8BNmpkYqLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 January 2014 16:07, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> On Fri, Jan 17, 2014 at 09:23:07AM +0000, Ard Biesheuvel wrote:
>> This enables AT_HWCAP2 for ARM. The generic support for this
>> new ELF auxv entry was added in commit 2171364d1a9 (powerpc:
>> Add HWCAP2 aux entry)
>
> Does this require a corresponding change in libc so that the entry is
> actually used by the dynamic linker?
>

The auxv entry itself is already wired up [this includes getauxval()]

https://sourceware.org/git/?p=glibc.git;a=commit;h=1ae8bfe07c1a

The only thing that is lacking is a way to hook up ifunc relocation,
as the current prototype passes a single 32-bit quantity.
So either we change the prototype to (hwcap, hwcap2) or we need to
rely on getauxval() in ifunc selectors if they need to inspect hwcap2

-- 
Ard.
