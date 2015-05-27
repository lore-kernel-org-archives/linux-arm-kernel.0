From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 May 2015 18:33:21 +0100
Subject: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
In-Reply-To: <1290103954.26573.1432642616013.JavaMail.open-xchange@oxbsltgw08.schlund.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150507185216.GP22845@sirena.org.uk>
 <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <20150507193236.GS22845@sirena.org.uk>
 <1290103954.26573.1432642616013.JavaMail.open-xchange@oxbsltgw08.schlund.de>
Message-ID: <20150527173321.GH21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 02:16:55PM +0200, Stefan Wahren wrote:
> > Mark Brown <broonie@kernel.org> hat am 7. Mai 2015 um 21:32 geschrieben:

> > > > > In the bootloader code enabling the DC-DC is critical. There is a known
> > > > > issue
> > > > > which falsely triggers the brownout detection.

> > > > Why would the driver not provide these operations?

> > > I didn't implement this operation because the suggested workaround for the
> > > hardware issue isn't very nice
> > > (disable brownout detection during enabling DC-DC). I was afraid of the
> > > implementation.

> > That doesn't sound too complicated?

> Okay, i think i managed the brownout handling.
> 
> Unfortunately i'm stuck at the next step. The DC-DC (3 way output) can supply 3
> LDOs vddd, vdda, vddio. In case of a DC-DC state change the 3 regulators needs
> to be reconfigured before.

> I tought of REGULATOR_EVENT_PRE_DISABLE and REGULATOR_EVENT_PRE_ENABLE events,
> but i'm not sure that's the right way to achieve a synchronization between DC-DC
> and consuming LDOs.

OK, that's possibly sounding a bit complicated.  Is it just a case of
writing some value, doing a reconfiguration and rewriting the original
value or is it something more?  If it's much more complicated than that
then I think putting a comment in the driver explaining what the issue
is would be the right step, that would address the issue with the driver
looking strange.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150527/8fce3acb/attachment.sig>
