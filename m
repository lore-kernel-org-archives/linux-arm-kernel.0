From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 23 Apr 2018 11:21:19 +0200
Subject: [PATCH] Revert "drm/sun4i: add lvds mode_valid function"
In-Reply-To: <20180421045155.15332-1-megous@megous.com>
References: <20180421045155.15332-1-megous@megous.com>
Message-ID: <20180423092119.5ssii67dtvsekwze@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2018 at 06:51:55AM +0200, megous at megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> The reverted commit broke LVDS output on TBS A711 Tablet. That tablet
> has simple-panel node that has fixed pixel clock-frequency that A83T
> SoC used in the tablet can't generate exactly.
> 
> Requested rate is 52000000 and rounded_rate is calculated as 51857142.
> It's close enough for it to work in practice, but with strict check
> in the reverted commit, the mode is rejected needlessly in this case.
> 
> DT allows to specify a range of values for simple-panel/clock-frequency,
> but driver doesn't respect that ATM. Given that TBS A711 is the single
> user of sun4i-lvds driver, let's revert that commit for now, until
> a better solution for the problem is found.
> 
> Also see: https://patchwork.kernel.org/patch/9446385/ for relevant
> discussion (or search for "[RFC] drm/sun4i: rgb: Add 5% tolerance
> to dot clock frequency check").
> 
> Fixes: e4e4b7ad50cf ("drm/sun4i: add lvds mode_valid function")
> Reported-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180423/059befd1/attachment-0001.sig>
