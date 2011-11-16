From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Nov 2011 14:11:30 +0000
Subject: [PATCH] ARM: pxa: add support for Raumfeld DDX
In-Reply-To: <4EC3C376.3040007@gmail.com>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
 <20111115141348.GG3077@opensource.wolfsonmicro.com>
 <4EC3B30F.60403@gmail.com>
 <20111116131910.GE29986@opensource.wolfsonmicro.com>
 <4EC3C376.3040007@gmail.com>
Message-ID: <20111116141130.GF29986@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 03:06:46PM +0100, Daniel Mack wrote:
> On 11/16/2011 02:19 PM, Mark Brown wrote:

> > What I'd expect here is that the arch/arm code would register a
> > different platform device depending on which board it's running on
> > (though actually controlling I2C device registration is enough as ASoC
> > won't probe the sound driver until the components appear).

> Ok, I can do this. However, the two driver will share some logic wrt
> GPIO lines that put the codecs into reset. But ok, we can live with that
> I guess, as it in fact makes the driver smaller and easier to read.

Hrm, I'd expect that that logic would be in the CODEC drivers - they
really do need to know that their registers went away.

> > Look at the snd_soc_dai_link definition, and things like speyside.

> Sorry, I still don't get it. All implementations I can find call
> snd_soc_dai_set_fmt() for the cpu and codec dais from the
> .ops->hw_params function they reference from their snd_soc_dai_links.
> Just like this new code does as well. What am I missing?

Are you *sure* you're looking at current code?  The dai_fmt field isn't
that obscurely named...
