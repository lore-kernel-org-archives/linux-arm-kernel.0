From: robh@kernel.org (Rob Herring)
Date: Wed, 11 Jul 2018 14:04:50 -0600
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
In-Reply-To: <20180711053122.30773-2-andrew@aj.id.au>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
Message-ID: <20180711200450.GB17291@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> Baseboard Management Controllers (BMCs) are embedded SoCs that exist to
> provide remote management of (primarily) server platforms. BMCs are
> often tightly coupled to the platform in terms of behaviour and provide
> many hardware features integral to booting and running the host system.
> 
> Some of these hardware features are simple, for example scratch
> registers provided by the BMC that are exposed to both the host and the
> BMC. In other cases there's a single bit switch to enable or disable
> some of the provided functionality.
> 
> The documentation defines bindings for fields in registers that do not
> integrate well into other driver models yet must be described to allow
> the BMC kernel to assume control of these features.

So we'll get a new binding when that happens? That will break 
compatibility.

> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> 
> Since RFC v1:
> 
> * Add a commit message
> * Minor changes to documented labels
> 
>  .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 258 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> new file mode 100644
> index 000000000000..2c869fcc7ef2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> @@ -0,0 +1,252 @@
> +BMC Miscellaneous Control Interfaces
> +====================================
> +
> +Baseboard Management Controllers (BMCs) often have an array of hardware
> +features that need to be described but are awkward to sensibly expose.
> +
> +This bindings document provides a generic mechanism for describing such
> +features, covering read-only (RO), read-modify-write (RMW) and
> +write-1-set/write-1-clear (W1SC) semantics.

If we wanted a generic mechanism for single register bits/fields in DT, 
we'd have one already. A node per register bit doesn't scale.

Maybe this should be modelled using GPIO binding? There's a line there 
too as whether the signals are "general purpose" or not.

Rob
