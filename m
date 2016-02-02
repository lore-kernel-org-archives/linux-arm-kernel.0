From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 2 Feb 2016 17:05:07 +0000
Subject: [PATCH v4] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1602011522070.32766@knanqh.ubzr>
References: <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <1454349165-12249-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1602011404420.32766@knanqh.ubzr>
 <SG2PR06MB0572F0EE79C00A530FA9CF398ADE0@SG2PR06MB0572.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1602011522070.32766@knanqh.ubzr>
Message-ID: <HKXPR06MB0565EEA0ED5BB19E5CFC992B8ADF0@HKXPR06MB0565.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Feb 2016, Nicolas Pitre wrote:
> The __data_loc symbol doesn't convey much to say with regards to XIP 
> mapping.  It would be better to dedicate another symbol with a 
> proper name instead.  Something like xiprom_start and xiprom_end perhaps.
> This way, someone looking at the linker script won't be fooled by a 
> hidden meaning tied to _etext or __data_loc.

In keeping with the convention that's already in the vmlinux.lds, I'm going to go with "_xiprom" and "_exiprom"


> > Or, should we keep piling more stuff in vmlinux.lds.S?
>
> I still think the split linker file is the way to go.

So...since I didn't hear any clapping and cheering, first I'd like to fix what I know is broken and get that in. Then go back to the splitting linker script idea.


Chris
