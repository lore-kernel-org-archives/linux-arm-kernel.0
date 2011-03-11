From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Fri, 11 Mar 2011 12:14:11 +0000
Subject: [PATCH RFC] arm: mini2440: Fix uda134x codec problem.
In-Reply-To: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
References: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
Message-ID: <1299845651.3394.47.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-09 at 21:46 +0100, Marek Belisko wrote:
> ASoC audio for mini2440 platform in current kenrel doesn't work.
> First problem is samsung_asoc_dma device is missing in initialization.
> Next problem is with codec. Codec is initialized but never probed
> because no platform_device exist for codec driver. It leads to errors
> during codec binding to asoc dai. Next problem was platform data which
> was passed from board to asoc main driver but not passed to codec when
> called codec_soc_probe().
> 
> Following patch should fix issues. But not sure if in correct way.
> Please review.
> 
> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>

Acked-by: Liam Girdwood <lrg@ti.com>
