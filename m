From: hias@horus.com (Matthias Reichl)
Date: Mon, 27 Feb 2017 12:51:08 +0100
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <7b78c782-28e1-4849-5d00-8caf30847d5c@flatmax.org>
References: <20170225133952.GA28091@camel2.lan>
 <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
 <20170226144958.GA5543@camel2.lan>
 <732a71ac-5ec5-37e1-1190-be036ea34555@flatmax.org>
 <20170226221648.GA10974@camel2.lan>
 <7cef41ee-ef00-22b7-830f-517a9d594ed0@flatmax.org>
 <20170227080433.GA2718@delle.lan>
 <170950f7-354f-e6a9-cefb-834a00fadd1b@flatmax.org>
 <20170227103024.GF2718@delle.lan>
 <7b78c782-28e1-4849-5d00-8caf30847d5c@flatmax.org>
Message-ID: <20170227115108.GA6732@delle.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 10:21:25PM +1100, Matt Flax wrote:
> 
> 
> On 27/02/17 21:30, Matthias Reichl wrote:
> >
> >I don't see that. Some people might want to be able to use multichannel
> >on RPi, but that's something very different than adding code that just
> >lies about driver capabilites.
> >
> 
> I am going to invite you over for dinner to eat steamed vegetables :)
> If I make the steamed vegetables in the microwave and they taste like
> steamed vegetables, are they steamed vegetables ?

If you connect an amplifier with a volume control to your soundcard
does that mean that your soundcard now has a volume control? No, your
amp has.

> I have a bcm2835 (Pi 2 and 3) SoC here. It is producing multichannel (8 out,
> 6 in) audio. In ALSA we call that DSP mode - right ?!

No. DSP modes are protocol/timing specifications as I2S, PDP, S/PDIF, ...
You can look these up in datasheets and if a chip implements such a
protocol you can be sure that it adheres to that standard - i.e. it
will sync the frames to the pulses on LRclk.

> If a chipset can do multichannel, do we need to invent a new DSP mode name
> to call it dsp mode ? Surely not, because steamed vegetables are steamed
> vegetables :)

You can do multichannel audio via IEC958 AC3/DTS passthrough as well. This
doesn't mean that each driver has to implement that as a separate mode.

In fact they are still operating in 2-channel PCM mode, only the data
packed into the stream has to be interpreted differently. This even worked
with standard CD players, you could have DTS on CD. Of course if you
connected a standard analog amp to it you'd only get noise. But an amp with
digital S/PDIF input and an AC3/DTS decoder could decode the multichannel
audio stream and output it to it's 5.1 speakers.

so long,

Hias
