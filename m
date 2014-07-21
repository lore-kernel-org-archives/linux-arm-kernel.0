From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Jul 2014 21:28:18 +0200
Subject: mvebu: Can we make the orion-mdio clock a requirement?
In-Reply-To: <20140721190614.GB20027@arch.cereza>
References: <20140721190614.GB20027@arch.cereza>
Message-ID: <20140721212818.2d4920c4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Mon, 21 Jul 2014 16:06:15 -0300, Ezequiel Garcia wrote:

> Currently the mvmdio driver does not require a clock to be declared,
> and instead this is optional.
> 
> However (almost) all the platforms that currently use it, i.e. the
> Armada, Kirkwood and Dove SoCs, require some clock to be enabled before
> the MDIO registers can be accessed.
> 
> The Orion5x SoC doesn't declare any clock for neither the ethernet node,
> nor the MDIO node. Is that correct?

There are no gatable clocks on Orion5x, so unless the driver really
wants a clock, there's no hard requirement to give a clock reference.

> Do you think we could make the clock a required property in the mvmdio
> devicetree node? How would that behave in the non-DT case?

I don't think the mvmdio driver is used in non-DT contexts.

However, yes, I tend to agree, making the clock mandatory would
probably be a good thing.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
