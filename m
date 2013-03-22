From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 22 Mar 2013 12:08:09 +0100
Subject: [PATCH V2 1/3] clk: Restructure code for __clk_reparent
In-Reply-To: <20130321205310.834.2857@quantum>
References: <1363873693-30902-1-git-send-email-ulf.hansson@stericsson.com>
 <1363873693-30902-2-git-send-email-ulf.hansson@stericsson.com>
 <20130321205310.834.2857@quantum>
Message-ID: <CAPDyKFr3yE6-=OFX=SSfiew95mXQELJTCsGCiXZMZc8G1gdA=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 March 2013 21:53, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Ulf Hansson (2013-03-21 06:48:11)
>> +void __clk_reparent(struct clk *clk, struct clk *new_parent)
>> +{
>> +       clk_reparent(clk, new_parent);
>> +       clk_debug_reparent(clk, new_parent);
>>         __clk_recalc_rates(clk, POST_RATE_CHANGE);
>>  }
>>
>> @@ -1364,7 +1378,9 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>>         }
>>
>>         /* propagate rate recalculation downstream */
>> -       __clk_reparent(clk, parent);
>> +       clk_reparent(clk, parent);
>> +       clk_debug_reparent(clk, parent);
>> +       __clk_recalc_rates(clk, POST_RATE_CHANGE);
>>
>
> This is an interesting change.  Why not call __clk_reparent here instead
> of open coding an identical sequence?

By lazyness when rebasing patches I decided to keep it. :-) Well, my
idea here was also to make it visible how these three calls will be
split out to be called from three different places.

Do you want me to fixup?

Br
Uffe

>
> Regards,
> Mike
