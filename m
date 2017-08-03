From: david.wu@rock-chips.com (David.Wu)
Date: Thu, 3 Aug 2017 22:02:53 +0800
Subject: [PATCH v3 05/11] net: stmmac: dwmac-rk: Add internal phy support
In-Reply-To: <6b1ebf64-6903-6d35-b1fc-92ec47334425@gmail.com>
References: <1501654546-17292-1-git-send-email-david.wu@rock-chips.com>
 <1501654888-19514-1-git-send-email-david.wu@rock-chips.com>
 <6b1ebf64-6903-6d35-b1fc-92ec47334425@gmail.com>
Message-ID: <6cf4697e-7e94-0e14-a059-c80053492da3@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian & ChenYu

? 2017/8/3 1:38, Florian Fainelli ??:
> This is incorrect in two ways:
> 
> - this is a property of the PHY, so it should be documented as such in
> Documentation/devicetree/bindings/net/phy.txt so other bindings can
> re-use it
> 
> - if it was specific to your MAC you would expect a vendor prefix to
> this property, which is not there
> 
> An alternative way to implement the external/internal logic selection
> would be mandate that your Ethernet PHY node have a compatible string
> like this:
> 
> phy at 0 {
> 	compatible = "ethernet-phy-id1234.d400", "ethernet-phy-802.3-c22";
> };
> 
> Then you don't need this phy-is-internal property, because you can
> locate the PHY node by the phy-handle (see more about that in a reply to
> patch 10) and you can determine ahead of time whether this PHY is
> internal or not based on its compatible string.

We may implement a read_bool_property after parsed phy phandle at 
stmmac_platform.c, which would make MAC driver know it is a internal phy.
