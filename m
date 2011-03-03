From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 03 Mar 2011 15:22:37 +0300
Subject: [patch v2 1/2] mc13892: reboot on wdi event
In-Reply-To: <20110302185000.369378760@rtp-net.org>
References: <20110302184512.512010086@rtp-net.org>
	<20110302185000.369378760@rtp-net.org>
Message-ID: <4D6F880D.3000207@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-03-2011 21:45, Arnaud Patard (Rtp) wrote:

> By default, on wdi (watchdog input) event the mc13892 is powering off.
> This patch allows to change this behaviour throught platform_data.

    Er, for some reason, this patch was in attachment...

> v2:
> - move to mc13xxx-core
> - make it configurable

> Signed-off-by: Arnaud Patard<arnaud.patard@rtp-net.org>

> Index: linux-2.6-submit/drivers/mfd/mc13xxx-core.c
> ===================================================================
> --- linux-2.6-submit.orig/drivers/mfd/mc13xxx-core.c	2011-03-01 22:26:40.000000000 +0100
> +++ linux-2.6-submit/drivers/mfd/mc13xxx-core.c	2011-03-02 12:24:30.000000000 +0100
> @@ -136,6 +136,9 @@
>   #define MC13XXX_REVISION_FAB		(0x03 << 11)
>   #define MC13XXX_REVISION_ICIDCODE	(0x3f << 13)
>
> +#define MC13892_POWERCTL2		15
> +#define MC13892_POWERCTL2_WDIRESET	(1<<12)

    Please add spaces around << to@least be consistent with the code above 
and below.

> +
>   #define MC13783_ADC1		44
>   #define MC13783_ADC1_ADEN		(1 << 0)
>   #define MC13783_ADC1_RAND		(1 << 1)
[...]
> @@ -734,6 +738,15 @@
>   	if (ret || id == MC13XXX_ID_INVALID)
>   		goto err_revision;
>
> +	if ((id == MC13XXX_ID_MC13892) && pdata->wdi_reboot) {

    Parens around == not necessary.

WBR, Sergei
