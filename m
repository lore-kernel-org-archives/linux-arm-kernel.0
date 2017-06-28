From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 19:12:05 +0100
Subject: [PATCH v13 05/14] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls.
In-Reply-To: <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
References: <20170624062419.23778-1-dannym@scratchpost.org>
 <20170624062419.23778-6-dannym@scratchpost.org>
 <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
Message-ID: <20170628181205.sfagsnuqmfrqhoen@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 09:48:59AM +0800, Chen-Yu Tsai wrote:
> On Sat, Jun 24, 2017 at 2:24 PM, Danny Milosavljevic

> > +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
> > +       SOC_DAPM_DOUBLE("DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
> >                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),

> This changes the mixer control names exposed to userspace. While I think
> consolidating mixer controls is nice, giving the user a less cluttered
> view, I'm not sure about the changing a possible userspace ABI.

> Maxime, ALSA and ASoC people, any comments about this?

It's better not to change things but on the other hand it really depends
if there's any users who will notice - if nobody notices it doesn't
matter.

Can we *please* get some review of the rest of this series?  It's
enormous, we're on version *13* and the first review on this version
here is on patch 5.  If the first four patches are fine then please says
so, if they're not then let's have some review comments so things can
move towards merging them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/8c305584/attachment.sig>
