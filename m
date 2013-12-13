From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Thu, 12 Dec 2013 18:37:08 -0800 (PST)
Subject: [PATCH] ARM: shmobile: r8a7790 - fix shdi resource sies
In-Reply-To: <1386869040-20849-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1386869040-20849-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <871u1hsd44.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Ben

Thank you for your patch

> The r8a7790.dtsi file has three sdhi nodes which all have the wrong resource
> size for their register block. This causes the sh_modbile_sdhi driver to
> fail to communicate with card at-all.
> 
> Change each sdhi node size from 0x100 to 0x200 to correct this.
> 
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Linux SH <linux-sh@vger.kernel.org>
> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Tested-by: William Towle <william.towle@codethink.co.uk>
> ---

Unfortunately, sdhi resource size 0x100 is corrent on Renesas SDHI.
The wrong is SDHI/TMIO driver side, not SoC side.
Now, I'm working/sending sh_modbile_sdhi driver fixup patches for R-Car H2,
but it need more time (= there is merge timing issue)

Best regards
---
Kuninori Morimoto
