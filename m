From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 28 Jan 2014 12:12:26 +0100
Subject: [alsa-devel] [PATCH 4/4] ASoC: tda998x: adjust the audio hw
 parameters from EDID
In-Reply-To: <20140128110051.GI11841@sirena.org.uk>
References: <cover.1390813480.git.moinejf@free.fr>
 <d99e90932aad1a644fa32ff22fd2cb56b830341b.1390813481.git.moinejf@free.fr>
 <20140127204441.GZ11841@sirena.org.uk>
 <20140127204915.GC15937@n2100.arm.linux.org.uk>
 <20140127205437.GC11841@sirena.org.uk>
 <s5hppncihn6.wl%tiwai@suse.de>
 <20140128110051.GI11841@sirena.org.uk>
Message-ID: <s5hiot4icmd.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tue, 28 Jan 2014 11:00:51 +0000,
Mark Brown wrote:
> 
> On Tue, Jan 28, 2014 at 10:23:57AM +0100, Takashi Iwai wrote:
> > Mark Brown wrote:
> > > On Mon, Jan 27, 2014 at 08:49:15PM +0000, Russell King - ARM Linux wrote:
> 
> > > > Yes, preferably as a generic ALSA helper rather than an ASoC helper -
> > > > I don't see any need for this to be ASoC specific (I have a pure ALSA
> > > > driver which has very similar code in it.)
> 
> > > Indeed, definitely ALSA generic - ideally we could factor a lot of the
> > > integration with the video side out.
> 
> > Yes, indeed.
> 
> > OTOH, as discussed recently, we're heading to move from ELD parsing to
> > more direct communication between video and audio drivers for
> > HD-audio.  ELD will be still provided to user-space, but not evaluated
> > any longer in the new scenario.
> 
> That sort of refactoring being one of the best reasons to keep things
> out of individual drivers!  Having said all this I don't know if it's
> worth blocking Jean-Francois' work on that, it's an improvement in
> itself.  Splitting the code out a bit would be good to help prepare but
> having the full refactoring done might be too much of a blocker.

I just rather wanted to point out the general direction for the
further development, didn't mean NAK.  Jean-Francois' patch itself
looks simple enough, so I see no problem to take it for now as is.


Takashi
