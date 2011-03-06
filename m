From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 6 Mar 2011 13:06:36 +0100
Subject: [PATCH] ARM: twd: Adjust localtimer frequency with
	cpufreqnotifiers
In-Reply-To: <eea425c066cc69c30f118fb102fff43e@mail.gmail.com>
References: <1290060899-9786-1-git-send-email-ccross@android.com>
	<AANLkTimCuV5N0jr8c949uONEvieQ5MDZ9KHDXtneG5AT@mail.gmail.com>
	<4D70BE9D.4000507@stericsson.com>
	<AANLkTin7ZXYALOy_jk1uR3SbZA51nSnU-ncSjG+n_RPn@mail.gmail.com>
	<4D714C17.7080102@gmail.com>
	<AANLkTims4e7o0sPxVnN0D1mNWDH7uC9q=pBQrBoad2os@mail.gmail.com>
	<eea425c066cc69c30f118fb102fff43e@mail.gmail.com>
Message-ID: <AANLkTi=KcmqmghVxhwGvv79heRU3C+TC-v2VnWSWt7bU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 5, 2011 at 9:19 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:

> While doing this patch for OMAP I also found that
> CPUFREQ notifiers does delays scaling timer frequency
> and there is a tick deviation(3-4 ms) around 1st tick and
> last tick around twd rescaling.

Is this caused by ticks that have been programmed
already (based on the previous frequency) when the scaling
takes effect? (That's most likely I think.)

The latter could be fixed by simply calling
schedule() for each CPU connected in the same core as
the TWD at the end of twd_update_cpu_frequency(),
couldn't it?

Colin what do you say?

> Another issue was not able to select higher fixed twd rate
> and found fix for the same.

Can you send out the patch?

Yours,
Linus Walleij
