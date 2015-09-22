From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 21 Sep 2015 17:15:28 -0700
Subject: [PATCH] mtd: nand: sunxi: fix sunxi_nand_chips_cleanup()
In-Reply-To: <1442160883-29011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1442160883-29011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150922001528.GL31505@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2015 at 06:14:43PM +0200, Boris Brezillon wrote:
> The sunxi_nand_chips_cleanup() function is missing a call to list_del()
> which generates a double free error.

And if you could manage to get past that...an infinite loop, no?

> Reported-by: Priit Laes <plaes@plaes.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: <stable@vger.kernel.org> # 3.19+
> Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")

Applied to linux-mtd.git, as this is a -stable fix.

Brian
