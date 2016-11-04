From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 4 Nov 2016 08:49:40 +0100
Subject: [PATCH] clk: sunxi: Fix M factor computation for APB1
In-Reply-To: <1478217236-12831-1-git-send-email-stephan@soliotek.com>
References: <1478217236-12831-1-git-send-email-stephan@soliotek.com>
Message-ID: <20161104074940.ak46ghzoa3o3xcie@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 12:53:56AM +0100, St?phan Rafin wrote:
> commit cfa636886033 ("clk: sunxi: factors: Consolidate get_factors
> parameters into a struct") introduced a regression for m factor
> computation in sun4i_get_apb1_factors function.
> 
> The old code reassigned the "parent_rate" parameter to the targeted
> divisor value and was buggy for the returned frequency but not for the
> computed factors. Now, returned frequency is good but m factor is
> incorrectly computed (its max value 31 is always set resulting in a
> significantly slower frequency than the requested one...)
> 
> This patch simply restores the original proper computation for m while
> keeping the good changes for returned rate.
> 
> Signed-off-by: St?phan Rafin <stephan@soliotek.com>

Applied (added a Fixes tag), thanks

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161104/a56fa6c0/attachment.sig>
