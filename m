From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 09 Jan 2015 18:12:44 +0300
Subject: [PATCH v2 4/8] irqchip: devicetree: document Conexant Digicolor
 irq binding
In-Reply-To: <3bdf8fa0bf971b4881024e72312c3c9d29298e79.1420744369.git.baruch@tkos.co.il>
References: <cover.1420744368.git.baruch@tkos.co.il>
 <3bdf8fa0bf971b4881024e72312c3c9d29298e79.1420744369.git.baruch@tkos.co.il>
Message-ID: <54AFEFEC.5000300@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/8/2015 10:40 PM, Baruch Siach wrote:

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>   .../bindings/interrupt-controller/digicolor-ic.txt   | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
> new file mode 100644
> index 000000000000..fdf9a4c59bf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
> @@ -0,0 +1,20 @@
> +Conexant Digicolor Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : should be "cnxt,cx92755-ic"
> +- reg : Specifies base physical address and size of the MISC area, that is
> +  where the interrupt controller registers are located
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +
> +Example:
> +
> +	intc: intc at f0000000 {

    The node name should be "interrupt-controller at f0000000", according to the 
ePAPR standard, section 2.2.2.

[...]

WBR, Sergei
