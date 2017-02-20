From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 20 Feb 2017 15:51:03 +0530
Subject: [PATCH 3/4] ARM: da850-evm: add a fixed regulator for the UI
 board IO expander
In-Reply-To: <1487269285-6948-4-git-send-email-bgolaszewski@baylibre.com>
References: <1487269285-6948-1-git-send-email-bgolaszewski@baylibre.com>
 <1487269285-6948-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <850248e4-b0e7-2e42-40a3-f0ede456b391@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 February 2017 11:51 PM, Bartosz Golaszewski wrote:
> Without this regulator the tca6416 GPIO expander on the UI board can't
> be probed in board file mode and we're not getting VPIF IRQs.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 0b9ff2a..1b6a07b 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -828,6 +828,9 @@ static struct regulator_consumer_supply fixed_supplies[] = {
>  
>  	/* Baseboard 1.8V: 5V -> TPS73701DCQ -> 1.8V */
>  	REGULATOR_SUPPLY("DVDD", "1-0018"),
> +
> +	/* Dummy regulator for the UI board IO expander. */

Instead may be:

	/* UI card 3.3V: 5V -> TPS73701DCQ -> 3.3V */

> +	REGULATOR_SUPPLY("vcc", "1-0020"),

Thanks,
Sekhar
