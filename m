From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 28 Oct 2016 20:52:49 +0900
Subject: [PATCH v2 2/2] arm64: dts: hi6220: add resets property into dwmmc
 nodes
In-Reply-To: <20161028101919.GA25564@leoy-linaro>
References: <1472094041-5357-2-git-send-email-guodong.xu@linaro.org>
 <CAKfTPtB0FtGbm4C5z+LJizrsHikKt_BGFti5XY+LN3w7zO1Vjw@mail.gmail.com>
 <CALAqxLXfb48h8hMQmAaJ+YjA5=pekkQ8Dg8ReL6VTTfmuFRPDw@mail.gmail.com>
 <CAKfTPtAXdkKcfpHmUmQNwuJxO0PORcCf49noST_CCkZPigPwgw@mail.gmail.com>
 <CGME20161028072654epcas4p13cbf983b3e22dd96039ed33a4ac792d5@epcas4p1.samsung.com>
 <20161028072640.GB17266@leoy-linaro>
 <d7993c1a-5e50-9a33-0900-5c1a79884d3c@samsung.com>
 <20161028073830.GC17266@leoy-linaro>
 <24930ad4-313f-a4f0-c89a-770238863816@samsung.com>
 <95e22336-0465-f1e1-71b8-548d0e6ee8b7@samsung.com>
 <20161028101919.GA25564@leoy-linaro>
Message-ID: <f5dfafbb-39df-4edb-03b8-57c0e34c912f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/28/2016 07:19 PM, Leo Yan wrote:
> On Fri, Oct 28, 2016 at 06:54:58PM +0900, Jaehoon Chung wrote:
> 
> [...]
> 
>>>>> Could you share the log? Is there any log about failure?
>>>>
>>>> Sure, please see below log:
>>>
>>> It's related with -EPROBE_DEFER..I'm not sure but if CONFIG_RESET_CONTROLLER is enabled, it's searching for reset controller.
>>> Maybe hi6220 has handled the reset controller(?)...
>>>
>>> I'm checking devm_reset_control_xxx...It's possible to occur the other boards which enabled RESET_CONTROLLER..
>>
>> Could you check the below thing..
>>
>>         /* find reset controller when exist */
>> -       pdata->rstc = devm_reset_control_get_optional(dev, NULL);
>> +       pdata->rstc = devm_reset_control_get_optional(dev, "dwmci-reset");
>>         if (IS_ERR(pdata->rstc)) {
>>                 if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
>>                         return ERR_PTR(-EPROBE_DEFER);
> 
> Confirmed with this fixing, the kernel can bootup successfully.
> 
> Thanks for this.

Thanks for checking this..If this approach is not bad, i will send the patch.
Or if there are other good approaches, let me know, plz.

Best Regards,
Jaehoon Chung

> 
>> To prevent the wrong controlling, how about adding "#reset-names" for dwmmc controller?
>>
>>
>> Best Regards,
>> Jaehoon Chung
> 
> 
> 
