From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 21 Aug 2012 17:29:54 +0800
Subject: [PATCH 2/3] ARM: PRIMA2: make mach-prima2 common for all SiRF
 series SoC
In-Reply-To: <CAGsJ_4ynJjm6WuA6NGZdOgj80Xc=ZxKcRatQuEacVW=EXuxh=w@mail.gmail.com>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <1345450787-17246-3-git-send-email-Barry.Song@csr.com>
 <201208202106.43206.arnd@arndb.de>
 <CAGsJ_4ynJjm6WuA6NGZdOgj80Xc=ZxKcRatQuEacVW=EXuxh=w@mail.gmail.com>
Message-ID: <CAGsJ_4zBEgexWBWsKCe2UtfP1m7BSMO9dq8thi3oQVYsq22v+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/21 Barry Song <21cnbao@gmail.com>:
> 2012/8/21 Arnd Bergmann <arnd@arndb.de>:
>> On Monday 20 August 2012, Barry Song wrote:
>>> From: Barry Song <Baohua.Song@csr.com>
>>>
>>> We will have SiRF Marco and Polo, so rename the dir to mach-sirf
>>> and add Kconfig menu
>>>
>>> Signed-off-by: Baohua Song <Baohua.Song@csr.com>
>>> ---
>>>  arch/arm/Kconfig                                   |   10 +++++-----
>>>  arch/arm/Makefile                                  |    2 +-
>>>  arch/arm/mach-sirf/Kconfig                         |   16 ++++++++++++++++
>>>  arch/arm/{mach-prima2 => mach-sirf}/Makefile       |    0
>>>  arch/arm/{mach-prima2 => mach-sirf}/Makefile.boot  |    0
>>>  .../arm/{mach-prima2 => mach-sirf}/board-generic.c |    0
>>>  arch/arm/{mach-prima2 => mach-sirf}/common.h       |    0
>>>  .../include/mach/clkdev.h                          |    0
>>>  .../include/mach/debug-macro.S                     |    0
>>>  .../include/mach/entry-macro.S                     |    0
>>>  .../{mach-prima2 => mach-sirf}/include/mach/gpio.h |    0
>>>  .../include/mach/hardware.h                        |    0
>>>  .../{mach-prima2 => mach-sirf}/include/mach/irqs.h |    0
>>>  .../{mach-prima2 => mach-sirf}/include/mach/map.h  |    0
>>
>> I'm not sure if we should rename all of these right now. I've been thinking
>> about moving all of recent and simple ARMv7 based platforms (socfpga, zynq,
>> prima2, ...) into a single directory, where they would basically end up
>> being one file per platform. We should discuss this at the ARM mini summit,
>> and I can let you know the outcome of it. I don't object on the rename in
>> principle, but it might end up causing extra churn.
>
> ok. i will follow the output of  ARM mini summit.

i would think merging several SoCs into a dir still needs much time.
if the whole rename is too aggresive for the moment, how about keeping
the mach-prima2 temporarily, but this prima2 dir will also include the
coming Marco stuff?

-barry
