From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 28 Feb 2017 09:59:29 +0000
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <20170227115108.GA6732@delle.lan>
References: <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
 <20170226144958.GA5543@camel2.lan>
 <732a71ac-5ec5-37e1-1190-be036ea34555@flatmax.org>
 <20170226221648.GA10974@camel2.lan>
 <7cef41ee-ef00-22b7-830f-517a9d594ed0@flatmax.org>
 <20170227080433.GA2718@delle.lan>
 <170950f7-354f-e6a9-cefb-834a00fadd1b@flatmax.org>
 <20170227103024.GF2718@delle.lan>
 <7b78c782-28e1-4849-5d00-8caf30847d5c@flatmax.org>
 <20170227115108.GA6732@delle.lan>
Message-ID: <20170228095929.GH2742@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 12:51:08PM +0100, Matthias Reichl wrote:
> On Mon, Feb 27, 2017 at 10:21:25PM +1100, Matt Flax wrote:
> > 
> > 
> > On 27/02/17 21:30, Matthias Reichl wrote:
> > >
> > >I don't see that. Some people might want to be able to use multichannel
> > >on RPi, but that's something very different than adding code that just
> > >lies about driver capabilites.
> > >
> > 
> > I am going to invite you over for dinner to eat steamed vegetables :)
> > If I make the steamed vegetables in the microwave and they taste like
> > steamed vegetables, are they steamed vegetables ?
> 
> If you connect an amplifier with a volume control to your soundcard
> does that mean that your soundcard now has a volume control? No, your
> amp has.
> 
> > I have a bcm2835 (Pi 2 and 3) SoC here. It is producing multichannel (8 out,
> > 6 in) audio. In ALSA we call that DSP mode - right ?!
> 
> No. DSP modes are protocol/timing specifications as I2S, PDP, S/PDIF, ...
> You can look these up in datasheets and if a chip implements such a
> protocol you can be sure that it adheres to that standard - i.e. it
> will sync the frames to the pulses on LRclk.
> 

I agree with the thoughts in this thread really if the AP doesn't
actually support DSP A mode we shouldn't add DSP A mode.

Thanks,
Charles
