From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 14 Oct 2011 14:26:27 -0400 (EDT)
Subject: [PATCH] ARM: mm/alignment.c: Fix build error
In-Reply-To: <1318615907-25391-1-git-send-email-fabio.estevam@freescale.com>
References: <1318615907-25391-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <alpine.LFD.2.02.1110141421490.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Oct 2011, Fabio Estevam wrote:

> If CONFIG_PROC_FS is not set the following error is generated because
> 'cpu_is_v6_unaligned' definition is protected by CONFIG_PROC_FS:
> 
> CC      arch/arm/mm/alignment.o
> arch/arm/mm/alignment.c: In function 'alignment_init':
> arch/arm/mm/alignment.c:964: error: implicit declaration of function 'cpu_is_v6_unaligned'
> arch/arm/mm/alignment.c:968: error: implicit declaration of function 'safe_usermode'
> make[1]: *** [arch/arm/mm/alignment.o] Error 1
> make: *** [arch/arm/mm] Error 2
> 
> This build error was triggered by 'make randconfig'.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

The same patch from Arnd is already queued by RMK.


Nicolas
