From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 28 Aug 2012 09:40:07 +0800
Subject: [PATCH 1/5] arm: mmp: make private clock definition exclude from
 common clock
In-Reply-To: <CAN1soZy54UcoQ_qrN2Wh4ZWVMCXj3gpHZas57GqQeT988dnkQQ@mail.gmail.com>
References: <1346036043-20115-1-git-send-email-xiechao.mail@gmail.com>
 <CAN1soZy54UcoQ_qrN2Wh4ZWVMCXj3gpHZas57GqQeT988dnkQQ@mail.gmail.com>
Message-ID: <CADApbegJwd3jQr+rKd-54AxhZG=On0LSEG5ioX-jnq9S0xY=ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 6:42 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Mon, Aug 27, 2012 at 10:53 AM, Chao Xie <xiechao.mail@gmail.com> wrote:
>> From: Chao Xie <chao.xie@marvell.com>
>>
>> the clock.c is mmp private implementation, make it excluded
>> from common clock framework
>>
>> Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
>> ---
>>  arch/arm/mach-mmp/Makefile |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
>> index b786f7e..815c3e7 100644
>> --- a/arch/arm/mach-mmp/Makefile
>> +++ b/arch/arm/mach-mmp/Makefile
>> @@ -2,13 +2,16 @@
>>  # Makefile for Marvell's PXA168 processors line
>>  #
>>
>> -obj-y                          += common.o clock.o devices.o time.o irq.o
>> +obj-y                          += common.o devices.o time.o irq.o
>>
>>  # SoC support
>>  obj-$(CONFIG_CPU_PXA168)       += pxa168.o
>>  obj-$(CONFIG_CPU_PXA910)       += pxa910.o
>>  obj-$(CONFIG_CPU_MMP2)         += mmp2.o sram.o
>>
>> +ifeq ($(CONFIG_COMMON_CLK), )
>> +obj-y                          += clock.o
>> +endif
>
> Why not to discard all private clock code? Maybe you can use common
> clk in arch-mmp directly.
Our dvfs and devfreq are set up based on private clock code. The
migration of dvfs and devfreq is on going. Checking in common clock
framework code will help us mirgarate the dvfs and devfreq, but i do
not want to block the our product development, so I would like to keep
the private clock code untile we have settle down all the problems.
