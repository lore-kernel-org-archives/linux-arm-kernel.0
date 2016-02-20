From: broonie@kernel.org (Mark Brown)
Date: Sun, 21 Feb 2016 04:59:25 +0900
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <871t87z1gz.fsf@belgarion.home>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
Message-ID: <20160220195925.GF18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 20, 2016 at 07:22:04PM +0100, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Instead we should be probing at runtime (as the non-ASoC AC'97 code does) or
> > something similar.

> When you say "non-ASoC AC'97 code", which file are you referring to ? Is it
> sound/pci/ac97/ac97_codec.c ?

Yes.

> If so is there already a table of tuples (AC97_VENDOR_ID1, AC97_VENDOR_ID2) ->
> (platform device, platform device data) and a matching mechanism already
> available to the ASoC drivers ?

ASoC doesn't really support the enumeration very well, you can use
ac97.c as the CODEC but that's about it.  There is a generic AC'97 PXA
driver in sound/arm, if your system can use that that'd be a better
route to DT integration for it I think.  Did you try that, if there are
problems with that perhaps we can improve that driver, it should  be
simpler.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160221/70f3d21d/attachment.sig>
