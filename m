From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Aug 2011 17:25:42 +0200
Subject: [PATCH 4/4] Move top level platform devices in sysfs to
	/sys/devices/soc/X
In-Reply-To: <1312981422-13294-4-git-send-email-lee.jones@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-4-git-send-email-lee.jones@linaro.org>
Message-ID: <201108241725.42549.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 August 2011, Lee Jones wrote:
> At the request of Arnd Bergmann this patch moves all SoC
> platform devices found in sysfs from /sys/devices/platform to
> /sys/devices/soc/<SoCNum>/. It is believed as the devices are
> SoC specific and a /sys/devices/soc node has recently become
> available, that this would be a more appropriate place to
> display the data.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c   |   19 +++++++++++++++----
>  arch/arm/mach-ux500/board-u5500.c    |    6 ++++++
>  arch/arm/mach-ux500/cpu-db5500.c     |    6 ++++++
>  arch/arm/mach-ux500/cpu-db8500.c     |   12 +++++++++++-
>  arch/arm/mach-ux500/devices-common.c |   19 +++++++++++++++----
>  arch/arm/mach-ux500/usb.c            |    4 ++++
>  6 files changed, 57 insertions(+), 9 deletions(-)
> 

Ok. What does the device tree in /sys/devices look like after this?

Does it match the flattened device tree description that you will have?

	Arnd
