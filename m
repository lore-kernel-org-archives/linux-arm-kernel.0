From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Oct 2013 08:54:56 -0600
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <CAEPRUYqfpdp1GqxBgx-q=hyvQDe4uyi6okzHPW2QmfmPG_Z3NQ@mail.gmail.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>	<1380846199-12829-4-git-send-email-syin@broadcom.com>
 <CAEPRUYqfpdp1GqxBgx-q=hyvQDe4uyi6okzHPW2QmfmPG_Z3NQ@mail.gmail.com>
Message-ID: <525FFA40.9050901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2013 12:03 AM, Christian Daudt wrote:
> On Thu, Oct 3, 2013 at 5:23 PM, Sherman Yin <syin@broadcom.com> wrote:
>> Adds pinctrl driver for Broadcom Capri (BCM281xx) SoCs.
>>
>> Signed-off-by: Sherman Yin <syin@broadcom.com>
>> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
>> Reviewed-by: Matt Porter <matt.porter@linaro.org>
>> ---
>>  arch/arm/mach-bcm/Kconfig       |    2 +
>>  drivers/pinctrl/Kconfig         |   10 +
>>  drivers/pinctrl/Makefile        |    1 +
>>  drivers/pinctrl/pinctrl-capri.c | 1727 +++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 1740 insertions(+)
>>  create mode 100644 drivers/pinctrl/pinctrl-capri.c
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index 69d67f7..2546365 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -10,6 +10,8 @@ config ARCH_BCM
>>         select GENERIC_CLOCKEVENTS
>>         select GENERIC_TIME
>>         select GPIO_BCM
>> +       select PINCTRL
>> +       select PINCTRL_CAPRI
>>         select SPARSE_IRQ
>>         select TICK_ONESHOT
>>         select CACHE_L2X0
> 
> On your subsequent patchset pls move this from Kconfig to
> arm/configs/bcm_defconfig, and break that modification into a separate
> patch from the drivers/* modification.

The other SoCs I'm familiar with all select this from their ARCH_xxx
config symbol.
