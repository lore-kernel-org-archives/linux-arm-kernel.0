From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 18:33:40 +0100
Subject: [PATCH] clk: sunxi: don't mark sun6i_ar100_data __initconst
In-Reply-To: <1454428571-4040607-1-git-send-email-arnd@arndb.de>
References: <1453727747-23307-11-git-send-email-wens@csie.org>
 <1454428571-4040607-1-git-send-email-arnd@arndb.de>
Message-ID: <20160202173340.GA4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 04:55:30PM +0100, Arnd Bergmann wrote:
> The clk-sun6i-ar100 clk driver is a platform driver that may use
> deferred probing, so its probe function must not access
> __init symbols. Kbuild warns about this:
> 
> WARNING: drivers/clk/sunxi/built-in.o(.text+0x15f0): Section mismatch in reference from the function sun6i_a31_ar100_clk_probe() to the (unknown reference) .init.rodata:(unknown)
> The function sun6i_a31_ar100_clk_probe() references
> the (unknown reference) __initconst (unknown).
> This is often because sun6i_a31_ar100_clk_probe lacks a __initconst
> annotation or the annotation of (unknown) is wrong.
> 
> Removing the __initconst annotation avoids the warning and makes
> deferred probing work.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 3ca2377b6fed ("clk: sunxi: rewrite sun6i-ar100 using factors clk")

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/a3ac1a8e/attachment.sig>
