From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 6 Jul 2013 01:49:45 +0200 (CEST)
Subject: [PATCH 5/9] clocksource: dw_apb_timer: quirk for variants without
 EOI register
In-Reply-To: <201307060054.07784.heiko@sntech.de>
References: <201307060051.09716.heiko@sntech.de>
 <201307060054.07784.heiko@sntech.de>
Message-ID: <alpine.DEB.2.02.1307060147070.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 6 Jul 2013, Heiko St?bner wrote:
> -	dw_ced->eoi = apbt_eoi;
> +	if (quirks & APBTMR_QUIRK_NO_EOI)
> +		dw_ced->eoi = apbt_eoi_int_status;
> +	else
> +		dw_ced->eoi = apbt_eoi;

No again. This has nothing to do with quirks. We use quirks for
workarounds and not for refactoring of code.

Thanks,

	tglx
