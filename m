From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Mar 2014 19:29:40 +0000
Subject: [linux-sunxi] Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
In-Reply-To: <20140311192411.GA4193@localhost.fastwebnet.it>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
 <20140303015616.GN2411@sirena.org.uk>
 <20140311192411.GA4193@localhost.fastwebnet.it>
Message-ID: <20140311192940.GA28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 08:24:11PM +0100, Carlo Caione wrote:
> On Mon, Mar 03, 2014 at 10:56:16AM +0900, Mark Brown wrote:

> > > +	regulators = of_find_node_by_name(np, "regulators");
> > > +	if (!regulators) {
> > > +		dev_err(&pdev->dev, "regulators node not found\n");
> > > +		return -EINVAL;
> > > +	}

> > The driver should be able to start up with no configuration provided at
> > all except for the device being registered - the user won't be able to
> > change anything but they will be able to read the current state of the
> > hardware which can be useful for diagnostics.

> If the device is DT enabled and no configuration is provided for
> regulators, these are disabled according to:

> http://lxr.linux.no/linux+v3.13.5/drivers/regulator/core.c#L3797

> Am I missing something or do you have any pointer?

With the above code the driver will return an error and never get as far
as registering the regulator.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/fdccf963/attachment-0001.sig>
