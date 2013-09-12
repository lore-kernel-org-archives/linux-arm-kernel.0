From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 12 Sep 2013 10:50:31 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <52318953.6090405@freescale.com>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450 <52318953.6090405@freescale.com>
Message-ID: <1378979431.2627.402.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 17:28 +0800, Huang Shijie wrote:
> ? 2013?09?11? 22:05, David Woodhouse ??:
> > What*actually*  happens, on the wire(s), when the flash driver asks the
> > SPI controller to perform a transaction?
> The LUT registers tell the controller how many wires are needed for a 
> transaction.
> For example, the read status only use a single line, while the quad read 
> uses 4 lines.

Is this not something that could theoretically be provided by the caller
when it *makes* the transaction?

Conceptually speaking, could it not be an additional argument to
spi_write_then_read() ? 

After all, it's the *device* driver (m25p80.c etc.) which will know what
the transaction actually *is*, and how many lines the device will want
to use for each transaction?

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/426d49e6/attachment.bin>
