From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 10 Jun 2014 16:30:49 +0530
Subject: [PATCH 1/4] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <1400766819-22286-2-git-send-email-lee.jones@linaro.org>
References: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
 <1400766819-22286-2-git-send-email-lee.jones@linaro.org>
Message-ID: <5396E561.4020805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 22 May 2014 07:23 PM, Lee Jones wrote:
> The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> devices. It has 2 ports which it can use for either; both SATA, both
> PCIe or one of each in any configuration.

I've asked others who wrote multi-phy PHY providers to model each individual
PHY as sub-node of the PHY provider. So It's only fair I ask you the same to
do. So in this case the dt node should look something like:

	miphy365x_phy: miphy365x at fe382000 {
		compatible = "st,miphy365x-phy";
		#phy-cells = <2>;
		st,syscfg = <&syscfg_rear>;
		channel at 0 {
			reg =	<0xfe382000 0x100>, <0xfe394000 0x100>;
			reg-names = "sata", "pcie";
		}

		channel at 1{
			reg =	<0xfe38a000 0x100>, <0xfe804000 0x100>;
			reg-names = "sata", "pcie";
		}

	};

Thanks
Kishon
