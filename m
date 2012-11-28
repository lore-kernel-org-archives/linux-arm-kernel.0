From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Nov 2012 10:32:42 +0800
Subject: [PATCH 6/6 v6] cpufreq, highbank: add support for highbank cpufreq
In-Reply-To: <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <20121128023240.GA28170@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 02:04:32PM -0600, Mark Langsdorf wrote:
> Highbank processors depend on the external ECME to perform voltage
> management based on a requested frequency. Communication between the
> A9 cores and the ECME happens over the pl320 IPC channel.

...

> +static int hb_voltage_change(unsigned int freq)
> +{
> +	int i;
> +	u32 msg[7];
> +
> +	msg[0] = HB_CPUFREQ_CHANGE_NOTE;
> +	msg[1] = freq / 1000;
> +	for (i = 2; i < 7; i++)
> +		msg[i] = 0;
> +
> +	return pl320_ipc_transmit(msg);

Is it possible to have this handled inside clk_set_rate() call of cpu
clock?

Shawn

> +}
