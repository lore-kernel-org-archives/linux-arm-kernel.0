From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 21 Oct 2016 17:59:57 +0200
Subject: [RFC PATCH 08/13] dwmac-meson8b: add support for phy selection
In-Reply-To: <20161021155408.GR16974@lunn.ch>
References: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
 <1477060838-14164-9-git-send-email-narmstrong@baylibre.com>
 <20161021155408.GR16974@lunn.ch>
Message-ID: <dc810494-6ece-c4ae-d412-ed9af3fac9c2@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 05:54 PM, Andrew Lunn wrote:
> On Fri, Oct 21, 2016 at 04:40:33PM +0200, Neil Armstrong wrote:
>> The Meson GXL dwmac Glue Layer also provides switching between an external PHY
>> and an internal RMII 10/100 PHY.
>> Add a way to setup the correct PHY switching from a device tree attribute.
> 
> Humm, actually. Maybe PHY_IS_INTERNAL in the phydrv->flags is the
> better solution. The MAC can then use phy_is_internal(ndev->phydev) to
> decide if this register needs programming.
> 
>        Andrew
> 

Hi Andrew,

Yes this would be a good idea if we were able to scan the internal and external PHYs at the same time,
but with our limited knowledge the values we write in the register seems to switch a mux for the whole RMII
and MDIO signals to either interface.

Do you have knowledge if this case is already handled upstream ?

Thanks for your help,
Neil
