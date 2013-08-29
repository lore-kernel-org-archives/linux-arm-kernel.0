From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 29 Aug 2013 12:07:04 +0200
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <521DEA20.8020103@gmail.com>
References: <20130828113459.48ecbb34@armhf> <521DCD33.2070008@gmail.com>
 <20130828121943.1c8327ca@skate> <521DD057.4040208@gmail.com>
 <20130828131548.0009d613@skate> <521DE2B3.9050508@gmail.com>
 <20130828135827.2307c89e@skate> <521DEA20.8020103@gmail.com>
Message-ID: <20130829120704.410ad309@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Aug 2013 14:16:32 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

	[snip]
> > Though, if the difference between the two units is the availability of
> > SPDIF support, then we shouldn't encode the channel number, but instead
> > the availability of SPDIF, i.e:
> >
> > 	audio0 {
> > 		reg = <... ...>;
> > 		compatible = "marvell,kirkwood-audio";
> > 		marvell,has-spdif;  
> 
> Agree, if you make it "marvell,has-spdif-in" and "marvell,has-spdif-out"
> Dove has either i2s-only or i2s+spdifo, kirkwood has i2s+spdifo+spdifi
> for the one audio controller available. Can't tell for Armada 370.
> 
> BTW, you might have followed some of the DT discussions with Mark
> before; as he insists on having a separate sound card node, he might
> argue that above property should be part of that node instead.

Yes. For the Cubox, the card will be described by something like:

	sound {
		compatible = "simple-audio";
		audio-controller = <&audio1>;
		audio-codec = <&spdif>;
		codec-dai-name = "dit-hifi";
	};

with:

	spdif: spdif {
 		compatible = "linux,spdif-dit";
	};

Then, the audio driver will know about s/pdif on the first open.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
