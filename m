From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 08 Mar 2018 13:01:35 +0900
Subject: [PATCH] dt-bindings: exynos: Document #sound-dai-cells property
 of the HDMI node
In-Reply-To: <20180307171111.14551-1-s.nawrocki@samsung.com>
References: <CGME20180307171131epcas1p4687ef394d1a0a6d0eb2de2691c977c3f@epcas1p4.samsung.com>
 <20180307171111.14551-1-s.nawrocki@samsung.com>
Message-ID: <5AA0B59F.3070402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

2018? 03? 08? 02:11? Sylwester Nawrocki ?(?) ? ?:
> The #sound-dai-cells DT property is required to describe link between
> the HDMI IP block and the SoC's audio subsystem.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
> index 8715ff06c457..6b2a526ec586 100644
> --- a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
> +++ b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
> @@ -50,6 +50,9 @@ Required properties for Exynos 5433:
>  - clock-names: aliases for above clock specfiers.
>  - samsung,sysreg: handle to syscon used to control the system registers.
>  
> +Optional properties for Exynos 4210, 4212, 5420 and 5433:
> + - #sound-dai-cells: should be 0.
> +

Just trivial question. 'sound-dai-cells' property could affect hdmi driver? I looked into HDMI codec driver but I didn't find relevat code.
I mean that if this property never affect HDMI driver then this property would be a dead thing even through this can be declared optionally.

Thanks,
Inki Dae

>  Example:
>  
>  	hdmi {
> 
