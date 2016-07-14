From: agraf@suse.de (Alexander Graf)
Date: Thu, 14 Jul 2016 10:01:50 +0200
Subject: [PATCH] arm64: Add config to limit user space to 47bits
In-Reply-To: <VI1PR0801MB142315FBEDD571CC23E8D7F796320@VI1PR0801MB1423.eurprd08.prod.outlook.com>
References: <1468424567-15925-1-git-send-email-agraf@suse.de>
 <CAKv+Gu_QH=sZi--FVqHebd1P+6UMzEqWQQ1u3Y170B7cND8Kgw@mail.gmail.com>
 <578668D3.6010406@suse.de> <20160714010812.GA17138@e103986-lin>
 <837E6456-4718-45D7-8EE7-E28E11DB8BD3@suse.de>
 <VI1PR0801MB1423AC2E8EDEE7EA33A6233196320@VI1PR0801MB1423.eurprd08.prod.outlook.com>
 <e24481b9-fb6a-aead-a72b-43b7d561b940@suse.de>
 <VI1PR0801MB142315FBEDD571CC23E8D7F796320@VI1PR0801MB1423.eurprd08.prod.outlook.com>
Message-ID: <45E0D3FF-FEC1-4A70-8B2D-A941A35788EB@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Am 14.07.2016 um 09:49 schrieb Zheng Xu <Zheng.Xu@arm.com>:
> 
> Sorry, I might misunderstand the issue. I thought there are still issues with master.
> 
> I saw that you've mentioned there are pointers to .rodata. And I only fixed the heap. So I am just worried if there can be issues with .rodata. If pointers to .rodata are not tagged and used as js objects, it should be fine.

Please don't top post on kernel mailing lists.

The old Spidermonkey (which is used by couchdb) has some string allocation optimization in jsstr.cpp that directly pregenerates js strings in .rodata at compile time. Just try to run couchdb on a 48bit va aarch64 system and it will fall apart.

Fixing mozjs master doesn't really help here, since couchdb requires the ancient spidermonkey 1.8.5. An alternative to fixing that old js implementation would obviously also be to move couchdb to mozjs master.


Alex
