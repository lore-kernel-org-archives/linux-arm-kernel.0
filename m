From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Oct 2018 13:04:02 +0100
Subject: [PATCH V2 4/8] gpio: vf610: add optional clock support
In-Reply-To: <1540295058-26090-5-git-send-email-aisheng.dong@nxp.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181023120401.GO30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 11:49:17AM +0000, A.s. Dong wrote:
> +	clk_gpio = devm_clk_get(&pdev->dev, "gpio");
> +	clk_port = devm_clk_get(&pdev->dev, "port");
> +	if ((PTR_ERR(clk_gpio) == -EPROBE_DEFER) ||
> +	    (PTR_ERR(clk_port) == -EPROBE_DEFER)) {

	if (clk_gpio == ERR_PTR(-EPROBE_DEFER) ||
	    clk_port == ERR_PTR(-EPROBE_DEFER)) {

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
