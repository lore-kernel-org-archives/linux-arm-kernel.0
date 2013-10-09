From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Oct 2013 19:22:02 +0100
Subject: [alsa-devel] [RFC v2] ASoC: pcm: Store component running state
In-Reply-To: <1381329076-12022-1-git-send-email-mpa@pengutronix.de>
References: <20131009141242.GE19005@pengutronix.de>
 <1381329076-12022-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20131009182202.GX21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 04:31:16PM +0200, Markus Pargmann wrote:
> Store the state of the components to detect not matching START/STOP
> command pairs. Otherwise a component's trigger function may be called
> twice with the same command which can lead to problems.

> This is a patch which stores the state of platform, cpu_dai and codec_dai to
> call their trigger functions only if they are not already in the correct state.

No, this seems way too complex and fragile.  The original idea was
better though I'm still not convinced it actually fixes the problem you
think it fixes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131009/b86e9fd1/attachment.sig>
