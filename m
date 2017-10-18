From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 18 Oct 2017 20:31:27 +0200 (CEST)
Subject: [PATCH v6 2/5] clocksource: stm32: convert driver to timer_of
In-Reply-To: <1508331506-23782-3-git-send-email-benjamin.gaignard@linaro.org>
References: <1508331506-23782-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508331506-23782-3-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <alpine.DEB.2.20.1710182028080.2477@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Oct 2017, Benjamin Gaignard wrote:

> Convert driver to use timer_of helpers. This allow to remove
> custom proprietary structure.
> 
> Increase min delta value because if it is too small it could
> generate too much interrupts and the system will not be able
> to catch them all.

This does two completely independent changes at once. What the heck has
increasing min delta to do with converting it to timer_of() helpers?

Nothing at all. So please split this into two distinct patches. Each doing
ONE thing.

See Documentation/process/submitting-patches.rst:

  3) Separate your changes
  ------------------------

  Separate each **logical change** into a separate patch.

Reading, understanding and complying with that document is not optional.

Thanks,

	tglx
