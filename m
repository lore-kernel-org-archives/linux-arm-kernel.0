From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 21 Nov 2018 15:11:00 +0530
Subject: [RFC PATCH 0/6] Armada 38x comphy driver to support 2.5Gbps
 networking
In-Reply-To: <20181114105606.GR30658@n2100.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <f0e71064-6919-6f7f-d605-671a1c662a33@ti.com>
 <20181114105606.GR30658@n2100.armlinux.org.uk>
Message-ID: <2d473b33-4b49-c208-51b0-2c6b5cb35d79@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 14/11/18 4:26 PM, Russell King - ARM Linux wrote:
> On Wed, Nov 14, 2018 at 01:39:29PM +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On 12/11/18 5:59 PM, Russell King - ARM Linux wrote:
>>> Hi,
>>>
>>> This series adds support for dynamically switching between 1Gbps
>>> and 2.5Gbps networking for the Marvell Armada 38x SoCs, tested on
>>> Armada 388 on the Clearfog platform.
>>>
>>> This is necessary to be able to connect (eg) a Clearfog platform
>>> with a Macchiatobin platform via the SFP sockets, as Clearfog
>>> currently only supports 1Gbps networking via the SFP socket and
>>> Macchiatobin defaults to 2.5Gbps when using Fiberchannel SFPs.
>>>
>>> In order to allow dynamic switching, we need to implement a common
>>> phy driver to switch the ethernet serdes lane speed - 2.5Gbps is
>>> just 1Gbps up-clocked by 2.5x.  We implement a simple comphy
>>> driver to achieve this, which only supports networking.
>>>
>>> With this, we are able to support both Fiberchannel SFPs operating
>>> at 2.5Gbps or 1Gbps, and 1G ethernet SFPs plugged into the Clearfog
>>> platform, dynamically selecting according to the SFPs abilities.
>>>
>>> I'm aware of the proposed changes to the PHY layer, changing
>>> phy_set_mode() to take the ethernet phy interface type, hence why
>>> this is RFC - there's also the question about how this will be
>>> merged.  This series is currently based on 4.20-rc1, but will
>>> likely need to be rebased when the PHY layer changes hit.
>>
>> For this case, I'd prefer the phy_set_mode series and the phy and net changes
>> here (after rebasing) go via linux-phy tree.
> 
> Please let me know when they've hit, thanks.

I've merged the phy_set_mode series to linux-phy -next.

Thanks
Kishon
> 
