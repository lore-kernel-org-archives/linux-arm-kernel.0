From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 09:32:13 +0000
Subject: [PATCH v3 03/15] mfd: menelaus: Convert to threaded irq
In-Reply-To: <1386606085-26838-3-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-3-git-send-email-balbi@ti.com>
Message-ID: <20131210093213.GV12675@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 09 Dec 2013, Felipe Balbi wrote:

> We don't need that extra workqueue when we have generic threaded irq
> handlers support. This patch just moves over to threaded irqs and
> deletes the unnecessary workqueue.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)

<snip>

> -		err = request_irq(client->irq, menelaus_irq, 0,
> -				  DRIVER_NAME, menelaus);
> +		err = request_threaded_irq(client->irq, NULL, menelaus_irq,
> +				IRQF_ONESHOT, DRIVER_NAME, menelaus);

devm_* managed resources please.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
