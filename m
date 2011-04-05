From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 5 Apr 2011 17:07:36 +0300
Subject: [PATCH] Fix the broken build for Marvell Dove platform.
In-Reply-To: <AANLkTikH9qZDXr2QFBxAZdzKn-q1a=Lp26EN5gES6u+i@mail.gmail.com>
References: <1301219689-9186-1-git-send-email-kostap@marvell.com>
	<AANLkTikH9qZDXr2QFBxAZdzKn-q1a=Lp26EN5gES6u+i@mail.gmail.com>
Message-ID: <BANLkTi=RvWJNWwFTDFf8LiX13MN_ca8mHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2011 at 1:32 PM, saeed bishara <saeed.bishara@gmail.com> wrote:
> On Sun, Mar 27, 2011 at 11:54 AM, Konstantin Porotchkin
> <kostap@marvell.com> wrote:
>> Remove call to the old GPIO init function.
>> Fix old MPP control offset value.
>>
>> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
>> ---
>> ?arch/arm/mach-dove/include/mach/dove.h | ? ?2 +-
>> ?arch/arm/mach-dove/mpp.c ? ? ? ? ? ? ? | ? ?3 ---
>> ?2 files changed, 1 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
>> index e5fcdd3..b20ec9a 100644
>> --- a/arch/arm/mach-dove/include/mach/dove.h
>> +++ b/arch/arm/mach-dove/include/mach/dove.h
>> @@ -136,7 +136,7 @@
>> ?#define DOVE_MPP_GENERAL_VIRT_BASE ? ? (DOVE_SB_REGS_VIRT_BASE | 0xe803c)
>> ?#define ?DOVE_AU1_SPDIFO_GPIO_EN ? ? ? (1 << 1)
>> ?#define ?DOVE_NAND_GPIO_EN ? ? ? ? ? ? (1 << 0)
>> -#define DOVE_MPP_CTRL4_VIRT_BASE ? ? ? (DOVE_GPIO_VIRT_BASE + 0x40)
>> +#define DOVE_MPP_CTRL4_VIRT_BASE ? ? ? (DOVE_GPIO_LO_VIRT_BASE + 0x40)
>> ?#define ?DOVE_SPI_GPIO_SEL ? ? ? ? ? ? (1 << 5)
>> ?#define ?DOVE_UART1_GPIO_SEL ? ? ? ? ? (1 << 4)
>> ?#define ?DOVE_AU1_GPIO_SEL ? ? ? ? ? ? (1 << 3)
>> diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
>> index 71db2bd..c66c763 100644
>> --- a/arch/arm/mach-dove/mpp.c
>> +++ b/arch/arm/mach-dove/mpp.c
>> @@ -147,9 +147,6 @@ void __init dove_mpp_conf(unsigned int *mpp_list)
>> ? ? ? ?u32 pmu_sig_ctrl[PMU_SIG_REGS];
>> ? ? ? ?int i;
>>
>> - ? ? ? /* Initialize gpiolib. */
>> - ? ? ? orion_gpio_init();
>> -
>> ? ? ? ?for (i = 0; i < MPP_NR_REGS; i++)
>> ? ? ? ? ? ? ? ?mpp_ctrl[i] = readl(MPP_CTRL(i));
>>
> looks fine to me. Nico, can you please merge?
> saeed
Nico, a similar patch (arm: dove: Use correct GPIO_BASE and remove
orion_gpio_init() leftover) from Thomas Gleixner that was sent later
was merged to mainline, please drop this patch.

saeed
