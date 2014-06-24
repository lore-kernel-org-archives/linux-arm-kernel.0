From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jun 2014 00:13:19 +0200
Subject: [PATCH v14 06/10] drm: drm_display_mode: add signal polarity flags
In-Reply-To: <20140624145745.GR32514@n2100.arm.linux.org.uk>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-6-git-send-email-denis@eukrea.com>
 <20140624145745.GR32514@n2100.arm.linux.org.uk>
Message-ID: <20140624221318.GA30183@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 03:57:46PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 16, 2014 at 12:11:20PM +0200, Denis Carikli wrote:
> > We need a way to pass signal polarity informations
> >   between DRM panels, and the display drivers.
> > 
> > To do that, a pol_flags field was added to drm_display_mode.
> > 
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> 
> This patch needs an ack from the DRM people - can someone review it
> please?  This series has now been round 14 revisions and it's about
> time it was properly reviewed - or a statement made if it's
> unacceptable.

I didn't follow all of the earlier discussions around this, but it seems
to me like data-enable polarity and the pixel data edge flags are
properties of the interface rather than the video mode.

struct drm_display_mode represents the video timings and I'm not sure if
it's a good idea to extend it with this type of information.

Maybe we need to add a separate type of device to store these parameters
(much like we've done for MIPI DSI devices).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140625/400d1e9e/attachment.sig>
