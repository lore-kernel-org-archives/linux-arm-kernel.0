From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 29 Mar 2011 18:43:45 +0200
Subject: [PATCH 1/4] arm: lpc32xx: add tsc-device
In-Reply-To: <1301328090-25994-1-git-send-email-w.sang@pengutronix.de>
References: <1301328090-25994-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F811ECEDC208@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thanks for submitting these. These all look good!

> +/* TSC (Touch Screen Controller) */
> +
> +static struct resource lpc32xx_tsc_resources[] = {
> +	{
> +		.start = LPC32XX_ADC_BASE,
> +		.end = LPC32XX_ADC_BASE + SZ_16K - 1,

The LPC32xx user's guide spaces peripheral register sets 16K apart,
but internally the register blocks are 4K or smaller. I'm not sure
why these need to be setup as 16K instead of 4K. Hmm, maybe I'm
missing something here?

Kevin
