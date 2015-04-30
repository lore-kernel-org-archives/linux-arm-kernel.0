From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Apr 2015 21:12:07 +0100
Subject: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
In-Reply-To: <1429672640.14162.55.camel@mtksdaap41>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
 <20150418173407.GE26185@sirena.org.uk>
 <20150420043747.GH6325@pengutronix.de>
 <20150420204849.GJ14892@sirena.org.uk>
 <1429672640.14162.55.camel@mtksdaap41>
Message-ID: <20150430201207.GK22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 22, 2015 at 11:17:20AM +0800, Koro Chen wrote:

> If using DPCM, it seems the most suitable FE DAIs will be memif, and
> external interface like I2S should be BE DAIs. Do you think it is
> suitable for our memif to be FE DAIs? Then which memif to used can be
> described in a machine driver's FE DAIs. But I think this has a problem
> that our memif is one-direction, playback or capture. So the binded pcm
> device cannot have playback and capture capability together. May it
> cause trouble for user space apps that assumes there will be pcmC0D0p,
> pcmC0D0c?

I think the only userspace application you really have to worry about
here is PulseAudio which (at least with UCM) should be able to cope
since it needs to handle things like USB microphones.  I think
everything else I can think of can either cope or has to handle the same
use cases as PulseAudio does so should have support.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150430/243c1ad7/attachment.sig>
