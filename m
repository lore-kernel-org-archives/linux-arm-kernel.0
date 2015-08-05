From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 5 Aug 2015 13:45:31 -0700
Subject: [PATCH 22/23] misc: atmel_tclib: get and use slow clock
In-Reply-To: <1438335599-3301-23-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-23-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150805204531.GA9784@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 11:39:58AM +0200, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> hang") added a workaround for the slow clock as it is not properly handled
> by its users.
> 
> Get and use the slow clock as it is necessary for the timer counters.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm at vger.kernel.org
>  drivers/clocksource/tcb_clksrc.c |  8 ++++++++
>  drivers/misc/atmel_tclib.c       |  4 ++++
>  drivers/pwm/pwm-atmel-tcb.c      | 23 ++++++++++++++++-------
>  include/linux/atmel_tc.h         |  1 +
>  4 files changed, 29 insertions(+), 7 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
