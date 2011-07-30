From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 01:53:41 +0200
Subject: [PATCH 07/18] dmaengine/amba-pl08x: Enable/Disable amba_pclk with
	channel requests
In-Reply-To: <20110730130537.GB15791@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<96781d46e41fa6ffc04b88527a25d73f5a59eda8.1311936524.git.viresh.kumar@st.com>
	<20110730120740.GA15791@n2100.arm.linux.org.uk>
	<20110730130537.GB15791@n2100.arm.linux.org.uk>
Message-ID: <CAKnu2MqTYF43wW3axM--jXdtvsCyRBTLEHDc3hPoJYAmTAL5UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Jul 30, 2011 at 01:07:40PM +0100, Russell King - ARM Linux wrote:
>> It may make better sense to convert this to runtime PM. ?I suspect
>> that there's core support which the amba/bus.c can do to help in that
>> respect (eg, managing the apb pclk itself) so that we don't have to
>> add the same code to every primecell driver.
>
> Something like this for the bus driver (untested):
>
> ?drivers/amba/bus.c | ? 38 ++++++++++++++++++++++++++++++++++++--
> ?1 files changed, 36 insertions(+), 2 deletions(-)

I think the pm_runtime_* code Rabin put in place inside
drivers/spi/spi-pl022.c would play really well with this approach, and
just work, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
