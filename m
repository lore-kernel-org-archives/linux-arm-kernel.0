From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 6 Oct 2011 19:10:40 +0200
Subject: [PATCH RESEND] ARM: smp_twd: Reconfigure clockevents after
	cpufreq change
In-Reply-To: <1315292775-4413-1-git-send-email-linus.walleij@stericsson.com>
References: <1315292775-4413-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAKnu2ModYp+F0kq6qVo9SQJ88GR_EwGNgH2WZXJrXUeR1xyzQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/6 Linus Walleij <linus.walleij@stericsson.com>:

> From: Colin Cross <ccross@android.com>
>
> The localtimer's clock changes with the cpu clock. After a
> cpufreq transition, update the clockevent's frequency and
> reprogram the next clock event.

Thomas do you think you can have a look at this patch and ACK
it if it looks OK to you? It's the use of clockevents_update_freq()
function you added after we discussed this in Budapest.

Since it's likely the first user of that infrastructure we need
to get it right.

Here is the entire patch i Russells tracker:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6956/2

Tell me if you want me to resend the patch again and
I'll fix.

Yours,
Linus Walleij
