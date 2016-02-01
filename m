From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 1 Feb 2016 19:41:08 +0000
Subject: [PATCH v4] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1602011404420.32766@knanqh.ubzr>
References: <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <1454349165-12249-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1602011404420.32766@knanqh.ubzr>
Message-ID: <SG2PR06MB0572F0EE79C00A530FA9CF398ADE0@SG2PR06MB0572.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Feb 2016, Nicolas Pitre wrote:

> The __data_loc symbol doesn't convey much to say with regards to XIP
> mapping.  It would be better to dedicate another symbol with a proper
> name instead.  Something like xiprom_start and xiprom_end perhaps.  
> This way, someone looking at the linker script won't be fooled by a
> hidden meaning tied to _etext or __data_loc.

That's fine by me.


However, I just saw the email "[PATCH] ARM: vmlinux.lds: assert that ROM and RAM don't overlap when XIP_KERNEL=y" sent in a little while ago.

So, do we first want to reconsider splitting out the XIP stuff into a separate linker script? Hence my proposal form November "[PATCH v2] ARM: xip: Move XIP linking to a separate file".

Or, should we keep piling more stuff in vmlinux.lds.S?


Chris
