From: saeed.bishara@gmail.com (saeed bishara)
Date: Thu, 3 Mar 2011 15:50:26 +0200
Subject: Compiling a kernel for armv5 + armv6
In-Reply-To: <20110303132056.GB18351@pengutronix.de>
References: <20110303132056.GB18351@pengutronix.de>
Message-ID: <AANLkTi=u_R=c0b0PQEK_fLqEOfXe-rcyiaEr73kzo2E9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2011 at 3:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Doing so currently breaks with:
>
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:196: Error: selected processor does not support `strex r1,r2,[sp]'
> arch/arm/kernel/entry-armv.S:228: Error: selected processor does not support `strex r1,r2,[sp]'
> arch/arm/kernel/entry-armv.S:286: Error: selected processor does not support `strex r1,r2,[sp]'
> arch/arm/kernel/entry-armv.S:323: Error: selected processor does not support `strex r1,r2,[sp]'
>
> These are used in svc_exit and restore_user_regs.
>
> Is there a way to fix this or do we have to live with this?
try to add this line to the Makefile
 AFLAGS_entry-armv.o      :=-Wa,-march=armv6k
>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
