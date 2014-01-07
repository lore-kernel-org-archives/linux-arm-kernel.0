From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 14:35:38 +0000
Subject: [PATCH v7 3/3] mfd: max14577: Add device tree bindings document
In-Reply-To: <2536498.L12VSLryvi@amdc1227>
References: <1386329534-14186-1-git-send-email-k.kozlowski@samsung.com>
 <1386329534-14186-4-git-send-email-k.kozlowski@samsung.com>
 <2536498.L12VSLryvi@amdc1227>
Message-ID: <20140107143538.GI31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 03:10:04PM +0100, Tomasz Figa wrote:
> On Friday 06 of December 2013 12:32:14 Krzysztof Kozlowski wrote:

> > +- regulators :
> > +	Required properties:
> > +		- compatible : "maxim,max14577-regulator"

> > +	May contain a sub-node per regulator from the list below. Each

> Is "May" the correct word? Wouldn't it be better to always have
> configuration specified for all regulators of the cell?

It doesn't achieve anything to force people to include unused regulators
in the DT - the node is only needed if the kernel needs to do something
with the regulator.  This means that all the individual regulators end
up being optional.  The set of 

> Now this patch creates a question whether we should keep the existing
> black-box MFD scheme, where the list of cells is determined by an array
> hardcoded inside the driver or rather we should completely move to DT
> based description where of_mfd_populate() could create all MFD cells
> using description from DT.

This has been discussed before.  The biggest issue is that the Linux
idea of what cells it wants depends very much on whatever the current
set of subsystems Linux has and the way we divide the hardware between
them.  That's not a static thing, we're seeing flux with things like
extcon and clk at the minute for example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/a5c95db7/attachment.sig>
