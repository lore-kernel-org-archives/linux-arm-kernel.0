From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 25 May 2017 14:22:04 +0530
Subject: [PATCH 2/3] gpio: pcf857x: move header file out of I2C realm
In-Reply-To: <CACRpkdZzrtP0Jr5ZnOJrN9CZQDO1CXgW7Z9jTw1Mt_MkP0Saqw@mail.gmail.com>
References: <20170521215727.1243-1-wsa@the-dreams.de>
 <20170521215727.1243-3-wsa@the-dreams.de>
 <CACRpkdZzrtP0Jr5ZnOJrN9CZQDO1CXgW7Z9jTw1Mt_MkP0Saqw@mail.gmail.com>
Message-ID: <41555985-34c3-da9c-e4a4-f61d4eb2ec38@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tuesday 23 May 2017 03:05 PM, Linus Walleij wrote:
> On Sun, May 21, 2017 at 11:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> 
>> include/linux/i2c is not for client devices. Move the header file to a
>> more appropriate location.
>>
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>> ---
>>  arch/arm/mach-davinci/board-da830-evm.c        | 2 +-
>>  arch/arm/mach-davinci/board-dm644x-evm.c       | 2 +-
>>  arch/arm/mach-davinci/board-dm646x-evm.c       | 2 +-
>>  arch/arm/mach-pxa/balloon3.c                   | 2 +-
>>  arch/arm/mach-pxa/stargate2.c                  | 2 +-
>>  arch/mips/ath79/mach-pb44.c                    | 2 +-
>>  drivers/gpio/gpio-pcf857x.c                    | 2 +-
>>  include/linux/{i2c => platform_data}/pcf857x.h | 0
>>  8 files changed, 7 insertions(+), 7 deletions(-)
>>  rename include/linux/{i2c => platform_data}/pcf857x.h (100%)
> 
> Patch applied.
> 
> BTW ARM SoC maintainers be warned, I optimistically assume this will
> not collide with any ARM SoC work...

Thanks for the heads-up. The mach-davinci part does not clash with
anything I have queued. I added this patch to a branch of my tree which
I merge together but don't sent upstream. So I will know if I end up
queuing anything which clashes.

Thanks,
Sekhar
