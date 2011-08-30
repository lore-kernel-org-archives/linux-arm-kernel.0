From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 31 Aug 2011 07:48:37 +0800
Subject: [PATCH 1/3] ARM: cache-l2x0: make the reinitialization possible
In-Reply-To: <CAGsJ_4wn7zd1Q_s+bq2308W09MHLX5AJevVqsdJd=o4eiGrhNg@mail.gmail.com>
References: <1314690017-17590-1-git-send-email-shawn.guo@linaro.org>
	<1314690017-17590-2-git-send-email-shawn.guo@linaro.org>
	<CAGsJ_4xavZXTa2Z+isORODjK_HoFpSJ5ZMRrd38metiZzYDBeA@mail.gmail.com>
	<20110830145240.GA19359@S2100-06.ap.freescale.net>
	<CAGsJ_4wn7zd1Q_s+bq2308W09MHLX5AJevVqsdJd=o4eiGrhNg@mail.gmail.com>
Message-ID: <CAGsJ_4w1+7X1PP1xwQOD5eD9VsOemP=nvnAVvGUnGiqdNGUYHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/31 Barry Song <21cnbao@gmail.com>:
> 2011/8/30 Shawn Guo <shawn.guo@freescale.com>:
>> On Tue, Aug 30, 2011 at 10:08:59PM +0800, Barry Song wrote:
>>> 2011/8/30 Shawn Guo <shawn.guo@linaro.org>:
>>> > If ARM core gets powered off during suspend, L2 cache controller
>>> > has to be reinitialized by resume procedure.
>>> >
>>> > The patch removes __init annotation from a few initialization
>>> > functions to make the reinitialization possible. ?For example,
>>> > platform resume function can call l2x0_of_init() to get L2 cache
>>> > back to work.
>>>
>>> i think it is good. and i have sent a similar patch before:
>>>
>>> http://www.spinics.net/lists/arm-kernel/msg137372.html
>>> [PATCH v2 3/4] ARM: L2X0: move l2x0_init out of .init section
>>>
>> Since prima2 supports DT, you may also want to call l2x0_of_init()
>> instead of l2x0_init(). ?l2x0_of_init() will parse configuration from
>> DT and sets up tag RAM control for you.
>
> i know that. and rob's patch did some suppport to prima2 and we were
> in the loop of that patch and i have acked it if you read the mail.
> i sent the patch againest the Linus's tree.

you might find two earlier threads about l2x0 re-init as well:

Colin Cross:
[PATCH] ARM: mm: cache-l2x0: Add support for re-enabling l2x0

Barry Song:
[RFC] ARM: l2x0: suspend/resume entries

let's wait for some feedback from Russell.

>
>>
>> --
>> Regards,
>> Shawn
-barry
