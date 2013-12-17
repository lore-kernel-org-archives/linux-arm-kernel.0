From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Dec 2013 11:10:48 +0800
Subject: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
In-Reply-To: <1387228450-641-2-git-send-email-b20788@freescale.com>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
Message-ID: <20131217031045.GF6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 04:14:10PM -0500, Anson Huang wrote:
> @@ -201,9 +238,75 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_node;
>  	}
>  
> +	prop = of_find_property(np, "fsl,soc-operating-points", NULL);

This is a new property, and it should be documented in binding doc.
Remember to copy devicetree at vger.kernel.org when you send a patch with
binding doc update.

Shawn
