From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 30 Aug 2011 22:08:59 +0800
Subject: [PATCH 1/3] ARM: cache-l2x0: make the reinitialization possible
In-Reply-To: <1314690017-17590-2-git-send-email-shawn.guo@linaro.org>
References: <1314690017-17590-1-git-send-email-shawn.guo@linaro.org>
	<1314690017-17590-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAGsJ_4xavZXTa2Z+isORODjK_HoFpSJ5ZMRrd38metiZzYDBeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/30 Shawn Guo <shawn.guo@linaro.org>:
> If ARM core gets powered off during suspend, L2 cache controller
> has to be reinitialized by resume procedure.
>
> The patch removes __init annotation from a few initialization
> functions to make the reinitialization possible. ?For example,
> platform resume function can call l2x0_of_init() to get L2 cache
> back to work.

i think it is good. and i have sent a similar patch before:

http://www.spinics.net/lists/arm-kernel/msg137372.html
[PATCH v2 3/4] ARM: L2X0: move l2x0_init out of .init section

people haven't give any feedback yet.

>
> It also adds the empty function for l2x0_init() and l2x0_of_init(),
> so that we can keep '#ifdef CONFIG_CACHE_L2X0' check in header.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
-barry
