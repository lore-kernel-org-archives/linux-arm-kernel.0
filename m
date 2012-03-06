From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2012 21:34:37 +0000
Subject: [PATCH v5] lpc32xx: Added ethernet driver
In-Reply-To: <1331067664-9124-1-git-send-email-stigge@antcom.de>
References: <1331067664-9124-1-git-send-email-stigge@antcom.de>
Message-ID: <201203062134.38077.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roland,

One more thing I noticed this time:

On Tuesday 06 March 2012, Roland Stigge wrote:
> +static inline phy_interface_t lpc_phy_interface_mode(void)
> +{
> +#ifdef CONFIG_ARCH_LPC32XX_MII_SUPPORT
> +       return PHY_INTERFACE_MODE_MII;
> +#else
> +       return PHY_INTERFACE_MODE_RMII;
> +#endif
> +}
> +
> +static inline int use_iram_for_net(void)
> +{
> +#ifdef CONFIG_ARCH_LPC32XX_IRAM_FOR_NET
> +       return 1;
> +#else
> +       return 0;
> +#endif
> +}

This should eventually both become run-time options based on the device tree.
I don't know if you planned to do that anyway, but if you want the same kernel
binary to be used for systems in different configurations, you cannot have
compile-time decisions that are exclusive-or. Since you don't support device
tree yet but plan to do that in the future, you could add a comment here
about it, or you could even prepare it for that case already by passing the
device into the functions that will be required for reading the properties.

	Arnd
