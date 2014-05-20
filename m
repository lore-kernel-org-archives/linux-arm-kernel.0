From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 May 2014 22:58:54 +0100
Subject: [alsa-devel] [PATCH] Fix for possible null pointer dereference
 in dma.c
In-Reply-To: <537BC744.8020601@metafoo.de>
References: <1400191076-28279-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <5379E284.7030700@gmail.com>
 <CAFo99gZ3kVGn04we5OtRtbkceYRs6SiHXRyoX1Gb-SknJH=z=w@mail.gmail.com>
 <537BAA2B.9090906@gmail.com> <537BC744.8020601@metafoo.de>
Message-ID: <20140520215854.GY12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:21:08PM +0200, Lars-Peter Clausen wrote:
> On 05/20/2014 09:16 PM, Tomasz Figa wrote:

> >Still, I'm not too experienced with ALSA and ASoC, so I might be wrong.
> >Mark, what do you think about this?

> Given that there is a patch[1] which removes the whole file I think we can
> stop the discussion about this patch here.

> But for the record, substream will never ever be NULL in this function. prtd
> might be though if the DMA completion callback races against the closing of
> the PCM stream.

Yeah, what Lars said - obviously the patch removing the driver is more
comprehensive!

For the record it's very helpful to be specific about what the problem
being addressed is in the changelog, if it's not obvious what the bug
that's being fixed is that'll slow things down.  Please also use subject
lines appropriate for the subsystem, it will help your patch get
noticed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/f0995ade/attachment.sig>
