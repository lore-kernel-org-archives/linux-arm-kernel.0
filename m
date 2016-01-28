From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 27 Jan 2016 17:16:45 -0800
Subject: MTK mt8173-evb: mainline unstable, and big-endian boot failures
In-Reply-To: <CAOi56cVDbkAJEDWy3+DV63a=UuD7nqpUu8X7e-OjtWM-4dj_-w@mail.gmail.com>
 (Kevin Hilman's message of "Wed, 27 Jan 2016 16:55:25 -0800")
References: <CAOi56cVDbkAJEDWy3+DV63a=UuD7nqpUu8X7e-OjtWM-4dj_-w@mail.gmail.com>
Message-ID: <7hsi1ilczm.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@baylibre.com> writes:

[...]

> It seems to be pretty stable up through v4.4 but
> unreliable/unpredictable in v4.5-rc1 and lots of places in between.
> It's hard to bisect because it doesn't reliably fail, but when it does
> fail to finish booting, it's typically after it reaches a shell, and
> trying to run various simple shell commands fails to complete, like
> this example from next-20160125[2].
>
> To me this suggests possibly an issue with the idle driver where
> characters might be getting lost on the serial console, which causes
> the automated boot scripts to fail because the shell is still waiting
> for the command to be finished.

FWIW, I think I confirmed my suspicion that it's an idle driver issue
because adding 'nohlt' on the cmdline, which forces cpuidle_poll mode
(essentially disabling cpuidle) makes mainline boot quite reliably on my
mt8173-evb board now.

Kevin
