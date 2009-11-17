From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Nov 2009 02:28:42 -0500
Subject: [PATCH 01/02] pxa: set default WLED output current in saar
In-Reply-To: <771cded00911050019u20ff2609ifd6c54dbdc66ccf2@mail.gmail.com>
References: <771cded00911042358p6543a877x43560fa1ba89eac7@mail.gmail.com>
	<771cded00911042358l3065497eobc91775c81fd6fe8@mail.gmail.com>
	<771cded00911050019u20ff2609ifd6c54dbdc66ccf2@mail.gmail.com>
Message-ID: <771cded00911162328s69037c1bh6ed4c729a80217e8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2009 at 3:19 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> On Thu, Nov 5, 2009 at 2:58 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>> On Thu, Nov 5, 2009 at 2:58 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>>> From 4fdab1032a74fcfcd48b134d0d91af5f1868332b Mon Sep 17 00:00:00 2001
>>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>>> Date: Thu, 5 Nov 2009 10:31:01 -0500
>>> Subject: [PATCH] [ARM] pxa: set default WLED output current in saar
>>>
>>> Set default WLED output current in saar. Otherwise, LCD backlight won't be
>>> effective.
>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>>> ---
>>> ?arch/arm/mach-pxa/saar.c | ? ?5 +++++
>>> ?1 files changed, 5 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
>>> index 8241a63..a16590a 100644
>>> --- a/arch/arm/mach-pxa/saar.c
>>> +++ b/arch/arm/mach-pxa/saar.c
>>> @@ -451,10 +451,15 @@ static inline void saar_init_lcd(void) {}
>>> ?#endif
>>>
>>> ?#if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
>>> +static struct da9034_backlight_pdata saar_da9034_backlight = {
>>> + ? ? ? .out_current ? ?= DA9034_WLED_CURRENT(4),
>>> +};
>>> +
>>> ?static struct da903x_subdev_info saar_da9034_subdevs[] = {
>>> ? ? ? ?[0] = {
>>> ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "da903x-backlight",
>>> ? ? ? ? ? ? ? ?.id ? ? ? ? ? ? = DA9034_ID_WLED,
>>> + ? ? ? ? ? ? ? .platform_data ?= &saar_da9034_backlight,
>>> ? ? ? ?},
>>> ?};
>>>
>>> --
>>> 1.5.6.5
>>>
>>
>> It should be the second patch in this series.
>>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002--ARM-pxa-set-default-WLED-output-current-in-saar.patch
Type: text/x-patch
Size: 1067 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091117/49ff3938/attachment.bin>
