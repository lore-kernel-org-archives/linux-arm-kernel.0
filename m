From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Oct 2017 10:51:12 +0100
Subject: [PATCH v7 2/6] ARM: smp_scu: add a helper for powering on a
 specific CPU
In-Reply-To: <20170917164523.6970-3-martin.blumenstingl@googlemail.com>
References: <20170917164523.6970-1-martin.blumenstingl@googlemail.com>
 <20170917164523.6970-3-martin.blumenstingl@googlemail.com>
Message-ID: <20171023095111.GP20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 06:45:19PM +0200, Martin Blumenstingl wrote:
> To boot the secondary CPUs on the Amlogic Meson8/Meson8m2 (Cortex-A9)
> and Meson8b (Cortex-A5) SoCs we have to enable SCU mode SCU_PM_NORMAL,
> otherwise the secondary cores will not start.
> This patch adds a scu_cpu_power_enable() function which can be used to
> enable SCU_PM_NORMAL for a specific (logical) CPU. An internal helper
> function is also created, to avoid code duplication with
> scu_power_mode().
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
