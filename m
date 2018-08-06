From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon, 06 Aug 2018 11:22:43 +0200
Subject: [PATCH v6 0/8] Cedrus driver for the Allwinner Video Engine,
 using media requests
In-Reply-To: <4e8a0286-7e49-5622-1895-ac3268224152@xs4all.nl>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <4e8a0286-7e49-5622-1895-ac3268224152@xs4all.nl>
Message-ID: <145b34861e7cd487dc4d9383020f186c9f273f13.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 2018-08-04 at 14:43 +0200, Hans Verkuil wrote:
> On 07/25/2018 12:02 PM, Paul Kocialkowski wrote:
> > This is the sixth iteration of the updated Cedrus driver,
> > that supports the Video Engine found in most Allwinner SoCs, starting
> > with the A10. It was tested on the A13, A20, A33 and H3.
> > 
> > The initial version of this driver[0] was originally written and
> > submitted by Florent Revest using a previous version of the request API
> > that is necessary to provide coherency between controls and the buffers
> > they apply to.
> > 
> > The driver was adapted to use the latest version of the media request
> > API[1], as submitted by Hand Verkuil. Media request API support is a
> > hard requirement for the Cedrus driver.
> > 
> > The driver itself currently only supports MPEG2 and more codecs will be
> > added to the driver eventually. The output frames provided by the
> > Video Engine are in a multi-planar 32x32-tiled YUV format, with a plane
> > for luminance (Y) and a plane for chrominance (UV). A specific format is
> > introduced in the V4L2 API to describe it.
> > 
> > This implementation is based on the significant work that was conducted
> > by various members of the linux-sunxi community for understanding and
> > documenting the Video Engine's innards.
> > 
> > In addition to the media requests API, the following series are required
> > for Cedrus:
> > * vicodec: the Virtual Codec driver
> 
> This will appear in for 4.19.
>
> > * allwinner: a64: add SRAM controller / system control
> > * SRAM patches from the Cedrus VPU driver series version 5
> 
> What about these? Are they queued up for 4.19 as well?

Yes, they are queued for 4.19 through Maxime's tree[0].

> I'll post a rebased reqv17 later today that includes the
> "add v4l2_ctrl_request_hdl_find/put/ctrl_find functions" patch.

Great, I'll rebase and send a new version (taking in account your latest
review) as soon as time allows!

Cheers,

Paul

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/log/?h=sunxi/for-next

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180806/3f5b6bf8/attachment.sig>
