From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 24 May 2010 22:17:29 +0300
Subject: [PATCH v3 10/14] omap: mailbox: reorganize registering
In-Reply-To: <20100524183249.GF21117@n2100.arm.linux.org.uk>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-11-git-send-email-felipe.contreras@gmail.com>
	<20100524.182407.67910029.Hiroshi.DOYU@nokia.com>
	<20100524183249.GF21117@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikNquOP901wjXup7K-5ea8OvgiRT9Vs7B8vR0jB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 9:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 24, 2010 at 06:24:07PM +0300, Hiroshi DOYU wrote:
>> From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> Subject: [PATCH v3 10/14] omap: mailbox: reorganize registering
>> Date: Sat, 22 May 2010 19:14:21 +0200
>>
>> > platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > - ? if (unlikely(!res)) {
>> > - ? ? ? ? ? dev_err(&pdev->dev, "invalid mem resource\n");
>> > - ? ? ? ? ? return -ENODEV;
>> > - ? }
>> > + ? res = pdev->resource;
>>
>> why not?
>>
>> ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> I agree - always use the accessors provided rather than going beneath
> the covers and fiddling directly with stuff inside objects.

Yes, this patch slipped from the previous series where resources were
defined in the same file and some tricky assumptions were being made.
Now platform_get_resource() makes more sense.

-- 
Felipe Contreras
