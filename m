From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 28 Jul 2014 18:54:18 +0100
Subject: [PATCH v15 06/12] document: dt: add the binding on HiP04 clock
In-Reply-To: <1406555876-11989-7-git-send-email-haojian.zhuang@linaro.org>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140728175418.GD2576@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 02:57:50PM +0100, Haojian Zhuang wrote:
> The DT binding for Hisilicon HiP04 clock driver.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  .../devicetree/bindings/clock/hip04-clock.txt        | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hip04-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/hip04-clock.txt b/Documentation/devicetree/bindings/clock/hip04-clock.txt
> new file mode 100644
> index 0000000..4d31ae3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/hip04-clock.txt
> @@ -0,0 +1,20 @@
> +* Hisilicon HiP04 Clock Controller
> +
> +The HiP04 clock controller generates and supplies clock to various
> +controllers within the HiP04 SoC.
> +
> +Required Properties:
> +
> +- compatible: should be one of the following.
> +  - "hisilicon,hip04-clock" - controller compatible with HiP04 SoC.

There's only one clock controller on-board and it's custom for HiP04?

> +
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +- #clock-cells: should be 1.
> +
> +
> +Each clock is assigned an identifier and client nodes use this identifier
> +to specify the clock which they consume.
> +
> +All these identifier could be found in <dt-bindings/clock/hip04-clock.h>.

This must come in the same patch.

Mark.
