From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Jan 2013 15:33:33 +0900
Subject: [PATCH 05/15] ASoC: fsl: fiq and dma cannot both be modules
In-Reply-To: <20130122035028.GB29677@S2100-06.ap.freescale.net>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-6-git-send-email-arnd@arndb.de>
 <20130122035028.GB29677@S2100-06.ap.freescale.net>
Message-ID: <20130122063331.GA1766@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 11:50:30AM +0800, Shawn Guo wrote:
> On Mon, Jan 21, 2013 at 05:15:58PM +0000, Arnd Bergmann wrote:

> > Without this patch, we cannot build the ARM 'allmodconfig', or
> > we get this error:

> > sound/soc/fsl/imx-pcm-dma.o: In function `init_module':
> > sound/soc/fsl/imx-pcm-dma.c:177: multiple definition of `init_module'
> > sound/soc/fsl/imx-pcm-fiq.o:sound/soc/fsl/imx-pcm-fiq.c:334: first defined here
> > sound/soc/fsl/imx-pcm-dma.o: In function `cleanup_module':
> > sound/soc/fsl/imx-pcm-dma.c:177: multiple definition of `cleanup_module'
> > sound/soc/fsl/imx-pcm-fiq.o:sound/soc/fsl/imx-pcm-fiq.c:334: first defined here

> I sent a fix [1] for that queued by Mark.

> Mark,

> Is the patch on the way to 3.8-rc?

Yes, should be.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130122/831a9df6/attachment.sig>
