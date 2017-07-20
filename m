From: j-keerthy@ti.com (Keerthy)
Date: Thu, 20 Jul 2017 15:13:44 +0530
Subject: [PATCH v2 0/3] gpio: davinci: Add missing return checks
In-Reply-To: <1500543738-9696-1-git-send-email-j-keerthy@ti.com>
References: <1500543738-9696-1-git-send-email-j-keerthy@ti.com>
Message-ID: <fc3de1fa-35b0-fc09-7116-921d7d2bf8a9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 20 July 2017 03:12 PM, Keerthy wrote:
> The patch series does a couple of important return handling which were missed
> earlier in the driver probe.
> 
> This is based on Suman's:
> 
> http://marc.info/?l=linux-arm-kernel&m=150034845427555&w=2
> http://marc.info/?l=linux-arm-kernel&m=150034856627618&w=2 
> 

My bad! The series has no dependency on the above. I have split the
device tree patches to keep it independent.

> Changes in v2:
> 
>   * Removed the device tree patch for to keep the series independent.
> 
> Keerthy (3):
>   gpio: davinci: Use devm_gpiochip_add_data in place of
>     gpiochip_add_data
>   gpio: davinci: Handle the return value of davinci_gpio_irq_setup
>     function
>   gpio: davinci: Convert prinkt to dev_err
> 
>  drivers/gpio/gpio-davinci.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
