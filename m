From: petr.cvek@tul.cz (Petr Cvek)
Date: Tue, 18 Aug 2015 00:18:47 +0200
Subject: [PATCH v2 13/21] ARM: pxa: magician: Fix charging source and add
 NiCd backup charging
In-Reply-To: <55D25A1B.50106@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25A1B.50106@tul.cz>
Message-ID: <55D25DC7.7040200@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 18.8.2015 v 00:03 Petr Cvek napsal(a):
> +static int magician_is_usb_online(void)
> +{
> +	my_usb_online = gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERT1) &&
> +		(!gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE)); /* USB=0 */
> +	return my_usb_online;
>  }

This patch requires my_usb_online variable defined by 

	[PATCH v2 12/21] ARM: pxa: magician: Add PXA27x UDC support

because both (UDC and charging) require same EGPIO.


Petr
