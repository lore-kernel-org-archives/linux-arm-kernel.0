From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 27 Aug 2018 22:35:00 +0200
Subject: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
In-Reply-To: <20180827200344.16158-2-f.fainelli@gmail.com>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
 <20180827200344.16158-2-f.fainelli@gmail.com>
Message-ID: <20180827203500.GN27483@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -210,6 +228,17 @@
>  			reg = <4>;
>  		};
>  
> +		port at 5 {
> +			label = "sfp";
> +			phy-mode = "sgmii";
> +			reg = <5>;
> +			sfp = <&sfp>;
> +			fixed-link {
> +				speed = <1000>;
> +				full-duplex;
> +			};

Hi Florian

You might want to add a comment about why you are using fixed-link and
sgmii, which seems very odd. Is it even correct?

       Andrew
