From: tj@kernel.org (Tejun Heo)
Date: Mon, 19 May 2014 16:09:00 -0400
Subject: [PATCH] ahci: imx: PLL clock needs 100us to settle down
In-Reply-To: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
References: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140519200900.GB27506@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 08:46:01PM +0800, Shawn Guo wrote:
> The commit e783c51 (ahci: imx: software workaround for phy reset issue
> in resume) calls imx_sata_phy_reset() to reset phy immediately after
> SATA MPLL is enabled.  It seems working fine mostly, but fails in some
> case as below.
> 
> ...
> ahci-imx 2200000.sata: failed to reset phy: -110
> ahci-imx: probe of 2200000.sata failed with error -110
> 
> After talking to the designer, we learnt that when enabling i.MX6Q SATA
> MPLL, we need to wait 100us for it to settle down for safety.  Add this
> required delay to fix above failure.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
