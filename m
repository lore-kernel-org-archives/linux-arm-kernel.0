From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 22 Dec 2015 13:23:20 +0100
Subject: [PATCH 2/2] ARM: mvebu: use regulator-boot-on on Armada 388 GP
In-Reply-To: <1450708916-15966-3-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Mon, 21 Dec 2015 15:41:56 +0100")
References: <1450708916-15966-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1450708916-15966-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87fuyur7t3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On lun., d?c. 21 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Really, what we meant by regulator-always-on is that the regulators
> are already turned on by the bootloader, for which regulator-boot-on
> is a better description.
>

What happened if the bootloader do not turn the regulator on?
I fear that in this case the regulator won't be turned on at all.

> A net advantage of using regulator-boot-on is that the regulator is
> not touched at boot time by the kernel, which avoids having the hard
> drives spinning down and then up again, taking several (~5) seconds of
> additional boot time.
>
> In addition, there is no need to have such properties on the child
> regulators used for SATA. Having it on the parent regulator that
> really controls the GPIO is sufficient.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-388-gp.dts | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
> index d8dab0f..1ef6cc6 100644

>  
> @@ -309,7 +309,7 @@
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
>  		enable-active-high;
> -		regulator-always-on;
> +		regulator-boot-on;
>  		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
>  	};
This node had been removed by a patch you sent few days ago:
"ARM: mvebu: remove duplicated regulator definition in Armada 388 GP"

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
