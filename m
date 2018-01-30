From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Jan 2018 08:55:15 -0600
Subject: [PATCH 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <1517248844.2804.16.camel@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-2-l.stach@pengutronix.de>
 <20180129175549.f6ljaccpo5ms6xkc@rob-hp-laptop>
 <1517248844.2804.16.camel@pengutronix.de>
Message-ID: <CAL_JsqJk8-yC4XnTFwAuV1p5PUg5o=x2XQd9pUXULxHZ4xsFFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 12:00 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Montag, den 29.01.2018, 11:55 -0600 schrieb Rob Herring:
>> On Wed, Jan 17, 2018 at 07:32:42PM +0100, Lucas Stach wrote:
>> > This adds the basic DTS for the i.MX8MQ.
>> > For now only the following peripherals are supported:
>> > - IOMUXC (pin controller)
>> > - CCM (clock controller)
>> > - GPIO
>> > - UART
>> > - uSDHC (SD/eMMC controller)
>> > - FEC (ethernet controller)
>> > - i2c
>> >
>> > This is enough to get a very basic board support up and running.
>> > +                   compatible = "nxp,imx8mq-aips-bus",
>> > "simple-bus";
>> > +                           compatible = "nxp,imx8mq-gpio",
>> > "fsl,imx35-gpio";
>> > +                           compatible = "nxp,imx8mq-iomuxc";
>>
>> Also, are all these new compatibles documented?
>
> Only those where the driver isn't matching one of the older
> compatibles.
>
> I'm not sure what the policy is for those "just in case" compatibles,
> where we have older compatibles that are currently used, but the newer
> compatibles are in the DT to make it easy to match them when any IP
> integration issues turn up at a later time.

They all should be documented, so dts files can be validated (once we
have machine parseable binding docs).

Rob
