From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 28 Jan 2014 10:23:57 +0100
Subject: [alsa-devel] [PATCH 4/4] ASoC: tda998x: adjust the audio hw
 parameters from EDID
In-Reply-To: <20140127205437.GC11841@sirena.org.uk>
References: <cover.1390813480.git.moinejf@free.fr>
 <d99e90932aad1a644fa32ff22fd2cb56b830341b.1390813481.git.moinejf@free.fr>
 <20140127204441.GZ11841@sirena.org.uk>
 <20140127204915.GC15937@n2100.arm.linux.org.uk>
 <20140127205437.GC11841@sirena.org.uk>
Message-ID: <s5hppncihn6.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Mon, 27 Jan 2014 20:54:37 +0000,
Mark Brown wrote:
> 
> On Mon, Jan 27, 2014 at 08:49:15PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 27, 2014 at 08:44:41PM +0000, Mark Brown wrote:
> 
> > > Can this parsing code be factored out - it (or large parts of it) should
> > > be usable by other HDMI devices shouldn't it?
> 
> > Yes, preferably as a generic ALSA helper rather than an ASoC helper -
> > I don't see any need for this to be ASoC specific (I have a pure ALSA
> > driver which has very similar code in it.)
> 
> Indeed, definitely ALSA generic - ideally we could factor a lot of the
> integration with the video side out.

Yes, indeed.

OTOH, as discussed recently, we're heading to move from ELD parsing to
more direct communication between video and audio drivers for
HD-audio.  ELD will be still provided to user-space, but not evaluated
any longer in the new scenario.


Takashi
