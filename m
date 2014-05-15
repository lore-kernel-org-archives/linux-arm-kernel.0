From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 15 May 2014 11:08:15 +0200
Subject: [PATCH v2 2/3] drm/panel: add support for EDT panels
In-Reply-To: <1400142449.4102.16.camel@paszta.hi.pengutronix.de>
References: <cover.1400103181.git.stefan@agner.ch>
 <35c081171a3d9a9401767601c02a12e266b37dd0.1400103181.git.stefan@agner.ch>
 <20140515075102.GE5952@ulmo>
 <1400142449.4102.16.camel@paszta.hi.pengutronix.de>
Message-ID: <20140515090814.GB6434@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 10:27:29AM +0200, Philipp Zabel wrote:
> Am Donnerstag, den 15.05.2014, 09:51 +0200 schrieb Thierry Reding:
> > On Wed, May 14, 2014 at 11:45:57PM +0200, stefan at agner.ch wrote:
> > > From: Stefan Agner <stefan@agner.ch>
> > > 
> > > This panels are sold by Toradex for Colibri T20/T30 and Apalis T30
> > > evaluation kits.
> > > 
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > 
> > Panel patches should go to the dri-devel mailing list as well.
> > 
> > Also a patch was posted only yesterday for a panel that seems to be the
> > exact same one as this, even though the name differs minimally, see:
> > 
> > 	https://patchwork.kernel.org/patch/4175251/
> > 
> > Adding Philipp on Cc so you guys can work together whether this is
> > indeed the same panel. The only differences seem to be in the vertical
> > front and back porches, but I suspect that either settings will work on
> > both Tegra and i.MX.
> 
> The ETM0700G0DH6 Datasheet lists 2 lines as the typical vsync pulse
> width, 525 lines as the vertical period, and 35 lines as the vsync -de
> time, which is vsync len + back porch.
> So vertical timings 480 + 10 + 2 + 33 = 525 should be valid for the
> ET0700G0DH6 panel:

Shouldn't that work with 480 + 8 + 2 + 35 too? It seems to me that it
should still be safe for that panel. Similarily I'd expect your timings
to work on the ET070080DH6.

Irrespective of that they both seem to have different capabilities so
two compatible values should be fine. However for the purpose of the
simple panel driver they could be made to share the same timings if it
works for both panels and devices.

As for the touch panel on the ETM0700G0DH6, do you happen to know how
that's usually connected? I suspect it needs external hardware to
capture the YU, XL, YD and XR pins and turn that into raw coordinates
and pen down interrupts.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/98c1de54/attachment-0001.sig>
