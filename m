From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 15 Feb 2017 12:27:59 -0300
Subject: [PATCH] clk: rockchip: Set "ignore unused" for PMU M0 clocks on
 rk3399
In-Reply-To: <20170214210114.5846-1-dianders@chromium.org>
References: <20170214210114.5846-1-dianders@chromium.org>
Message-ID: <CABxcv=kzW9SvrWYNasqCDkV7D6Y2zq+oRuqoPFdWuaWUhPehEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On Tue, Feb 14, 2017 at 6:01 PM, Douglas Anderson <dianders@chromium.org> wrote:
> The PMU Cortex M0 on rk3399 is intended to be used for things like
> DDRFreq transitions, suspend/resume, and other things that are the
> purview of ARM Trusted Firmware and not the kernel.  As such, the
> kernel shouldn't be messing with the clocks.  Add CLK_IGNORE_UNUSED to
> these clocks.
>

Isn't CLK_IS_CRITICAL a more suitable flag for this case?

Best regards,
Javier
