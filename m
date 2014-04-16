From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Apr 2014 18:42:16 +0100
Subject: [PATCH v3 09/18] ASoC: fsl-ssi: Only enable baudclk when used
In-Reply-To: <20140416080826.GA13449@MrMyself>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <1397482548-28463-10-git-send-email-mpa@pengutronix.de>
 <20140414152850.GB7197@MrMyself>
 <20140416072738.GC6159@pengutronix.de>
 <20140416080826.GA13449@MrMyself>
Message-ID: <20140416174216.GW12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 04:08:29PM +0800, Nicolin Chen wrote:
> On Wed, Apr 16, 2014 at 09:27:38AM +0200, Markus Pargmann wrote:

> > Is there always exactly one hw_free call for one hw_params call? There
> > is a comment above the function:
> > "Frees resources allocated by hw_params, can be called multiple times",

> That's a good question. IIRC, snd_pcm_release_substream() would call its
> hw_free() right before calling snd_pcm_close(). So there would be at least
> twice for hw_free()'s execution.

There may be any number of hw_params() calls.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140416/6decb35f/attachment.sig>
