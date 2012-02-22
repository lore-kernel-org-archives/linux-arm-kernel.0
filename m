From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 23 Feb 2012 09:24:30 +1100
Subject: [PATCH v2 05/19] ARM: at91/ST: remove not needed casts
In-Reply-To: <7fc3c7e0093a675e205fe1763de7dfccdda8e692.1329903206.git.nicolas.ferre@atmel.com>
References: <1329903585-30738-1-git-send-email-nicolas.ferre@atmel.com>
 <7fc3c7e0093a675e205fe1763de7dfccdda8e692.1329903206.git.nicolas.ferre@atmel.com>
Message-ID: <4F456B1E.1080700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/02/12 20:39, Nicolas Ferre wrote:

> Remove the unnecessary (void) cast on at91_st_read()
> return value.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>


Thanks Nicolas.

Acked-by: Ryan Mallon <rmallon@gmail.com>

> ---
>  arch/arm/mach-at91/at91rm9200_time.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> index 0c1980c..dd7f782 100644
> --- a/arch/arm/mach-at91/at91rm9200_time.c
> +++ b/arch/arm/mach-at91/at91rm9200_time.c
> @@ -111,7 +111,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
>  {
>  	/* Disable and flush pending timer interrupts */
>  	at91_st_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
> -	(void) at91_st_read(AT91_ST_SR);
> +	at91_st_read(AT91_ST_SR);
>  
>  	last_crtr = read_CRTR();
>  	switch (mode) {
> @@ -157,7 +157,7 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
>  
>  	/* Cancel any pending alarm; flush any pending IRQ */
>  	at91_st_write(AT91_ST_RTAR, alm);
> -	(void) at91_st_read(AT91_ST_SR);
> +	at91_st_read(AT91_ST_SR);
>  
>  	/* Schedule alarm by writing RTAR. */
>  	alm += delta;
> @@ -192,7 +192,7 @@ void __init at91rm9200_timer_init(void)
>  	/* Disable all timer interrupts, and clear any pending ones */
>  	at91_st_write(AT91_ST_IDR,
>  		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
> -	(void) at91_st_read(AT91_ST_SR);
> +	at91_st_read(AT91_ST_SR);
>  
>  	/* Make IRQs happen for the system timer */
>  	setup_irq(AT91_ID_SYS, &at91rm9200_timer_irq);
