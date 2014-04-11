From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 11 Apr 2014 14:33:18 +0800
Subject: [PATCH RESEND 4/5] Documentation: add the Marvell Berlin
 pinctrl documentation
In-Reply-To: <1397135274-10764-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140411143318.67e55a17@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Apr 2014 06:07:53 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  .../bindings/pinctrl/marvell,berlin-pinctrl.txt    | 43
> ++++++++++++++++++++++ 1 file changed, 43 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt
> b/Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt new
> file mode 100644 index 000000000000..e21538a37734 --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt
> @@ -0,0 +1,43 @@
> +* Pinctrl driver for the Marvell Berlin SoCs
> +
> +The pins controlled by the Marvell Berlin controller are organized in
> groups. +Configuration is done by group, so no actual pin information is
> needed. +
> +Required properties:
> +- compatible:	"marvell-berlin2cd-pinctrl",
> +		"marvell-berlin2-pinctrl",
> +		"marvell-berlin2q-pinctrl"
> +- reg: registers physical addresses and lengths of the pin controller.
> +- reg-names: name of the register regions.
> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices.
> +
> +A pinctrl should contains subnodes representing the pinctrl pin group
> +configurations, one per group. Each subnode has the group name and the
> muxing +function used.
> +
> +Required subnode-properties:
> +- berlin,group: a string describing the group's name.
> +- berlin,function: the function used to mux the group.

Would it be better to s/function/mode? Because in mrvl internal technology
discussion and docs, we usually say "set pinmux Gy as mode z".


Thanks,
Jisheng
