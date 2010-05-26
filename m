From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 26 May 2010 21:50:03 +0800
Subject: [PATCH 5/5] pxa/vpac270: Add VGA modes for ADV7125
In-Reply-To: <1274404366-26304-5-git-send-email-marek.vasut@gmail.com>
References: <1274404366-26304-1-git-send-email-marek.vasut@gmail.com>
	<1274404366-26304-5-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTikR62CIASihEmtac9aa2zZAZqzLgNFKxpDeeQLR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 9:12 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/vpac270.c | ? 50 ++++++++++++++++++++++++++++++++++++++++++-
> ?1 files changed, 49 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> index d4bf54a..207a1e5 100644
> --- a/arch/arm/mach-pxa/vpac270.c
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -492,7 +492,55 @@ static struct pxafb_mode_info vpac270_lcd_modes[] = {
> ? ? ? ?.vsync_len ? ? ?= 2,
>
> ? ? ? ?.sync ? ? ? ? ? = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -},
> +}, { ? /* CRT 640x480 */
> + ? ? ? .pixclock ? ? ? = 35000,
> + ? ? ? .xres ? ? ? ? ? = 640,
> + ? ? ? .yres ? ? ? ? ? = 480,
> + ? ? ? .bpp ? ? ? ? ? ?= 16,
> + ? ? ? .depth ? ? ? ? ?= 16,
> +
> + ? ? ? .left_margin ? ?= 96,
> + ? ? ? .right_margin ? = 48,
> + ? ? ? .upper_margin ? = 33,
> + ? ? ? .lower_margin ? = 10,
> +
> + ? ? ? .hsync_len ? ? ?= 48,
> + ? ? ? .vsync_len ? ? ?= 1,
> +
> + ? ? ? .sync ? ? ? ? ? = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +}, { ? /* CRT 800x600 H=30kHz V=48HZ */
> + ? ? ? .pixclock ? ? ? = 25000,
> + ? ? ? .xres ? ? ? ? ? = 800,
> + ? ? ? .yres ? ? ? ? ? = 600,
> + ? ? ? .bpp ? ? ? ? ? ?= 16,
> + ? ? ? .depth ? ? ? ? ?= 16,
> +
> + ? ? ? .left_margin ? ?= 50,
> + ? ? ? .right_margin ? = 1,
> + ? ? ? .upper_margin ? = 21,
> + ? ? ? .lower_margin ? = 12,
> +
> + ? ? ? .hsync_len ? ? ?= 8,
> + ? ? ? .vsync_len ? ? ?= 1,
> +
> + ? ? ? .sync ? ? ? ? ? = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +}, { ? /* CRT 1024x768 H=40kHz V=50Hz */
> + ? ? ? .pixclock ? ? ? = 15000,
> + ? ? ? .xres ? ? ? ? ? = 1024,
> + ? ? ? .yres ? ? ? ? ? = 768,
> + ? ? ? .bpp ? ? ? ? ? ?= 16,
> + ? ? ? .depth ? ? ? ? ?= 16,
> +
> + ? ? ? .left_margin ? ?= 220,
> + ? ? ? .right_margin ? = 8,
> + ? ? ? .upper_margin ? = 33,
> + ? ? ? .lower_margin ? = 2,
> +
> + ? ? ? .hsync_len ? ? ?= 48,
> + ? ? ? .vsync_len ? ? ?= 1,
> +
> + ? ? ? .sync ? ? ? ? ? = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +}
> ?};
>
> ?static struct pxafb_mach_info vpac270_lcd_screen = {
> --
> 1.7.0
>
>
