From: liam.r.girdwood@linux.intel.com (Liam Girdwood)
Date: Wed, 06 May 2015 09:58:14 +0100
Subject: [alsa-devel] [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
In-Reply-To: <20150505223542.GM15510@sirena.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk> <s5ha8ymy3e2.wl-tiwai@suse.de>
 <20150505223542.GM15510@sirena.org.uk>
Message-ID: <1430902694.16962.11.camel@loki>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-05 at 23:35 +0100, Mark Brown wrote:
> On Sun, Apr 05, 2015 at 05:57:09PM +0200, Takashi Iwai wrote:
> > At Thu, 02 Apr 2015 10:22:06 +0100,
> > Russell King wrote:
> 
> > > +config SND_PCM_ELD
> > > +	bool
> 
> > I don't mind much adding this one, but a new Kconfig is always a
> > question.  I'd like to hear other's opinion, too.
> 
> One point in favour of this is that there's been some discussion
> recently of IoT applications with very low resource requirements that
> might need audion functionality so it's likely that people will be
> taking a look at trying to minimize code size for the audio stack.  This
> sort of configurability may well be useful for such applications.


Fwiw, Keyon is looking at reducing runtime audio DRAM usage atm and will
probably have to add other Kconfig options to the audio kernel config
e.g. disable DPCM, disable DAPM, disable HW/SW params refinement,
disable async audio ioctls, etc. Currently the kernel audio core and
drivers are coming in at between 300k to 500k, which is a lot for a
device with limited memory and very simple audio requirements.

Liam
