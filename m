From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Jan 2014 11:00:51 +0000
Subject: [alsa-devel] [PATCH 4/4] ASoC: tda998x: adjust the audio hw
 parameters from EDID
In-Reply-To: <s5hppncihn6.wl%tiwai@suse.de>
References: <cover.1390813480.git.moinejf@free.fr>
 <d99e90932aad1a644fa32ff22fd2cb56b830341b.1390813481.git.moinejf@free.fr>
 <20140127204441.GZ11841@sirena.org.uk>
 <20140127204915.GC15937@n2100.arm.linux.org.uk>
 <20140127205437.GC11841@sirena.org.uk>
 <s5hppncihn6.wl%tiwai@suse.de>
Message-ID: <20140128110051.GI11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 10:23:57AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Mon, Jan 27, 2014 at 08:49:15PM +0000, Russell King - ARM Linux wrote:

> > > Yes, preferably as a generic ALSA helper rather than an ASoC helper -
> > > I don't see any need for this to be ASoC specific (I have a pure ALSA
> > > driver which has very similar code in it.)

> > Indeed, definitely ALSA generic - ideally we could factor a lot of the
> > integration with the video side out.

> Yes, indeed.

> OTOH, as discussed recently, we're heading to move from ELD parsing to
> more direct communication between video and audio drivers for
> HD-audio.  ELD will be still provided to user-space, but not evaluated
> any longer in the new scenario.

That sort of refactoring being one of the best reasons to keep things
out of individual drivers!  Having said all this I don't know if it's
worth blocking Jean-Francois' work on that, it's an improvement in
itself.  Splitting the code out a bit would be good to help prepare but
having the full refactoring done might be too much of a blocker.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140128/6ec7cfaf/attachment.sig>
