From: Rob Herring <robh@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: ath9k-devel at lists.ath9k.org, devicetree at vger.kernel.org,
	linux-wireless at vger.kernel.org, ath9k-devel at qca.qualcomm.com,
	mcgrof at do-not-panic.com, mark.rutland at arm.com, kvalo at codeaurora.org,
	chunkeey at googlemail.com, arend.vanspriel at broadcom.com,
	julian.calaby at gmail.com, bjorn at mork.no, linux at rempel-privat.de,
	nbd at nbd.name
Subject: Re: [PATCH v7 1/3] Documentation: dt: net: add ath9k wireless device
 binding
Message-ID: <20161008225056.GA25449@rob-hp-laptop>
References: <20160906214623.20424-1-martin.blumenstingl@googlemail.com>
 <20161002214743.2263-1-martin.blumenstingl@googlemail.com>
 <20161002214743.2263-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161002214743.2263-2-martin.blumenstingl@googlemail.com>
Date: Sat, 8 Oct 2016 17:50:58 -0500
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2016 at 11:47:41PM +0200, Martin Blumenstingl wrote:
> Add documentation how devicetree can be used to configure ath9k based
> devices.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/net/wireless/qca,ath9k.txt | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
> new file mode 100644
> index 0000000..9b58ede
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
> @@ -0,0 +1,30 @@
> +* Qualcomm Atheros ath9k wireless devices
> +
> +This node provides properties for configuring the ath9k wireless device. The
> +node is expected to be specified as a child node of the PCI controller to
> +which the wireless chip is connected.
> +
> +Required properties:
> +- compatible: For PCI and PCIe devices this should be an identifier following
> +		the format as defined in "PCI Bus Binding to Open Firmware"
> +		Revision 2.1. One of the possible formats is "pciVVVV,DDDD"
> +		where VVVV is the PCI vendor ID and DDDD is PCI device ID.

Are there some known values you can document here? Like the one in the 
example.

> +- reg: Address and length of the register set for the device.
> +
> +Optional properties:
> +- qca,no-eeprom: Indicates that there is no physical EEPROM connected to the
> +			ath9k wireless chip (in this case the calibration /
> +			EEPROM data will be loaded from userspace using the
> +			kernel firmware loader).
> +- mac-address: See ethernet.txt in the parent directory
> +- local-mac-address: See ethernet.txt in the parent directory
> +
> +
> +In this example, the node is defined as child node of the PCI controller:
> +&pci0 {
> +	ath9k at 168c,002d {

wifi at ...

> +		compatible = "pci168c,002d";
> +		reg = <0x7000 0 0 0 0x1000>;
> +		qca,no-eeprom;
> +	};
> +};
> -- 
> 2.10.0
> 
