From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 25 Feb 2011 07:38:23 +0100
Subject: [TRIVIAL/PATCH] ARM: hw_breakpoint: Fix newlines in WARN messages
In-Reply-To: <1298573739-25144-1-git-send-email-sboyd@codeaurora.org>
References: <1298573739-25144-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <19815.20063.647326.437650@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Stephen Boyd writes:
> These warnings are missing newlines and spaces causing confusing
> looking output when they trigger.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/kernel/hw_breakpoint.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index d600bd3..5aab00e 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -238,8 +238,8 @@ static int enable_monitor_mode(void)
>  	ARM_DBG_READ(c1, 0, dscr);
>  
>  	/* Ensure that halting mode is disabled. */
> -	if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN, "halting debug mode enabled."
> -				"Unable to access hardware resources.")) {
> +	if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN, "halting debug mode enabled. "
> +				"Unable to access hardware resources.\n")) {
>
I'd prefer the message text not to be line wrapped, even if it
violates the general line length rule, because that makes it easier to
grep for the message in the source code.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
