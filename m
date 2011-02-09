From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Feb 2011 12:33:34 -0200
Subject: [PATCH 2/2] ARM i.MX23/28: Add framebuffer device support
In-Reply-To: <1297257651-8002-3-git-send-email-s.hauer@pengutronix.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTimX7HHC5XuJbbCRu=u7cSC9s3B_und_T2z2S0AX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Feb 9, 2011 at 11:20 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> ---
> ?arch/arm/mach-mxs/clock-mx23.c ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-mxs/clock-mx28.c ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mxs/devices-mx23.h ? ? ? ? ? | ? ?4 ++
> ?arch/arm/mach-mxs/devices-mx28.h ? ? ? ? ? | ? ?4 ++
> ?arch/arm/mach-mxs/devices/Kconfig ? ? ? ? ?| ? ?4 ++
> ?arch/arm/mach-mxs/devices/Makefile ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mxs/devices/platform-mxsfb.c | ? 46 ++++++++++++++++++++++++++++
> ?7 files changed, 61 insertions(+), 1 deletions(-)
> ?create mode 100644 arch/arm/mach-mxs/devices/platform-mxsfb.c
>
> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> index ca72a05..bfc7f27 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -446,7 +446,7 @@ static struct clk_lookup lookups[] = {
> ? ? ? ?_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
> ? ? ? ?_REGISTER_CLOCK(NULL, "usb", usb_clk)
> ? ? ? ?_REGISTER_CLOCK(NULL, "audio", audio_clk)
> - ? ? ? _REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> + ? ? ? _REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)

Is the removal of the pwm clock intended here?

Regards,

Fabio Estevam
