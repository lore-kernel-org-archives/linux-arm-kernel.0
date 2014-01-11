From: computersforpeace@gmail.com (Brian Norris)
Date: Sat, 11 Jan 2014 15:47:31 -0800
Subject: [PATCH 0/4] mtd: kill the NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE
In-Reply-To: <1387555350-989-1-git-send-email-shijie8@gmail.com>
References: <1387555350-989-1-git-send-email-shijie8@gmail.com>
Message-ID: <20140111234731.GG1992@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 12:02:26AM +0800, Huang Shijie wrote:
> [1] Why kill them?
>     As time goes on, the NAND's page size and oob size become larger and larger.
>     So we have changes these two macros frequently in order to support the new
>     NAND.
> 
> [2] How does this patch set do?
>     There are three drivers which uses these two macros, the mxc-nand, denali,
>     and the cafe-nand.
> 
>     This patch will allocate a temporary buffer for the nand_scan_ident, and 
>     after it have getten the right page size and oob size, it will re-allocate
>     the buffer again.
> 
> [3] I do not have the boards which have the relative NAND controller.
> 
>     I hope someone can test this patch set.
> 
>     thanks.
> 
> 
> Huang Shijie (4):
>   mtd: mxc-nand: kill the NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE
>   mtd: denali: kill the NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE
>   mtd: nand: kill the the NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE for
>     nand_buffers{}
>   mtd: nand: remove the NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE

Pushed only the first 2 patches. Patch 3 still has some issues.

Thanks,
Brian
