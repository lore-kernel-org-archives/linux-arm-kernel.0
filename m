From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 13:49:10 +0000
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <550A4382.4030209@gmail.com>
References: <550A42AC.8060104@gmail.com>
 <550A4382.4030209@gmail.com>
Message-ID: <20150319134910.GF18473@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 03:33:22AM +0000, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@sonymobile.com>
> 
> Add /chosen/dtb-node binding.

Why? It doesn't matter what the cover says, the commit message should
have a rationale.

Who needs this information, and when do they need it?

Why is the existing information insufficient?

> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt |   37 +++++++++++
> 
> Index: b/Documentation/devicetree/bindings/chosen.txt
> ===================================================================
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -46,6 +46,43 @@ on PowerPC "stdout" if "stdout-path" is
>  should only use the "stdout-path" property.
>  
>  
> +dtb-info node
> +----------------
> +
> +Information that describes where the device tree blob (DTB) came from and the
> +environment it was created in.
> +
> +This node is normally created by including arch/arm/boot/dts/skeleton.dtsi,
> +which includes include/dt-bindings/version.dtsi.
> +
> +Properties:
> +
> +version
> +	The version of the DTB.  This is analagous to the linux kernel version.
> +
> +	This is a format free field intended for human consumption.  User space
> +	programs should not have any expections about this property.

I doubt that this would stay the case for long were this property added.

> +	The DTB number in this property is incremented each time a make that
> +	creates one or more DTBs is invoked.  If the make creates multiple
> +	DTBs then this number is only incremented once.
> +
> +	The DTB number is stored in file .version_dtb.

This is irrelevant to the binding, and as you mention above, you can
make no expectations about this property.

I'm not sure I see the point in adding a property which is not
well-defined and not guarnateed to be in any way stable.

> +
> +version-linux
> +	The version of the linux kernel most recently built in the source
> +	control system that contains the source used to build the DTB.
> +
> +	The linux kernel version number is not incremented for a make that
> +	creates a DTB.

...so if I build a DTB outside of a linux source tree I don't get to
describe that?

> +dtb-path
> +	The build directory relative path of the DTB.
> +
> +dts-path
> +	The absolute path of the .dts file compiled to create the DTB.

Why do you need the DTB path?

Why do these differ w.r.t. absolute/relative?

Why would you _ever_ need an absolute path!?

Mark.
