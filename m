From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 27 Mar 2013 10:40:28 +0100 (CET)
Subject: [PATCH v4] clk: allow reentrant calls into the clk framework
In-Reply-To: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
Message-ID: <alpine.LFD.2.02.1303270941320.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Mar 2013, Mike Turquette wrote:

> Reentrancy into the clock framework from the clk.h api is necessary
> for clocks that are prepared and unprepared via i2c_transfer (which
> includes many PMICs and discrete audio chips) as well as for several
> other use cases.

That explanation sucks.

Why does an i2c clock need reentrancy? Just because it's i2c or what?

What exactly are the "several other use cases"?

Why do you need the spinlock side reentrant? If a clock is handled by
i2c it hardly can hold the spinlock over a i2c transfer.

A few pointers to code which needs this would be nice as well.

I'm refraining from reviewing the horrible implementation until I get
proper answers to the above questions.

Thanks,

	tglx
