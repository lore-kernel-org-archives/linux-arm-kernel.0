From: rajagopal.venkat@linaro.org (Rajagopal Venkat)
Date: Fri, 22 Mar 2013 15:29:17 +0530
Subject: [PATCH V2 2/3] clk: Improve errorhandling for clk_set_parent
In-Reply-To: <20130321210019.834.12024@quantum>
References: <1363873693-30902-1-git-send-email-ulf.hansson@stericsson.com>
 <1363873693-30902-3-git-send-email-ulf.hansson@stericsson.com>
 <20130321210019.834.12024@quantum>
Message-ID: <CA+Z25wWnGFFK9d+zdL+6iDDmS=0PKGDtU=+rePeGTv8PMtgSOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 March 2013 02:30, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Ulf Hansson (2013-03-21 06:48:12)
>> @@ -1344,8 +1341,9 @@ out:
>>  int clk_set_parent(struct clk *clk, struct clk *parent)
>>  {
>>         int ret = 0;
>> +       u8 p_index;
>>
>> -       if (!clk || !clk->ops)
>> +       if (!clk || !clk->ops || !parent)
>>                 return -EINVAL;
>>
>
> A NULL clock is valid according to the clk.h api.  I would like to allow
> parent to be NULL, resulting in a migration from the real clock tree to
> the orphans list.
>
> This feature was apparently buggy for some time and Rajagopal sent me a
> patch off-list to fix it.  Rajagopal, can you post your patch publicly?
>

Patch is available at https://patchwork.kernel.org/patch/2012221/
Do you want me to rebase it on top of this patchset?

> Thanks,
> Mike



-- 
Regards,
Rajagopal
