From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 Sep 2011 17:28:29 +0800
Subject: [PATCH v2] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
References: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20110929092828.GE19318@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 25, 2011 at 08:26:09PM -0700, Barry Song wrote:
> we save the l2x0 registers at the first initialization, and platform codes
> can get them to restore l2x0 status after wakeup.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v2:
>  define the structure l2x0_regs to hold all saved registers;
>  make saved copy of registers non-static so that platform codes can access them;
>  add asm_offset for l2x0 saved regs(l2x0_regs struct) so that asm codes can use
> 

I'm trying to migrate imx6q to this infrastructure, but seeing some
facts that might stop me from the effort.  Please help me understand
these facts are correct.

It seems to me that the only benefit that imx6q gains from the
infrastructure is the register saving, and I fail to see any benefit
on the restoring.

 * I still have to save physical base of l2x0 for register restoring.
 * I do not have the physical address of l2x0_saved_regs, and I have
   to manage to get it somehow.

-- 
Regards,
Shawn
