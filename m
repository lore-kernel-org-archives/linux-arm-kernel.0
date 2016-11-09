From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 12:26:30 -0600
Subject: [PATCH v2 2/6] mfd: dt: Add bindings for the Aspeed SoC Display
 Controller (GFX)
In-Reply-To: <1478097481-14895-3-git-send-email-andrew@aj.id.au>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
 <1478097481-14895-3-git-send-email-andrew@aj.id.au>
Message-ID: <20161109182630.tg3puvwurgx6iinw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 01:07:57AM +1030, Andrew Jeffery wrote:
> The Aspeed SoC Display Controller is presented as a syscon device to
> arbitrate access by display and pinmux drivers. Video pinmux
> configuration on fifth generation SoCs depends on bits in both the
> System Control Unit and the Display Controller.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-gfx.txt | 17 +++++++++++++++++

The register space can't be split to 2 nodes? 

>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt b/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
> new file mode 100644
> index 000000000000..aea5370efd97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
> @@ -0,0 +1,17 @@
> +* Device tree bindings for Aspeed SoC Display Controller (GFX)
> +
> +The Aspeed SoC Display Controller primarily does as its name suggests, but also
> +participates in pinmux requests on the g5 SoCs. It is therefore considered a
> +syscon device.
> +
> +Required properties:
> +- compatible:		"aspeed,ast2500-gfx", "syscon"

I think perhaps we should drop the syscon here and the driver should 
just register as a syscon.

Rob
