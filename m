From: fainelli@broadcom.com (Florian Fainelli)
Date: Tue, 21 Apr 2015 11:51:32 -0700
Subject: [PATCH 0/3] power: reset: BCM63xx reboot support
In-Reply-To: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
References: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <55369C34.5020201@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/03/15 17:17, Florian Fainelli wrote:
> Hi all,
> 
> This patch series adds support for the BCM6328-style software reset hardware
> block commonly found on Broadcom BCM63xx DSL SoCs.

Looks like we can utilize the generic syscon reboot driver instead of
open-coding one, let's do that instead.

> 
> Thanks!
> 
> Florian Fainelli (3):
>   Documentation: bindings: add BCM6328-style soft reset binding
>   power: reset: add Broadcom BCM63xx software reset driver
>   ARM: dts: BCM63xx: add soft-reset node
> 
>  .../devicetree/bindings/arm/bcm/bcm63138.txt       | 16 +++++
>  arch/arm/boot/dts/bcm63138.dtsi                    |  5 ++
>  drivers/power/reset/Kconfig                        |  7 ++
>  drivers/power/reset/Makefile                       |  1 +
>  drivers/power/reset/bcm63xx-reboot.c               | 80 ++++++++++++++++++++++
>  5 files changed, 109 insertions(+)
>  create mode 100644 drivers/power/reset/bcm63xx-reboot.c
> 


-- 
Florian
