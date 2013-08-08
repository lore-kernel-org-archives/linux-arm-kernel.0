From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Aug 2013 10:36:28 +0100
Subject: [PATCH 17/20] ASoC: pxa: pxa-pcm-lib: switch over to
 snd-soc-dmaengine-pcm
In-Reply-To: <52035EF0.1030208@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-18-git-send-email-zonque@gmail.com>
 <20130807160743.GI6427@sirena.org.uk> <5202718F.2050507@gmail.com>
 <20130807163258.GL6427@sirena.org.uk> <52035463.1030909@gmail.com>
 <52035A81.6090903@metafoo.de> <52035EF0.1030208@gmail.com>
Message-ID: <20130808093628.GS6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 11:03:44AM +0200, Daniel Mack wrote:
> On 08.08.2013 10:44, Lars-Peter Clausen wrote:

> > There is intentionally no dependency on ASoC for the soc-dmaengine-pcm code, 
> > though since I wasn't sure whether there was ever going to be a userside 
> > outside of ASoC the coded ended up in ASoC folder. It shouldn't be a problem to 
> > make it available to all of ALSA.

> Ok, great. I queued a patch for that. Will be part of my next spin, or,
> in case the series doesn't make it in time, I'll re-post all the patches
> that can be applied independently up front.

You probably don't need to move it, just adding a select (which should
ignore Kconfig dependencies) from the non-ASoC PXA stuff ought to do the
trick.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/871e2548/attachment.sig>
