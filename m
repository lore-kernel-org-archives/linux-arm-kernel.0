From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Fri, 24 Aug 2012 16:52:57 +0200 (CEST)
Subject: [PATCH 4/5] DRM: add i.MX IPUv3 base driver
In-Reply-To: <1596192785.2810155.1345817566620.JavaMail.root@advansee.com>
Message-ID: <806769921.2812305.1345819977325.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Jun 14, 09:43:26 EDT 2012, Sascha Hauer wrote:
> The IPU is the Image Processing Unit found on i.MX51/53 SoCs. It
> features several units for image processing, this patch adds support
> for the units needed for Framebuffer support, namely:
> 
> - Display Controller (dc)
> - Display Interface (di)
> - Display Multi Fifo Controller (dmfc)
> - Display Processor (dp)
> - Image DMA Controller (idmac)
> 
> This patch is based on the Freescale driver, but follows a different
> approach. The Freescale code implements logical idmac channels and
> the handling of the subunits is hidden in common idmac code pathes
> in big switch/case statements. This patch instead just provides code
> and resource management for the different subunits. The user, in this
> case the framebuffer driver, decides how the different units play
> together.

What is the status of this series, and especially of this patch, as to its
integration into upstream? At some point, you were talking about pushing it to
staging, but since things don't seem to have evolved.

> The IPU has other units missing in this patch:
> 
> - CMOS Sensor Interface (csi)
> - Video Deinterlacer (vdi)
> - Sensor Multi FIFO Controler (smfc)
> - Image Converter (ic)
> - Image Rotator (irt)
> 
> So expect more files to come in this directory.

Do you have a schedule for that? Are you waiting for more customer projects at
Pengutronix to do that?

Would your customers_pengutronix_mx5_master-20120612 tag be the starting point
for these new files? Can it be used as a working solution in the meantime, or
does it have limitations?

That would be great to finally have full IPU/VPU/GPU support for i.MX5 into
upstream. As you already know, Linaro also have some video support for i.MX5 in
this head:
http://git.linaro.org/gitweb?p=landing-teams/working/freescale/kernel.git;a=shortlog;h=refs/heads/lt-3.2-imx5

Matt, I think you also have video support for efikamx, don't you?

Is there a plan to merge all these developments into upstream?

Best regards,
Beno?t
