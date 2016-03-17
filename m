From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Mar 2016 11:43:08 +0000
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
 <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
Message-ID: <20160317114308.GF2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 11:58:05AM +0100, Michal Suchanek wrote:
> On 17 March 2016 at 08:27, Maxime Ripard

> > You're mixing two things up: the fact that we can't do more than the
> > FIFO length in PIO and that we're missing DMA support. We have patches
> > to address both, and there's no depedency between the two.

> The only thing is that although DMA is optional on pretty much any
> system you will have DMA available unless you broke your config. You
> really do want the DMA support when it is available. So there will be
> nobody testing the non-DMA part and it will be prone to bitrot.

Well, it might be worth doing PIO for very short transfers even if you
have DMA - it's quite common for this to perform better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/3e5bc193/attachment.sig>
