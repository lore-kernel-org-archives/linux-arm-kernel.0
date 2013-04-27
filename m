From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Apr 2013 17:12:10 -0700
Subject: [PATCH 1/4] clocksource: nomadik-mtu: fix up clocksource/timer
In-Reply-To: <CACRpkdYWSM0BK77qWbQWh0xsN+Ps95Q70zG-GE98MYvThrky2A@mail.gmail.com>
References: <1366463287-9922-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdYWSM0BK77qWbQWh0xsN+Ps95Q70zG-GE98MYvThrky2A@mail.gmail.com>
Message-ID: <20130427001210.GA1714@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 20, 2013 at 03:19:43PM +0200, Linus Walleij wrote:
> ARM SoC folks:
> 
> On Sat, Apr 20, 2013 at 3:08 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > The Nomadik clocksource driver has had a bad define making it
> > impossible to use it for sched_clock() for a while. Fix this
> > and also enable it for the Nomadik.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> This one should go to fixes ASAP, could you pick it to your fixes
> branch? It could be tagged stable if desired - this only affects the
> Nomadik which works just OK on jiffies so it's really no big regression.
> The Ux500 does not use the MTU for sched_clock().

Ok, applied on top of next/multiplatform, seems to be what it's based on.

Tagging as stable is up to you as platform owner. :) Since it won't directly
apply to older kernels you might be better of submitting it to Greg separately.


-Olof
