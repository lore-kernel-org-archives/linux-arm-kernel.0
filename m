From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 22:34:29 +0200
Subject: [PATCH] ARM: Drop CONFIG_RTC_LIB dependency
In-Reply-To: <CAAEAJfC3zJiVv9bCmP1VqpHkMPNbaqx75mmsXEh7k7UMU6DGVQ@mail.gmail.com>
References: <1459569633-6470-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <4624574.xXAYWxU134@wuerfel>
 <CAAEAJfC3zJiVv9bCmP1VqpHkMPNbaqx75mmsXEh7k7UMU6DGVQ@mail.gmail.com>
Message-ID: <7827332.ilWiE07kMM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 16:22:18 Ezequiel Garcia wrote:
> > Sorry for missing this the first time around. The patch looks fine to me,
> > but I wonder if we should just do this for all architectures, the patch
> > below looks like it should do the trick. If you want to have your ARM
> > patch merged separately, that's fine too, please add my
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> >
> 
> Sure, if your patch does not break any platform, then
> I think it's much better than taking mine.

I've gone through my patches again to see which ones to submit and
it turned out that mine was wrong: we can't remove the symbol
because some architectures (not ARM) symbols exported by
drivers/rtc/rtc-lib.c.

Your patch is fine, and we can do the same thing on arm64.

	Arnd
