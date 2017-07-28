From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 28 Jul 2017 10:54:30 -0700
Subject: [PATCH 0/3] net-next: stmmac: support future possible different
 internal phy mode
In-Reply-To: <20170728144424.GB7221@Red>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
 <20170728135544.GD32230@lunn.ch> <20170728142508.GA7221@Red>
 <20170728143600.GB2132@lunn.ch> <20170728144424.GB7221@Red>
Message-ID: <f8fe754c-8b46-a9f6-4020-f7db6c985773@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2017 07:44 AM, Corentin Labbe wrote:
> On Fri, Jul 28, 2017 at 04:36:00PM +0200, Andrew Lunn wrote:
>>>> I've probably asked this before: Does the internal PHY use a different
>>>> PHY ID in registers 2 and 3?
>>>>
>>>
>>> yes
>>>
>>> reg2: 0x0044
>>> reg3: 0X1500
> 
> Copy/paste error, its 1400
> 
>>
>> So this is not about loading the correct PHY driver. You can already
>> do this based on the PHY IDs...
>>
>> This is about selecting which PHY to use. Internal or External?	
>>
>>      Andrew
> 
> It is too late when we know the PHY ID.

> We need to set a syscon for choosing external/internal PHY.
> So we can rely only on DT.

Since the Device Tree needs to be correct to identify which PHY to use
(internal or external), if you use the standard compatible string for
the PHY that contains its OUI, e.g:

compatible = "ethernet-phy-id0044.1400", "ethernet-phy-ieee802.3-c22"

then you can have your Ethernet MAC identify whether this is an internal
PHY by having a list of compatible strings to match against.

Corentin, can you make sure you copy netdev, Andrew and myself on the
next submissions so we don't have to keep track of seemingly identical
threads (this one + the rockchip dwmac changes) and we can work towards
one solution?

Thanks
-- 
Florian
