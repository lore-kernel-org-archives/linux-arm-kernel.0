From: olof@lixom.net (Olof Johansson)
Date: Tue, 7 Feb 2017 11:21:15 -0800
Subject: [PATCH] ARM: ux500: cut some platform data
In-Reply-To: <2080077.OMxztrf17j@wuerfel>
References: <20170131210832.3377-1-linus.walleij@linaro.org>
 <2080077.OMxztrf17j@wuerfel>
Message-ID: <CAOesGMidfUAomiTzStaby6TUDE0rhbQcC1P8v3UHaMVnG9FrXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2017 at 7:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, January 31, 2017 10:08:32 PM CET Linus Walleij wrote:
>> This platform data is revoked: the drivers are getting the DMA
>> configuration from the device tree, it has been done like that
>> since the DMA support was merged and this data has not been used
>> since. The remaining auxdata is also unused.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ARM SoC folks: please apply this directly to the ux500/dev branch,
>> or if you want some separate cleanup branch. I originally
>> intended to send it along with other changes but those will land
>> in v4.12 or something instead.
>> ---
>>  arch/arm/mach-ux500/board-mop500-audio.c | 77 -----------------------------
>>  arch/arm/mach-ux500/board-mop500.h       | 17 -------
>>  arch/arm/mach-ux500/cpu-db8500.c         | 16 ------
>>  arch/arm/mach-ux500/ste-dma40-db8500.h   | 85 --------------------------------
>>  4 files changed, 195 deletions(-)
>>  delete mode 100644 arch/arm/mach-ux500/board-mop500-audio.c
>>  delete mode 100644 arch/arm/mach-ux500/board-mop500.h
>>  delete mode 100644 arch/arm/mach-ux500/ste-dma40-db8500.h
>
> Applied to next/soc, thanks!

Linus,

Looks like you missed to update the Makefile:
http://arm-soc.lixom.net/buildlogs/arm-soc/v4.10-rc5-794-gf8777f3/buildall.arm.allmodconfig.log.failed

I'll fix up in our tree, no need to send a patch.


-Olof
