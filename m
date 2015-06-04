From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 4 Jun 2015 08:20:55 +0200
Subject: [RFT v2 45/48] genirq,
 gpio: Kill the first parameter 'irq' of irq_flow_handler_t
In-Reply-To: <1433391238-19471-46-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-46-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <CABxcv==u4XqozhR9=aXohGKy-qV696Rv74GqsgeUh0KUEoByEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jiang,

On Thu, Jun 4, 2015 at 6:13 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
>
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/gpio/gpio-altera.c     |    6 ++----
>  drivers/gpio/gpio-bcm-kona.c   |    2 +-
>  drivers/gpio/gpio-davinci.c    |    2 +-
>  drivers/gpio/gpio-dwapb.c      |    2 +-
>  drivers/gpio/gpio-ep93xx.c     |    4 ++--
>  drivers/gpio/gpio-intel-mid.c  |    2 +-
>  drivers/gpio/gpio-lynxpoint.c  |    2 +-
>  drivers/gpio/gpio-mpc8xxx.c    |    2 +-
>  drivers/gpio/gpio-msic.c       |    2 +-
>  drivers/gpio/gpio-msm-v2.c     |    2 +-
>  drivers/gpio/gpio-mvebu.c      |    2 +-
>  drivers/gpio/gpio-mxc.c        |    4 ++--
>  drivers/gpio/gpio-mxs.c        |    2 +-
>  drivers/gpio/gpio-omap.c       |    2 +-

For gpio-omap:

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
