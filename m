From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 01:43:46 +0200
Subject: [PATCH 4/4] ARM: ks8695: convert to generic time and clocksource
In-Reply-To: <504057A8.7030302@snapgear.com>
References: <1346264842-20411-1-git-send-email-linus.walleij@linaro.org>
 <504057A8.7030302@snapgear.com>
Message-ID: <CACRpkdZ0Gw5H_yRcN2CmC+F8NtUcySTrLehuzZdWrbDwL4HHWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 8:20 AM, Greg Ungerer <gerg@snapgear.com> wrote:

> Ok, tested on a KS8695 based machine. Boots and runs, obviously
> clock is basically working. But 'date' never shows the time
> increasing:
>
>   # date
>   Thu Jan  1 00:00:00 UTC 1970
>   # date
>   Thu Jan  1 00:00:00 UTC 1970
>   # date
>   Thu Jan  1 00:00:00 UTC 1970
>   #
>
> And yes, that did work before applying this patch :-)

That mean clockevent is running but not clocksource.

And I think that is because I forgot a ~ in the mask for disabling
the T1 timer, so setting up the clockevent disables the clocksource ...

I'll send out a fixed version, plese test!

(BTW I had not clue the 68K maintainer had a platform like
this, fun!)

Yours,
Linus Walleij
