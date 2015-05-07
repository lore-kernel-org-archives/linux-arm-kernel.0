From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 7 May 2015 09:18:09 +0200
Subject: [PATCH v2 2/7] crypto: add new driver for Marvell CESA
In-Reply-To: <20150507030100.GA29395@gondor.apana.org.au>
References: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
 <1430742426-21202-3-git-send-email-boris.brezillon@free-electrons.com>
 <20150507030100.GA29395@gondor.apana.org.au>
Message-ID: <20150507091809.2fb5b22e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Thu, 7 May 2015 11:01:00 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Mon, May 04, 2015 at 02:27:01PM +0200, Boris Brezillon wrote:
> > The existing mv_cesa driver supports some features of the CESA IP but is
> > quite limited, and reworking it to support new features (like involving the
> > TDMA engine to offload the CPU) is almost impossible.
> > This driver has been rewritten from scratch to take those new features into
> > account.
> > 
> > This new driver adds support for:
> > - new armada SoCs (up to 38x) while keeping support for older ones (Orion
> >   and Kirkwood)
> > - DMA mode to offload the CPU in case of intensive crypto usage
> > - new algorithms: SHA256, DES and 3DES
> > 
> > The existing CESA driver is kept around to ease transition to this new
> > driver (take some time to audit the code and/or wait for users feedback).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> 
> This patch is too big for the mailing list.  Please provide a
> URL for people to download and review.

Here [1] is a branch containing the patches submitted in this series.
I guess I won't have other choices but to split this patch (as
Sebastian suggested) in my next iteration :-).

Best Regards,

Boris

[1]https://github.com/bbrezillon/linux-marvell/commits/cesa-v2


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
