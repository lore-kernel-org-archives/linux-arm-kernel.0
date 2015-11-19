From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 19 Nov 2015 11:07:07 -0800
Subject: [PATCH 01/27] mtd: nand: fix drivers abusing mtd->priv
In-Reply-To: <1447681080-31232-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447681080-31232-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151119190707.GE64635@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 02:37:34PM +0100, Boris Brezillon wrote:
> The ->priv field of the mtd_info object attached to a nand_chip device
> should point to the nand_chip device. The pxa and cafe drivers are
> assigning this field their own private structure, which works fine as long
> as the nand_chip field is the first one in the driver private struct but
> seems a bit fragile.
> Fix that by setting mtd->priv to point the nand_chip field and assigning
> chip->priv to the private structure head.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Applied to l2-mtd.git
