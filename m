From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 12 Nov 2013 11:15:16 -0500
Subject: [PATCH 11/12] mtd: nand: davinci: don't request AEMIF address
 range
In-Reply-To: <4F5844B3A985794BA902E12C070812375F8D64@DNCE04.ent.ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-12-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8D64@DNCE04.ent.ti.com>
Message-ID: <52825414.4000806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 November 2013 12:12 PM, Khoronzhuk, Ivan wrote:
> The AEMIF driver registers are used to setup timings for each chip
> select. The same registers range is used to setup NAND settings.
> The AEMIF and NAND drivers not use the same registers in this range.
> 
> In case with AEMIF driver, the memory address range is requested
> already by AEMIF, so we cannot request it twice, just ioremap.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
