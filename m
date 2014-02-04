From: mporter@linaro.org (Matt Porter)
Date: Tue, 4 Feb 2014 16:16:38 -0500
Subject: [PATCH 2/6] regulator: add bcm59056 pmu DT binding
In-Reply-To: <20140204172309.GG22609@sirena.org.uk>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-3-git-send-email-mporter@linaro.org>
 <20140204172309.GG22609@sirena.org.uk>
Message-ID: <20140204211638.GA16179@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 05:23:09PM +0000, Mark Brown wrote:
> On Tue, Feb 04, 2014 at 07:19:08AM -0500, Matt Porter wrote:
> > Add a DT binding for the BCM59056 PMU. The binding inherits from
> > the generic regulator bindings.
> 
> Is this really only a regulator - does the chip have no other functions?

It's your average multi-function device with other functions as you are
suspecting.  Buried in the the MFD driver comments is me admitting that
I need to split this into two bindings. The base device, "bcm59056" and
then "bcm59056-reg". So point noted, I'll updated with the appropriate
binding for each.

> > +- regulators: This is the list of child nodes that specify the regulator
> > +  initialization data for defined regulators.  Generic regulator bindings
> > +  are described in regulator/regulator.txt.
> 
> The regulators property should always be optional, the driver should be
> able to start up and read back the hardware state without any further
> configuration.

Ahh, ok. I will make it so.

Thanks,
Matt
