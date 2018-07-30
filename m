From: davem@davemloft.net (David Miller)
Date: Mon, 30 Jul 2018 09:25:45 -0700 (PDT)
Subject: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
In-Reply-To: <20180730100154.27906-3-yangbo.lu@nxp.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
Message-ID: <20180730.092545.225621578249887012.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Mon, 30 Jul 2018 18:01:54 +0800

> +static unsigned int cksel = DEFAULT_CKSEL;
> +module_param(cksel, uint, 0644);
> +MODULE_PARM_DESC(cksel, "Select reference clock");
> +
> +static unsigned int clk_src;
> +module_param(clk_src, uint, 0644);
> +MODULE_PARM_DESC(clk_src, "Reference clock frequency (if clocks property not provided in dts)");
> +
> +static unsigned int tmr_prsc = 2;
> +module_param(tmr_prsc, uint, 0644);
> +MODULE_PARM_DESC(tmr_prsc, "Output clock division/prescale factor");
> +
> +static unsigned int tmr_fiper1 = 1000000000;
> +module_param(tmr_fiper1, uint, 0644);
> +MODULE_PARM_DESC(tmr_fiper1, "Desired fixed interval pulse period (ns)");
> +
> +static unsigned int tmr_fiper2 = 100000;
> +module_param(tmr_fiper2, uint, 0644);
> +MODULE_PARM_DESC(tmr_fiper2, "Desired fixed interval pulse period (ns)");

Sorry, there is no way I am every applying something like this.  Module
parameters are to be avoided at all costs.

And you don't need it here, you have DTS, please use it.

You are required to support the existing DTS cases, in order to
avoid breaking things, anyways.
