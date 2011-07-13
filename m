From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 13 Jul 2011 18:35:10 +0400
Subject: [PATCH V7 2/4] MTD: pxa3xx_nand: convert all printk into dev_*
In-Reply-To: <CALZhoSShiGBPdZtxUK1c6+PPMJQWHM5G6Ucb6+H=Tb+aszCu5g@mail.gmail.com>
References: <1310466535-15287-1-git-send-email-leiwen@marvell.com>	<1310481336-13230-3-git-send-email-leiwen@marvell.com>	<4E1D7A1E.1020802@mvista.com>
	<CALZhoSShiGBPdZtxUK1c6+PPMJQWHM5G6Ucb6+H=Tb+aszCu5g@mail.gmail.com>
Message-ID: <4E1DAD1E.4090706@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Lei Wen wrote:

>>> Signed-off-by: Lei Wen<leiwen@marvell.com>
>>> ---
>>>  drivers/mtd/nand/pxa3xx_nand.c |   27 ++++++++++++++++-----------
>>>  1 files changed, 16 insertions(+), 11 deletions(-)
>>> diff --git a/drivers/mtd/nand/pxa3xx_nand.c
>>> b/drivers/mtd/nand/pxa3xx_nand.c
>>> index 1efecf7..afe14bd 100644
>>> --- a/drivers/mtd/nand/pxa3xx_nand.c
>>> +++ b/drivers/mtd/nand/pxa3xx_nand.c
>> [...]
>>> @@ -774,11 +774,15 @@ static int pxa3xx_nand_config_flash(struct
>>> pxa3xx_nand_info *info,
>>>        struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
>>>        uint32_t ndcr = 0x0; /* enable all interrupts */
>>>
>>> -       if (f->page_size != 2048 && f->page_size != 512)
>>> +       if (f->page_size != 2048 && f->page_size != 512) {
>>> +               dev_err(&pdev->dev, "Current only support 2048 and 512
>>> size\n");
>>>                return -EINVAL;
>>> +       }
>>>
>>> -       if (f->flash_width != 16 && f->flash_width != 8)
>>> +       if (f->flash_width != 16 && f->flash_width != 8) {
>>> +               dev_err(&pdev->dev, "Only support 8bit and 16 bit!\n");

>>   So this patch not only converts printk() to dev_*() calls, it also adds
>> some dev_err() calls? This should have been mentioned in the change long at
>> least...

> What do you mean by "chang long"? Do you mean the cover letter or the
> patch name?

    I mean the patch description (which in this patch is missing).

> Certainly it is a good suggest to show it in the change version list.

    Don't quite understand what you mean here...

> Best regards,
> Lei

WBR, Sergei
