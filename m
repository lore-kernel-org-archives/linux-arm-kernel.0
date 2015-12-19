From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Dec 2015 23:48:48 +0000
Subject: [PATCH 2/3] arm: dts: phy3250: add SD fixed regulator
In-Reply-To: <1450567932-22994-3-git-send-email-vz@mleia.com>
References: <1450567932-22994-1-git-send-email-vz@mleia.com>
 <1450567932-22994-3-git-send-email-vz@mleia.com>
Message-ID: <20151219234848.GT8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 20, 2015 at 01:32:11AM +0200, Vladimir Zapolskiy wrote:
> @@ -162,6 +171,7 @@
>  				cd-gpios = <&gpio 3 1 0>;
>  				cd-inverted;
>  				bus-width = <4>;
> +				vqmmc-supply = <&sd_reg>;

This looks wrong.  ios->power_mode controls the _card_ power (which is
vmmc-supply), not the signalling power (which is vqmmc-supply):

- vmmc-supply            : phandle to the regulator device tree node, mentioned
                           as the VCC/VDD supply in the eMMC/SD specs.

- vqmmc-supply           : phandle to the regulator device tree node, mentioned
                           as the VCCQ/VDD_IO supply in the eMMC/SD specs.


-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
