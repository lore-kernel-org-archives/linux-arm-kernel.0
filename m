From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Mon, 12 Jan 2015 17:18:38 +0800
Subject: [PATCH v6 1/2] mtd: hisilicon: add a new NAND controller driver
 for hisilicon hip04 Soc
In-Reply-To: <5265608.Ut8IQVYZc5@wuerfel>
References: <1421047734-30818-1-git-send-email-wangzhou1@hisilicon.com>
 <1421047734-30818-2-git-send-email-wangzhou1@hisilicon.com>
 <5265608.Ut8IQVYZc5@wuerfel>
Message-ID: <54B3916E.4040906@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/12 16:21, Arnd Bergmann wrote:
> On Monday 12 January 2015 15:28:53 Zhou Wang wrote:
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
> 
> I haven't looked at earlier versions, but it looks very good to
> me overall. Just add a patch description above please.

Hi Arnd,

The earlier version is same with this one, just change E-mail
address here. Will add a patch description in next version. Thanks!

> 
> One tiny detail:
> 
>> +static const struct of_device_id nfc_id_table[] = {
>> +	{ .compatible = "hisilicon,504-nfc" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, nfc_id_table);
>> +
>> +static struct platform_driver hisi_nfc_driver = {
>> +	.driver = {
>> +		.name  = "hisi_nand",
>> +		.of_match_table = of_match_ptr(nfc_id_table),
>> +		.pm = &hisi_nfc_pm_ops,
>> +	},
>> +	.probe		= hisi_nfc_probe,
>> +	.remove		= hisi_nfc_remove,
>> +};
> 
> Remove the of_match_ptr() macro here to avoid a warning when
> CONFIG_OF is not set.

Will remove the macro here, thanks!

Best regards,
Zhou Wang

> 
> 	Arnd
> 
> .
> 
