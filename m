From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 13 Sep 2011 19:22:17 -0700 (PDT)
Subject: [PATCH 01/11] clk: Add a generic clock infrastructure
In-Reply-To: <1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com
	>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <decbd6943536eae1bddda9765ac5b267.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, August 24, 2011 6:15 am, Mark Brown wrote:
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 1d37f42..93ff870 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h

> -struct clk;
> +static inline int clk_prepare(struct clk *clk) { return 0; }
> +static inline void clk_unprepare(struct clk *clk) { }
> +

You should add might_sleep() inside these stubs. That way, if any device
driver developers wants to move over to the new APIs before their arch
does, they get to see the warnings when they call prepare/unprepare in
atomic context.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
