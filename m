From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 May 2015 19:52:16 +0100
Subject: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
In-Reply-To: <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
Message-ID: <20150507185216.GP22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 08:37:18PM +0200, Stefan Wahren wrote:
> > Stefan Wahren <stefan.wahren@i2se.com> hat am 4. Mai 2015 um 22:34

> > i'm sorry, i forgot the following point in the changelog:

> > - move dcdc handling from mxs_power to mxs-regulator

> > I hope the change is okay. I implemented only is_enabled() to have at least 1
> > operation.
> > But it's not really necessary.

> do we need enable / disable operation?

> In the bootloader code enabling the DC-DC is critical. There is a known issue
> which falsely triggers the brownout detection.

Why would the driver not provide these operations?

> > > I'm also not 100% clear what code the DCDCs and LDOs are
> > > sharing here...

> > Actually only probing and the regulator info structure.

> How can i improve that?

If the devices aren't sharing code then they should be separate drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150507/3fcf8b63/attachment.sig>
