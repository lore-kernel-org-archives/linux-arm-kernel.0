From: blogic@openwrt.org (John Crispin)
Date: Mon, 25 Jan 2016 13:19:46 +0100
Subject: [PATCH V2 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <CABxcv=kWnUwpCo=JJbnPAARRM226YfBJw_6yF7MiE8-7iqBD+Q@mail.gmail.com>
References: <1453718405-40815-1-git-send-email-blogic@openwrt.org>
 <1453718405-40815-2-git-send-email-blogic@openwrt.org>
 <CABxcv=kWnUwpCo=JJbnPAARRM226YfBJw_6yF7MiE8-7iqBD+Q@mail.gmail.com>
Message-ID: <56A612E2.1010509@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/01/2016 13:11, Javier Martinez Canillas wrote:
> Hello,
> 
> On Mon, Jan 25, 2016 at 7:40 AM, John Crispin <blogic@openwrt.org> wrote:
>> From: Chen Zhong <chen.zhong@mediatek.com>
> 
> [snip]
> 
>> +}
>> +
>> +static struct platform_driver mt6323_regulator_driver = {
>> +       .driver = {
>> +               .name = "mt6323-regulator",
>> +       },
>> +       .probe = mt6323_regulator_probe,
>> +};
>> +
> 
> You don't have a .of_match table but according the DT bindings, the
> compatible string "mediatek,mt6323-regulator" should be used so there
> should be a OF match table or the vendor prefix of the compatible
> string won't be used for matching (i.e: fallbacks to the driver .name
> for match).

the driver is probed via drivers/mfd/mt6397-core.c and does not require
the OF match table. It loads fine just like the mt6397 driver.

> 
>> +module_platform_driver(mt6323_regulator_driver);
>> +
>> +MODULE_AUTHOR("Chen Zhong <chen.zhong@mediatek.com>");
>> +MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6397 PMIC");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:mt6323-regulator");
> 
> This alias should not be needed if you provide a OF match table and a
> MODULE_DEVICE_TABLE(of, foo);

see above.

	John
