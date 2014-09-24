From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 24 Sep 2014 11:00:34 +0000
Subject: [PATCHv4 3/6] ARM: dts: Add initial LS1021A TWR board dts support
In-Reply-To: <4264466.HtkUxyxBW8@wuerfel>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <3321146.kBfn28qbNM@wuerfel>
 <a83d5601a26b4e45be5e5016de287287@BL2PR03MB467.namprd03.prod.outlook.com>
 <4264466.HtkUxyxBW8@wuerfel>
Message-ID: <bb122a232a1c40559e84a058f3d003b4@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd at arndb.de]
>Sent: Wednesday, September 24, 2014 5:36 PM
>To: Lu Jingchang-B35083
>Cc: Guo Shawn-R65073; mark.rutland at arm.com; linux-arm-
>kernel at lists.infradead.org; devicetree at vger.kernel.org; Lu Chen-B46807; Fu
>Chao-B44548
>Subject: Re: [PATCHv4 3/6] ARM: dts: Add initial LS1021A TWR board dts
>support
>
>On Wednesday 24 September 2014 05:47:53 Jingchang Lu wrote:
>>
>> The ethernet device nodes already have the phy-handle properties to
>their mdio nodes.
>>
>> The alias for PHY nodes here is:
>>   The ethernet has two kind of PHY interface, one is SGMII, and the
>> other is RGMII, The selection is done by the reset configuration
>> word(RCW), so Phy-handle properties should be change properly to
>> reflecting the PHY interface selection. This is done by fixing up dtb
>> in u-boot before booting the kernel. Thus the alias for PHY nodes is
>added here for fdt finding the PHY nodes easily.
>
>Ok, I see. I thought that this was what the labels in the dtb were
>supposed to be used for. Can't you do the same thing in u-boot by using a
>label as opposed to the alias?
>
>IIRC you should be able to add an additional label like
>
>+&mdio0 {
>+       enet1_sgmii_phy: sgmii_phy0: ethernet-phy at 0 {
>+               reg = <0x0>;
>+       };
>
>and then use libfdt to find the node through that, rather than through the
>alias. I don't know how things are handled on other platforms, but I think
>that was how it was initially thought up when we introduced the fdt format
>on PowerPC.
>
>	Arnd

We also do the phy-handle fixup on our PowerPC platform based on the aliases,
and so I adopt the same way to make these fixup consistent between SoCs.
And the u-boot fdt fixup code base on the aliases has been upstreamed, so may
we keep this aliases unchanged?

BTW, find a node by alias is easily, could you give me some clue on finding a node
by a label directly, Thanks.


Best Regards,
Jingchang
