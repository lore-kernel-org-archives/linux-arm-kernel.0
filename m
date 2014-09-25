From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 12:57:29 +0200
Subject: [PATCHv4 3/6] ARM: dts: Add initial LS1021A TWR board dts support
In-Reply-To: <1b72af7d8c90492ba91115ef958bbda7@BLUPR03MB472.namprd03.prod.outlook.com>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <3598074.CpE7Waa9La@wuerfel>
 <1b72af7d8c90492ba91115ef958bbda7@BLUPR03MB472.namprd03.prod.outlook.com>
Message-ID: <8538195.h7lPfgcOv3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014 08:06:27 Jingchang Lu wrote:
> 
> Libfdt doesn't provide way to find a node by label. Label is just a shortcut to
> a full absolute path, it's useful in device tree source reference, but is hard
> to find a label after build to dtb. Aliases just provide the way to save a
> full absolute path in properties like label, but they can be find in dtb after
> build so that fixup on dtb can find a node efficiently. So I think the aliases
> for the phy nodes is also reasonable. Many others boards also use labels for
> various dts nodes.

Ok, fair enough.

I still think it would be a good idea in general to let all boot loaders
find nodes and properties by label, which in theory should be simpler
than finding them by aliases, but if they don't do that today it should
not stop your file from getting merged.

	Arnd
