From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jul 2016 00:22:09 +0200
Subject: [PATCH v2 09/10] Documentation: devicetree: Add dts description
 for nuc900
In-Reply-To: <1468136542-2656-2-git-send-email-vw@iommu.org>
References: <1468136542-2656-1-git-send-email-vw@iommu.org>
 <1468136542-2656-2-git-send-email-vw@iommu.org>
Message-ID: <1618088.N8H7ez3XRZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 10, 2016 3:42:21 PM CEST Wan Zongshun wrote:
> diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,nuc900-soc.txt b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,nuc900-soc.txt
> new file mode 100644
> index 0000000..0284edf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,nuc900-soc.txt
> @@ -0,0 +1,12 @@
> +. Nuvoton NUC900 series, Soc specific driver binding.
> +
> +Required properties:
> +- compatible : Should be "nuvoton,nuc900-soc"
> +- syscon : Reference to gcr controller.
> +
> +Example:
> +
> +reset {
> +       compatible = "nuvoton,nuc900-soc";
> +       syscon = <&gcr>;
> +};

I think this one should be dropped: Instead of modeling the DT based on what
is convenient for the current Linux driver implementation, we only want to
list devices in the dts that are physically present, and the "soc" is really
the sum of all the on-chip devices.

Better change the soc_device driver to bind directly to the "nuvoton,nuc970-gcr"
device.

	Arnd
