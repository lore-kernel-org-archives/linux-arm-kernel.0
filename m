From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 29 Mar 2018 16:03:27 -0400
Subject: [net-next PATCH v2 08/10] net: netcp: ethss: use
 of_get_phy_mode() to support different RGMII modes
In-Reply-To: <20180327173509.GQ5862@lunn.ch>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
 <1522168309-12338-9-git-send-email-m-karicheri2@ti.com>
 <20180327173509.GQ5862@lunn.ch>
Message-ID: <1b12754d-38b5-d03a-3ba8-90135ad3ead0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2018 01:35 PM, Andrew Lunn wrote:
>> +	} else if (slave->link_interface == RGMII_LINK_MAC_PHY) {
>> +		has_phy = true;
>> +		phy_mode = of_get_phy_mode(slave->node);
>> +		/* if phy-mode is not present, default to
>> +		 * PHY_INTERFACE_MODE_RGMII
>> +		 */
>> +		if (phy_mode < 0)
>> +			phy_mode = PHY_INTERFACE_MODE_RGMII;
> 
> Can only do RGMII? Maybe add a call here to
> phy_interface_mode_is_rgmii() and return -EINVAL if DT contains
> something which is not RGMII?
> 
Ok. Make sense.

> 	  Andrew
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
