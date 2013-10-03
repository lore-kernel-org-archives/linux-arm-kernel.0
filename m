From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 3 Oct 2013 23:27:51 +0300
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20131003202751.GZ6192@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 03:51:25PM -0300, Fabio Estevam wrote:
> This is based on the initial work done by Sascha Hauer and Tony Prisk.
> 
> Tested on imx6q-wandboard and imx6q-sabresd boards.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Rebased against 3.12-rc3 and fixed header file location
> 

It should be done against linux-next as previously mentioned but the
header still needs to be fixed in linux-next I think?

Also it has the following Smatch warnings which are all basically
correct.

drivers/staging/imx-drm/imx-hdmi.c:511 imx_hdmi_update_csc_coeffs() error: buffer overflow '(*csc_coeff)[0]' 4 <= 4
drivers/staging/imx-drm/imx-hdmi.c:520 imx_hdmi_update_csc_coeffs() error: buffer overflow '(*csc_coeff)[1]' 4 <= 4
drivers/staging/imx-drm/imx-hdmi.c:529 imx_hdmi_update_csc_coeffs() error: buffer overflow '(*csc_coeff)[2]' 4 <= 4
drivers/staging/imx-drm/imx-hdmi.c:785 hdmi_phy_i2c_write() info: ignoring unreachable code.
drivers/staging/imx-drm/imx-hdmi.c:873 hdmi_phy_configure() warn: unsigned 'hdmi->hdmi_data.video_mode.mpixelclock' is never less than zero.
drivers/staging/imx-drm/imx-hdmi.c:1537 imx_hdmi_fb_registered() warn: inconsistent returns spin_lock:&hdmi->irq_lock: locked (1514 [s32min-(-1),1-s32max]) unlocked (1508 [0], 1537 [0])
drivers/staging/imx-drm/imx-hdmi.c:1537 imx_hdmi_fb_registered() warn: inconsistent returns irqsave:flags: locked (1514 [s32min-(-1),1-s32max]) unlocked (1508 [0], 1537 [0])
drivers/staging/imx-drm/imx-hdmi.c:1837 imx_hdmi_platform_probe() info: why not propagate 'irq' from platform_get_irq() instead of (-22)?

regards,
dan carpenter
