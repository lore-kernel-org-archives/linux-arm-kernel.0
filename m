From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Mar 2013 14:58:59 +0100
Subject: [PATCH 05/10] arm: mach-mvebu: convert to use mvebu-mbus driver
In-Reply-To: <1362577426-12804-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130306145859.56cc0f93@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed,  6 Mar 2013 14:43:41 +0100, Thomas Petazzoni wrote:
> The changes needed to migrate the mach-mvebu (Armada 370 and Armada
> XP) to the mvebu-mbus driver are fairly minimal, since not many
> devices currently supported on those SoCs use address decoding
> windows. The only one being the BootROM window, used to bring up
> secondary CPUs.
> 
> However, this BootROM window needed for SMP brings an important
> requirement: the mvebu-mbus driver must be initialized at the
> ->early_init() time, otherwise the BootROM window cannot be setup
> early enough to be ready before the secondary CPUs are started.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Of course, a v1 can't be good...

> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 8188d13..e46955b 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -39,6 +39,9 @@
>  	};
>  
>  	soc {
> +		compatible = "marvell,armadaxp-mbus", "simple-bus";

This should be armada370-mbus.


> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index 1c6fbf4..481a5ba 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c

And all this shouldn't have been there, but instead should have gone
into 04/10. That's a rebase -i mistake.

Ignore this patch series, I'll resend a v2 that fixes this problem.

Sorry for the noise,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
