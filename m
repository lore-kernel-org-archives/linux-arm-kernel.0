From: kishorek.kadiyala@gmail.com (kishore kadiyala)
Date: Fri, 24 Sep 2010 22:01:48 +0530
Subject: [PATCH v3 1/4] omap4 hsmmc: Adding card detect support for MMC1
In-Reply-To: <AANLkTikLqi4=OOJ_ciMqTt7HKJzDo-WsZJ8D2CpP712c@mail.gmail.com>
References: <14833.10.24.255.18.1285173812.squirrel@dbdmail.itg.ti.com>
	<8F7AF80515AF0D4D93307E594F3CB40E5F57C548@dlee03.ent.ti.com>
	<AANLkTikLqi4=OOJ_ciMqTt7HKJzDo-WsZJ8D2CpP712c@mail.gmail.com>
Message-ID: <AANLkTim0Qm=x3vVuT26oSNzTg+BZV+KCAJj5oVs3etWD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hari,


On Thu, Sep 23, 2010 at 11:22 AM, kishore kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> Hi Hari,
>
> On Thu, Sep 23, 2010 at 1:19 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
>> Kishore,
>>
>>> +int twl6030_mmc_card_detect(struct device *dev, int slot)
>>> +{
>>> + ? ? int ret = -EIO;
>>> + ? ? u8 read_reg = 0;
>>> + ? ? struct platform_device *pdev = to_platform_device(dev);
>>> +
>>> + ? ? switch (pdev->id) {
>>> + ? ? case 0:
>>> + ? ? ? ? ? ? /*
>>> + ? ? ? ? ? ? ?* BIT0 of REG_MMC_CTRL
>>> + ? ? ? ? ? ? ?* 0 - Card not present ,1 - Card present
>>> + ? ? ? ? ? ? ?*/
>>> + ? ? ? ? ? ? ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &read_reg,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? TWL6030_MMCCTRL);
>>> + ? ? ? ? ? ? if (ret >= 0)
>>> + ? ? ? ? ? ? ? ? ? ? ret = read_reg & STS_MMC;
>>> + ? ? ? ? ? ? break;
>>
>> nitpick: may be you don't need a switch statement for only one case.
>
> From future perspective,since there are 5 MMC controllers on OMAP4
> and current patch supports card detect feature only for one controller i.e MMC1
> as of now. Once the interfaces connected on the remaining 4 MMC controllers
> are defined further additions will be required for respective cases.


Correcting my previous comment, I've just verified twl6030 current
version spec on OMAP4
which can provide card detect interrupt only for one MMC controller i.e MMC1.
I will replace switch with if.

Regards,
Kishore
