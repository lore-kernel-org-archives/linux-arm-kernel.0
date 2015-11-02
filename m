From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 2 Nov 2015 12:55:15 -0800
Subject: [PATCH 1/2] mtd: nand: sunxi: fix
 sunxi_nfc_hw_ecc_read/write_chunk()
In-Reply-To: <1445372161-6529-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1445372161-6529-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151102205515.GA7274@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 10:16:00PM +0200, Boris Brezillon wrote:
> The sunxi_nfc_hw_ecc_read/write_chunk() functions try to avoid changing
> the column address if unnecessary, but the logic to determine whether it's
> necessary or not is currently wrong: it adds the ecc->bytes value to the
> current offset where it should actually add ecc->size.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes 913821bdd211 "mtd: nand: sunxi: introduce sunxi_nfc_hw_ecc_read/write_chunk()"

Pushed both to l2-mtd.git
