From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 22 Feb 2011 14:20:56 +0300
Subject: [PATCH v2 12/13] da850: pruss SUART platform specific additions.
In-Reply-To: <B2D7D72494BB443F80DA08E22323999B@subhasishg>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-13-git-send-email-subhasish@mistralsolutions.com>
	<4D55860E.3090908@mvista.com>
	<B2D7D72494BB443F80DA08E22323999B@subhasishg>
Message-ID: <4D639C18.9010309@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-02-2011 12:18, Subhasish Ghosh wrote:

> I could not follow your recommendations clearly, are you suggesting this:

> int __init da8xx_register_pruss(struct da8xx_pruss_devices *pruss_device)
> {
> #ifdef CONFIG_SERIAL_PRUSS_SUART_MODULE
> int ret;
>
> ret = clk_add_alias(NULL, "da8xx_pruss_uart.1",
> NULL, &da850_mcasp_device.dev);
> if (ret < 0)
> return ret;
> #endif
> da8xx_pruss_dev.dev.platform_data = pruss_device;
> return platform_device_register(&da8xx_pruss_dev);
> }

    Yes. But still better would be to wrap clk_add_alias() into a function of 
its own (defining it empty if CONFIG_SERIAL_PRUSS_SUART_MODULE is not defined).

WBR, Sergei
