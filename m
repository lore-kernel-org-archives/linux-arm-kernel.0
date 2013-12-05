From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Dec 2013 11:50:15 +0000
Subject: [PATCH] ASoC: samsung: Initialize the dma_data for secondary dai
In-Reply-To: <CAAgF-BdqRzB5MxTf_9nZkgSOY=F6dGAs0yhTkNHqrUQLonFAsw@mail.gmail.com>
References: <1385632932-16579-1-git-send-email-padma.v@samsung.com>
 <20131128113800.GB27568@sirena.org.uk>
 <CAAgF-BdqRzB5MxTf_9nZkgSOY=F6dGAs0yhTkNHqrUQLonFAsw@mail.gmail.com>
Message-ID: <20131205115015.GP29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 04:33:19PM +0530, Padma Venkat wrote:
> On Thu, Nov 28, 2013 at 5:08 PM, Mark Brown <broonie@kernel.org> wrote:

> > Why don't we need this fix for mainline?  The dmaengine change is just
> > moving the initialisation through a layer of indirection but there was
> > initialisation anyway.  I'm concerned that there's a bug that ought to
> > be fixed for v3.13 as well here.

> Yes. We need this for mainline. Not dependent on your dmaengine changes.

Ah, just saw this one - I'll cook up a version of it, due to the
refactoring the change doesn't apply directly to v3.13.

> >>       return snd_dmaengine_pcm_register(dev, &samsung_dmaengine_pcm_config,
> >> -                                       SND_DMAENGINE_PCM_FLAG_COMPAT);
> >> +                                       SND_DMAENGINE_PCM_FLAG_COMPAT |
> >> +                             SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME);

> > This is already done.

> Should I send another patch by removing this flag from this patch?

No need.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131205/4bc67a76/attachment.sig>
