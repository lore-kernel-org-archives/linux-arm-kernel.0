From: carlo@caione.org (Carlo Caione)
Date: Mon, 23 May 2016 18:59:31 +0200
Subject: [PATCH v3 4/4] documentation: Add secure monitor binding
 documentation
In-Reply-To: <20160523163815.GE4976@leverpostej>
References: <1464021024-29380-1-git-send-email-carlo@caione.org>
 <1464021024-29380-5-git-send-email-carlo@caione.org>
 <20160523163815.GE4976@leverpostej>
Message-ID: <20160523165931.GA31299@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/16 17:38, Mark Rutland wrote:
> Hi,
> 
> Minor nit, but please put the binding earlier in the series than the
> code implementing it, as per
> Documentation/devicetree/bindings/submitting-patches.txt
> 
> This makes it possible to review a series in a linear fashion.

I'll do. Thanks for the pointer.

[...]
> > +
> > +Required properties for the secure monitor node:
> > +- compatible: Should be "amlogic,meson-sm"
> > +- amlogic,sm-cmd-input-base: SMC32 function identifier to read the physical
> > +                             address of the input buffer
> > +- amlogic,sm-cmd-output-base: SMC32 function identifier to read the physical
> > +                              address of the output buffer
> 
> Do the IDs for these actually differ per board?

I expect these to differ per SoC (GXBB in this case), not per board. The
driver is generic enough to be (hopefully) used for several SoCs just
changing the related header file that defines the SCM commands.

> Are some functions simply not implemented on some boards?

I don't think this is possible.

[...]
> > +
> > +Example of the node using the secure monitor:
> > +
> > +	#include <dt-bindings/firmware/meson-gxbb-sm.h>
> > +
> > +	...
> > +
> > +	efuse: efuse {
> > +		compatible = "amlogic,meson-gxbb-efuse";
> > +		secure-monitor = <&sm>;
> > +		amlogic,sm-cmd-read-efuse = <SM_EFUSE_READ>;
> > +		amlogic,sm-cmd-max-efuse = <SM_EFUSE_USER_MAX>;
> 
> Likewise for these?

AFAIK the secure monitor code and related commands are SoC specific.

Thanks,

-- 
Carlo Caione
