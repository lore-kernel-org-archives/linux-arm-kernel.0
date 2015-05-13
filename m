From: lznuaa@gmail.com (Zhi Li)
Date: Wed, 13 May 2015 09:35:09 -0500
Subject: [PATCH 2/3] input: keyboad: imx: add snvs power key driver
In-Reply-To: <20150512184328.GC20725@dtor-ws>
References: <1431449438-19460-1-git-send-email-Frank.Li@freescale.com>
 <1431449438-19460-2-git-send-email-Frank.Li@freescale.com>
 <20150512184328.GC20725@dtor-ws>
Message-ID: <CAHrpEqRJfRq0Y_1Xd5r9KvNut6H_4RGOkWZvo=78_iwhNY0qvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
>> +{
>> +     struct platform_device *pdev = dev_id;
>> +     struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
>> +     void __iomem *ioaddr = pdata->ioaddr;
>> +     u32 lp_status;
>> +
>> +     pm_wakeup_event(pdata->input->dev.parent, 0);
>> +     lp_status = readl_relaxed(ioaddr + SNVS_LPSR_REG);
>> +     if (lp_status & SNVS_LPSR_SPO)
>> +             mod_timer(&pdata->check_timer, jiffies + msecs_to_jiffies(2));
>
> Why 2 and not 1 or 0?
>

I checked internal team about this. no special reason for that.
Just do debounce.

best regards
Frank Li
