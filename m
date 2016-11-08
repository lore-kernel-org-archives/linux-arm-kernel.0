From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2016 13:32:15 +0000
Subject: [PATCH RFC 00/12] tda998x updates
In-Reply-To: <2264579a-3273-d9c4-761a-f50f547eb39b@arm.com>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
 <2264579a-3273-d9c4-761a-f50f547eb39b@arm.com>
Message-ID: <20161108133215.GQ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 01:19:51PM +0000, Robin Murphy wrote:
> Hi Russell,
> 
> On 08/11/16 12:24, Russell King - ARM Linux wrote:
> > As no one responded to the previous round, I'm not spending soo much
> > time writing up a description of these changes again.  It's also been
> > quite a long time, so I've forgotten all the details of the changes,
> > so I'll do my best.
> > 
> > Changes from the previous series include:
> > - reorder the initial three patches
> > - change the (now third patch)... I think to increase the size of the
> >   locked region.
> > - fix edid parsing for infoframe generation - as was pointed out for
> >   dw-hdmi, parsing the EDID in get_modes() is incorrect, as that method
> >   will not be called when an override-edid is in effect.  We need to
> >   parse the override-edid.  Moreover, infoframe generation should not
> >   be keyed to whether the monitor is HDMI or not, CEA-861B allows non-
> >   HDMI to send infoframes.
> > - only send audio if audio and infoframes are supported.
> > 
> > Otherwise, these are very much like the previous posting of the series,
> > except rebased upon the mali/hdlcd/tda998x change to remove the
> > drm_connector_register() call.
> > 
> > https://www.spinics.net/lists/dri-devel/msg121495.html
> > 
> > It'd be nice to have other tda998x users ack and test these patches,
> 
> I've just merged your drm-tda998x-devel branch and booted it on my Juno,
> and I can at least confirm that DVI still seems to still work as before.
> Anything in particular I should be looking out for? (Unfortunately the
> only handy HDMI monitor is one of those slightly-out-of-spec ones which
> has never really worked with the pixel clocks Juno provides)

Unfortunately, my drm-tda998x-devel branch is slightly out of date with
these patches it's the original set of 10 patches.  I've not pushed
these ones out to that branch yet, as I've three additional patches on
top of these which aren't "ready" for pushing out.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
