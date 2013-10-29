From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 Oct 2013 13:45:50 -0200
Subject: [PATCH v3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <CAOMZO5BYXv4whoRrRD7pF5zj9DArEnbqFaZVdLgZgPC2nSDePw@mail.gmail.com>
References: <1382992009-19407-1-git-send-email-festevam@gmail.com>
 <20131028211945.GJ16735@n2100.arm.linux.org.uk>
 <CAOMZO5BYXv4whoRrRD7pF5zj9DArEnbqFaZVdLgZgPC2nSDePw@mail.gmail.com>
Message-ID: <CAOMZO5DN0KGvUBut0BqyvPTdyByWtZ=uamTpQGeENBzMOfJK3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 1:00 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Today I was able to get access to a wandboard solo and the HDMI image
> does look different compared to a wandboard quad board:
>
> - The Linux logo penguins are steady on mx6q, but on mx6solo the
> contour lines look like they flicker.
> - The kernel log text appears in good white colour with mx6q, but not
> so white on mx6solo (tending to green).
>
> Even the U-boot HDMI splash screen is not very steady on mx6solo.
>
> I will try to look at these mx6 solo HDMI issues.

With the change below I am able to get a good HDMI quality image on
mx6solo (and mx6quad as well):

--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -238,7 +238,7 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
                sig_cfg.Vsync_pol = 1;

        sig_cfg.enable_pol = 1;
-       sig_cfg.clk_pol = 0;
+       sig_cfg.clk_pol = 1;
        sig_cfg.width = mode->hdisplay;
        sig_cfg.height = mode->vdisplay;
        sig_cfg.pixel_fmt = out_pixel_fmt;

Regards,

Fabio Estevam
