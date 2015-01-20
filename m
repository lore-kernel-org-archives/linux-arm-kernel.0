From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 20 Jan 2015 12:44:42 -0800
Subject: [PATCH] mtd: atmel_nand: return max bitflips in all sectors in
 pmecc_correction()
In-Reply-To: <1421207446-16973-1-git-send-email-josh.wu@atmel.com>
References: <1421207446-16973-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20150120204442.GQ9759@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 11:50:46AM +0800, Josh Wu wrote:
> atmel_nand_pmecc_read_page() will return the total bitflips in this
> page. This is incorrect.
> 
> As one nand page includes multiple ecc sectors, that will cause the
> returned total bitflips exceed ecc capablity.
> 
> So this patch will make pmecc_correct() return the max bitflips of all
> sectors in the page. That also makes atmel_nand_pmecc_read_page() return
> the max bitflips.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Pushed to l2-mtd.git. Thanks.

Brian
