From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 11 Mar 2013 14:12:03 +0200
Subject: [PATCH] ARM: OMAP: zoom: Use pwm stack for lcd and keyboard
 backlight
In-Reply-To: <1363003076-17360-1-git-send-email-peter.ujfalusi@ti.com>
References: <1363003076-17360-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <513DCA13.40705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-03-11 13:57, Peter Ujfalusi wrote:
> Use pwm_leds driver for the keyboard light and pwm-backlight for the lcd
> backlight control (instead of implementing the PWM driver part in the board
> file).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom-display.c     | 56 ----------------------------
>  arch/arm/mach-omap2/board-zoom-peripherals.c | 53 +++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 57 deletions(-)

I can't test this, but looks fine to me. Good to get rid of the hacky
backlight code in board-zoom-display.c.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130311/c49d2c3d/attachment.sig>
