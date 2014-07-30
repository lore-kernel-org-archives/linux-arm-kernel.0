From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Jul 2014 11:46:07 +0100
Subject: [PATCH v2 03/10] mtd: spi-nor: add DDR quad read support
In-Reply-To: <20140730074500.GF11952@brian-ubuntu>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-4-git-send-email-b32955@freescale.com>
 <20140730050843.GE11952@brian-ubuntu>
 <20140730064413.GA15547@shldeISGChi005.sh.intel.com>
 <20140730074500.GF11952@brian-ubuntu>
Message-ID: <20140730104607.GQ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 12:45:00AM -0700, Brian Norris wrote:
> On Wed, Jul 30, 2014 at 02:44:13PM +0800, Huang Shijie wrote:
> > On Tue, Jul 29, 2014 at 10:08:43PM -0700, Brian Norris wrote:
> > > On Mon, Apr 28, 2014 at 11:53:40AM +0800, Huang Shijie wrote:
> > > > This patch adds the DDR quad read support by the following:

> > > Are DDR modes in the scope of drivers/spi/ at all, so that we could
> > > someday wire it up through m25p80.c? Or is 'DDR' such a distortion of
> > > the meaning of 'SPI' such that it will be restricted only to SPI NOR
> > > dedicated controllers?

> > IMHO, the DDR modes can _NOT_ be handled by the driver/spi/*.

> I agree to some extent, but I wanted to confirm with the SPI guys that
> DDR is truly unique to SPI NOR. (I know it doesn't currently support
> it.)

I don't know what DDR is in this context, sorry.  I'm guessing you're
right since it sounds like something to do with extra clocks and this is
probably not something used by generic SPI devices at present (if it
ends up being widely implemented by sufficiently generic controllers
that might change but the trend seems to be to flash specific
controllers).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/fc997013/attachment-0001.sig>
