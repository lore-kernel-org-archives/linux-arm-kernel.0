From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 22 Jan 2012 21:42:08 +0100
Subject: [RFC PATCH 06/11] Cortex-M3: Add base support for Cortex-M3
In-Reply-To: <CAHXqBFKYVOpeLxK_Fc_fcaa1ehoq2wJM1LnfEGvWnENzk4GqLw@mail.gmail.com>
References: <20120122111230.GB14835@pengutronix.de>
 <1327230817-12855-6-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAHXqBFKYVOpeLxK_Fc_fcaa1ehoq2wJM1LnfEGvWnENzk4GqLw@mail.gmail.com>
Message-ID: <20120122204208.GC14835@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Micha?,

On Sun, Jan 22, 2012 at 08:45:24PM +0100, Micha? Miros?aw wrote:
> 2012/1/22 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > --- a/arch/arm/kernel/head-common.S
> > +++ b/arch/arm/kernel/head-common.S
> > @@ -100,7 +100,7 @@ __mmap_switched:
> > ? ? ? ?str ? ? r2, [r6] ? ? ? ? ? ? ? ? ? ? ? ?@ Save atags pointer
> > ? ? ? ?cmp ? ? r7, #0
> > ? ? ? ?bicne ? r4, r0, #CR_A ? ? ? ? ? ? ? ? ? @ Clear 'A' bit
> > - ? ? ? stmneia r7, {r0, r4} ? ? ? ? ? ? ? ? ? ?@ Save control register values
> > + ? ? ? stmiane r7, {r0, r4} ? ? ? ? ? ? ? ? ? ?@ Save control register values
> > ? ? ? ?b ? ? ? start_kernel
> > ?ENDPROC(__mmap_switched)
> >
> 
> This fixes one of previous patches, doesn't it?
Thanks for noticing, and no, stmiane is an undefined instruction, but
only the non-thumb build barfs on that. It seems my conflict resolution
failed somehow :-(. I fixed it now.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
