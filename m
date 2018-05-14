From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 14 May 2018 16:06:40 +0200
Subject: [PATCH v14 3/8] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls
In-Reply-To: <20180505085056.6c6011ca@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-4-dannym@scratchpost.org>
 <20180503144618.oojhvmey44dtg5fa@flea>
 <20180505085056.6c6011ca@scratchpost.org>
Message-ID: <20180514140640.oig6hqbh5utvzhmd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2018 at 08:51:43AM +0200, Danny Milosavljevic wrote:
> Hi Maxime,
> 
> On Thu, 3 May 2018 16:46:19 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> 
> > Doesn't that mean that the controls will be shared between the right
> > and left mixers now, which wasn't the case before?
> 
> Yes.  However Chen-Yu said that except for debugfs that cannot be
> observed by user space anyway.
> 
> It's nice to have the NEW controls have multiple channels, which is what
> this does.
> 
> >And also, wouldn't
> > the controls be called "Left Mixer Left Mixer Left DAC Playback
> > Switch" (for the first one) now?
> 
> No.  I checked using "amixer" - the names look fine,
> "Left Mixer Left DAC Playback Switch".
> 
> With the patch series, amixer says:
> 
> numid=10,iface=MIXER,name='FM Playback Switch'
> numid=6,iface=MIXER,name='FM Playback Volume'
> numid=5,iface=MIXER,name='Line Boost Volume'
> numid=9,iface=MIXER,name='Line Playback Switch'
> numid=4,iface=MIXER,name='Line Playback Volume'
> numid=1,iface=MIXER,name='Mic1 Boost Volume'
> numid=11,iface=MIXER,name='Mic1 Playback Switch'
> numid=2,iface=MIXER,name='Mic2 Boost Volume'
> numid=12,iface=MIXER,name='Mic2 Playback Switch'
> numid=7,iface=MIXER,name='Mic Playback Volume'
> numid=18,iface=MIXER,name='Capture Source'
> numid=19,iface=MIXER,name='Differential Line Source'
> numid=8,iface=MIXER,name='Left Mixer Left DAC Playback Switch'
> numid=15,iface=MIXER,name='Power Amplifier DAC Playback Switch'
> numid=16,iface=MIXER,name='Power Amplifier Mixer Playback Switch'
> numid=17,iface=MIXER,name='Power Amplifier Mute Switch'
> numid=3,iface=MIXER,name='Power Amplifier Volume'
> numid=14,iface=MIXER,name='Right Mixer Left DAC Playback Switch'
> numid=13,iface=MIXER,name='Right Mixer Right DAC Playback Switch'

Great then :)

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180514/5b428001/attachment.sig>
