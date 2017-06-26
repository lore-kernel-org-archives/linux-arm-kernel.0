From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Jun 2017 21:21:00 +0200
Subject: [PATCH v13 05/14] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls.
In-Reply-To: <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
References: <20170624062419.23778-1-dannym@scratchpost.org>
 <20170624062419.23778-6-dannym@scratchpost.org>
 <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
Message-ID: <20170626192100.h5o366tawcnkqosx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 09:48:59AM +0800, Chen-Yu Tsai wrote:
> On Sat, Jun 24, 2017 at 2:24 PM, Danny Milosavljevic
> <dannym@scratchpost.org> wrote:
> > Since it's now possible to have a DAPM mixer control with multiple channels,
> > use it to cut down the total number of controls.
> >
> > Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> > ---
> >  sound/soc/sunxi/sun4i-codec.c | 27 ++++++++++++---------------
> >  1 file changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> > index c69b55c..3718137 100644
> > --- a/sound/soc/sunxi/sun4i-codec.c
> > +++ b/sound/soc/sunxi/sun4i-codec.c
> > @@ -685,15 +685,12 @@ static const struct snd_kcontrol_new sun7i_codec_extra_controls[] = {
> >                        sun7i_codec_micin_preamp_gain_scale),
> >  };
> >
> > -static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
> > -       SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > -                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> > -};
> > -
> > -static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
> > -       SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
> > +       SOC_DAPM_DOUBLE("DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
> >                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
> 
> This changes the mixer control names exposed to userspace. While I think
> consolidating mixer controls is nice, giving the user a less cluttered
> view, I'm not sure about the changing a possible userspace ABI.
> 
> Maxime, ALSA and ASoC people, any comments about this?

Yeah, breaking userspace is definitely not ok.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170626/fca69846/attachment.sig>
