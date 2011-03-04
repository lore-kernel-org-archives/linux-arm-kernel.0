From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 04 Mar 2011 15:48:45 -0800
Subject: [PATCHv4 0/4] ARM: Fixing udelay() for SMP and non-SMP systems
In-Reply-To: <AANLkTi=KU_zUrBsp0a9iJyj6RmTgYqZcffQynTV-2tKW@mail.gmail.com>
References: <1292883633-19553-1-git-send-email-sboyd@codeaurora.org>
	<AANLkTi=KU_zUrBsp0a9iJyj6RmTgYqZcffQynTV-2tKW@mail.gmail.com>
Message-ID: <4D717A5D.8010608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2011 02:10 AM, Linus Walleij wrote:
> 2010/12/20 Stephen Boyd<sboyd@codeaurora.org>:
>
>> These patches fix the udelay() issue pointed out on
>> arm-lkml[1][2]. A quick recap: some SMP machines can scale
>> their CPU frequencies independent of one another. loops_per_jiffy
>> is calibrated globally and used in __const_udelay(). If one CPU
>> is running faster than what the loops_per_jiffy is calculated
>> (or scaled) for, udelay() will be incorrect and not wait long
>> enough (or too long). A similar problem occurs if the cpu
>> frequency is scaled during a udelay() call.
>
> Hwt's happening to this patch set? We have applied it and
> implemented a timer for the U8500.
>
> Tested-by: Linus Walleij<linus.walleij@linaro.org>
>
> Mattias WALLIN can probably also provide a Tested-by:
> from ST-Ericsson if it helps.
>
> Generally I think this is good and important stuff that should
> be merged, will you be submitting it to Russells patch tracker
> or pull request for 2.6.39?
>

Thanks for testing and reporting it Linus. We are certainly interested 
in getting this in. If I'm not mistaken, the last time we sent it out, 
there was a C vs. assembly argument and got side tracked or no one acked 
or responded to it. Will try to send out the patches again within the 
next few weeks.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
