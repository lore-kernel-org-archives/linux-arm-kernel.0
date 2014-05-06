From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 6 May 2014 22:13:12 +0800
Subject: mx6qsabresd hangs on linux-next
In-Reply-To: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>
References: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>
Message-ID: <20140506141310.GA2794@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 07:50:24PM -0300, Fabio Estevam wrote:
> Hi,
> 
> I am running linux-next 20140505 on a mx6qsabresd and I am getting the
> following hang after ldb is bound:
> 
> imx-ipuv3 2400000.ipu: IPUv3H probed
> imx-ipuv3 2800000.ipu: IPUv3H probed
> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [drm] No driver support for vblank timestamp query.
> imx-drm display-subsystem.11: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
> imx-drm display-subsystem.11: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
> mmc1: new SDHC card at address e7ac
> mmcblk0: mmc1:e7ac SD04G 3.69 GiB
> imx-drm display-subsystem.11: bound imx-ipuv3-crtc.2 (ops ipu_crtc_ops)
>  mmcblk0: unknown partition table
> imx-drm display-subsystem.11: bound imx-ipuv3-crtc.3 (ops ipu_crtc_ops)
> imx-hdmi 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
> imx-drm display-subsystem.11: bound 120000.hdmi (ops hdmi_ops)
> imx-drm display-subsystem.11: bound ldb.10 (ops imx_ldb_ops)
> 
> (... system hangs)

I'm seeing the same issue here.  It seems to be caused by some clk
divider code change.  I'm looking into it further.

Shawn
