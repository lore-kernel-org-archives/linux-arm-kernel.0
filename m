From: davem@davemloft.net (David Miller)
Date: Mon, 14 Dec 2015 16:12:18 -0500 (EST)
Subject: [PATCH net] stmmac: dwmac-sunxi: Call exit cleanup function in
 probe error path
In-Reply-To: <1449828229-10720-1-git-send-email-wens@csie.org>
References: <1449828229-10720-1-git-send-email-wens@csie.org>
Message-ID: <20151214.161218.2057176608170714361.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 11 Dec 2015 18:03:49 +0800

> dwmac-sunxi has 2 callbacks that were called from stmmac_platform as
> part of the probe and remove sequences.
> 
> Ater the conversion of dwmac-sunxi into a standalone platform driver,
> the .init function is called before calling into the stmmac driver
> core, but .exit is not called to clean up if stmmac returns an error.
> 
> This patch fixes the probe error path. This properly cleans up and
> releases resources when the driver core fails to probe.
> 
> Cc: Joachim Eastwood <manabian@gmail.com>
> Fixes: 9a9e9a1edee8 ("stmmac: dwmac-sunxi: turn setup callback into a
> 		      probe function")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks.
