From: john.stultz@linaro.org (John Stultz)
Date: Fri, 28 Oct 2016 14:12:56 -0700
Subject: [PATCH v2 2/2] arm64: dts: hi6220: add resets property into dwmmc
 nodes
In-Reply-To: <20161028123422.GA22734@leoy-linaro>
References: <CALAqxLXfb48h8hMQmAaJ+YjA5=pekkQ8Dg8ReL6VTTfmuFRPDw@mail.gmail.com>
 <CAKfTPtAXdkKcfpHmUmQNwuJxO0PORcCf49noST_CCkZPigPwgw@mail.gmail.com>
 <CGME20161028072654epcas4p13cbf983b3e22dd96039ed33a4ac792d5@epcas4p1.samsung.com>
 <20161028072640.GB17266@leoy-linaro>
 <d7993c1a-5e50-9a33-0900-5c1a79884d3c@samsung.com>
 <20161028073830.GC17266@leoy-linaro>
 <24930ad4-313f-a4f0-c89a-770238863816@samsung.com>
 <95e22336-0465-f1e1-71b8-548d0e6ee8b7@samsung.com>
 <20161028101919.GA25564@leoy-linaro>
 <f5dfafbb-39df-4edb-03b8-57c0e34c912f@samsung.com>
 <20161028123422.GA22734@leoy-linaro>
Message-ID: <CALAqxLX9_y8CpagsUeorOE4gpR6_i-_G+EZfXNpBxare3VnJCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 5:34 AM, Leo Yan <leo.yan@linaro.org> wrote:
> On Fri, Oct 28, 2016 at 08:52:49PM +0900, Jaehoon Chung wrote:
>
> [...]
>
>> >> Could you check the below thing..
>> >>
>> >>         /* find reset controller when exist */
>> >> -       pdata->rstc = devm_reset_control_get_optional(dev, NULL);
>> >> +       pdata->rstc = devm_reset_control_get_optional(dev, "dwmci-reset");
>> >>         if (IS_ERR(pdata->rstc)) {
>> >>                 if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
>> >>                         return ERR_PTR(-EPROBE_DEFER);
>> >
>> > Confirmed with this fixing, the kernel can bootup successfully.
>> >
>> > Thanks for this.
>>
>> Thanks for checking this..If this approach is not bad, i will send the patch.
>> Or if there are other good approaches, let me know, plz.
>
> I'd like Guodong and John to confirm for Hikey specific. I have no
> knowledge for this so cannot answer.

No objection from me. I hadn't run into the issue, as I'm not booting
off the sd card.

The patch from Jaehoon doesn't seem to cause trouble in my testing so
far, so I think its worth generating a patch and sending it in for
4.9-rc

thanks
-john
