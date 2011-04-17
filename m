From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Apr 2011 20:40:33 +0200
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <1302792592-17484-3-git-send-email-lee.jones@linaro.org>
References: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
	<1302792592-17484-3-git-send-email-lee.jones@linaro.org>
Message-ID: <201104172040.34082.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 April 2011, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/Kconfig |    1 +
>  arch/arm/mach-ux500/id.c    |   96 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 0 deletions(-)
> 

NAK

As I explained in one or more of the previous email exchanges, the SoC
device really needs to represent the SoC, we don't just create random
crap in sysfs in order to stick attributes there.

You have to make sure that all devices that are part of the soc on ux500
are children of the soc device. Please list the contents of
/sys/devices/platform and /sys/devices/soc/*/ in your changelog, before
and after the patch is applied.

	Arnd
