From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:03:44 +0100
Subject: [PATCH v2 31/43] drm/sun4i: Add a dedicated ioctl call for
 allocating tiled buffers
In-Reply-To: <20181123113019.43vrzvj42l35el7z@DESKTOP-E1NTVVP.localdomain>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-32-paul.kocialkowski@bootlin.com>
 <20181123113019.43vrzvj42l35el7z@DESKTOP-E1NTVVP.localdomain>
Message-ID: <20181127090344.qlrksisbbmcjm3ac@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 11:30:20AM +0000, Brian Starkey wrote:
> Hi Paul,
> 
> On Fri, Nov 23, 2018 at 10:25:03AM +0100, Paul Kocialkowski wrote:
> >This introduces a dedicated ioctl for allocating buffers for the VPU
> >tiling mode. It allows setting up buffers that comply to the hardware
> >alignment requirements, by aligning the stride and height to 32 bytes.
> >
> >Only YUV semiplanar and planar formats are allowed by the ioctl, as the
> >hardware does not support the tiling mode for other formats.
> 
> What's the general feeling about a more generic version of this ioctl?
> There doesn't seem to be anything Allwinner-specific in the ioctl
> arguments.

I'm definitely in favor of having such an ioctl.

maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/92a6c511/attachment.sig>
