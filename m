From: david.wu@rock-chips.com (David.Wu)
Date: Fri, 28 Jul 2017 14:56:03 +0800
Subject: [PATCH v2 05/11] net: stmmac: dwmac-rk: Add internal phy support
In-Reply-To: <65ae1747-4dff-b1d8-8aa3-684fc8c7809a@gmail.com>
References: <1501160156-30328-1-git-send-email-david.wu@rock-chips.com>
 <1501160540-30662-1-git-send-email-david.wu@rock-chips.com>
 <20170727134834.GD18666@lunn.ch>
 <65ae1747-4dff-b1d8-8aa3-684fc8c7809a@gmail.com>
Message-ID: <69ad9443-ff65-8e49-df68-7e5e6c812d45@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

? 2017/7/28 0:54, Florian Fainelli ??:
> - if you need knowledge about this PHY connection type prior to binding
> the PHY device and its driver (that is, before of_phy_connect()) we
> could add a boolean property e.g: "phy-is-internal" that allows us to
> know that, or we can have a new phy-mode value, e.g: "internal-rmii"
> which describes that, either way would probably be fine, but the former
> scales better
> 

Using "phy-is-internal" is very helpful, but it is easy to confuse with 
the real internal PHY, may we use the other words like phy is inlined?.

> Then again, using phy-mode = "internal" even though this is Reduced MII
> is not big of a deal IMHO as long as there is no loss of information and
> that internal de-facto means internal reduced MII for instance.
> -- 
