From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 5 Apr 2017 13:32:56 +0200
Subject: [PATCH v6 19/39] media: Add i.MX media core driver
In-Reply-To: <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170405113256.GB26831@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!


> +https://boundarydevices.com/products/nit6x_5mp

I'd use /product/ in url, as it redirects there.

> +https://boundarydevices.com/product/nit6x_5mp_mipi

..and for consistency.

> +The following example configures a direct conversion pipeline to capture
> +from the OV5640, transmitting on MIPI CSI-2 virtual channel 1. $sensorfmt
> +can be any format supported by the OV5640. $sensordim is the frame
> +dimension part of $sensorfmt (minus the mbus pixel code). $outputfmt can
> +be any format supported by the ipu1_ic_prpenc entity at its output pad:
> +
> +.. code-block:: none
> +
> +   # Setup links
> +   media-ctl -l "'ov5640 1-003c':0 -> 'imx6-mipi-csi2':0[1]"
> +   media-ctl -l "'imx6-mipi-csi2':2 -> 'ipu1_csi1':0[1]"
> +   media-ctl -l "'ipu1_csi1':1 -> 'ipu1_ic_prp':0[1]"
> +   media-ctl -l "'ipu1_ic_prp':1 -> 'ipu1_ic_prpenc':0[1]"
> +   media-ctl -l "'ipu1_ic_prpenc':1 -> 'ipu1_ic_prpenc capture':0[1]"
> +   # Configure pads
> +   media-ctl -V "'ov5640 1-003c':0 [fmt:$sensorfmt field:none]"
> +   media-ctl -V "'imx6-mipi-csi2':2 [fmt:$sensorfmt field:none]"
> +   media-ctl -V "'ipu1_csi1':1 [fmt:AYUV32/$sensordim field:none]"
> +   media-ctl -V "'ipu1_ic_prp':1 [fmt:AYUV32/$sensordim field:none]"
> +   media-ctl -V "'ipu1_ic_prpenc':1 [fmt:$outputfmt field:none]"
> +
> +Streaming can then begin on "ipu1_ic_prpenc capture" node. The v4l2-ctl
> +tool can be used to select any supported YUV or RGB pixelformat on the
> +capture device node.

Nothing for you to fix here, but we should really create some
library-like interface for media-ctl. 
									Pavel
									
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/028b8853/attachment-0001.sig>
