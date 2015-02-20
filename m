From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Feb 2015 17:48:36 +0000
Subject: [RFC PATCH 3/3] eeprom: qfprom: Add Qualcomm QFPROM support.
In-Reply-To: <1424365731-26768-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1424365639-26634-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424365731-26768-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150220174836.GK8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 05:08:51PM +0000, Srinivas Kandagatla wrote:
> +static int qfprom_remove(struct platform_device *pdev)
> +{
> +	struct eeprom_device *eeprom = platform_get_drvdata(pdev);
> +
> +	return eeprom_unregister(eeprom);

Same problem...

> +static int qfprom_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	void __iomem *base;
> +	struct device *dev = &pdev->dev;
> +	struct eeprom_device *eeprom;
> +	int rval;
> +
> +	eeprom = devm_kzalloc(dev, sizeof(*eeprom), GFP_KERNEL);
> +	if (!eeprom)
> +		return -ENOMEM;
...
> +	rval = eeprom_register(eeprom);

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
