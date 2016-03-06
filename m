From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 6 Mar 2016 22:42:06 +0100
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
Message-ID: <20160306214206.GW8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 01:51:51PM +0100, Michal Suchanek wrote:
> Hello,
> 
> On 26 February 2016 at 13:25, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Feb 26, 2016 at 07:56:56AM +0200, Priit Laes wrote:
> >> From: Emilio L?pez <emilio@elopez.com.ar>
> >>
> >> This patch adds support for 64 byte or bigger transfers on the
> >> sun4i SPI controller. Said transfers will be performed via DMA.
> >>
> >> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> >> Tested-by: Michal Suchanek <hramrach@gmail.com>
> >> Tested-by: Priit Laes <plaes@plaes.org>
> >> ---
> >
> > You *must* sign off any patches you are sending, please see
> > SubmittingPatches.
> 
> I have sent these patches in the past.

Mike's point was that since it's Priit that he's submitting the
patches, he must add his SoB.

> Besides this non-technical objection there were multiple technical
> objections.
> 
> IIRC one was that the driver does not handle the case when the DMA
> channels are not available. As I understand it the channels are
> exclusively reserved for a particular peripherial on sunxi platform so
> this ShoulNotHappen(tm). So it's probably fine for the driver to fail
> probe  when you have broken DT or no DMA engine support for sunxi
> platform.

There's a quite trivial scenario that would trigger this: if the dma
driver or dmaengine is not enabled / loaded.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160306/056db8b7/attachment.sig>
