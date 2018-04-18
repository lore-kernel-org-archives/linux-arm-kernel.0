From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 18 Apr 2018 16:27:25 -0700
Subject: [PATCH] clk: sunxi-ng: replace lib-y with obj-y
In-Reply-To: <1524052351-14103-1-git-send-email-yamada.masahiro@socionext.com>
References: <1524052351-14103-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <152409404578.51482.16644171573677016161@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Masahiro Yamada (2018-04-18 04:52:31)
> We had commit 06e226c7fb23 ("clk: sunxi-ng: Move all clock types to a
> library") and commit 799c43415442 ("kbuild: thin archives make default
> for all archs") in the same development cycle, from different trees.
> 
> With migration to the thin archive, the entire drivers/clk/sunxi-ng/lib.a
> is linked to the vmlinux.  This does not break build, but we do not get
> any size saving.
> 
> However, we do not need to go back to the individual Kconfig options.
> The default configuration pulls in all (or most) of the CCU parts anyway.
> Also, once we enable CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, we can simply
> list all files with obj-y, and the linker will drop all unused functions
> by itself.
> 
> After the long discussion [1], people there agreed to fix this, but
> nobody sent a patch after all.  I am doing it now.
> 
> I lifted up CONFIG_SUNXI_CCU to drivers/clk/Makefile because everything
> in drivers/clk/sunxi-ng/ depends on SUNXI_CCU.
> 
> [1] https://patchwork.kernel.org/patch/9796521/
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Thanks for remembering to take care of this. I forgot about it all.

Acked-by: Stephen Boyd <sboyd@kernel.org>

Or I can pick this up directly. Let me know.
