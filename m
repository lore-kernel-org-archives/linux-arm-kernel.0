From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Mar 2015 10:10:17 -0700
Subject: [PATCH v2] mtd: atmel_nand: check NFC busy flag by HSMC_SR
 instead of NFC cmd regs
In-Reply-To: <1421922090-8803-1-git-send-email-josh.wu@atmel.com>
References: <1421922090-8803-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20150311171017.GG4124@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 06:21:30PM +0800, Josh Wu wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Currently the driver read NFC command registers to get NFC busy flag.
> Actually this flag also can be get by reading HSMC_SR register.
> 
> Use the read NFC command registers need mapping a huge memory region.
> To save the mapped memory region, we change to check NFC busy flag by
> reading HSMC_SR register.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> 
> Changes in v2:
> - Change me to signed-off-by.
> - modify the error log.

Pushed to l2-mtd.git.

Brian
