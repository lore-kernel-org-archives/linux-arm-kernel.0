From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Nov 2012 10:05:39 -0700
Subject: [RFC PATCH 1/4] ARM: S3C24XX: move s3c24xx-irq to drivers/irqchip
In-Reply-To: <201211121447.49977.heiko@sntech.de>
References: <201211121446.30167.heiko@sntech.de>
 <201211121447.49977.heiko@sntech.de>
Message-ID: <50A12C63.2000609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 06:47 AM, Heiko St?bner wrote:
> Removes another part from plat-s3c24xx and also enables further
> improvements happening in the correct location.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/plat-s3c24xx/Makefile                     |    1 -
>  drivers/irqchip/Kconfig                            |    3 +++
>  drivers/irqchip/Makefile                           |    1 +
>  .../irq.c => drivers/irqchip/irq-s3c24xx.c         |    0
>  5 files changed, 5 insertions(+), 1 deletions(-)
>  rename arch/arm/plat-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c (100%)

Presumably there's a header file somewhere that defines the interface to
irq-s3c24xx.c that other code in arch/arm/plat-s3c24xx is using to
initialize it. That header should be moved somewhere public (i.e.
outside {mach,plat}-*/include/{mach,plat}). However, you then end up
with a header file per IRQ driver in that public location. So, Thomas
Petazzoni started working on a solution for that:

> http://lists.arm.linux.org.uk/lurker/message/20121027.164514.11eb86db.en.html
