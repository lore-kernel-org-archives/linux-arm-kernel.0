From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Apr 2017 10:02:41 +0200
Subject: [PATCH] arm64: sunxi: always enable reset controller
In-Reply-To: <20170419173601.3773999-1-arnd@arndb.de>
References: <20170419173601.3773999-1-arnd@arndb.de>
Message-ID: <20170420080241.4445eir3nsmrq6fw@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 07:35:36PM +0200, Arnd Bergmann wrote:
> The sunxi clk driver causes a link error when the reset controller
> subsystem is disabled:
> 
> drivers/clk/built-in.o: In function `sun4i_ve_clk_setup':
> :(.init.text+0xd040): undefined reference to `reset_controller_register'
> drivers/clk/built-in.o: In function `sun4i_a10_display_init':
> :(.init.text+0xe5e0): undefined reference to `reset_controller_register'
> drivers/clk/built-in.o: In function `sunxi_usb_clk_setup':
> :(.init.text+0x10074): undefined reference to `reset_controller_register'
> 
> We already force it to be enabled on arm32 and some other arm64 platforms,
> but not on arm64/sunxi. This adds the respective Kconfig statements to
> also select it here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig.platforms | 2 ++
>  1 file changed, 2 insertions(+)
> 
> I'd suggest we can pick this up in arm-soc as a non-urgent bugfix for 4.12

That works for me, you can add my Acked-by.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170420/8c6d2517/attachment.sig>
