From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 1 Sep 2013 09:04:20 +0200
Subject: [PATCH 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <20130831112430.GD6617@n2100.arm.linux.org.uk>
References: <20130828113521.35c53365@armhf> <521DCD80.9010105@gmail.com>
 <20130831125128.0e3a23c7@armhf>
 <20130831112430.GD6617@n2100.arm.linux.org.uk>
Message-ID: <20130901090420.526e3bc3@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 31 Aug 2013 12:24:31 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > According to the Dove specification, the audio controller works with
> > the samples rates 44.1, 48 and 96 kHz, so, I don't see the usage of the
> > external clock, except when using the two audio controllers with
> > different sample rates.  
> 
> I don't see what the Dove specification has to do with that statement:
> what the Dove spec says is that if you use just the internal DCO, then
> only 44.1kHz, 48kHz and 96kHz are supported (with some trimming of that.)
> However, the use of an external clock allows further rates to be supported.
> If you have an external clock, there is no requirement to use the DCO for
> those sample rates - you can if you wish, or you can use the external clock.
> 
> The mainline driver implements the use of the DCO for the standard 44.1,
> 48 and 96kHz rates, otherwise it uses the external clock if present.  This
> is entirely conformant with the Dove spec.

Russell,

I looked again at the Armada-510-Functional-Spec, and I found:

- section 12.1
	...
	I2S Supported Features
		An audio sample rate (Fs) of 44.1/48/96 kHz.
		...
	S/PDIF Supported Features
		The IEC60958-1, IEC60958-3, and IEC61937 specifications.
		An audio sample rate (Fs) of 44.1/48/96 kHz.
		...

- Table 436: Clocks Control Register
	     Offset: Unit0: 0x000B1230, Unit1: 0x000B5230
	...
	1:0 MCLK source RW  MCLK = 256 Fs, where Fs = 44.1 kHz, 48 kHz, 96 kHz.
			0x0 Playback should not be active when selecting an external MCLK, or moving
			    from one external MCLK to another MCLK source.
			    0 = DCO: MCLK is from DCO.
			    1 = Reserved
			    2 = Reserved
			    3 = External: MCLK is from an external source.

As they don't work with my TV set, may you confirm that these webradios

	http://kerne.online.stalig.net/live-ori.ogg
	http://www.tv-radio.com/station/france_bleu_breiz_izel_mp3/france_bleu_breiz_izel_mp3-32k.m3u
	http://plumfm.online.stalig.net/live-ori.ogg

work for you with the external clock? (sample rates resp. 33.075, 24
and 22.05 kHz)

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
