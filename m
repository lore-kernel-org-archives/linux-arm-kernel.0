From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 May 2015 12:43:33 +0100
Subject: [PATCH 13/13] drm: bridge/dw_hdmi-ahb-audio: parse ELD from HDMI
 driver
In-Reply-To: <20150527104308.GA8341@phenom.ffwll.local>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1yD-0006lK-RC@rmk-PC.arm.linux.org.uk>
 <20150527104308.GA8341@phenom.ffwll.local>
Message-ID: <20150527114333.GD21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 12:43:08PM +0200, Daniel Vetter wrote:

> Just curious questions really, I probably don't understand what's exactly
> going on. But I do think that we need a more formal way for drm/snd to
> talk to each another (i915 is growing quite a few hairy things in that
> area outside of eld atm). Problems we have are around shared power wells

Yes, I agree strongly with this - I've been asking for a while for more
code sharing and common code in this path, the helpers in here are
really good from that point of view and I'm very pleased we've got them
applied.

> and clocks (x86 doesn't help here without all the dt goodness). But
> there's also stuff like figuring out the right dividers for a given
> audio/video clock. eld and hotplug is still done in hw, but I've heard
> noises that we need to have a sw approach too on some platforms at least.

That seems to be the case, yes - FWIW quite a few of the embedded
systems are basically connecting a standard S/PDIF or I2S output to a
HDMI encoder chip or IP block so the audio controller knows nothing of
HDMI directly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150527/e9d7664a/attachment.sig>
