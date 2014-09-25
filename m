From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 25 Sep 2014 08:06:27 +0000
Subject: [PATCHv4 3/6] ARM: dts: Add initial LS1021A TWR board dts support
In-Reply-To: <3598074.CpE7Waa9La@wuerfel>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <4264466.HtkUxyxBW8@wuerfel>
 <bb122a232a1c40559e84a058f3d003b4@BL2PR03MB467.namprd03.prod.outlook.com>
 <3598074.CpE7Waa9La@wuerfel>
Message-ID: <1b72af7d8c90492ba91115ef958bbda7@BLUPR03MB472.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd at arndb.de]
>Sent: Wednesday, September 24, 2014 11:55 PM
>To: Lu Jingchang-B35083
>Cc: Guo Shawn-R65073; mark.rutland at arm.com; linux-arm-
>kernel at lists.infradead.org; devicetree at vger.kernel.org; Lu Chen-B46807; Fu
>Chao-B44548
>Subject: Re: [PATCHv4 3/6] ARM: dts: Add initial LS1021A TWR board dts
>support
>
>On Wednesday 24 September 2014 11:00:34 Jingchang Lu wrote:
>>
>> We also do the phy-handle fixup on our PowerPC platform based on the
>> aliases, and so I adopt the same way to make these fixup consistent
>between SoCs.
>> And the u-boot fdt fixup code base on the aliases has been upstreamed,
>> so may we keep this aliases unchanged?
>
>I don't see a strong reason to change it, it just seemed strange to me.
>
>> BTW, find a node by alias is easily, could you give me some clue on
>> finding a node by a label directly, Thanks.
>
>I haven't used libfdt in this way myself, so I don't know how it would be
>done. However, the idea is that the labels in dts files end up as ELF
>symbols in the dtb, so you can look them up by following the ELF headers.
>
>	Arnd

Libfdt doesn't provide way to find a node by label. Label is just a shortcut to
a full absolute path, it's useful in device tree source reference, but is hard
to find a label after build to dtb. Aliases just provide the way to save a
full absolute path in properties like label, but they can be find in dtb after
build so that fixup on dtb can find a node efficiently. So I think the aliases
for the phy nodes is also reasonable. Many others boards also use labels for
various dts nodes.
Thanks.

Best Regards,
Jingchang
 
