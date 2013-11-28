From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Nov 2013 14:16:07 +0100
Subject: ACPI
In-Reply-To: <20131127122543.5DEE2C404EC@trevor.secretlab.ca>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <201311261443.30784.jbe@pengutronix.de>
 <20131127122543.5DEE2C404EC@trevor.secretlab.ca>
Message-ID: <CACRpkdbCqc4R1YF_eEa5PfnADSdroqnAuQ50sYnuhOnkjqS5bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 1:25 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, 26 Nov 2013 14:43:30 +0100, J?rgen Beisert <jbe@pengutronix.de> wrote:
>> On Tuesday 26 November 2013 13:55:10 Grant Likely wrote:
>> > On Tue, Nov 26, 2013 at 12:43 PM, Linus Walleij

>> > > Since i2c is a slow bus, can be 100kHz or so, how does that
>> > > avoid locking the entire CPU while e.g. waiting for transactions on
>> > > the external bus to complete?
(...)
>> >
>> > ACPI5 defines a binding for serial busses (i2c & spi) which allows
>> > real device drivers to drive the bus and allows ACPI and the kernel to
>> > share the bus safely. Using that binding means some i2c devices can be
>> > 'owned' by ACPI and others owned by the kernel.
>>
>> This means bus locking. And Linus' other question about CPU locking while ACPI
>> drives the I2C bus?
>
> It means Linux owns the I2C bus and AML methods request the OS to
> perform a transaction on its behalf.

Aha OK so that is consistent with how control of GPIOs (and I guess
other things as well) are partitioned between the kernel and ACPI AML
methods. And it's not so bad, this is manageable.

Yours,
Linus Walleij
