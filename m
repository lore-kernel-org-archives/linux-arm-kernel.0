From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 20 Nov 2009 04:13:50 -0500
Subject: [PATCH 09/10] input: enable touch on 88pm860x
In-Reply-To: <20091120084457.GD3009@core.coreip.homeip.net>
References: <771cded00911130104s3bc6ff97ma3a7f7ad76ae9198@mail.gmail.com>
	<20091114025425.GA3587@core.coreip.homeip.net>
	<771cded00911162227i24cd5a4cv9899e220b1c37c6e@mail.gmail.com>
	<20091118051646.GC31480@core.coreip.homeip.net>
	<771cded00911191902s171a9fe4ucb21ea0c75bb12cb@mail.gmail.com>
	<20091120084457.GD3009@core.coreip.homeip.net>
Message-ID: <771cded00911200113u24e9f7e3pb0b4f6325467ab71@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 3:44 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Haojian,
>
> On Thu, Nov 19, 2009 at 10:02:23PM -0500, Haojian Zhuang wrote:
>> +
>> +static int __devexit pm860x_touch_remove(struct platform_device *pdev)
>> +{
>> + ? ? struct pm860x_touch *touch = platform_get_drvdata(pdev);
>> +
>
> "pm860x_free_irq(chip, irq);" is still missing here.
>
>> + ? ? input_unregister_device(touch->idev);
>> + ? ? return 0;
>> +}
>> +
>>
>> ? ? ? ? To compile this driver as a module, choose M here: the
>> ? ? ? ? module will be called pcap_ts.
>> +
>> +config TOUCHSCREEN_88PM860X
>> + ? ? tristate "Marvell 88PM860x touchscreen"
>> + ? ? depends on MFD_88PM860X
>> + ? ? help
>> + ? ? ? Say Y here if you have a 88PM860x PMIC and want to enable
>> + ? ? ? support for the built-in touchscreen.
>
> "To compile this driver as a module..."
>
> Thanks!
>
> Other than that:
>
> ? ? ? ?Acked-by: Dmitry Torokhov <dtor@mail.ru>
>
> --
> Dmitry
>

Fixed. Actually it could be built as module already. Now append more
comments on it.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0009-input-enable-touch-on-88pm860x.patch
Type: text/x-patch
Size: 8855 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091120/b99dd893/attachment.bin>
