From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 13 Jul 2018 09:27:30 -0700
Subject: [PATCH] clk: imx6ul: fix missing of_node_put()
In-Reply-To: <1531480400-7664-1-git-send-email-hofrat@osadl.org>
References: <1531480400-7664-1-git-send-email-hofrat@osadl.org>
Message-ID: <153149925072.48062.9395649003513930129@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Nicholas Mc Guire (2018-07-13 04:13:20)
> of_find_compatible_node() is returning a device node with refcount
> incremented and must be explicitly decremented after the last use
> which is right after the us in of_iomap() here.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit 787b4271a6a0 ("clk: imx: add imx6ul clk tree support")

This is not how a Fixes line works. It doesn't have 'commit'. I'll
remove it when applying so no need to resend.
