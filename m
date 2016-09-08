From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 08 Sep 2016 17:16:12 +0200
Subject: [PATCH v2 2/2] arm64: dts: rk3399: add powerdomain for typec
In-Reply-To: <1473289577-14101-2-git-send-email-zyw@rock-chips.com>
References: <1473289577-14101-1-git-send-email-zyw@rock-chips.com>
 <1473289577-14101-2-git-send-email-zyw@rock-chips.com>
Message-ID: <1502775.CkB0Rhdvgx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 7. September 2016, 16:06:17 CEST schrieb Chris Zhong:
> The tcpc power domain will try to power up/down the power of Type-C PHY.
> Hence, we need control it in Type-C PHY driver with the pm_runtime helper.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

applied to my dts64 branch for 4.9 (or 4.10) after fixing the subject 
(rockchip: instead of rk3399:), as even without the advanced logic from patch1 
the driver core will already make sure to at least powerup the domain before 
probe and power-down after remove.


Heiko
