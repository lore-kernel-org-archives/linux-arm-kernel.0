From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jun 2014 15:54:56 +0200
Subject: [PATCH v5 2/2] i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface)
 controller support
In-Reply-To: <1402408036-5235-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1402408036-5235-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402408036-5235-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <6454089.IP8IFVsofj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 June 2014 15:47:16 Boris BREZILLON wrote:
> 
> +config I2C_SUN6I_P2WI
> +       tristate "Allwinner sun6i internal P2WI controller"
> +       depends on ARCH_SUNXI
> +       help
> +         If you say yes to this option, support will be included for the
> +         P2WI (Push/Pull 2 Wire Interface) controller embedded in some sunxi
> +         SOCs.
> +         The P2WI looks like an SMBus controller (which supports only byte
> +         accesses), except that it only supports one slave device.
> +         This interface is used to connect to specific PMIC devices (like the
> +         AXP221).
> +

Sorry for the stupid question, but why is this an i2c driver if the
hardware protocol is completely different?

I understand that a lot of devices can be driven using either spi or
i2c, and we have two sets of {directories,maintainers,bus_types,...}
for them. Your description sounds like this is a separate option
that isn't any closer to i2c than it is to spi.

Would it perhaps be better to expose it only as a regmap rather than
an i2c host?

	Arnd
