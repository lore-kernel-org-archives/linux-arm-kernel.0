From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Jun 2013 14:05:15 +0530
Subject: [PATCH v2] ARM: edma: Convert to devm_* api
In-Reply-To: <1371481078-18058-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1371481078-18058-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <51C01BC3.4060100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/17/2013 8:27 PM, Prabhakar Lad wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> Use devm_ioremap_resource instead of reques_mem_region()/ioremap(),
> devm_request_irq() instead of request_irq() and kzalloc() calls to
> devm_kzalloc().
> 
> This ensures more consistent error values and simplifies error paths.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Nice clean-up. The patch did not build since <linux/err.h> was not
included. I fixed it locally and applied to v3.11/soc-2 branch of my tree.

Thanks,
Sekhar
