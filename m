From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Feb 2012 09:26:34 -0800
Subject: Internal timers in deep sleep
In-Reply-To: <CAM8FrK++W4ScR-htTDXeA7iniz9LTXB_29yzhDNfOu5=VLC+mQ@mail.gmail.com>
References: <CAM8FrK++W4ScR-htTDXeA7iniz9LTXB_29yzhDNfOu5=VLC+mQ@mail.gmail.com>
Message-ID: <20120213172633.GA1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

* Marcus Folkesson <marcus.folkesson@gmail.com> [120211 03:37]:
> Is it possible to speed up the time it takes to go to/from deepsleep?
> The pm_suspend() does a lot of things, eg. freeze processes, suspend
> drivers and so on.

Depending on the omap, you can already do suspend while idle or off
while idle. This means the RAM is in self-refresh and the omap is
either suspended or powered off in the idle loop. This is typically
done with a combination of constantly running 32 KiHz clocksource and
wake-up capable GPT1 clockevent timer.

If you have similar timers on your hardware, this may be the way to go.
In this case there's no need to freeze processes, so the latency is
quite minimal.

Regards,

Tony
