From: broonie@kernel.org (Mark Brown)
Date: Wed, 25 Apr 2018 11:53:09 +0100
Subject: [PATCH v3 2/3] regulator: add support for SY8106A regulator
In-Reply-To: <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-3-icenowy@aosc.io>
 <20180424170733.GD22073@sirena.org.uk>
 <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io>
Message-ID: <20180425105309.GC24769@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 07:41:35AM +0800, Icenowy Zheng wrote:
> ? 2018?4?25? GMT+08:00 ??1:07:33, Mark Brown <broonie@kernel.org> ??:
> >On Mon, Apr 23, 2018 at 10:46:56PM +0800, Icenowy Zheng wrote:

> >> --- /dev/null
> >> +++ b/drivers/regulator/sy8106a-regulator.c
> >> @@ -0,0 +1,176 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * sy8106a-regulator.c - Regulator device driver for SY8106A

> >Just make the entire thing a C++ comment so it looks consistent and
> >joined up.

> SPDX identifier is special -- it should be in a seperated
> comment block.

No, it just needs to be a C++ comment on the first line to ease machine
parsing.  The rest of the file doesn't matter for that.

> >> +	if (reg & SY8106A_GO_BIT)
> >> +		return reg & rdev->desc->vsel_mask;
> >> +	else
> >> +		return (chip->fixed_voltage - rdev->desc->min_uV) /
> >> +		       rdev->desc->uV_step;

> >You could use the standard get_voltage_sel() if you provide a mapping
> >operation that set everything with _GO_BIT set to return the fixed
> >voltage.  Though looking at this it seems that the fixed voltage will
> >always be one that could be set via the register anyway so I'm
> >wondering
> >if the easiest thing here isn't to just have the driver turn off
> >_GO_BIT

> Do you mean "turn on" here?

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180425/bff45862/attachment.sig>
