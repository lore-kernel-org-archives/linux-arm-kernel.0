From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 25 Jul 2018 13:33:19 -0700
Subject: [PATCH] clk: imx6sll: fix missing of_node_put()
In-Reply-To: <1531500004-23175-1-git-send-email-hofrat@osadl.org>
References: <1531500004-23175-1-git-send-email-hofrat@osadl.org>
Message-ID: <153255079923.48062.1152946611739352576@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Nicholas Mc Guire (2018-07-13 09:40:04)
> of_find_compatible_node() is returning a device node with refcount
> incremented and must be explicitly decremented after the last use
> which is right after the us in of_iomap() here.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit 4a5f720b6542 ("clk: imx: add clock driver for imx6sll")
> ---

Applied to clk-next
