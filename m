From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 14 May 2013 15:40:57 +0100
Subject: [PATCH] mfd: db8500-prcmu: Update stored DSI PLL divider value
In-Reply-To: <1368537295-23459-1-git-send-email-ulf.hansson@stericsson.com>
References: <1368537295-23459-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130514144057.GH28781@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 May 2013, Ulf Hansson wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Previously the DSI PLL divider rate was initialised statically and
> assumed to be 1. Before the common clock framework were enabled for
> ux500, a call to clk_set_rate() would always update the HW registers
> no matter what the current setting was.
> 
> This patch makes sure the actual hw settings and the sw assumed
> settings are matched.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Paer-Olof Haakansson <par-olof.hakansson@stericsson.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c |    2 ++
>  1 file changed, 2 insertions(+)

I understand that this is causing an issue for the Multimedia guys who
use this. As it's causing an issue and you are 'the' ST-E clock guru,
I'll tentatively apply this to my v3.10 -fixes branch.

If anyone has any arguments against it, please step forward.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
