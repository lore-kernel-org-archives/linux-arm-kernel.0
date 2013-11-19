From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Nov 2013 20:09:57 +0000
Subject: [PATCH 08/10] ASoC: ux500_pcm: Differentiate between pdata and
 DT initialisation
In-Reply-To: <528BBE90.4020802@metafoo.de>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-9-git-send-email-lee.jones@linaro.org>
 <20131119184829.GF2674@sirena.org.uk>
 <20131119193341.GC19953@lee--X1> <528BBE90.4020802@metafoo.de>
Message-ID: <20131119200957.GS2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 08:40:00PM +0100, Lars-Peter Clausen wrote:
> On 11/19/2013 08:33 PM, Lee Jones wrote:

> > Despite the '+'s, I'm not actually adding these parameters, I'm
> > duplicating the pdata version and removing the stuff I 'know' that's
> > not required. I don't know what happens when/if these two parameters
> > are removed. I can add this to my TODO when I rip out platform data
> > support, which will happen when this stuff lands.

> I think the patch is fine for now. Once non-DT support has been removed for
> ux500 we should be able to remove the whole ux500_pcm.c file (Assuming that
> the ux500 DMA engine driver gains dma_slave_caps support).

Yeah, it shouldn't break anything but I'd rather at least have a comment
on any new code that specifies these things by hand explaining why the
automatic stuff doesn't work, it's much nicer to not have to specify the
magic numbers by hand and this will help encourage new code to do the
right thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/2d29152b/attachment.sig>
