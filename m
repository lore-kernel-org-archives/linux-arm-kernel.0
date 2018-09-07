From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 15:26:20 +0200
Subject: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <4b30c0bf-e525-1868-f625-569d4a104aa0@xs4all.nl>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-6-contact@paulk.fr>
 <4b30c0bf-e525-1868-f625-569d4a104aa0@xs4all.nl>
Message-ID: <20180907132620.lmsvlwpa3rzioj2h@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Fri, Sep 07, 2018 at 03:13:19PM +0200, Hans Verkuil wrote:
> On 09/07/2018 12:24 AM, Paul Kocialkowski wrote:
> > From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > 
> > This introduces the Cedrus VPU driver that supports the VPU found in
> > Allwinner SoCs, also known as Video Engine. It is implemented through
> > a V4L2 M2M decoder device and a media device (used for media requests).
> > So far, it only supports MPEG-2 decoding.
> > 
> > Since this VPU is stateless, synchronization with media requests is
> > required in order to ensure consistency between frame headers that
> > contain metadata about the frame to process and the raw slice data that
> > is used to generate the frame.
> > 
> > This driver was made possible thanks to the long-standing effort
> > carried out by the linux-sunxi community in the interest of reverse
> > engineering, documenting and implementing support for the Allwinner VPU.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> One high-level comment:
> 
> Can you add a TODO file for this staging driver? This can be done in
> a follow-up patch.
> 
> It should contain what needs to be done to get this out of staging:
> 
> - Request API needs to stabilize
> - Userspace support for stateless codecs must be created

On that particular note, as part of the effort to develop the driver,
we've also developped two userspace components:

  - v4l2-request-test, that has a bunch of sample frames for various
    codecs and will rely solely on the kernel request api (and DRM for
    the display part) to test and bringup a particular driver
    https://github.com/bootlin/v4l2-request-test

  - libva-v4l2-request, that is a libva implementation using the
    request API
    https://github.com/bootlin/libva-v4l2-request

Did you have something else in mind?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/74dbcadb/attachment.sig>
