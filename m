From: sjg@chromium.org (Simon Glass)
Date: Thu, 12 Jan 2012 13:48:10 -0800
Subject: [PATCH 7/9] arm/tegra: emc: device tree bindings
In-Reply-To: <1324599468-12845-8-git-send-email-olof@lixom.net>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-8-git-send-email-olof@lixom.net>
Message-ID: <CAPnjgZ2vLiNWTweDduMgpEF-Jeucszvef20p3abv0kk6Pj3XTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Thu, Dec 22, 2011 at 4:17 PM, Olof Johansson <olof@lixom.net> wrote:
> Device tree bindings for the EMC tables on tegra.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> ---
> ?.../devicetree/bindings/arm/tegra/emc.txt ? ? ? ? ?| ?100 ++++++++++++++++++++
> ?arch/arm/boot/dts/tegra20.dtsi ? ? ? ? ? ? ? ? ? ? | ? ?7 ++
> ?2 files changed, 107 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/arm/tegra/emc.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/tegra/emc.txt b/Documentation/devicetree/bindings/arm/tegra/emc.txt
> new file mode 100644
> index 0000000..09335f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/emc.txt
> @@ -0,0 +1,100 @@
> +Embedded Memory Controller
> +
> +Properties:
> +- name : Should be emc
> +- #address-cells : Should be 1
> +- #size-cells : Should be 0
> +- compatible : Should contain "nvidia,tegra20-emc".
> +- reg : Offset and length of the register set for the device
> +- nvidia,use-ram-code : If present, the sub-nodes will be addressed
> + ?and chosen using the ramcode board selector. If omitted, only one
> + ?set of tables can be present and said tables will be used
> + ?irrespective of ram-code configuration.
> +
> +Child device nodes describe the memory settings for different configurations and clock rates.
> +
> +Example:
> +
> + ? ? ? emc at 7000f400 {
> + ? ? ? ? ? ? ? #address-cells = < 1 >;
> + ? ? ? ? ? ? ? #size-cells = < 0 >;
> + ? ? ? ? ? ? ? compatible = "nvidia,tegra20-emc";
> + ? ? ? ? ? ? ? reg = <0x7000f4000 0x200>;

Minor point - that should be 0x7000f400.

Regards,
SImon
