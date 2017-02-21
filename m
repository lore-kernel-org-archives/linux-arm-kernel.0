From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Feb 2017 11:16:21 +0800
Subject: [PATCH 1/2] dts: mfd: axp20x: Add xpowers,master-mode property
 for AXP806 PMICs
In-Reply-To: <112c3e4aa625ce2c550ae7ae4446a61d058455b5.1487428238.git.rask@formelder.dk>
References: <cover.1487428238.git.rask@formelder.dk>
 <112c3e4aa625ce2c550ae7ae4446a61d058455b5.1487428238.git.rask@formelder.dk>
Message-ID: <CAGb2v66RCFt9x1r16UNZDTow7R-Donix5oxtfjm4BG_58R1VCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 19, 2017 at 3:51 AM, Rask Ingemann Lambertsen
<rask@formelder.dk> wrote:
> commit b101829a029a ("mfd: axp20x: Fix AXP806 access errors on cold boot")
> was intended to fix the case where a board uses an AXP806 in slave mode,
> but the boot loader leaves it in master mode for lack of AXP806 support.
> But now the driver breaks on boards where the PMIC is operating in master
> mode. To let the device tree describe which mode of operation is needed,
> this patch introduces a new property "xpowers,master-mode".
>
> Fixes: b101829a029a ("mfd: axp20x: Fix AXP806 access errors on cold boot")

I think this should point to the original commit that added support
for the AXP806.

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 86ae540..9af3457 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -29,6 +29,9 @@ Optional properties:
>                   regulator to drive the OTG VBus, rather then as an input pin
>                   which signals whether the board is driving OTG VBus or not.
>
> +- x-powers,master-mode: Boolean (axp806 only). Set this when the PMIC is
> +                       wired for master mode. The default is slave mode.
> +
>  - <input>-supply: a phandle to the regulator supply node. May be omitted if
>                   inputs are unregulated, such as using the IPSOUT output
>                   from the PMIC.
> --
> 2.10.2
>
