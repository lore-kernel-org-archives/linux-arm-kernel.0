From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 2 Jan 2012 23:11:07 +0530
Subject: [RFC][PATCH 2/4] lcd: platform-lcd: Add support for Hydis
 hv070wsa lcd panel
In-Reply-To: <20120102114559.GE2899@opensource.wolfsonmicro.com>
References: <1325483675-21908-1-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-2-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-3-git-send-email-thomas.abraham@linaro.org>
 <20120102114559.GE2899@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwRaB=gvM35sfAyb9gEZ62tSAH3z+AaS5K9oiE-pAyR-wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2 January 2012 17:15, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jan 02, 2012 at 11:24:33AM +0530, Thomas Abraham wrote:
>
>> +static void lcd_hv070wsa_set_power(struct platform_lcd *plcd, unsigned int pwr)
>> +{
>> + ? ? struct plat_lcd_hydis_hv070wsa_pdata *pdata = plcd->lcd_pdata;
>> +
>> + ? ? gpio_direction_output(pdata->gpio, pwr);
>> +}
>
> This doesn't look at all specific to this panel - it's just setting a
> GPIO - so it should probably just be a generic gpio-lcd driver (or
> similar). ?It ought to be possible to do a device tree binding for at
> least this subset of panels.

Right. I should not have made it specific to hv070wsa panel. This type
of functionality is reusable for other lcd panels as well. I will
modify this patch.

Thanks,
Thomas.
