From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Feb 2014 11:18:14 +0000
Subject: [alsa-devel] [PATCH v3 4/5] ASoC: tda998x: adjust the audio hw
 parameters from EDID
In-Reply-To: <52F2021A.9020804@metafoo.de>
References: <cover.1391274627.git.moinejf@free.fr>
 <1b15025671d9099863a3091346536e45891e4a26.1391274628.git.moinejf@free.fr>
 <20140204180625.GM22609@sirena.org.uk>
 <20140205101134.4591e5c3@armhf> <52F2021A.9020804@metafoo.de>
Message-ID: <20140205111814.GF22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 10:19:22AM +0100, Lars-Peter Clausen wrote:
> On 02/05/2014 10:11 AM, Jean-Francois Moine wrote:

> >So, in the CODEC, I don't see how I could update the parameters
> >dictated by the EDID otherwise in changing the DAI driver parameters.

> The startup function is the right place. But instead of modifying
> the DAI use snd_pcm_hw_constraint_mask64(),
> snd_pcm_hw_constraint_list(), etc. to setup the additional
> constraints that come from the EDID.

Right.

> Bonus points for making this a generic helper function that takes a
> runtime and a EDID and then applies the EDID constraints on the
> runtime.

...as previously requested.  I know there was some discusion of broader
moves to factor this stuff out but it'd still be good to keep it
separated out even prior to a final non-EDID based solution so it's
easier to refactor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/f91a9e51/attachment.sig>
