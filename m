From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 16 Dec 2015 20:04:31 +0100
Subject: [PATCH v3] net/macb: add support for resetting PHY using GPIO
In-Reply-To: <1450290690-32369-1-git-send-email-gregory.clement@free-electrons.com>
References: <1450290690-32369-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20151216190431.GB28759@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 07:31:30PM +0100, Gregory CLEMENT wrote:
> +Optional properties for PHY child node:
> +- reset-gpios : Should specify the gpio for phy reset

reset-gpios plural or reset-gpio singular?

> +
>  Examples:
>  
>  	macb0: ethernet at fffc4000 {
> @@ -29,4 +32,8 @@ Examples:
>  		local-mac-address = [3a 0e 03 04 05 06];
>  		clock-names = "pclk", "hclk", "tx_clk";
>  		clocks = <&clkc 30>, <&clkc 30>, <&clkc 13>;
> +		ethernet-phy at 1 {
> +			reg = <0x1>;
> +			reset-gpios = <&pioE 6 1>;

Did you mean "gpioE" ?

Thanks,
Richard
