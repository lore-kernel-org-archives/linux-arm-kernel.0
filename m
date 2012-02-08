From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Feb 2012 10:46:08 -0800
Subject: [PATCH 06/16] ARM: omap: fix uninformative vc/i2c
 configuration error message
In-Reply-To: <E1RvAWj-0006HB-7D@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAWj-0006HB-7D@rmk-PC.arm.linux.org.uk>
Message-ID: <20120208184608.GF29796@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:06]:
> On my OMAP4 platform, I'm getting this error message repeated several
> times at boot:
> 
> omap_vc_i2c_init: I2C config for all channels must match.
> omap_vc_i2c_init: I2C config for all channels must match.
> 
> This doesn't help identify what the problem is.  Fix this message to
> be more informative:
> 
> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).
> 
> This allows us to identify which voltage domains have a problem, and
> what the I2C configuration state (a boolean, i2c_high_speed) setting
> being used actually is.
> 
> omap4_iva_pmic and omap4_mpu_pmic both have it set true.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
