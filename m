From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jan 2015 12:52:43 +0000
Subject: [PATCH v3 5/8] gpio: Add Fujitsu MB86S7x GPIO driver
In-Reply-To: <1420803212-4350-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1420802369-3840-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420803212-4350-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <20150109125243.GM12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 07:33:32PM +0800, Vincent Yang wrote:
> +static int mb86s70_gpio_remove(struct platform_device *pdev)
> +{
> +	struct mb86s70_gpio_chip *gchip = platform_get_drvdata(pdev);
> +
> +	gpiochip_remove(&gchip->gc);

This doesn't disable and unprepare the clock.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
