From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Dec 2013 17:49:47 -0800
Subject: [PATCH v2 2/3] pinctrl: Add msm8x74 configuration
In-Reply-To: <20131210084140.GF11990@sonymobile.com>
References: <1386295805-13708-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1386295805-13708-3-git-send-email-bjorn.andersson@sonymobile.com>
 <52A24E08.706@codeaurora.org> <20131210084140.GF11990@sonymobile.com>
Message-ID: <52A7C4BB.6000701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/13 00:41, Bjorn Andersson wrote:
> On Fri 06 Dec 14:22 PST 2013, Stephen Boyd wrote:
>
>>> +config PINCTRL_MSM8X74
>>> +	bool "Qualcomm 8x74 pin controller driver"
>>> +	select PINCTRL_MSM
>> No help?
>>
> I could write something up, although I guess someone will add a
> select PINCTRL_MSM8X74 in the mach-msm Kconfig and then we're done
> with it.

I hope nobody selects the PINCTRL_MSM8X74 config. It's certainly not
necessary to boot into a ramdisk. I thought checkpatch complained about
missing help for visible options.

>
>> Also, do we ever plan to have anything more than the gpio pins and the
>> sdc pins? It seems like we spend a lot of space describing exactly the
>> same thing in these structs for each of the 146 gpio pins when we could
>> just know that range 0 to 146 is gpio pins and have different code for
>> that part vs the 6 or something sd pins.
>>
> We have to have a pingroup list, so I did look at having that list
> referencing a common object with the gpio/sdc specific data.
>
> But just having it in one large blob is the way that other pinctrl
> drivers does it and hence a common problem to pinctrl and multi-platform
> arm support.

I don't follow what Linus is recommending. How could
.gpio_request_enable()/.gpio_disable_free() help us here?

>
> I have not seen any code in the open referencing the other pins, so I
> left them out for now.
>
>


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
