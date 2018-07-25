From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 25 Jul 2018 13:32:38 -0700
Subject: [PATCH] clk: imx6ul: fix missing of_node_put()
In-Reply-To: <1531480400-7664-1-git-send-email-hofrat@osadl.org>
References: <1531480400-7664-1-git-send-email-hofrat@osadl.org>
Message-ID: <153255075856.48062.12106960428649534948@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Nicholas Mc Guire (2018-07-13 04:13:20)
> of_find_compatible_node() is returning a device node with refcount
> incremented and must be explicitly decremented after the last use
> which is right after the us in of_iomap() here.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit 787b4271a6a0 ("clk: imx: add imx6ul clk tree support")
> ---

Applied to clk-next
