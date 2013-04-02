From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 02 Apr 2013 10:00:03 +0200
Subject: [PATCH 0/6] pinctrl: Add support for pin control on S3C64xx
In-Reply-To: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1441305.zvZX7Ed4lY@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 18 of March 2013 22:31:49 Tomasz Figa wrote:
> This series makes necessary preparations to add support for pin
> controller available on Samsung S3C64xx using pinctrl-samsung driver
> and then adds pinctrl-s3c64xx driver which implements SoC-specific part
> of the code.
> 
> It has been tested on a tiny6410 (mini6410-compatible) board with my
> patches for samsung-time cleanup and S3C64xx Device Tree support:
>  - http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16664
>  -
> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg16325.
> html
> 
> Just the driver is added for now, as this is the part that can safely go
> through Linus' pinctrl tree. I will post appropriate enablement patches
> after all the dependencies get merged to Kgene's tree.
> 
> See particular patches for more detailed description of all changes.
> 
> Tomasz Figa (6):
>   pinctrl: samsung: Protect bank registers with a spinlock
>   pinctrl: samsung: Include pinctrl-exynos driver data conditionally
>   pinctrl: samsung: Split pin bank description into two structures
>   pinctrl: samsung: Remove hardcoded register offsets
>   pinctrl: samsung: Handle banks with two configuration registers
>   pinctrl: Add pinctrl-s3c64xx driver
> 
>  .../bindings/pinctrl/samsung-pinctrl.txt           |   3 +
>  drivers/pinctrl/Kconfig                            |   5 +
>  drivers/pinctrl/Makefile                           |   1 +
>  drivers/pinctrl/pinctrl-exynos.c                   |  36 +-
>  drivers/pinctrl/pinctrl-exynos.h                   |  16 +-
>  drivers/pinctrl/pinctrl-s3c64xx.c                  | 817
> +++++++++++++++++++++ drivers/pinctrl/pinctrl-samsung.c                
>  |  99 ++-
>  drivers/pinctrl/pinctrl-samsung.h                  |  42 +-
>  8 files changed, 947 insertions(+), 72 deletions(-)
>  create mode 100644 drivers/pinctrl/pinctrl-s3c64xx.c

Any comments about this series?

Best regards,
Tomasz
