From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Sep 2014 17:54:43 +0200
Subject: [PATCHv4 3/6] ARM: dts: Add initial LS1021A TWR board dts support
In-Reply-To: <bb122a232a1c40559e84a058f3d003b4@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <4264466.HtkUxyxBW8@wuerfel>
 <bb122a232a1c40559e84a058f3d003b4@BL2PR03MB467.namprd03.prod.outlook.com>
Message-ID: <3598074.CpE7Waa9La@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 September 2014 11:00:34 Jingchang Lu wrote:
> 
> We also do the phy-handle fixup on our PowerPC platform based on the aliases,
> and so I adopt the same way to make these fixup consistent between SoCs.
> And the u-boot fdt fixup code base on the aliases has been upstreamed, so may
> we keep this aliases unchanged?

I don't see a strong reason to change it, it just seemed strange to me.

> BTW, find a node by alias is easily, could you give me some clue on finding a node
> by a label directly, Thanks.

I haven't used libfdt in this way myself, so I don't know how it would
be done. However, the idea is that the labels in dts files end up as
ELF symbols in the dtb, so you can look them up by following the ELF
headers.

	Arnd
