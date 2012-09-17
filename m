From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Sep 2012 14:50:56 +0000
Subject: [PATCH v3] ARM: imx: armadillo5x0: Fix illegal register access
In-Reply-To: <1347845315-16565-1-git-send-email-festevam@gmail.com>
References: <1347845315-16565-1-git-send-email-festevam@gmail.com>
Message-ID: <201209171450.57142.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit eb92044eb (ARM i.MX3: Make ccm base address a variable )
> it is necessary to pass the CCM register base as a variable.
> 
> Fix the CCM register access in mach-armadillo5x0 by passing mx3_ccm_base and 
> avoid illegal accesses.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think you should probably add a "Cc: stable at vger.kernel.org" tag as
well to ensure it gets applied on longterm kernels, and it would be
good to mention how far back it needs to be applied (v3.4, v3.5, v3.6?)
so we don't accidentally get it on an older kernel that breaks from
this patch.

	Arnd
