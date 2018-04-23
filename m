From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Apr 2018 09:53:39 +0200
Subject: [PATCH 2/8] dmaengine: shdmac: Change platform check to
 CONFIG_ARCH_RENESAS
In-Reply-To: <1524230914-10175-3-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20180423075338.riknxyjugnv5grjb@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 03:28:28PM +0200, Geert Uytterhoeven wrote:
> Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> is CONFIG_ARCH_RENESAS a more appropriate platform check than the legacy
> CONFIG_ARCH_SHMOBILE, hence use the former.
> 
> Renesas SuperH SH-Mobile SoCs are still covered by the CONFIG_CPU_SH4
> check, just like before support for Renesas ARM SoCs was added.
> 
> Instead of blindly changing all the #ifdefs, switch the main code block
> in sh_dmae_probe() to IS_ENABLED(), as this allows to remove all the
> remaining #ifdefs.
> 
> This will allow to drop ARCH_SHMOBILE on ARM in the near future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
