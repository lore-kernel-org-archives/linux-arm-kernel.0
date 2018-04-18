From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Apr 2018 15:31:17 -0700
Subject: [PATCH v2] ARM: dts: BCM5301X: Make usb3 phy use mdio phy driver
In-Reply-To: <20180409223153.41893-1-npcomplete13@gmail.com>
References: <20180315135647.48456-1-npcomplete13@gmail.com>
 <20180409223153.41893-1-npcomplete13@gmail.com>
Message-ID: <68519de5-9a47-9cb5-064c-dc4703aaa508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2018 03:31 PM, Vivek Unune wrote:
> Currently, usb3 phy in bcm5301x.dtsi uses platform driver which
> requires register range "ccb-mii" <0x18003000 0x1000>. This range
> overlaps with mdio cmd and param registers (<0x18003000 0x8>).
> Essentially, the platform driver partly acts like a mdio bus
> driver, hence to use of this register range.
> 
> In some Northstar devices like Linksys EA9500, secondary switch
> is connected via external mdio. The only way to access and
> configure the external switch is via mdio bus. When we enable the
> mdio bus in it's current state, the mdio bus and any child buses
> fail to register because of the register range overlap.
> 
> On Northstar, the usb3 phy is connected at address 0x10 on the
> internal mdio bus. This change moves the usb3_phy node and makes
> it a child node of internal mdio bus.
> 
> Thanks to Rafa? Mi?ecki's commit af850e14a7ae
> ("phy: bcm-ns-usb3: add MDIO driver using proper bus layer") the
> same usb3 platform driver can now act as usb3 phy mdio driver.
> 
> Tested on Linksys Panamera (EA9500)
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> ---
> v2: Disabled usb3_phy by default, then enabled in dts where
>     necessary

Rafal, Hauke, this looks good to me, can you review? Thanks
-- 
Florian
