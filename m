From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Sep 2017 18:30:26 +0100
Subject: [PATCH v2 16/29] ARM: kernel: switch to relative exception tables
In-Reply-To: <nycvar.YSQ.7.76.1709041311230.8603@knanqh.ubzr>
References: <20170903120757.14968-1-ard.biesheuvel@linaro.org>
 <20170903120757.14968-17-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1709041311230.8603@knanqh.ubzr>
Message-ID: <CAKv+Gu_wgTk0GdPiR5qvTDXqiX+ZUJ_s7Zs68i2Z4VHW+CcXyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 September 2017 at 18:17, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sun, 3 Sep 2017, Ard Biesheuvel wrote:
>
>> To avoid having to relocate the contents of extable entries at
>> runtime when running with KASLR enabled, wire up the existing
>> support for emitting them as relative references. This ensures
>> these quantities are invariant under runtime relocation.
>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Could it be better to have a macro that encapsulates exception entries
> e.g.:
>
>         .macro ex_entry insn fixup
>         .long   \insn - ., \fixup - .
>         .endif
>
> so that if ever this changes again or for whatever reason someone needs
> absolute entries then this won't have to be done everywhere. The section
> switch could be included in such a macro too. And it is so easy to
> forget to do the "- ." when adding new entries.
>

Good point. I will change that.
