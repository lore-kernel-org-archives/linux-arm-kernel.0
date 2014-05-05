From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 5 May 2014 19:50:24 -0300
Subject: mx6qsabresd hangs on linux-next
Message-ID: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am running linux-next 20140505 on a mx6qsabresd and I am getting the
following hang after ldb is bound:

imx-ipuv3 2400000.ipu: IPUv3H probed
imx-ipuv3 2800000.ipu: IPUv3H probed
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
imx-drm display-subsystem.11: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
imx-drm display-subsystem.11: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
mmc1: new SDHC card at address e7ac
mmcblk0: mmc1:e7ac SD04G 3.69 GiB
imx-drm display-subsystem.11: bound imx-ipuv3-crtc.2 (ops ipu_crtc_ops)
 mmcblk0: unknown partition table
imx-drm display-subsystem.11: bound imx-ipuv3-crtc.3 (ops ipu_crtc_ops)
imx-hdmi 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
imx-drm display-subsystem.11: bound 120000.hdmi (ops hdmi_ops)
imx-drm display-subsystem.11: bound ldb.10 (ops imx_ldb_ops)

(... system hangs)

If I built the kernel without LVDS support then it boots fine until the prompt.

Haven't started debugging it yet, but in case anyone has any
suggestions, please let me know.

I have also tested with Shawn's for-next and the problem does not
happen with his tree.

Regards,

Fabio Estevam
