From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Jul 2017 13:25:21 +0200
Subject: [PATCH RFC 1/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <20170703185952.18a97e9b7b05cbe321cb1268@magewell.com>
References: <1498561654-14658-1-git-send-email-yong.deng@magewell.com>
 <1498561654-14658-2-git-send-email-yong.deng@magewell.com>
 <667c858b-2655-88c5-6bbc-9d70d06c1ff1@xs4all.nl>
 <20170703185952.18a97e9b7b05cbe321cb1268@magewell.com>
Message-ID: <20170703112521.ca253erguut5v7se@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 03, 2017 at 06:59:52PM +0800, Yong wrote:
> > > +	select VIDEOBUF2_DMA_CONTIG
> > > +	select REGMAP_MMIO
> > > +	---help---
> > > +	   Support for the Allwinner Camera Sensor Interface Controller.
> > 
> > This controller is the same for all Allwinner SoC models?
> 
> No.
> I will change the Kconfig and Makefile.

This is basically a design that has been introduced in the A31 (sun6i
family). I guess we should just call the driver and Kconfig symbols
sun6i_csi (even though we don't support it yet). It also used on the
A23, A33, A80, A83T, H3, and probably the H5 and A64.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170703/3cc08dfb/attachment.sig>
