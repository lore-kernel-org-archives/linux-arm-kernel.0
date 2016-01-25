From: tbm@cyrius.com (Martin Michlmayr)
Date: Mon, 25 Jan 2016 13:45:47 -0800
Subject: ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD
In-Reply-To: <87zivteq7t.fsf@free-electrons.com>
References: <20160111042540.GA31022@jirafa.cyrius.com>
 <87zivteq7t.fsf@free-electrons.com>
Message-ID: <20160125214547.GB12980@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Gregory CLEMENT <gregory.clement@free-electrons.com> [2016-01-25 14:36]:
>  On lun., janv. 11 2016, Martin Michlmayr <tbm@cyrius.com> wrote:
> > OpenRD-Client requires the CS42L51 codec.
> 
> This patch do not apply anymore on v4.5-rc1.
> 
> Could you regenerate it, please?
> 
> Then I will apply it on mvebu/defconfig with Andrew'w Reviewed-by tag.

ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD

OpenRD-Client requires the CS42L51 codec.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index af29780..9317e5a 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -137,6 +137,7 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_KIRKWOOD_SOC=y
 CONFIG_SND_SOC_ALC5623=y
+CONFIG_SND_SOC_CS42L51_I2C=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_HID_DRAGONRISE=y
 CONFIG_HID_GYRATION=y

-- 
Martin Michlmayr
http://www.cyrius.com/
