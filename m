From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 19 Oct 2011 11:05:02 +0530
Subject: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
	for	debug_prints
In-Reply-To: <1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
	<1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govindraj,

On Tue, Oct 18, 2011 at 21:05:41, R, Govindraj wrote:
> If OMAP UART is used as console uart and debug is enabled,
> avoid gating of uart clocks to print all debug prints.
: 
:
>  			console_uart_id = uart->num;
>  
> +			if (cmdline_find_option("debug")) {
> +				uart_debug = true;

Shouldn't "loglevel" also be checked?

Regards
Afzal
