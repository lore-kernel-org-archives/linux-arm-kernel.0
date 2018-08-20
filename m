From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 20 Aug 2018 15:36:47 +0200
Subject: [PATCH 0/5] Set max rate for video PLLs
In-Reply-To: <20180809165217.30680-1-jernej.skrabec@siol.net>
References: <20180809165217.30680-1-jernej.skrabec@siol.net>
Message-ID: <20180820133647.vpj7p36ir334g4am@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2018 at 06:52:12PM +0200, Jernej Skrabec wrote:
> This patch series implement maximum rate constraint for video PLLs,
> because it is possible to set higher PLL rate that is actually
> supported in HW.
> 
> Issue became apparent when user reported non-working monitor connected
> to board with H5 SoC. Native monitor resolution in this case was
> 2560x1080, with 185580 kHz pixel clock. Clock subsystem found out that
> best matching pixel clock can be generated if video PLL is set to 2040
> MHz, which is way out of specs for PLL. With this patch series applied,
> everything worked just fine, with slightly higher rate error, but within
> working limits for PLL and HDMI.
> 
> I'm not sure if "Fixes" tag should be added. It solves real world
> problem, but there was nothing wrongly implemented, just upper limit
> is missing.
> 
> While user reported that these patches solve the issue on H5, I added
> similar fixes for other SoCs too. Since I don't have such monitor,
> I only tested if board boots up and if HDMI works (H3, R40 and A83T).

Queued for 4.20, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/c01ca50c/attachment.sig>
