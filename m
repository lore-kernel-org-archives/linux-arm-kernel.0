From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 4 Apr 2017 11:00:49 +0200
Subject: [PATCH v2 12/13] drm/meson: Add RST to bring together kerneldoc
In-Reply-To: <1490109950-21421-13-git-send-email-narmstrong@baylibre.com>
References: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
 <1490109950-21421-13-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170404090049.auhtxqke3l5px5a7@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 04:25:49PM +0100, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

\o/ for kerneldoc!

This is awesome, but I guess it's time to extract a drivers.rst sub-file
within Doc/gpu and put all the various driver docs in there? Would be
great if you could do the follow-up for that.

Thanks, Daniel

> ---
>  Documentation/gpu/index.rst |  1 +
>  Documentation/gpu/meson.rst | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/gpu/meson.rst
> 
> diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
> index e998ee0..7eceb97 100644
> --- a/Documentation/gpu/index.rst
> +++ b/Documentation/gpu/index.rst
> @@ -11,6 +11,7 @@ Linux GPU Driver Developer's Guide
>     drm-kms-helpers
>     drm-uapi
>     i915
> +   meson
>     tinydrm
>     vc4
>     vga-switcheroo
> diff --git a/Documentation/gpu/meson.rst b/Documentation/gpu/meson.rst
> new file mode 100644
> index 0000000..479f6f5
> --- /dev/null
> +++ b/Documentation/gpu/meson.rst
> @@ -0,0 +1,61 @@
> +=============================================
> +drm/meson AmLogic Meson Video Processing Unit
> +=============================================
> +
> +.. kernel-doc:: drivers/gpu/drm/meson/meson_drv.c
> +   :doc: Video Processing Unit
> +
> +Video Processing Unit
> +=====================
> +
> +The Amlogic Meson Display controller is composed of several components
> +that are going to be documented below:
> +
> +.. code::
> +
> +  DMC|---------------VPU (Video Processing Unit)----------------|------HHI------|
> +     | vd1   _______     _____________    _________________     |               |
> +  D  |-------|      |----|            |   |                |    |   HDMI PLL    |
> +  D  | vd2   | VIU  |    | Video Post |   | Video Encoders |<---|-----VCLK      |
> +  R  |-------|      |----| Processing |   |                |    |               |
> +     | osd2  |      |    |            |---| Enci ----------|----|-----VDAC------|
> +  R  |-------| CSC  |----| Scalers    |   | Encp ----------|----|----HDMI-TX----|
> +  A  | osd1  |      |    | Blenders   |   | Encl ----------|----|---------------|
> +  M  |-------|______|----|____________|   |________________|    |               |
> +  ___|__________________________________________________________|_______________|
> +
> +Video Input Unit
> +================
> +
> +.. kernel-doc:: drivers/gpu/drm/meson/meson_viu.c
> +   :doc: Video Input Unit
> +
> +Video Post Processing
> +=====================
> +
> +.. kernel-doc:: drivers/gpu/drm/meson/meson_vpp.c
> +   :doc: Video Post Processing
> +
> +Video Encoder
> +=============
> +
> +.. kernel-doc:: drivers/gpu/drm/meson/meson_venc.c
> +   :doc: Video Encoder
> +
> +Video Canvas Management
> +=======================
> +
> +.. kernel-doc:: drivers/gpu/drm/meson/meson_canvas.c
> +   :doc: Canvas
> +
> +Video Clocks
> +============
> +
> +.. kernel-doc:: drivers/gpu/drm/meson/meson_vclk.c
> +   :doc: Video Clocks
> +
> +HDMI Video Output
> +=================
> +
> +.. kernel-doc:: drivers/gpu/drm/meson/meson_dw_hdmi.c
> +   :doc: HDMI Output
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
