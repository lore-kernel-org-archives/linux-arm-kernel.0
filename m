From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 1 Feb 2016 15:23:34 -0500 (EST)
Subject: [PATCH v4] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <SG2PR06MB0572F0EE79C00A530FA9CF398ADE0@SG2PR06MB0572.apcprd06.prod.outlook.com>
References: <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <1454349165-12249-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1602011404420.32766@knanqh.ubzr>
 <SG2PR06MB0572F0EE79C00A530FA9CF398ADE0@SG2PR06MB0572.apcprd06.prod.outlook.com>
Message-ID: <alpine.LFD.2.20.1602011522070.32766@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Feb 2016, Chris Brandt wrote:

> On Mon, 1 Feb 2016, Nicolas Pitre wrote:
> 
> > The __data_loc symbol doesn't convey much to say with regards to XIP
> > mapping.  It would be better to dedicate another symbol with a proper
> > name instead.  Something like xiprom_start and xiprom_end perhaps.  
> > This way, someone looking at the linker script won't be fooled by a
> > hidden meaning tied to _etext or __data_loc.
> 
> That's fine by me.
> 
> 
> However, I just saw the email "[PATCH] ARM: vmlinux.lds: assert that 
> ROM and RAM don't overlap when XIP_KERNEL=y" sent in a little while 
> ago.
> 
> So, do we first want to reconsider splitting out the XIP stuff into a 
> separate linker script? Hence my proposal form November "[PATCH v2] 
> ARM: xip: Move XIP linking to a separate file".
> 
> Or, should we keep piling more stuff in vmlinux.lds.S?

I still think the split linker file is the way to go.


Nicolas
