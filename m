From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Nov 2014 22:49:47 +0100
Subject: [PATCH] clk: sunxi: Remove ahb1_sdram from sun6i/sun8i protected
 clocks list
In-Reply-To: <1416823515-9207-1-git-send-email-wens@csie.org>
References: <1416823515-9207-1-git-send-email-wens@csie.org>
Message-ID: <20141125214947.GG25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 06:05:15PM +0800, Chen-Yu Tsai wrote:
> The ahb1_sdram clock gate is only used for accessing the sdram
> controller's registers over the bus. It is not used for actually clock
> the controller or the dram, hence it does not need to be protected.
> 
> This also gets rid of the problem when the protected ahb1_sdram gate
> is prepared/enabled while it is still an orphan, and the operation
> is not propagated to the correct parent.
> 
> This was confirmed on my A23 tablet and my A31 Hummingbird.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Queued for 3.20, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/776e12f9/attachment.sig>
