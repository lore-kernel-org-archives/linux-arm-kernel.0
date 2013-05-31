From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 15:53:10 +0200
Subject: [PATCH 02/39] ARM: u300: device tree support for the timer
In-Reply-To: <CACRpkdZYsnUhjYO_U4L56TMY+fs+ZU9zk3zLWnjPtf8Bmmn0YQ@mail.gmail.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <7742928.6bJiIVUE0X@wuerfel>
 <CACRpkdZYsnUhjYO_U4L56TMY+fs+ZU9zk3zLWnjPtf8Bmmn0YQ@mail.gmail.com>
Message-ID: <2014595.XlPVsySsVh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 13:26:31 Linus Walleij wrote:
> 
> > You should not need the CONFIG_OF #ifdef, since the CLOCKSOURCE_OF_DECLARE
> > macro is designed to let the function get dropped by the compiler when
> > that is not set.
> >
> > You might want a CONFIG_ATAGS check for the other function though.
> 
> Both the other function and the #ifdef CONFIG_OF are deleted in
> patch 21. Is this OK?

Ok, that's fine then.

> >> diff --git a/arch/arm/mach-u300/timer.h b/arch/arm/mach-u300/timer.h
> >> index d34287b..7766dfa 100644
> >> --- a/arch/arm/mach-u300/timer.h
> >> +++ b/arch/arm/mach-u300/timer.h
> >> @@ -1 +1,2 @@
> >>  extern void u300_timer_init(void);
> >> +
> >
> > You probably didn't mean to include this newline.
> 
> This entire file is also deleted in patch 21.
> 
> I can fix it up if you absolutely want to but it feels like
> something of an academic exercise.

No, not if that is the only change you'd do to this patch.

	Arnd
