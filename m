From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Apr 2012 11:49:47 +0000
Subject: [PATCH 12/17] ARM clps711x: Simple optimise debug_macro by
 removing one NOP
In-Reply-To: <201204211118.23857.arnd@arndb.de>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <1334999490-27177-13-git-send-email-shc_work@mail.ru>
 <201204211118.23857.arnd@arndb.de>
Message-ID: <201204211149.47404.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 April 2012, Arnd Bergmann wrote:
> 
> On Saturday 21 April 2012, Alexander Shiyan wrote:
> > 
> >                 .macro  addruart, rp, rv, tmp
> > -#ifndef CONFIG_DEBUG_CLPS711X_UART2
> > -               mov     \rp, #0x0000    @ UART1
> > -#else
> > -               mov     \rp, #0x1000    @ UART2
> > +#ifdef CONFIG_DEBUG_CLPS711X_UART2
> > +               mov     \rp, #0x1000    @ Add offset for UART2 base reg
> >  #endif
> >                 orr     \rv, \rp, #CLPS711X_VIRT_BASE
> >                 orr     \rp, \rp, #CLPS711X_PHYS_BASE
> 
> This looks wrong at first sight. Is rp guaranteed to be zero when calling
> the macro? Am I misreading this? Sorry my ARM assembly skill is still horrible.

Ah, Russell was faster to point out the same problem. Well I'm glad that
I sometimes read the assembly correctly then ;-)

	Arnd
