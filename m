From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 15:40:14 -0500
Subject: [PATCH v0 04/10] arm: orion5x: Generalise mv88f5181l pinctrl
 support for 88f5181
In-Reply-To: <1468679348-10522-5-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1468679348-10522-5-git-send-email-jm@lentin.co.uk>
Message-ID: <20160717204014.GA16350@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 03:29:02PM +0100, Jamie Lentin wrote:
> As far as I'm aware the mv88f5181-b1 and mv88f5181l are the same at the
> pinctrl level, so re-use the definitions for both.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  .../bindings/pinctrl/marvell,orion-pinctrl.txt     |  4 ++--
>  drivers/pinctrl/mvebu/pinctrl-orion.c              | 23 +++++++++++-----------
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
> index 27570a3..5a79bad 100644
> --- a/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
> @@ -4,8 +4,8 @@ Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
>  part and usage.
>  
>  Required properties:
> -- compatible: "marvell,88f5181l-pinctrl", "marvell,88f5182-pinctrl",
> -              "marvell,88f5281-pinctrl"
> +- compatible: "marvell,88f5181-pinctrl", "marvell,88f5181l-pinctrl",
> +              "marvell,88f5182-pinctrl", "marvell,88f5281-pinctrl"

Please reformat to one per line. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>


>  
>  - reg: two register areas, the first one describing the first two
>    contiguous MPP registers, and the second one describing the single
