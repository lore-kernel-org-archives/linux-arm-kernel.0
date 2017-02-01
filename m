From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2017 21:04:44 +0100
Subject: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host
 Bridge
In-Reply-To: <20170201160224.jg6tuls2xcuul3m4@rob-hp-laptop>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170201160224.jg6tuls2xcuul3m4@rob-hp-laptop>
Message-ID: <CACRpkdat3rcNL9=FHXBD7zT5LoZy3BGCV1ZT74AoeR4JytSoaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 5:02 PM, Rob Herring <robh@kernel.org> wrote:
> On Sat, Jan 28, 2017 at 09:48:36PM +0100, Linus Walleij wrote:

>> +Example:
>> +
>> +pci at 50000000 {
>> +     compatible = "cortina,gemini-pci";
>> +     reg = <0x50000000 0x100>;
>
> Config space is indirectly accessed?

Yes it is a really annoying construction. The first device, the Faraday
roob hub is at that address, the init code uses that to set up the bus.

As soon as the bus is up, we use bus accessors to talk to the root
hub on slot 0 (this manages interrupts etc).

I guess I could even unmap this reg range at that point ...

I guess I could also get the address directly from the IO range
and start poking around. I don't know if that is any better.

Yours,
Linus Walleij
