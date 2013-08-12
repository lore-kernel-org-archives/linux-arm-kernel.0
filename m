From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Aug 2013 11:07:28 +0100
Subject: [PATCH 17/18] spi: s3c64xx: Always select S3C64XX_PL080 when
 ARCH_S3C64XX is enabled
In-Reply-To: <2033369.1oHkX7kdGa@flatron>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-18-git-send-email-tomasz.figa@gmail.com>
 <20130811191140.GI6427@sirena.org.uk> <2033369.1oHkX7kdGa@flatron>
Message-ID: <20130812100728.GL6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 01:03:19AM +0200, Tomasz Figa wrote:
> On Sunday 11 of August 2013 20:11:40 Mark Brown wrote:

> > Do we need the select here (or should we have other selects for the
> > Exynos SoCs)?

> The driver would build fine without this symbol selected, but since it 
> relies on availability of DMA, it doesn't make too much sense to build it 
> this way. This kind of selects makes kernel configuration more user 
> friendly IMHO.

> Possibly adding appropriate selects (PL330) for s5p* and exynos could make 
> sense.

Right.  On these SoCs it's probably worth doing it in the arch/arm code
rather than for every device using the controller though, it's the same
DMA controller for everything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/881733fb/attachment.sig>
