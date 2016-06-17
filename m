From: tj@kernel.org (Tejun Heo)
Date: Fri, 17 Jun 2016 12:15:52 -0400
Subject: [PATCH] ata: sata_mv: fix mis-conversion in mv_write_cached_reg()
In-Reply-To: <1465318149-21029-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465318149-21029-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160617161552.GM3262@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 05:49:09PM +0100, Ben Dooks wrote:
> Fix the signed issue in mv_write_cached_reg() where the laddr
> is assigned from a (long)addr instead of (unsigned long)addr.
> 
> Fixes the following warnings:
> 
> drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
> drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
> drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
> drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to libata/for-4.7-fixes.

Thanks.

-- 
tejun
