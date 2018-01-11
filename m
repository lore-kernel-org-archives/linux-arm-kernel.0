From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Jan 2018 14:28:44 +0100
Subject: [PATCH v5 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <1515639966-35902-1-git-send-email-yong.deng@magewell.com>
References: <1515639966-35902-1-git-send-email-yong.deng@magewell.com>
Message-ID: <20180111132844.mok7upqjycpx3bqm@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Thu, Jan 11, 2018 at 11:06:06AM +0800, Yong Deng wrote:
> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
> 
> This patch implement a v4l2 framework driver for it.
> 
> Currently, the driver only support the parallel interface. MIPI-CSI2,
> ISP's support are not included in this patch.
> 
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

I've needed this patch in order to fix a NULL pointer dereference:
http://code.bulix.org/oz6gmb-257359?raw

This is needed because while it's ok to have a NULL pointer to
v4l2_subdev_pad_config when you call the subdev set_fmt with
V4L2_SUBDEV_FORMAT_ACTIVE, it's not with V4L2_SUBDEV_FORMAT_TRY, and
sensors will assume taht it's a valid pointer.

Otherwise,
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/7f6a1adb/attachment-0001.sig>
