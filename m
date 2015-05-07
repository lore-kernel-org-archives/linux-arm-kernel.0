From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 May 2015 20:32:36 +0100
Subject: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
In-Reply-To: <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150507185216.GP22845@sirena.org.uk>
 <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
Message-ID: <20150507193236.GS22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 09:25:19PM +0200, Stefan Wahren wrote:
> > Mark Brown <broonie@kernel.org> hat am 7. Mai 2015 um 20:52 geschrieben:

> > > In the bootloader code enabling the DC-DC is critical. There is a known
> > > issue
> > > which falsely triggers the brownout detection.

> > Why would the driver not provide these operations?

> I didn't implement this operation because the suggested workaround for the
> hardware issue isn't very nice 
> (disable brownout detection during enabling DC-DC). I was afraid of the
> implementation.

That doesn't sound too complicated?

> > If the devices aren't sharing code then they should be separate drivers.

> Okay. 

> mxs-regulator-ldo.c
> mxs-regulator-dcdc.c

> What do you think of?

Sure.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150507/8ce42fec/attachment.sig>
