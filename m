From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 07 Dec 2016 17:48:24 +0100
Subject: [PATCH 8/9] arm64: dts: rockchip: partially describe PWM
 regulators for Gru
In-Reply-To: <1480645653-36943-9-git-send-email-briannorris@chromium.org>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
 <1480645653-36943-9-git-send-email-briannorris@chromium.org>
Message-ID: <2418784.7dMdkAyuIx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

Am Donnerstag, 1. Dezember 2016, 18:27:32 CET schrieb Brian Norris:
> We need to add regulators to the CPU nodes, so cpufreq doesn't think it
> can crank up the clock speed without changing the voltage. However, we
> don't yet have the DT bindings to fully describe the Over Voltage
> Protection (OVP) circuits on these boards. Without that description, we
> might end up changing the voltage too much, too fast.
> 
> Add the pwm-regulator descriptions and associate the CPU OPPs, but leave
> them disabled.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

is there a specific reason for keeping this change separate?
While it is nice for documentation reasons, as it stands now the previous 
patch introduces a regression (cpufreq trying to scale without regulators) and 
immediately fixes it here.

So if you're ok with it, I'd like to merge this one back into the previous 
patch when applying.


Heiko
