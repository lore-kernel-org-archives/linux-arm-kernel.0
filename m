From: davem@davemloft.net (David Miller)
Date: Mon, 07 Apr 2014 14:56:05 -0400 (EDT)
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <1396672506-9296-4-git-send-email-zhangfei.gao@linaro.org>
References: <1396672506-9296-1-git-send-email-zhangfei.gao@linaro.org>
 <1396672506-9296-4-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140407.145605.1744792379075147420.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat,  5 Apr 2014 12:35:06 +0800

> +#define DESC_DEF_CFG			0x14

You absolutely cannot do this.

You must document what the bits in the TX descriptor config field
mean, all of them.

I bet there is a bit in there somewhere which tells the chip to signal
an interrupt when the packet has been sent.

But since you haven't documented the descriptor fields properly with
a full set of macro defines, we can't know what bit that is.

I really am very disappointed in the quality of this driver, and you
can expect that there will be a lot of push back and requests for
changes before this driver will be even close to being ready for
inclusion.
