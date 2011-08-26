From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 26 Aug 2011 11:12:41 +0800
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAGsJ_4yGSJPDiywak=ArMSv6DUKyCRAZ2J1Fxj6ZKgryyMzu8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/19 Linus Walleij <linus.walleij@stericsson.com>:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> This creates a subsystem for handling of pin control devices.
> These are devices that control different aspects of package
> pins.
>
> Currently it handled pinmuxing, i.e. assign electronic functions
> to groups of pins of pins on primarily PGA and BGA type of chip
> packages and common in embedded systems.
>
> The plan is to also handle other I/O pin control aspects such as
> biasing, driving, input properties such as schmitt-triggering,
> load capacitance etc within this subsystem.
>
> This is being done to depopulate the arch/arm/* directory of such
> custom drivers and try to abstract the infrastructure they all
> need. See the Documentation/pinmux.txt file that is part of this
> patch for more details.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Barry Song <baohua.song@csr.com>

even there are still many discussions about data model and
device/function mapping, it is basically usable to CSR SiRFprimaII.
Then i moved the old prima2 pinmux to this framework and made some
basic tests.
Basic APIs like pinmux_get/pinmux_enable/pinmux_disable/pinmux_put
should be working.

Linus, i'll also send the patch of csr pinmux prototype. you might
review and take it as another example except your stericsson U300 and
take care while you merge pinmux.

> ---
> ?Documentation/ABI/testing/sysfs-class-pinmux | ? 11 +
> ?Documentation/pinctrl.txt ? ? ? ? ? ? ? ? ? ?| ?512 +++++++++++++++++++
> ?MAINTAINERS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?5 +
> ?drivers/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?4 +
> ?drivers/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +
> ?drivers/pinctrl/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? 29 ++
> ?drivers/pinctrl/Makefile ? ? ? ? ? ? ? ? ? ? | ? ?6 +
> ?drivers/pinctrl/core.c ? ? ? ? ? ? ? ? ? ? ? | ?437 ++++++++++++++++
> ?drivers/pinctrl/core.h ? ? ? ? ? ? ? ? ? ? ? | ? 22 +
> ?drivers/pinctrl/pinmux.c ? ? ? ? ? ? ? ? ? ? | ?700 ++++++++++++++++++++++++++
> ?drivers/pinctrl/pinmux.h ? ? ? ? ? ? ? ? ? ? | ? ?4 +
> ?include/linux/pinctrl/machine.h ? ? ? ? ? ? ?| ? 62 +++
> ?include/linux/pinctrl/pinctrl.h ? ? ? ? ? ? ?| ?120 +++++
> ?include/linux/pinctrl/pinmux.h ? ? ? ? ? ? ? | ?122 +++++
> ?14 files changed, 2036 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/ABI/testing/sysfs-class-pinmux
> ?create mode 100644 Documentation/pinctrl.txt
> ?create mode 100644 drivers/pinctrl/Kconfig
> ?create mode 100644 drivers/pinctrl/Makefile
> ?create mode 100644 drivers/pinctrl/core.c
> ?create mode 100644 drivers/pinctrl/core.h
> ?create mode 100644 drivers/pinctrl/pinmux.c
> ?create mode 100644 drivers/pinctrl/pinmux.h
> ?create mode 100644 include/linux/pinctrl/machine.h
> ?create mode 100644 include/linux/pinctrl/pinctrl.h
> ?create mode 100644 include/linux/pinctrl/pinmux.h
>

Thanks
Barry
