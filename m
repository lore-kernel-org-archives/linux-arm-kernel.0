From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 06:55:50 -0500
Subject: [PATCH 3/4] rtc: enable rtc in max8925
In-Reply-To: <20100125122231.3d4ddc02@linux.lan.towertech.it>
References: <771cded01001250309x33f85bbah4db8b526f6706309@mail.gmail.com>
	<20100125122231.3d4ddc02@linux.lan.towertech.it>
Message-ID: <771cded01001250355p71099663j385d25fc63a5d63d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 6:22 AM, Alessandro Zummo <a.zummo@towertech.it> wrote:
> On Mon, 25 Jan 2010 06:09:04 -0500
> Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>
>> +
>> +static struct platform_driver max8925_rtc_driver = {
>> + ? ? .driver ? ? ? ? = {
>> + ? ? ? ? ? ? .name ? = "max8925-rtc",
>> + ? ? ? ? ? ? .owner ?= THIS_MODULE,
>> + ? ? },
>> + ? ? .probe ? ? ? ? ?= max8925_rtc_probe,
>> + ? ? .remove ? ? ? ? = __devexit_p(max8925_rtc_remove),
>> +};
>> +
>> +static int __init max8925_rtc_init(void)
>> +{
>> + ? ? return platform_driver_register(&max8925_rtc_driver);
>> +}
>> +module_init(max8925_rtc_init);
>> +
>> +static void __exit max8925_rtc_exit(void)
>
> ?this should be __devexit since you used __devexit_p
>

I declared __devexit_p on max8925_rtc_remove. So I need to use
__devexit on max8925_rtc_remove. I needn't use __devexit on
max8925_rtc_exit, is it?

Others are updated.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-rtc-enable-rtc-in-max8925.patch
Type: text/x-patch
Size: 10270 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100125/d0157fcc/attachment-0001.bin>
