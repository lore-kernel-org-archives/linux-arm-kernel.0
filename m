From: thomas.ab@samsung.com (Thomas Abraham)
Date: Mon, 2 Nov 2009 15:13:27 +0900
Subject: [PATCH 5/7] S3C64XX: Add platform data and driver resources for
	IDE controller driver.
In-Reply-To: <20091101130502.GI8096@trinity.fluff.org>
References: <1257051403-8146-1-git-send-email-thomas.ab@samsung.com>
	<20091101130502.GI8096@trinity.fluff.org>
Message-ID: <84c135f50911012213s8a137faua12e7f66c8d8ce76@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 1, 2009 at 10:05 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Sun, Nov 01, 2009 at 01:56:43PM +0900, Thomas Abraham wrote:
>> This patch adds the following for S3C IDE driver.
>> ? ? ? - IDE plafrom data strucure definition
>> ? ? ? - IDE driver resources
>> ? ? ? - IDE controller GPIO setup code
>> ? ? ? - IDE platform data setup code
>> ? ? ? - IDE platform device definition
>>
>> +void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata)
>> +{
>> + ? ? struct s3c_ide_platdata *pd;
>> +
>> + ? ? pd = (struct s3c_ide_platdata *)kmemdup(pdata,
>> + ? ? ? ? ? ? sizeof(struct s3c_ide_platdata), GFP_KERNEL);
>
> you do not need pd = (struct s3c_ide_platdata *), the result of kmemdup
> is 'void *' and thus can be cast to 'struct s3c_ide_platdata *'. Removing
> this will make the code flow better.
>
> doing:
>
> ? ? ? ?if (!pd)
> ? ? ? ? ? ? ? ?printk(KERN_ERR "%s: no memory for platform data\n", __func__);
> ? ? ? ?else
> ? ? ? ? ? ? ? ?s3c_device_cfcon.dev.platform_data = pd;
>
> would be better.

Ok. I will modify the code.

>
> other than the comments, this looks ok.
>
> --
> Ben
