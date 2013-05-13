From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 13 May 2013 11:44:48 +0100
Subject: [PATCH] mfd: ab8500-sysctrl: Always enable pm_power_off handler
In-Reply-To: <1368097688-17858-1-git-send-email-fabio.baltieri@linaro.org>
References: <1368097688-17858-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130513104448.GB3297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 May 2013, Fabio Baltieri wrote:

> AB8500 sysctrl driver implements a pm_power_off handler, but that is
> currently not registered until a specific platform data field is
> enabled.
> 
> This patch drops the platform data field and always registers
> ab8500_power_off if no other pm_power_off handler was defined before,
> and also introduces the necessary cleanup code in the driver's remove
> function.
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>  drivers/mfd/ab8500-sysctrl.c      | 6 +++++-
>  include/linux/mfd/abx500/ab8500.h | 2 --
>  2 files changed, 5 insertions(+), 3 deletions(-)

The code looks good to me, but I'd like Linus' or Mattias' Ack before
I apply it.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
