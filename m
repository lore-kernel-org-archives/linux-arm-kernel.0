From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 26 Oct 2015 10:39:46 +0000
Subject: [PATCH 2/3] nvmem: mediatek: Add Mediatek EFUSE driver
In-Reply-To: <20151026102834.GE25308@pengutronix.de>
References: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
 <1444984751-4572-3-git-send-email-andrew-ct.chen@mediatek.com>
 <562DF8C8.8060600@linaro.org> <20151026102834.GE25308@pengutronix.de>
Message-ID: <562E02F2.50709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/10/15 10:28, Sascha Hauer wrote:
> On Mon, Oct 26, 2015 at 09:56:24AM +0000, Srinivas Kandagatla wrote:
>>> +	.val_bits = 32,
>>> +	.reg_stride = 4,
>>> +};
>>> +
>>> +static int mtk_efuse_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct resource *res;
>>> +	struct nvmem_device *nvmem;
>>> +	struct nvmem_config *econfig;
>>> +	struct regmap *regmap;
>>> +	void __iomem *base;
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	base = devm_ioremap_resource(dev, res);
>>> +	if (IS_ERR(base))
>>> +		return PTR_ERR(base);
>>> +
>>> +	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
>>> +	if (!econfig)
>>> +		return -ENOMEM;
>> Why not use static econfig variable?
>
> Because drivers should not assume there is only one instance of them in
> the system. The qfprom driver does this and it's only a matter of
Good point, Yes, you are right. If MTK has possibility of having more 
than one efuse we can leave the code as it is.
> putting a second qcom,qfprom node into the device tree to break the
> driver.
It would indeed.
--srini
>
> Sascha
>
