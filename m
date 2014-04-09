From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 10 Apr 2014 09:49:51 +1000
Subject: [PATCH v7 4/6] pci: Introduce a domain number for pci_host_bridge.
In-Reply-To: <CAErSpo4BmoYzf6GxOPRni=q563zhON57s7=5Hz=2Cf-X2ft-1A@mail.gmail.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811272-1547-5-git-send-email-Liviu.Dudau@arm.com>
 <20140405000007.GD15806@google.com>
 <20140407084623.GG17163@e106497-lin.cambridge.arm.com>
 <1396862058.3671.40.camel@pasglop>
 <20140407100715.GI17163@e106497-lin.cambridge.arm.com>
 <CAErSpo7h+Yew2hBztzkOzcHU5r4OQebxFbcZGkNUwJwfTFsbfg@mail.gmail.com>
 <20140408102043.GV17163@e106497-lin.cambridge.arm.com>
 <CAErSpo4anYBmaRbJEFE9kAXSmnvfqud=w1QA=mSSsTUamM4kSw@mail.gmail.com>
 <20140409120750.GN985@e106497-lin.cambridge.arm.com>
 <CAErSpo4BmoYzf6GxOPRni=q563zhON57s7=5Hz=2Cf-X2ft-1A@mail.gmail.com>
Message-ID: <1397087391.3671.153.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-09 at 08:02 -0600, Bjorn Helgaas wrote:
> It's possible we could manage domain numbers in the core.  On ACPI
> systems, we currently we use the ACPI _SEG value as the domain.  In
> some cases, e.g., on ia64, config space access is done via firmware
> interfaces, and those interfaces expect the _SEG values.  We could
> conceivably maintain a mapping between _SEG and domain, but I'm not
> sure there's an advantage there.

I'd rather keep the ability for the architecture to assign domain
numbers.

I'm working on making them relate to the physical slot numbers
on our new systems so we get predictable PCI IDs which helps with
some stuff like the new network device naming scheme etc...

Predictability is a good thing :-)

> I probably don't understand what you intend by reversing the order.
> Are you suggesting something like new pcibios_*() interfaces the arch
> can use to get the host bridge apertures and domain number?

Cheers,
Ben.
