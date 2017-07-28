From: david.wu@rock-chips.com (David.Wu)
Date: Fri, 28 Jul 2017 16:19:52 +0800
Subject: [PATCH v2 01/11] net: phy: Add rockchip phy driver support
In-Reply-To: <807c43ee-8421-c0b3-8aea-6091bef07a4c@gmail.com>
References: <1501160156-30328-1-git-send-email-david.wu@rock-chips.com>
 <1501160156-30328-2-git-send-email-david.wu@rock-chips.com>
 <807c43ee-8421-c0b3-8aea-6091bef07a4c@gmail.com>
Message-ID: <c92ffbe9-dfb0-0fd7-680d-699c31902534@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

? 2017/7/28 0:51, Florian Fainelli ??:
>> +}
>> +
>> +static int rockchip_internal_phy_config_init(struct phy_device *phydev)
>> +{
>> +	int val;
>> +
>> +	/*
>> +	 * The auto MIDX has linked problem on some board,
>> +	 * workround to disable auto MDIX.
>> +	 */
> If this a board-specific problem you may consider register a PHY fixup
> for the affected boards, or introduce a specific property to illustrate
> that MDI-X is broken.

You mean is that if I need disable Auto-mdix, then I'm going to add a 
property to DTS, from here to decide whether or not to close Auto-mdix?

> 
