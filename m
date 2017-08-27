From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 27 Aug 2017 22:00:55 +0300
Subject: [PATCH v2 RESEND 1/2] dt-bindings: serial: 8250: Add MediaTek
 BTIF controller bindings
In-Reply-To: <29b52a3b95982f1097766d515aae09c57e11b002.1503165144.git.sean.wang@mediatek.com>
References: <cover.1503165144.git.sean.wang@mediatek.com>
 <29b52a3b95982f1097766d515aae09c57e11b002.1503165144.git.sean.wang@mediatek.com>
Message-ID: <8548a72a-4bf3-d44a-6d26-d64721cffe85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/19/2017 09:06 PM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Document the devicetree bindings in 8250.txt for MediaTek BTIF
> controller which could be found on MT7622 and MT7623 SoC.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   Documentation/devicetree/bindings/serial/8250.txt | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
> index 419ff6c..7528d90 100644
> --- a/Documentation/devicetree/bindings/serial/8250.txt
> +++ b/Documentation/devicetree/bindings/serial/8250.txt
> @@ -14,6 +14,9 @@ Required properties:
>   	  tegra132, or tegra210.
>   	- "nxp,lpc3220-uart"
>   	- "ralink,rt2880-uart"
> +	- For MediaTek MT7623, must contain "mediatek,mt7623-btif"
> +	- For other MediaTek SoCs , must contain "mediatek,<chip>-btif",
> +	  "mediatek,mt7623-btif" where <chip> is mt7622.

Hm, to me that's confusing. What about:
"mediatek,mt7623-btif": for MediaTek MT7623
"mediatek,mt7622-btif", "mediatek,mt7623-btif": for MediaTek MT7622

If in the future we have more SoCs that support the BTIF, we should add them 
like the mt7622 case.

Make sense?

Regards,
Matthias
