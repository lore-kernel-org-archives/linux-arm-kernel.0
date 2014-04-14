From: lho@apm.com (Loc Ho)
Date: Mon, 14 Apr 2014 10:52:41 -0700
Subject: [rtc-linux] [PATCH] rtc: Fix suspend/resume for APM X-Gene SoC
 RTC driver
In-Reply-To: <20140414172134.GB25182@sirena.org.uk>
References: <1397259218-20494-1-git-send-email-lho@apm.com>
 <20140414172134.GB25182@sirena.org.uk>
Message-ID: <CAPw-ZTn1qjA+1n62HhwphnSCTuqDMEE+adYeJ_L9c8n-Yqmtog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> -     clk_prepare_enable(pdata->clk);
>> +     ret = clk_prepare_enable(pdata->clk);
>> +     if (ret)
>> +             return ret;
>>
>>       /* Turn on the clock and the crystal */
>>       writel(RTC_CCR_EN, pdata->csr_base + RTC_CCR);
>>
>> -     device_init_wakeup(&pdev->dev, 1);
>> +     ret = device_init_wakeup(&pdev->dev, 1);
>> +     if (ret)
>> +             return ret;
>>
> If the init fails you should unprepare (though I suspect the same issue
> applies to other things in the probe function anyway).  If you fix that
> then feel free to add:
>

Okay... This is the only place missed. I don't see issue with other
locations. I will post another version soon.

-Loc
