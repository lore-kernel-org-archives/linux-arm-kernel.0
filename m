From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 May 2018 10:40:33 +0100
Subject: [PATCH] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <1527066324-24726-1-git-send-email-ilialin@codeaurora.org>
References: <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <1527066324-24726-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180523094033.GW17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 12:05:24PM +0300, Ilia Lin wrote:
> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +	if (IS_ERR(np))
> +		return PTR_ERR(np);
...
> +
> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +	if (!IS_ERR(pdev))

Do you need to hold a reference to `np' here?

> +		return 0;

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
