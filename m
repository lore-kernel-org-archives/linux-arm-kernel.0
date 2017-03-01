From: nicolas.dufresne@collabora.com (Nicolas Dufresne)
Date: Wed, 01 Mar 2017 10:21:06 -0500
Subject: [PATCH v6 2/2] [media] s5p-mfc: Handle 'v4l2_pix_format:field'
 in try_fmt and g_fmt
In-Reply-To: <33dbd3fa-04b2-3d94-5163-0a10589ff1c7@samsung.com>
References: <20170301115108.14187-1-thibault.saunier@osg.samsung.com>
 <CGME20170301115141epcas2p37801b1fbe0951cc37a4e01bf2bcae3da@epcas2p3.samsung.com>
 <20170301115108.14187-3-thibault.saunier@osg.samsung.com>
 <33dbd3fa-04b2-3d94-5163-0a10589ff1c7@samsung.com>
Message-ID: <1488381666.14858.5.camel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 01 mars 2017 ? 14:12 +0100, Andrzej Hajda a ?crit?:
> - on output side you have encoded bytestream - you cannot say about
> interlacing in such case, so the only valid value is NONE,
> - on capture side you have decoded frames, and in this case it
> depends
> on the device and driver capabilities, if the driver/device does not
> support (de-)interlacing (I suppose this is MFC case), interlace type
> field should be filled according to decoded bytestream header (on
> output
> side), but no direct copying from output side!!!

I think we need some nuance here for this to actually be usable. If the
information is not provided by the driver (yes, hardware is limiting
sometimes), it would make sense to copy over the information that
userspace provided. Setting NONE is just the worst approximation in my
opinion.

About MFC, it will be worth trying to read the DISPLAY_STATUS after the
headers has been processed. It's not clearly stated in the spec if this
will be set or not.

Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170301/cd10c72b/attachment.sig>
