From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Oct 2014 18:30:21 -0700
Subject: [PATCH v2 6/8] clk: Change clk_ops->determine_rate to return
 a clk_hw as the best parent
In-Reply-To: <1412695334-2608-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com>
 <1412695334-2608-7-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <5435E52D.1030806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2014 08:21 AM, Tomeu Vizoso wrote:
> This is in preparation for clock providers to not have to deal with struct clk.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>   drivers/clk/at91/clk-programmable.c |  4 ++--
>   drivers/clk/bcm/clk-kona.c          |  4 ++--
>   drivers/clk/clk-composite.c         |  9 +++++----
>   drivers/clk/clk.c                   | 11 +++++++----
>   drivers/clk/hisilicon/clk-hi3620.c  |  2 +-
>   drivers/clk/qcom/clk-rcg.c          | 20 ++++++++++++--------
>   drivers/clk/qcom/clk-rcg2.c         | 28 +++++++++++++++++-----------
>   drivers/clk/sunxi/clk-factors.c     |  4 ++--
>   drivers/clk/sunxi/clk-sun6i-ar100.c |  4 ++--
>   include/linux/clk-provider.h        |  4 ++--
>   10 files changed, 52 insertions(+), 38 deletions(-)

What is this based on? I see one in arch/mips/alchemy/common/clock.c as 
well.

Can you also update Documentation/clk.txt please?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
