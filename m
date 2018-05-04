From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 04 May 2018 09:57:20 +0200
Subject: [PATCH v2 07/10] media: platform: Add Sunxi-Cedrus VPU decoder
 driver
In-Reply-To: <20180424091328.jsqp36nxekuj23am@paasikivi.fi.intel.com>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154536.17846-3-paul.kocialkowski@bootlin.com>
 <20180424091328.jsqp36nxekuj23am@paasikivi.fi.intel.com>
Message-ID: <35411894a87b65865eb8b43e5f50829db336a323.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2018-04-24 at 12:13 +0300, Sakari Ailus wrote:
> Hi Paul
> 
> On Thu, Apr 19, 2018 at 05:45:33PM +0200, Paul Kocialkowski wrote:
> > This introduces the Sunxi-Cedrus VPU driver that supports the VPU
> > found
> > in Allwinner SoCs, also known as Video Engine. It is implemented
> > through
> > a v4l2 m2m decoder device and a media device (used for media
> > requests).
> > So far, it only supports MPEG2 decoding.
> > 
> > Since this VPU is stateless, synchronization with media requests is
> > required in order to ensure consistency between frame headers that
> > contain metadata about the frame to process and the raw slice data
> > that
> > is used to generate the frame.
> > 
> > This driver was made possible thanks to the long-standing effort
> > carried out by the linux-sunxi community in the interest of reverse
> > engineering, documenting and implementing support for Allwinner VPU.
> 
> No code review yet, but DT bindings precede the driver. Please also
> add the appropriate MAINTAINERS entries.

Thanks for the indication, will do in the next version(s).

Cheers,

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/acc41e91/attachment.sig>
