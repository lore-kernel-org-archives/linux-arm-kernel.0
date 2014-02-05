From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 5 Feb 2014 19:07:32 +0100
Subject: [alsa-devel] [PATCH v3 4/5] ASoC: tda998x: adjust the audio hw
 parameters from EDID
In-Reply-To: <52F2021A.9020804@metafoo.de>
References: <cover.1391274627.git.moinejf@free.fr>
 <1b15025671d9099863a3091346536e45891e4a26.1391274628.git.moinejf@free.fr>
 <20140204180625.GM22609@sirena.org.uk>
 <20140205101134.4591e5c3@armhf> <52F2021A.9020804@metafoo.de>
Message-ID: <20140205190732.5617f200@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Feb 2014 10:19:22 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> > So, in the CODEC, I don't see how I could update the parameters
> > dictated by the EDID otherwise in changing the DAI driver parameters.
> >  
> 
> The startup function is the right place. But instead of modifying the DAI 
> use snd_pcm_hw_constraint_mask64(), snd_pcm_hw_constraint_list(), etc. to 
> setup the additional constraints that come from the EDID.

It is more complicated, but it works. Nevertheless, I have 2 problems:

- snd_pcm_hw_constraint_list() keeps a pointer to the list, so, it
  cannot be in the stack. It fix this with static struct and rate array.

- snd_pcm_hw_constraint_mask64() is not exported.
  Is there an other way to set constraints on the formats/sample widths?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
