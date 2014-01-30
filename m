From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 30 Jan 2014 14:24:59 -0200
Subject: [PATCH] fix compilation of imx-hdmi
In-Reply-To: <20140130161347.GD15937@n2100.arm.linux.org.uk>
References: <20140130161347.GD15937@n2100.arm.linux.org.uk>
Message-ID: <52EA7CDB.7020206@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2014 02:13 PM, Russell King - ARM Linux wrote:
> imx-hdmi creates a hdmi_colorimetry enum.  This is also defined by
> include/linux/hdmi.h, which gets included now via DRM headers since
> 985e5dc207e133 (drm/edid: Populate picture aspect ratio for CEA modes).
> This leads to the compiler complaining:
>
> drivers/staging/imx-drm/imx-hdmi.c:58:6: error: nested redefinition of 'enum hdmi_colorimetry'
> drivers/staging/imx-drm/imx-hdmi.c:58:6: error: redeclaration of 'enum hdmi_colorimetry'
> include/linux/hdmi.h:48:6: note: originally defined here
>
> Fix it by using the one in linux/hdmi.h
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Sachin has also sent the same fix:

http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2014-January/045167.html

Regards,

Fabio Estevam
