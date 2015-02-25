From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 25 Feb 2015 19:52:41 +0100
Subject: [PATCH 2/2] mmc: dw_mmc: Don't crash if we get an interrupt before
 slot has initted
In-Reply-To: <1424887912-20015-2-git-send-email-dianders@chromium.org>
References: <1424887912-20015-1-git-send-email-dianders@chromium.org>
 <1424887912-20015-2-git-send-email-dianders@chromium.org>
Message-ID: <54EE19F9.6020302@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 02/25/2015 07:11 PM, Doug Anderson wrote:
> It's unlikely that this is really needed on any single-slot systems
> where we disable card detects until the end of probe, but it still
> seems safer to check to make sure that a slot has been initted before
> we try to dereference it to find the SDIO interrupt mask.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

On an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
