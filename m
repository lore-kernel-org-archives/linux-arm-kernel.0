From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Dec 2016 14:54:24 -0800
Subject: [PATCH 10/11] Document: dt: binding: imx: update doc for imx6sll
In-Reply-To: <1480660774-25055-11-git-send-email-ping.bai@nxp.com>
References: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
 <1480660774-25055-11-git-send-email-ping.bai@nxp.com>
Message-ID: <20161208225424.GQ5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02, Bai Ping wrote:
> Add necessary document update for i.MX6SLL support.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx6sll-clock.txt    | 13 ++++++++
>  .../bindings/pinctrl/fsl,imx6sll-pinctrl.txt       | 37 ++++++++++++++++++++++

Please split the bindings into different patches and put them
closer to the drivers that use them in the series.

>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6sll-clock.txt b/Documentation/devicetree/bindings/clock/imx6sll-clock.txt
> new file mode 100644
> index 0000000..4f52efa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx6sll-clock.txt
> @@ -0,0 +1,13 @@
> +* Clock bindings for Freescale i.MX6 UltraLite
> +
> +Required properties:
> +- compatible: Should be "fsl,imx6sll-ccm"
> +- reg: Address and length of the register set
> +- #clock-cells: Should be <1>
> +- clocks: list of clock specifiers, must contain an entry for each required
> +  entry in clock-names
> +- clock-names: should include entries "ckil", "osc", "ipp_di0" and "ipp_di1"
> +
> +The clock consumer should specify the desired clock by having the clock
> +ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6sll-clock.h
> +for the full list of i.MX6 SLL clock IDs.

Can you add an example node here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
