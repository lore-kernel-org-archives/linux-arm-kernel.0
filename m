From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Dec 2017 09:32:28 +0100
Subject: [PATCH] clk: sunxi: sun9i-mmc: Implement reset callback for
 reset controls
In-Reply-To: <20171218210709.GY7997@codeaurora.org>
References: <20171218035751.20661-1-wens@csie.org>
 <20171218210709.GY7997@codeaurora.org>
Message-ID: <20171219083228.mima36idnmhmogdy@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 01:07:09PM -0800, Stephen Boyd wrote:
> On 12/18, Chen-Yu Tsai wrote:
> > Our MMC host driver now issues a reset, instead of just deasserting
> > the reset control, since commit c34eda69ad4c ("mmc: sunxi: Reset the
> > device at probe time"). The sun9i-mmc clock driver does not support
> > this, and will fail, which results in MMC not probing.
> > 
> > This patch implements the reset callback by asserting the reset control,
> > then deasserting it after a small delay.
> > 
> > Fixes: 7a6fca879f59 ("clk: sunxi: Add driver for A80 MMC config clocks/resets")
> > Cc: <stable@vger.kernel.org> # 4.14.x
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> 
> Did you want us to pick this up into clk-fixes? It seems to be
> causing MMC to not work for some time? That sounds annoying
> enough.

That would be great, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171219/86f9bd6a/attachment.sig>
