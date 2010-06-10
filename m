From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 10 Jun 2010 14:47:40 -0400 (EDT)
Subject: [PATCH 01/10] arm/zImage: don't hard code the stack size twice
In-Reply-To: <AANLkTinvvP7GFMHDoaw3SgIetd42Yyho1r9oMuiSIlnV@mail.gmail.com>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTinvvP7GFMHDoaw3SgIetd42Yyho1r9oMuiSIlnV@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006101446450.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jun 2010, Eric Miao wrote:

> 2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > ?arch/arm/boot/compressed/head.S | ? ?3 ++-
> > ?1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > index c5191b1..390aa92 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -315,7 +315,7 @@ LC0: ? ? ? ? ? ? ? ?.word ? LC0 ? ? ? ? ? ? ? ? ? ? @ r1
> > ? ? ? ? ? ? ? ?.word ? _image_size ? ? ? ? ? ? @ r6
> > ? ? ? ? ? ? ? ?.word ? _got_start ? ? ? ? ? ? ?@ r11
> > ? ? ? ? ? ? ? ?.word ? _got_end ? ? ? ? ? ? ? ?@ ip
> > - ? ? ? ? ? ? ? .word ? user_stack+4096 ? ? ? ? @ sp
> > + ? ? ? ? ? ? ? .word ? user_stack_end ? ? ? ? ?@ sp
> > ?LC1: ? ? ? ? ? .word ? reloc_end - reloc_start
> > ? ? ? ? ? ? ? ?.size ? LC0, . - LC0
> >
> > @@ -1070,3 +1070,4 @@ reloc_end:
> > ? ? ? ? ? ? ? ?.align
> > ? ? ? ? ? ? ? ?.section ".stack", "w"
> > ?user_stack: ? ?.space ?4096
> > +user_stack_end:
> 
> This one looks OK to me.
> 
> Acked-by: Eric Miao <eric.miao@canonical.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
