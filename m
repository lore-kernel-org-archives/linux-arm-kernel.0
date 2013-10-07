From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 7 Oct 2013 10:59:44 +0200
Subject: [PATCH 1/5] drm/i2c: tda998x: set VIF for full range,
 underscanned display
In-Reply-To: <E1VSwUV-0000hl-Rw@rmk-PC.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwUV-0000hl-Rw@rmk-PC.arm.linux.org.uk>
Message-ID: <20131007105944.6746352b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 06 Oct 2013 23:07:55 +0100
Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index 60e8404..704040b5 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -549,6 +549,8 @@ tda998x_write_avi(struct drm_encoder *encoder, struct drm_display_mode *mode)
>  	buf[HB(0)] = 0x82;
>  	buf[HB(1)] = 0x02;
>  	buf[HB(2)] = 13;
> +	buf[PB(1)] = 2; /* underscanned display */
> +	buf[PB(3)] = 2 << 2; /* full range */
>  	buf[PB(4)] = drm_match_cea_mode(mode);
>  
>  	tda998x_write_if(encoder, DIP_IF_FLAGS_IF2, REG_IF2_HB0, buf,

You should use the 'hdmi.h' constants which are meaningful enough:

	buf[PB(1)] = HDMI_SCAN_MODE_UNDERSCAN;
	buf[PB(3)] = HDMI_QUANTIZATION_RANGE_FULL << 2;

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
