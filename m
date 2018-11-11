From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 11 Nov 2018 21:18:12 +0100 (CET)
Subject: [PATCH v2] ARM: staging: bcm2835-audio: interpolate audio delay
In-Reply-To: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
References: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
Message-ID: <1197390391.186035.1541967492518@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

> Mike Brady <mikebrady@eircom.net> hat am 11. November 2018 um 19:21 geschrieben:
> 
> 
> When the BCM2835 audio output is used, userspace sees a jitter up to 10ms
> in the audio position, aka "delay" -- the number of frames that must
> be output before a new frame would be played.
> Make this a bit nicer for userspace by interpolating the position
> using the CPU clock.
> The overhead is small -- an extra ktime_get() every time a GPU message
> is sent -- and another call and a few calculations whenever the delay
> is sought from userland.
> At 48,000 frames per second, i.e. approximately 20 microseconds per
> frame, it would take a clock inaccuracy of
> 20 microseconds in 10 milliseconds -- 2,000 parts per million --
> to result in an inaccurate estimate, whereas
> crystal- or resonator-based clocks typically have an
> inaccuracy of 10s to 100s of parts per million.
> 
> Signed-off-by: Mike Brady <mikebrady@eircom.net>

the former version of your patch has already been applied to staging-next.

Didn't you received Greg's email?

So please rebase your changes.

Stefan
