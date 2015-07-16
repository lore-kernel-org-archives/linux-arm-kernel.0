From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 16 Jul 2015 17:36:17 +0200
Subject: [PATCH v3] serial: mxs-auart: keep the AUART unit in reset state
 when not in use
In-Reply-To: <1437032458-8577-1-git-send-email-jbe@pengutronix.de>
References: <1437032458-8577-1-git-send-email-jbe@pengutronix.de>
Message-ID: <55A7CF71.7050507@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Whenever the UART device driver gets closed from userland, the driver
> disables the UART unit and then stops its clock to save power.
>
> The bit which disabled the UART unit is described as:
>
>   "UART Enable. If this bit is set to 1, the UART is enabled. Data
>   transmission and reception occurs for the UART signals. When the
>   UART is disabled in the middle of transmission or reception, it
>   completes the current character before stopping."
>
> The important part is the "it completes the current character". Whenever
> a reception is ongoing when the UART gets disabled (including the clock
> off) the statemachine freezes and "remembers" this state on the next
> open() and re-enabling of the unit's clock.
>
> In this case we end up receiving an additional bogus character
> immediately.
>
> The solution in this change is to move the AUART unit into its reset
> state on close() and only release it from its reset state on the next
> open().
>
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> ---

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks
Stefan
