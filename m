From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Feb 2017 18:53:18 +0100
Subject: [PATCH] clk: sunxi: ccu-sun5i needs nkmp
In-Reply-To: <20170214213005.2848151-1-arnd@arndb.de>
References: <20170214213005.2848151-1-arnd@arndb.de>
Message-ID: <20170216175318.fuj375743jt43um4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 10:29:45PM +0100, Arnd Bergmann wrote:
> A randconfig build ran into this rare link error:
> 
> drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.1+0x4): undefined reference to `ccu_nkmp_ops'
> drivers/clk/sunxi-ng/ccu-sun5i.o:(.data.__compound_literal.7+0x4): undefined reference to `ccu_nkmp_ops'
> 
> This adds the missing 'select'.
> 
> Fixes: 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Queued as a fix for 4.11, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/df7755f6/attachment-0001.sig>
