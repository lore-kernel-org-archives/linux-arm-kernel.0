From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 10 Oct 2018 09:19:14 +0000
Subject: [PATCH 32/36] dt-bindings: arm: Convert ST STi board/soc bindings
 to json-schema
In-Reply-To: <20181005165848.3474-33-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-33-robh@kernel.org>
Message-ID: <34e8ddcb-4b33-9082-b242-9ab2dee8eb7c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

On 10/05/2018 06:58 PM, Rob Herring wrote:
> Convert ST STi SoC bindings to DT schema format using json-schema.
> 
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/sti.txt | 23 -------------------
>  .../devicetree/bindings/arm/sti.yaml          | 23 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/sti.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/sti.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/sti.txt b/Documentation/devicetree/bindings/arm/sti.txt
> deleted file mode 100644
> index 8d27f6b084c7..000000000000
> --- a/Documentation/devicetree/bindings/arm/sti.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -ST STi Platforms Device Tree Bindings
> ----------------------------------------
> -
> -Boards with the ST STiH415 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih415";
> -
> -Boards with the ST STiH416 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih416";
> -
> -Boards with the ST STiH407 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih407";
> -
> -Boards with the ST STiH410 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih410";
> -
> -Boards with the ST STiH418 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih418";
> -
> diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
> new file mode 100644
> index 000000000000..10814334cfc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sti.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: None
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/arm/sti.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST STi Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Maxime Coquelin <maxime.coquelin@st.com>

Maxime has left STMicroelectronics, you can replace its email by mine
Patrice Chotard <patrice.chotard@st.com>


Thanks

Patrice

> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    items:
> +      - enum:
> +          - st,stih415
> +          - st,stih416
> +          - st,stih407
> +          - st,stih410
> +          - st,stih418
> +...
> 
