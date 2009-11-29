From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 29 Nov 2009 11:09:03 +0800
Subject: [PATCH] pxa/hx4700: actually use platform_lcd driver
In-Reply-To: <74d0deb30911250404m23001d38p77ba355804fcbc47@mail.gmail.com>
References: <1259148795-10335-1-git-send-email-mad_soft@inbox.ru>
	<74d0deb30911250404m23001d38p77ba355804fcbc47@mail.gmail.com>
Message-ID: <f17812d70911281909n7b7885b0k932606ba035480e8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 8:04 PM, pHilipp Zabel <philipp.zabel@gmail.com> wrote:
> On Wed, Nov 25, 2009 at 12:33 PM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
>> Commit e2c509c7e6 ([ARM] pxa/hx4700: use platform_lcd driver)
>> missed to actually register platform device for LCD.
>> It causes following GCC warning:
>> arch/arm/mach-pxa/hx4700.c:553: warning: 'hx4700_lcd' defined but not used
>>
>> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
>> ---
>> ?arch/arm/mach-pxa/hx4700.c | ? ?1 +
>> ?1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> This is a fix for 2.6.32.
>>
>> diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
>> index 83bd3c6..af44db2 100644
>> --- a/arch/arm/mach-pxa/hx4700.c
>> +++ b/arch/arm/mach-pxa/hx4700.c
>> @@ -820,6 +820,7 @@ static struct platform_device *devices[] __initdata = {
>> ? ? ? ?&gpio_keys,
>> ? ? ? ?&backlight,
>> ? ? ? ?&w3220,
>> + ? ? ? &hx4700_lcd,
>> ? ? ? ?&egpio,
>> ? ? ? ?&bq24022,
>> ? ? ? ?&gpio_vbus,
>> --
>> 1.6.3.4
>>
>>
>
> Thanks, this got lost in my local tree during the switch to platform_lcd.
>
> Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
>

Applied to 'devel'.
