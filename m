From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 07 Feb 2014 12:55:55 +0100
Subject: [PATCH v2 0/9] Samsung PM consolidation part 1 (clocks)
In-Reply-To: <CAJuA9ah97MQKrNeKG2vijFCr8b7T4r2Zr9gsGtETwtBLmKBrXg@mail.gmail.com>
References: <1391710616-14226-1-git-send-email-t.figa@samsung.com>
 <CAJuA9ah97MQKrNeKG2vijFCr8b7T4r2Zr9gsGtETwtBLmKBrXg@mail.gmail.com>
Message-ID: <52F4C9CB.6060901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/14 04:45, Thomas Abraham wrote:
> On Thu, Feb 6, 2014 at 11:46 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> > This series reworks suspend/resume handling of Samsung clock drivers
>> > to cover more SoC specific aspects that are beyond simple register
>> > save and restore. The goal is to have all the suspend/resume code
>> > that touches the clock controller in single place, which is the
>> > clock driver.
>> >
>> > On Exynos4210-based Trats, Exynos4412-based Trats2 and Exynos5250-based
>> > Arndale boards (except suspend/resume, which is broken because of
>> > unrelated reasons):
>> >
>> > Tested-by: Tomasz Figa <t.figa@samsung.com>
>> >
>> > Tomasz Figa (9):
>> >   clk: exynos4: Remove remnants of non-DT support
>> >   clk: samsung: Provide common helpers for register save/restore
>> >   clk: samsung: exynos4: Move suspend/resume handling to SoC driver
>> >   clk: samsung: exynos5250: Move suspend/resume handling to SoC driver
>> >   clk: samsung: exynos5420: Move suspend/resume handling to SoC driver
>> >   clk: samsung: s3c64xx: Move suspend/resume handling to SoC driver
>> >   clk: samsung: Drop old suspend/resume code
>> >   clk: samsung: exynos4: Add remaining suspend/resume handling
>> >   ARM: EXYNOS: pm: Drop legacy Exynos4 clock suspend/resume code
>> >
>> >  arch/arm/mach-exynos/pm.c            | 148 +-----------------------------
>> >  drivers/clk/samsung/clk-exynos4.c    | 172 +++++++++++++++++++++++++++++++----
>> >  drivers/clk/samsung/clk-exynos5250.c |  49 +++++++++-
>> >  drivers/clk/samsung/clk-exynos5420.c |  49 +++++++++-
>> >  drivers/clk/samsung/clk-exynos5440.c |   2 +-
>> >  drivers/clk/samsung/clk-s3c64xx.c    |  79 +++++++++++++---
>> >  drivers/clk/samsung/clk.c            |  71 ++++++---------
>> >  drivers/clk/samsung/clk.h            |  14 ++-
>> >  8 files changed, 348 insertions(+), 236 deletions(-)
>
> Nice series!
> Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>

Yes, that's a nice cleanup.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
