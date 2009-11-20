From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 19 Nov 2009 22:02:23 -0500
Subject: [PATCH 09/10] input: enable touch on 88pm860x
In-Reply-To: <20091118051646.GC31480@core.coreip.homeip.net>
References: <771cded00911130104s3bc6ff97ma3a7f7ad76ae9198@mail.gmail.com>
	<20091114025425.GA3587@core.coreip.homeip.net>
	<771cded00911162227i24cd5a4cv9899e220b1c37c6e@mail.gmail.com>
	<20091118051646.GC31480@core.coreip.homeip.net>
Message-ID: <771cded00911191902s171a9fe4ucb21ea0c75bb12cb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2009 at 12:16 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Nov 17, 2009 at 01:27:42AM -0500, Haojian Zhuang wrote:
>>
>> Up to now, I don't support module yet. When each component of this
>> PMIC is ready, I'll enable module.
>>
>
> I would do it rather sooner than later - then you'd notice that you are
> not freeing IRQ in pm860x_touch_remove() when you'd try to reload your
> module.
>
>> +
>> +static int __devexit pm860x_touch_remove(struct platform_device *pdev)
>> +{
>> + ? ? struct pm860x_touch *touch = platform_get_drvdata(pdev);
>> +
>> + ? ? input_unregister_device(touch->idev);
>> + ? ? return 0;
>> +}
>> +
>
> --
> Dmitry
>

updated with module supported.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0009-input-enable-touch-on-88pm860x.patch
Type: text/x-patch
Size: 8700 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091119/f62f38d6/attachment-0001.bin>
