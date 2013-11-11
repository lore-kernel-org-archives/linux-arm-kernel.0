From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 11 Nov 2013 17:43:21 +0200
Subject: [PATCH 0/2] DaVinci: GPIO: fixes
In-Reply-To: <1383893156-28010-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1383893156-28010-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <5280FB19.4020204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar, Prabhakar Lad

On 11/08/2013 08:45 AM, Prabhakar Lad wrote:> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> This patch series fixes gpio driver regestration
> and offset check for unbanked gpio.
> 
> Lad, Prabhakar (2):
>    gpio: davinci: Fix a check for unbanked gpio
>    ARM: davinci: Fix number of resources passed to
>      davinci_gpio_register() call

I've verified both patches - looks ok. 
Patch 1 - restores unbanked GPIO IRQs functionality
Patch 2 - allows to register GPIO Platform devices and boot without issues.

Could we move forward with these patches?

> 
>   arch/arm/mach-davinci/dm355.c  |    2 +-
>   arch/arm/mach-davinci/dm365.c  |    2 +-
>   arch/arm/mach-davinci/dm644x.c |    2 +-
>   arch/arm/mach-davinci/dm646x.c |    2 +-
>   drivers/gpio/gpio-davinci.c    |    4 +++-
>   5 files changed, 7 insertions(+), 5 deletions(-)
> 
