From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Nov 2014 09:47:21 +0000
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <87ppcznbyv.fsf@natisbad.org>
References: <cover.1415222752.git.arno@natisbad.org>
 <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
 <20141106055017.GL8509@sirena.org.uk> <87ppcznbyv.fsf@natisbad.org>
Message-ID: <20141107094721.GY8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 12:30:48AM +0100, Arnaud Ebalard wrote:
> Mark Brown <broonie@kernel.org> writes:

> > None of the alarm functionality checks to see if there's actually an IRQ
> > - is that OK? I'd at least expect the alarm interrupt enable call to
> > check if the interrupt is wired up.

> I can add those check BUT I would like some directions in order to
> support the following use case too.

> Current three in-tree users of ISL12057 are NAS devices (Netgear
> ReadyNAS 102, 104 and 2120). All of them *do not have* the interrupt pin
> of the RTC chip connected to an interrupt line of the SoC. Nonetheless,
> the IRQ line of the chip being connected to a PMIC on the board (TI
> TPS65251 [1] on ReadyNAS 102 and 104, I do not know for ReadyNAS
> 2120). When the device is off and the alarm rings, the device gets
> powered on. AFAICT, the IRQ coming on the TPS65251 is not replicated on
> any line of the SoC.

It's OK to support not having the interrupt, the point is that if there
isn't an interrupt the driver shouldn't support operations which rely on
the interrupt to succeed - things like enabling the alarm IRQ for
example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141107/f0d88edf/attachment.sig>
