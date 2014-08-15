From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Aug 2014 09:05:22 +0200
Subject: [PATCH v2 4/5] ARM: BCM63XX: add BCM963138DVT Reference platform
 DTS
In-Reply-To: <1408061487-20984-5-git-send-email-f.fainelli@gmail.com>
References: <1408061487-20984-1-git-send-email-f.fainelli@gmail.com>
 <1408061487-20984-5-git-send-email-f.fainelli@gmail.com>
Message-ID: <1522800.uXzhrGiWzF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 August 2014 17:11:26 Florian Fainelli wrote:
> +/ {
> +       compatible = "brcm,BCM963138DVT", "brcm,bcm63138";
> +       model = "Broadcom BCM963138DVT";
> +
> +       memory {
> +               reg = <0x0 0x08000000>;
> +       };
> +
> +};
> +
> +&serial0 {
> +       status = "okay";
> +};
> +
> +&serial1 {
> +       status = "okay";
> +};
> 

You should probably add a 'stdout-path' property in the aliases node
to pick the uart that is used for the console. It might require
a change to the driver as well.

	Arnd
