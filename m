From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 20 Apr 2011 14:45:39 -0700
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <20110420063643.GD15233@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>	<20110418094909.GE31131@pengutronix.de>	<20110418100716.GJ14770@pengutronix.de>	<4DACF761.3050503@codeaurora.org>	<20110419073249.GK31131@pengutronix.de>	<0943efffac47bface3dff8ca4d700361.squirrel@www.codeaurora.org>	<20110419093126.GA14770@pengutronix.de>	<2b16ee39-08ba-4482-a9fc-6d1393ac1229@email.android.com>
	<20110420063643.GD15233@pengutronix.de>
Message-ID: <4DAF5403.8090802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2011 11:36 PM, Sascha Hauer wrote:
> On Tue, Apr 19, 2011 at 03:28:50PM -0700, Saravana Kannan wrote:
>> Sascha Hauer<s.hauer@pengutronix.de>  wrote:
>>
>>>>>>
>>>>>> We should really have something like:
>>>>>> clk_set_rate_range(min, ideal, max)
>>>>> (Note this is orthogonal to the question if set_rate may barf on
>>> values
>>>>> other than the return values of round_rate.)
>>>>>
>>>>> clk_set_rate_range can even be implemented with clk_round_rate that
>>> is
>>>>> just required to fulfill:
>>>>
>>>> I think it's more important that we try to find a new API that's
>>> better
>>>> than clk_round_rate(). We can worry about the specifics of the
>>>> implementation later.
>>>
>>> You found it and Uwe found a way to implement this ontop of the old
>>> API,
>>> that's a comfortable situation, isn't it?
>>
>> Well, do we all agree to this new API? I have no problem with Uwe's
>> helper fn or his suggestion, if we all agree on the final API. I just
>> didn't want him wasting his time when the API is not finalized.
>
> As Uwes suggestion does not change the internal clock API it's
> relatively simple to try out. With this we moved to the
> add-a-helper-function class of patches and are not in the
> change-internal-and-external-API-with-hundreds-of-users
> class anymore.

If clk_set_rate_range() is not made an external API, then it's pointless 
to even add it.

Also, you can make it an internal API (to be implemented by clock 
drivers) and still not need "hundreds of users to change". The generic 
code will use this helper function if the set_rate_range() API is not 
implemented by a specific clock/clock driver. If it's implemented by the 
specific clock, then that one will be used. That's not rocket science.

Let's stop discussion about whether Uwe's change is useful or not. I 
don't care. If you think it's great, then good for you both.

Or, may be I will start a separate thread if you don't like me using 
this thread to get an agreement on the API first. Just you and me 
agreeing is not enough.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
