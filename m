From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 16:45:32 +0200
Subject: [PATCH v3 13/26] ARM: pxa: magician: Fix and add charging
 detection functions
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FA48A0.9090709@tul.cz>
Message-ID: <87eghli6di.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patch fixes the charging detection functions for pda_power driver
> (according to newly discovered EGPIOs) and add NiCd backup accumulator
> charging support.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
> +static int magician_is_usb_online(void)
> +{
> +	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERTED) &&
> +		(!gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE)); /* USB=0 */
No need to the extra parenthesis, just :
> +	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERTED) &&
> +		!gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE); /* USB=0 */

As the remaining looks sgood to me, I'll wait for a week for Philipp's ack and
queuing it after with this parenthesis thing fixed, won't cost me much.

Cheers.

--
Robert
