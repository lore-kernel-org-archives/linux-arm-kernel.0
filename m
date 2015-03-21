From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Mar 2015 11:50:10 +0100
Subject: [PATCH 3/6] clk: sunxi: Register divs clocks before factor clocks
In-Reply-To: <1426785548-5932-4-git-send-email-wens@csie.org>
References: <1426785548-5932-1-git-send-email-wens@csie.org>
 <1426785548-5932-4-git-send-email-wens@csie.org>
Message-ID: <20150321105010.GC2774@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 01:19:05AM +0800, Chen-Yu Tsai wrote:
> We want to reparent AHB clock to PLL6 on sun5i/sun7i using the assigned
> clocks properties. AHB is a factor clock, while PLL6 is a divs clock.
> 
> Register divs clocks before factor clocks so reparenting works. This
> is only needed because we do the reparenting on the clock provider.
> 
> The proper way to fix this is to split out all the old sunxi clocks
> into separate CLK_OF_DECLARE statements, like we are doing for sun9i.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150321/1586b51f/attachment.sig>
