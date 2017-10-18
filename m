From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 18 Oct 2017 20:35:51 +0200 (CEST)
Subject: [PATCH v6 3/5] clocksource: stm32: only use 32 bits timers
In-Reply-To: <1508331506-23782-4-git-send-email-benjamin.gaignard@linaro.org>
References: <1508331506-23782-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508331506-23782-4-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <alpine.DEB.2.20.1710182032170.2477@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Oct 2017, Benjamin Gaignard wrote:

> 16 bits hardware are not enough accure to be used.

That should probably read:

  16 bit counters are not accurate enough to be used.

Right?

> Do no allow them to be probed by tested max counter value.

I really do not understand why you want to do this. Accuracy is not really
a reason to dismiss working hardware right away. What you can do is to
lower the rating so other eventually available hardware will be preferred.

I might be missing something, but if so this is obviously missing in the
changelog.

Thanks,

	tglx
