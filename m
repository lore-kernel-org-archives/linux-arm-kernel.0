From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 May 2015 16:25:48 +0100
Subject: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC
 GQSPI controller
In-Reply-To: <20150520145552.GV31550@xsjsorenbubuntu>
References: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1432106871-27232-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150520145552.GV31550@xsjsorenbubuntu>
Message-ID: <20150520152548.GH21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 07:55:53AM -0700, S?ren Brinkmann wrote:
> On Wed, 2015-05-20 at 12:57PM +0530, Ranjit Waghmode wrote:

> > +static u32 zynqmp_gqspi_read(struct zynqmp_qspi *xqspi, u32 offset)

> > +static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 offset,
> > +				      u32 val)

> why are you wrapping (readl|writel)_relaxed?

It's very common to wrap the lookup from driver data to the MMIO
address.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/ea9b9d27/attachment.sig>
