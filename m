From: davidb@codeaurora.org (David Brown)
Date: Mon, 02 May 2011 09:55:01 -0700
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <1304307632.2686.33.camel@pororo> (Jeremy Kerr's message of "Mon,
	02 May 2011 11:40:32 +0800")
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<4DBDC3B5.7070808@gmail.com> <1304298586.2686.29.camel@pororo>
	<4DBE2064.2060303@gmail.com> <1304307632.2686.33.camel@pororo>
Message-ID: <8yabozlniu2.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 01 2011, Jeremy Kerr wrote:

> Hi Rob,
>
>> I think you will find many examples in the kernel where that is not done 
>> by drivers.
>
> Drivers should be checking the return value of clk_get - if they don't,
> it's a bug. This is the logical place to check, rather than before all
> clock API calls.
>
> For cases where there is no clock provided for the device (but is a
> valid clock on some machines), the platform code should return a no-op
> clock from the clk_get call. This 'noop clock' would be a good contender
> for inclusion into the kernel-wide infrastructure, like clk_fixed.

Having a general fixed clock is a good idea.  There seem to be several
'dummy' clocks under various subarchs, and Stephen Boyd posted one for
MSM on March 24.

Most of the MSM drivers check the clk_get and fail to probe the driver
if the clock is unavailable.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
