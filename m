From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Feb 2016 11:30:21 +0900
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <87povkuuf6.fsf@belgarion.home>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk>
 <87twl3xgud.fsf@belgarion.home>
 <20160220211659.GG18327@sirena.org.uk>
 <878u2fxbp9.fsf@belgarion.home>
 <20160221014920.GK18327@sirena.org.uk>
 <87povkuuf6.fsf@belgarion.home>
Message-ID: <20160226023021.GH18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 02:33:49AM +0100, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > It will not be called, the generic AC'97 code will be used.

> Ok, if it's not called no code in sound/soc/codecs/wm9713.c will be used, right
> ?
> In that case wm9713_set_dai_clkdiv() will never be used, nor will the
> wm9713_audio_map or wm9713_dapm_widgets be created, which will break all
> userspace programs relying on these mixers and DAPM routes.

> Or am I missing something ?

No, you're not missing anything - that'll be what happens.  If you need
to preserve the userspace ABI on your board you'd need a much bigger
(but very welcome) refactoring of the AC'97 code to be less hacky and
use the device model more directly, or at least define a generic AC'97
binding somehow.  All the AC'97 support has never really been properly
moved over to the device model and unfortunately nobody's yet cared
about it for device tree except in the simple cases supported by the
generic AC'97 code.  I appreciate that this isn't very helpful, it's
an unfortunate consequence of DT as an ABI.

We probably want to end up with something like what the Intel folks have
been doing recently for HDA to get that working within ASoC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/1af330dd/attachment.sig>
