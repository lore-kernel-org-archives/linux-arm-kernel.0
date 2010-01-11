From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 11 Jan 2010 03:32:10 -0500
Subject: [PATCH v2 06/09] backlight: enable backlight in 88pm860x
In-Reply-To: <1262953648.10097.34.camel@dax.rpnet.com>
References: <771cded00912090515k39cccec9od78addb8e127f491@mail.gmail.com>
	<20100108110646.GB3734@sortiz.org>
	<1262953648.10097.34.camel@dax.rpnet.com>
Message-ID: <771cded01001110032s7fe62605g72cdb50b73d0d53@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 8, 2010 at 7:27 AM, Richard Purdie <rpurdie@rpsys.net> wrote:
> On Fri, 2010-01-08 at 12:06 +0100, Samuel Ortiz wrote:
>> Hi Haojian, Richard,
>>
>> On Wed, Dec 09, 2009 at 08:15:28AM -0500, Haojian Zhuang wrote:
>> > From 8d2bc9826f758f113fde6f3fd01723111fbf2a91 Mon Sep 17 00:00:00 2001
>> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> > Date: Mon, 9 Nov 2009 12:41:07 -0500
>> > Subject: [PATCH] backlight: enable backlight in 88pm860x
>> >
>> > At most, three backlight device can be supported in 88pm860x driver.
>> I applied this patch and the LED one to my for-next branch.
>> Richard, whenever you have time for that, could you please quickly check if
>> they oook ok to you ? They're 2.6.34 material, so no rush here.
>
> I had a look through, they look basically ok.
>
> In the LED patch I'm not sure I like the SET_BRIGHTNESS and SET_BLINK
> sharing of a workqueue though. Its not going to crash, I can just see
> values potentially getting lost as the code has a race condition. It
> would be easier if it just compared led->current_brightness to
> led->brightness acting if needed and something similar for LED blinking.
>
> Cheers,
>
> Richard
>

Excuse me that there's a mutex lock in __led_set(). Both
SET_BRIGHTNESS & SET_BLINK calls __led_set(). There shouldn't be race
condition on set led. What's your opinion?

Best Regards
Haojian
