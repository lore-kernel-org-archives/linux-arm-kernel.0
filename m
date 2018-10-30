From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 30 Oct 2018 15:18:06 +0100
Subject: [PATCH V2] DT: rockchip: Fix stability issues with the
 'performance' governor on rock960
In-Reply-To: <1539767918-26587-1-git-send-email-daniel.lezcano@linaro.org>
References: <1539767918-26587-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <10930709.0rTHelch2x@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. Oktober 2018, 11:18:30 CET schrieb Daniel Lezcano:
> When the performance governor is set as default, the rock960 hangs
> around one minute after booting, whatever the activity is (idle, key
> pressed, loaded, ...).
> 
> Based on the commit log found at https://patchwork.kernel.org/patch/10092377/
> 
> "vdd_log has no consumer and therefore will not be set to a specific
> voltage. Still the PWM output pin gets configured and thence the vdd_log
> output voltage will changed from it's default. Depending on the idle
> state of the PWM this will slightly over or undervoltage the logic supply
> of the RK3399 and cause instability with GbE (undervoltage) and PCIe
> (overvoltage). Since the default value set by a voltage divider is the
> correct supply voltage and we don't need to change it during runtime we
> remove the rail from the devicetree completely so the PWM pin will not
> be configured."
> 
> After removing the vdd-log from the rock960's specific DT, the board
> does no longer hang and shows a stable behavior.
> 
> Apply the same change for the rock960 by removing the vdd-log from the
> DT.
> 
> Fixes: 874846f1fccd ("arm64: dts: rockchip: add 96boards RK3399 Ficus board")
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

applied as fix for 4.20
after including a stable-tag (board entered in previous kernel version)
and modified subject line a bit.


Thanks
Heiko
