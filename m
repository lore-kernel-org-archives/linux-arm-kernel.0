From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 24 Feb 2016 09:37:46 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.5
In-Reply-To: <20160224080803.GD30231@localhost>
References: <cover.1455859965.git.horms+renesas@verge.net.au>
 <20160224080803.GD30231@localhost>
Message-ID: <CAMuHMdWxXFf0MFKP27y6g7CUc1MeG0PuJ-FdoSkV+2gB5NvQTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Feb 24, 2016 at 9:08 AM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Feb 19, 2016 at 03:09:46PM +0900, Simon Horman wrote:
>> Please consider these Renesas ARM based SoC fixes for v4.5.
>>
>> This pull request is comprised of patches from Geert Uytterhoeven to avoid
>> writing to .text.
>>
>> * "ARM: shmobile: Move shmobile_scu_base from .text to .bss"
>>
>>   Resolves a problem for XIP kernels as writing to .text is not allowed.
>>   For non-XIP kernels a problem does not manifst as the pages are mapped
>>   read-only during late kernel startup.
>>
>> * The remaining patches resolve a kernel-crash that occurs during system
>>   suspend for CONFIG_DEBUG_RODATA=y kernels.
>>
>>
>> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
>>
>>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-fixes-for-v4.5
>>
>> for you to fetch changes up to 901c5ffaaed117a38be9d0c29247c4888d6c8636:
>>
>>   ARM: shmobile: Remove shmobile_boot_arg (2016-02-17 18:27:21 +0900)
>
> Hi Simon, Geert,
>
> I don't think any of these fixes are for regressions, are they? I.e. this is
> work to enable configs that never used to work (XIP, CONFIG_DEBUG_RODATA)?

These configs indeed never worked before.

However,

commit 25362dc496edaf17f714c0fecd8b3eb79670207b
Author: Kees Cook <keescook@chromium.org>
Date:   Tue Jan 26 01:19:36 2016 +0100

    ARM: 8501/1: mm: flip priority of CONFIG_DEBUG_RODATA

in arm/for-next will enable CONFIG_DEBUG_RODATA by default.

Not having the fixes in v4.5 means that if Russell's tree is merged
into mainline
for v4.6 before arm-soc, it will cause regressions and bisection issues.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
