From: sre@ring0.de (Sebastian Reichel)
Date: Sat, 16 Nov 2013 16:02:35 +0000
Subject: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is
 not found
In-Reply-To: <20131116154507.GL10317@atomide.com>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
 <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk>
 <20131116141853.GF10317@atomide.com>
 <5287908C.3040602@collabora.co.uk>
 <20131116154507.GL10317@atomide.com>
Message-ID: <20131116160234.GB5104@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 07:45:07AM -0800, Tony Lindgren wrote:
> Well let's see what Tomi prefers.
> 
> > > &vaux1 {
> > > 	/* Needed for ads7846 */
> > > 	regulator-name = "vcc";
> > > };
> > > 
> > > &vpll2 {
> > > 	/* Needed for DSS */
> > > 	regulator-name = "vdds_dsi";
> > > };
> 
> In the long we'll use regulator phandles anyways in the DSS related
> nodes, so from that point of view fixing dpi.c makes sense.

The hack, as being sent by Javier, will result in the wrong
regulator being used on the Nokia N900, which is using vaux1.
It must depend on the machine.

At the same time the N900 device tree file uses V28 as
regulator-name for vaux1 (which is the same one as legacy boot
used). Nothing depends on this, but I don't think it's a
good idea to use this property. Apparently it does not work
if multiple drivers need the same regulator under different
names.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/cbd7c55b/attachment-0001.sig>
