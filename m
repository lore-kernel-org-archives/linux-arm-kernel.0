From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 May 2013 15:26:05 +0800
Subject: [PATCH v4] tty: serial: add Freescale lpuart driver support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851CDEFB@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1369733161-19168-1-git-send-email-b35083@freescale.com>
 <20130529034913.GF370@S2101-09.ap.freescale.net>
 <B56CDBE15CE27145A4B77D2D24263E851CDEFB@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20130529072603.GI370@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 06:57:43AM +0000, Lu Jingchang-B35083 wrote:
> [Lu Jingchang-B35083] 
>   For multiple dts uart nodes, each node will call .probe once. If the uart_register_driver is called from .probe without any conditioning check, it will then be called more than once, but the uart_register_deiver can only register the same uart driver once. So I think current arrangement will be more reasonable. Thanks!
> 

It shouldn't be too hard to add a check for that.  But if you like to
stay with the current one, okay, I'm fine.

Shawn
