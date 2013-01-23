From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Jan 2013 10:42:30 +0100
Subject: [PATCH 2/4] drm/i2c: nxp-tda998x (v2)
In-Reply-To: <1358894185-21617-3-git-send-email-robdclark@gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-3-git-send-email-robdclark@gmail.com>
Message-ID: <20130123104230.38cfc515@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jan 2013 16:36:23 -0600
Rob Clark <robdclark@gmail.com> wrote:

> Driver for the NXP TDA998X i2c hdmi encoder slave.
> 
> v1: original
> v2: fix npix/nline programming
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/gpu/drm/i2c/Makefile      |   3 +
>  drivers/gpu/drm/i2c/tda998x_drv.c | 908 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 911 insertions(+)
>  create mode 100644 drivers/gpu/drm/i2c/tda998x_drv.c
	[snip]
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> new file mode 100644
> index 0000000..02054e8
> --- /dev/null
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -0,0 +1,908 @@
	[snip]
> +static void __exit
> +tda998x_exit(void)
> +{
> +	DBG("");
> +	drm_i2c_encoder_unregister(&tda998x_driver);
> +}
> +
> +MODULE_DESCRIPTION("NXP Semiconductors TDA998X TMDS transmitter driver");
> +
> +MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
> +MODULE_DESCRIPTION("NXP Semiconductors TDA998X HDMI Encoder");
> +MODULE_LICENSE("GPL");
> +
> +module_init(tda998x_init);
> +module_exit(tda998x_exit);

There are 2 MODULE_DESCRIPTION().

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
