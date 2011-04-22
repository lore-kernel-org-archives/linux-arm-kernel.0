From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 21 Apr 2011 21:57:36 -0700
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <alpine.LFD.2.02.1104212146400.3323@ionos>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1104212146400.3323@ionos>
Message-ID: <4DB10AC0.2000709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2011 12:48 PM, Thomas Gleixner wrote:
> On Fri, 15 Apr 2011, Sascha Hauer wrote:
>> From: Jeremy Kerr<jeremy.kerr@canonical.com>
>> + * @get:	Called by the core clock code when a device driver acquires a
>> + *		clock via clk_get(). Optional.
>> + *
>> + * @put:	Called by the core clock code when a devices driver releases a
>> + *		clock via clk_put(). Optional.
>
> These callbacks are completely pointless. There are only two non empty
> implementations in tree:
>
> One does a try_module_get(clk->owner), which should be done in generic
> code. The other does special clock enabling magic which wants to go to
> clk->prepare().

Aren't you kinda contradicting yourself? In the other thread you say 
that when we implement a generic framework, you will have to implement 
more than what a specific arch would need. This seems to be exactly one 
of those cases. What's wrong with it?

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
