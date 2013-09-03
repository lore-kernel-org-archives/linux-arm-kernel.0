From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Sep 2013 15:39:00 +0100
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <CA+Bv8XYp9zzoYa=-Obr3CW4KmQkB9mswaFj11pxffYqPY7Qwqw@mail.gmail.com>
References: <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <20130829110534.GV10783@sirena.org.uk>
 <CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
 <20130829180101.GO10783@sirena.org.uk>
 <CA+Bv8XavoekzHM6DU3BFdq8W+XK6aGr7bvW60W3L6gR2Cu2p4Q@mail.gmail.com>
 <20130829191051.GT10783@sirena.org.uk>
 <CA+Bv8XYp9zzoYa=-Obr3CW4KmQkB9mswaFj11pxffYqPY7Qwqw@mail.gmail.com>
Message-ID: <20130903143900.GJ3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 07:06:01AM -0700, Russ Dill wrote:
> On Thu, Aug 29, 2013 at 12:10 PM, Mark Brown <broonie@kernel.org> wrote:

> > I was thinking about the majority of regulators where setting a voltage
> > would be a single bitfield update (plus ramp delay, which is going to
> > need to be accounted for in the power on case).  If we need to do longer
> > sequences things get a bit more tricky in terms of interface but it
> > seems doable.

> The sequence for TPS65217 on beaglebone is rather long, it's 8
> register writes. It has to write the new value to the DCDC3 register
> and the apply bit to the DCDC register, but both registers are
> password locked registers. The password sequence is to write the
> password register, then the register, then the password register
> again, then the register again.

Oh dear, that's a bit annoying.  It's doable obviously if people decide
to go down that route but it's work and this is a very common system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130903/76f33bcf/attachment-0001.sig>
