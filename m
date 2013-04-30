From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 30 Apr 2013 13:49:28 +0200
Subject: [PATCH V2] video: implement a simple framebuffer driver
In-Reply-To: <517FAF78.1010306@ti.com>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <1547536.Us4pVspuI2@avalon> <517FAF78.1010306@ti.com>
Message-ID: <124304591.tbnLlR41q2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 April 2013 14:48:08 Tomi Valkeinen wrote:
> On 04/30/2013 02:42 PM, Laurent Pinchart wrote:
> > On Tuesday 30 April 2013 12:28:42 Arnd Bergmann wrote:
> >> On Tuesday 30 April 2013, Tomi Valkeinen wrote:
> >>> The bootloader would init the display hardware, the bootfb would give an
> >>> early /dev/fb0 for the kernel and userspace, and when the real display
> >>> driver is loaded, the bootfb would be unbound and the real driver would
> >>> take over.
> > 
> > This could be done with a KMS driver as well ;-)
> 
> Right, I forgot to mention that. I had it in mind also =).
> 
> DRM has the same problem as fbdev with multi-arch and lots of display
> and panel drivers.
> 
> Probably the same bootfb could be used for DRM also. Or do you see any
> benefit of having a "bootkms" driver, or such?

As part of the (long term) effort to deprecate fbdev I would of course prefer 
a bootkms driver. The KMS fbdev emulation layer would provide fbdev 
compatibility for free during the transition.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130430/297e1336/attachment.sig>
