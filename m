From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 04 Apr 2013 22:54:32 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCA0LzRdIEFSTTogczNjMjR4eDogRml4IHN3aXRjaGlu?=
 =?UTF-8?B?ZyBGSUZPIGluIGFyY2hfZW5hYmxlX3VhcnRfZmlmbyBmdW5jdGlvbg==?=
References: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
 <1362216174-10478-4-git-send-email-shc_work@mail.ru>
Message-ID: <1365101672.722585953@f87.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> Alexander Shiyan wrote:
> > 
> > When CONFIG_S3C_BOOT_UART_FORCE_FIFO symbol is set, we should
> > enable FIFO but actually switch command is missing in the code.
> > This patch adds this switch.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/plat-samsung/include/plat/uncompress.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h
> > b/arch/arm/plat-samsung/include/plat/uncompress.h
> > index 438b248..30fedd9 100644
> > --- a/arch/arm/plat-samsung/include/plat/uncompress.h
> > +++ b/arch/arm/plat-samsung/include/plat/uncompress.h
> > @@ -130,6 +130,8 @@ static inline void arch_enable_uart_fifo(void)
> >  			if (!(fifocon & S3C2410_UFCON_RESETBOTH))
> >  				break;
> >  		}
> > +
> > +		uart_wr(S3C2410_UFCON, S3C2410_UFCON_FIFOMODE);
> 
> Well, I think, if required, this should be moved into 'if (!(fifocon &
> S3C2410_UFCON_FIFOMODE))'.

Already here.

---
