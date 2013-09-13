From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 12 Sep 2013 22:58:30 -0400
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <1378979431.2627.402.camel@shinybook.infradead.org>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <52318953.6090405@freescale.com>
 <1378979431.2627.402.camel@shinybook.infradead.org>
Message-ID: <20130913025827.GA3051@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 10:50:31AM +0100, David Woodhouse wrote:
> On Thu, 2013-09-12 at 17:28 +0800, Huang Shijie wrote:
> > ? 2013?09?11? 22:05, David Woodhouse ??:
> > > What*actually*  happens, on the wire(s), when the flash driver asks the
> > > SPI controller to perform a transaction?
> > The LUT registers tell the controller how many wires are needed for a 
> > transaction.
> > For example, the read status only use a single line, while the quad read 
> > uses 4 lines.
> 
> Is this not something that could theoretically be provided by the caller
> when it *makes* the transaction?
> 
> Conceptually speaking, could it not be an additional argument to
> spi_write_then_read() ? 
> 
> After all, it's the *device* driver (m25p80.c etc.) which will know what
> the transaction actually *is*, and how many lines the device will want
> to use for each transaction?
yes. we can set the lines information in the spi_write_then_read().

But for the quadspi driver, it does not need this information.

When the drivers knows that it is a Quad-read transaction, it will uses
the relative LUT sequence which uses the 4 lines.

thanks
Huang Shijie
