From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 08:18:41 -0500
Subject: [PATCH v3 1/4] net: phy: dp83867: Add documentation for optional
 impedance control
In-Reply-To: <20161006051355.15947-2-mugunthanvnm@ti.com>
References: <20161006051355.15947-1-mugunthanvnm@ti.com>
 <20161006051355.15947-2-mugunthanvnm@ti.com>
Message-ID: <20161010131841.GA8391@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2016 at 10:43:52AM +0530, Mugunthan V N wrote:
> Add documention of ti,impedance-control which can be used to

Needs updating.

> correct MAC impedance mismatch using phy extended registers.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83867.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.txt b/Documentation/devicetree/bindings/net/ti,dp83867.txt
> index 5d21141..85bf945 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83867.txt
> +++ b/Documentation/devicetree/bindings/net/ti,dp83867.txt
> @@ -9,6 +9,18 @@ Required properties:
>  	- ti,fifo-depth - Transmitt FIFO depth- see dt-bindings/net/ti-dp83867.h
>  		for applicable values
>  
> +Optional property:
> +	- ti,min-output-impedance - MAC Interface Impedance control to set
> +				    the programmable output impedance to
> +				    minimum value (35 ohms).
> +	- ti,max-output-impedance - MAC Interface Impedance control to set
> +				    the programmable output impedance to
> +				    maximum value (70 ohms).

Define what are valid range of values for these.

> +
> +Note: ti,min-output-impedance and ti,max-output-impedance are mutually
> +      exclusive. When both properties are present ti,max-output-impedance
> +      takes precedence.
> +
>  Default child nodes are standard Ethernet PHY device
>  nodes as described in Documentation/devicetree/bindings/net/phy.txt
>  
> -- 
> 2.10.0.372.g6fe1b14
> 
