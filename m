From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Feb 2016 17:35:17 +0100
Subject: [PATCH 0/3] ARM: mvebu: Add driver for the Zyxel NSA3XX hwmon MCU
In-Reply-To: <1455147224-6742-1-git-send-email-linux@baker-net.org.uk> (Adam
 Baker's message of "Wed, 10 Feb 2016 23:33:41 +0000")
References: <1455147224-6742-1-git-send-email-linux@baker-net.org.uk>
Message-ID: <87mvr5x4xm.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,
 
 On jeu., f?vr. 11 2016, Adam Baker <linux@baker-net.org.uk> wrote:

> This patch series adds a driver to support the hardware monitoring MCU
> that is present in some models of the Zyxel NSA3xx series of NAS units.
>
> A patch is included to add it to the device tree for the NSA320 model,
> patches to the other device trees will be included if testers come
> forward (I already have a possible tester for NSA325).
>
> There are no dependencies between the patches so I guess the first two
> should go via the hardware monitoring maintainers and the third via
> the ARM mvebu maintainers.

You are right. However the first tow patch are misnamed, they better
should be called:
hwmn: Define binding for the nsa3xx-hwmon driver
hwmn: Create a driver to support the hardware monitoring chip

The last patch seems OK for me, and the binding has been approved. So
when you will get a review from the hwmon maintainer, I will apply the
last patch in the mvebu tree.

Thanks,

Gregory

>
>  [PATCH 1/3] Define a binding for the hardware monitoring chip present
>  [PATCH 2/3] Create a driver to support the hardware monitoring chip
>  [PATCH 3/3] Add an entry for the hardware monitoring MCU
>
>  Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt |  21 ++++++++
>  arch/arm/boot/dts/kirkwood-nsa320.dts                  |  13 ++++-
>  drivers/hwmon/Kconfig                                  |  13 +++++
>  drivers/hwmon/Makefile                                 |   1 +
>  drivers/hwmon/nsa3xx-hwmon.c | 223
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 269 insertions(+), 2 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
