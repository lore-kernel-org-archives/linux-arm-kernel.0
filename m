From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 19 Apr 2011 01:55:17 -0700 (PDT)
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <20110419073249.GK31131@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<20110418094909.GE31131@pengutronix.de>
	<20110418100716.GJ14770@pengutronix.de>
	<4DACF761.3050503@codeaurora.org>
	<20110419073249.GK31131@pengutronix.de>
Message-ID: <0943efffac47bface3dff8ca4d700361.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, April 19, 2011 12:32 am, Uwe Kleine-K?nig wrote:
> Hello,
>
> On Mon, Apr 18, 2011 at 07:45:53PM -0700, Saravana Kannan wrote:
>> On 04/18/2011 03:07 AM, Sascha Hauer wrote:
>> >On Mon, Apr 18, 2011 at 11:49:09AM +0200, Uwe Kleine-K?nig wrote:
>> >>On Fri, Apr 15, 2011 at 09:08:10PM +0200, Sascha Hauer wrote:
>> >AFAIK there are two different implementation types in the tree. Some
>> >implementations only allow to set to the exact rate round_rate returns
>> >while others round down in set_rate.
>> >
>> >Has this been specified what behaviour is expected?
>> >
>>
>> This is something I have nagged Russell once or twice about and then
>> sent out an email to the list for which there was very limited
>> response. I think clk_round_rate() is too generic and not very
>> useful.
>>
>> We should really have something like:
>> clk_set_rate_range(min, ideal, max)
> (Note this is orthogonal to the question if set_rate may barf on values
> other than the return values of round_rate.)
>
> clk_set_rate_range can even be implemented with clk_round_rate that is
> just required to fulfill:

I think it's more important that we try to find a new API that's better
than clk_round_rate(). We can worry about the specifics of the
implementation later.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
