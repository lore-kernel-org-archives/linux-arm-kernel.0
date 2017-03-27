From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Mar 2017 13:37:14 +0200
Subject: [PATCH] clk: sunxi-ng: fix build error without
 CONFIG_RESET_CONTROLLER
In-Reply-To: <20170327095753.29091-1-tobias.regnery@gmail.com>
References: <20170327095753.29091-1-tobias.regnery@gmail.com>
Message-ID: <20170327113714.4ozfacmdpu4qx7av@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 11:57:53AM +0200, Tobias Regnery wrote:
> With CONFIG_RESET_CONTROLLER=n we get the following link error in the
> sunxi-ng clk driver:
> 
> drivers/built-in.o: In function `sunxi_ccu_probe':
> mux-core.c:(.text+0x12fe68): undefined reference to 'reset_controller_register'
> mux-core.c:(.text+0x12fe68): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'reset_controller_register'
> 
> Fix this by adding the appropriate select statement.
> 
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/94690a35/attachment.sig>
