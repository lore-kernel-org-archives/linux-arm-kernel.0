From: robh@kernel.org (Rob Herring)
Date: Thu, 12 May 2016 12:20:27 -0500
Subject: [PATCH v2 1/2] doc/devicetree: Add Aspeed VIC bindings
In-Reply-To: <1463014882.20290.203.camel@kernel.crashing.org>
References: <462797239-14765-1-git-send-email-joel@jms.id.au>
 <1462802317-27086-1-git-send-email-joel@jms.id.au>
 <1462802317-27086-2-git-send-email-joel@jms.id.au>
 <20160511143313.GA7426@rob-hp-laptop>
 <1463014882.20290.203.camel@kernel.crashing.org>
Message-ID: <CAL_JsqJDGmvDxm1kN1w6NQZs0JLeA-V=X_BWi=VOaMTwftLn-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 8:01 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2016-05-11 at 09:33 -0500, Rob Herring wrote:
>> > +- interrupt-controller : Identifies the node as an interrupt controller
>> > +- #interrupt-cells : Specifies the number of cells needed to encode an
>> > +  interrupt source. The value shall be 1.
>>
>> No need for level vs. edge flags?
>
> That's an open question. Most interrupts are fixed. A handful of GPIOs
> can be configured either way. For now I am relying on uboot setting up
> the right config for them and I read it back at boot time, but we could
> make it part of the binding I suppose.

It is almost standard to just use 2 cells here even if reserved for
future use. Especially since the IP block seems to have registers to
control that.

>
>> > +- valid-sources : bitmask of valid irq sources
>>
>> Drop this. Either all interrupt controllers need this or none of
>> them do. The valid sources are the ones described in the DT.
>
> Looking at the code (I wrote that ages ago), this is only used for:

I'm guessing it came from the VIC binding. I never really liked the
property, but not enough to worry about it.

Rob
