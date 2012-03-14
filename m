From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 14 Mar 2012 08:07:28 +0100
Subject: [PATCH 2/7] of: add clock providers
In-Reply-To: <1331680947-29861-3-git-send-email-robherring2@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-3-git-send-email-robherring2@gmail.com>
Message-ID: <20120314070728.GC2659@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring wrote:
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
[...]
> +clock-output-names: Recommended to be a list of strings of clock output signal
> +		    names indexed by the first cell in the clock specifier.
> +		    However, the meaning of clock-output-name is domain

"clock-output-names"?

> +		    specific to the clock provider, and is only provided to
> +		    encourage using the same meaning for the majority of clock
> +		    providers.  This format may not work for clock providers
> +		    using a complex clock specifier format.  In those cases it
> +		    is recommended to omit this property and create a binding
> +		    specific names property.
> +
> +		    Clock consumer nodes must never directly reference
> +		    the provider's clock-output-name property.

Ditto.

[...]
> diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.txt b/Documentation/devicetree/bindings/clock/fixed-clock.txt
> new file mode 100644
> index 0000000..9a75342
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fixed-clock.txt
> @@ -0,0 +1,21 @@
> +Binding for simple fixed-rate clock sources.
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/fixed-clock.txt

This document references itself.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120314/f733a8bd/attachment.sig>
