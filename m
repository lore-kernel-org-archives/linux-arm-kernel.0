From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 Oct 2014 15:55:10 +0200
Subject: [PATCH 4/4] ARM: dts: Enable the reference clock for timer and
 watchdog on Armada 375 SoC
In-Reply-To: <1413984884-20273-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413984884-20273-5-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141022155510.5fee5f8e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 22 Oct 2014 10:34:44 -0300, Ezequiel Garcia wrote:

> -				clocks = <&coreclk 0>;
> +				clocks = <&refclk>;
> +				clock-names = "fixed";

Why not do like we do on Armada XP, and actually represent the
hardware, by showing that it takes two clocks as input:

                        timer at 20300 {
                                compatible = "marvell,armada-xp-timer";
                                clocks = <&coreclk 2>, <&refclk>;
                                clock-names = "nbclk", "fixed";
                        };



>  			watchdog at 20300 {
>  				compatible = "marvell,armada-375-wdt";
>  				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18254 0x4>;
> -				clocks = <&coreclk 0>;
> +				clocks = <&refclk>;
> +				clock-names = "fixed";
>  			};

Ditto.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
