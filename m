From: broonie@kernel.org (Mark Brown)
Date: Sun, 21 Feb 2016 06:16:59 +0900
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <87twl3xgud.fsf@belgarion.home>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk>
 <87twl3xgud.fsf@belgarion.home>
Message-ID: <20160220211659.GG18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 20, 2016 at 09:32:58PM +0100, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Sat, Feb 20, 2016 at 07:22:04PM +0100, Robert Jarzmik wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > There is a generic AC'97 PXA driver in sound/arm, if your system can use that
> > that'd be a better route to DT integration for it I think.
> I'm open on the topic.

> Historically, I use sound/soc/pxa/pxa2xx-ac97.c since 2008. I know it works, but
> if you think I should examine sound/arm/pxa2xx-ac97.c, let's do that.
> 
> > Did you try that, if there are problems with that perhaps we can improve that
> > driver, it should be simpler.

> I will. By now I fail to see how this will help in the wm9713 probing and
> detection ...

It will eumerate the AC'97 bus by itself and does not need the CODEC to
be described.

> Until I make the try, here is what I have as a device-tree extract in [1], which
> is my candidate for sound/soc/pxa/zylonite.c replacement.. If we conclude that
> wm9713 shouldn't be in device-tree, then I'm curious how the DAI bindings
> (simple-audio-card,dai-link*) should be handled.

They should be created as a function of enumerating the CODEC.  If you
use the genric AC'97 stuff it doesn't use ASoC at all and this happens
as a side effect.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160221/44d75648/attachment.sig>
