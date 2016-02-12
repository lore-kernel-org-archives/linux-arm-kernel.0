From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Feb 2016 10:52:21 -0600
Subject: [PATCH v2 1/2] clk: sunxi: Add support for A80 APBS clock
In-Reply-To: <1455269475-8180-2-git-send-email-wens@csie.org>
References: <1455269475-8180-1-git-send-email-wens@csie.org>
 <1455269475-8180-2-git-send-email-wens@csie.org>
Message-ID: <20160212165221.GA14697@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 05:31:14PM +0800, Chen-Yu Tsai wrote:
> A80's APBS clock is not the same as the APB0 clock on A23. The A80's
> is a zero-based divider, while the A23's is a power-of-two divider.
> 
> Replace the CLK_OF_DECLARE version of sun8i-a23-apb0. This also extends
> the common setup function to take div clk flags.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/clk-sun8i-apb0.c                | 23 ++++++++---------------
>  2 files changed, 9 insertions(+), 15 deletions(-)
