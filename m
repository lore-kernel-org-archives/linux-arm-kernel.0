From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 13 Oct 2015 11:06:13 -0700
Subject: [PATCH v4] mtd: nand: pass page number to ecc->write_xxx() methods
In-Reply-To: <1444728138-3744-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1443765205-8730-1-git-send-email-boris.brezillon@free-electrons.com>
 <1444728138-3744-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151013180613.GA107187@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 11:22:18AM +0200, Boris Brezillon wrote:
> The ->read_xxx() methods are all passed the page number the NAND controller
> is supposed to read, but ->write_xxx() do not have such a parameter.
> 
> This is a problem if we want to properly implement data
> scrambling/randomization in order to mitigate MLC sensibility to repeated
> pattern: to prevent bitflips in adjacent pages in the same block we need
> to avoid repeating the same pattern at the same offset in those pages,
> hence the randomizer/scrambler engine need to be passed the page value
> in order to adapt its seed accordingly.
> 
> Moreover, adding the page parameter to the ->write_xxx() methods add some
> consistency to the current API.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> CC: Josh Wu <josh.wu@atmel.com>
> CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Huang Shijie <shijie.huang@arm.com>
> CC: Stefan Agner <stefan@agner.ch>
> CC: devel at driverdev.osuosl.org
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-kernel at vger.kernel.org
> ---
> Changes since v3:
> - rebased on l2-mtd/master
> 
> Changes since v2:
> - fixed compilation error in the gpmi driver
> - compile tested all impacted drivers except the bf5xx_nand,
>   fsl_elbc_nand and fsl_ifc_nand ones
> 
> Changes since v1:
> - rebased on l2-mtd/master
> - fixed compilation error in the docg4 driver

Applied to l2-mtd.git
