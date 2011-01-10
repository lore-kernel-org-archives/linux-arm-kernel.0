From: maz@misterjones.org (Marc Zyngier)
Date: Mon, 10 Jan 2011 15:18:10 +0100
Subject: [PATCH 2/3] omap3: igep3: Fix IGEP module second MMC channel power
	supply.
In-Reply-To: <1294665974-10590-3-git-send-email-eballetbo@gmail.com>
References: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
	<1294665974-10590-3-git-send-email-eballetbo@gmail.com>
Message-ID: <2a90cfc8fdf83d0adb67c16d2be97784@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 10 Jan 2011 14:26:13 +0100, Enric Balletbo i Serra
<eballetbo@gmail.com> wrote:
> The second MMC channel (used by the WLAN/BT module) is not linked to
> power regulator. This causes the WLAN/BT module to fail being detected
if
> CONFIG_REGULATOR_DUMMY is not set.
> 
> This patch adds the two regulators that actually feed the WLAN/BT module
> (1v8 from the TWL4030 VIO LDO, and a fixed 3v3). With that patch, the
> second channel is properly detected.
> 
> Also change vmmc1 to use symbolic names instead of direct device
> reference.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>

Acked-by: Marc Zyngier <maz@misterjones.org>
-- 
Who you jivin' with that Cosmik Debris?
