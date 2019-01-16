Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095D4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:15:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF86420868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UOw11biC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X1sHMIct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF86420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EugCzPokG9FB38WiV4ACYku2dfbRpNTzjSU5+1F6xuE=; b=UOw11biCED2jVrDZeL6KZgnTc
	4OjgWuyKUxc3pvhVscZuEs0UL9HSVkE+o6e+VV4wUt9+fRFsenVngJNJv+PpDMEpaqpo4k09NnvVb
	U8vI4/vWRUjlpKq+twqYkNsMCKQwMTRo9tAsepoj/tOOiFG6i4lMCi+wHQTl+npwbof0cH49YnqjQ
	EwuFXyFB6KAW1FPfkRz9+Ko22ZvAjMXEtzBbfNs1ShWGoVUzStPU4w6I5oiC/EJxPX2E3dt5K9d3J
	FxwRatJeCwRldIn/HB+dbWvZdsWmCd8Ao2UIYH2pyKmzlc+J8C0vcF9q2QwsIZPb2Tr+S0hiExwGo
	QVIu+og9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjpiZ-0002zm-7e; Wed, 16 Jan 2019 18:15:11 +0000
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjpiV-0002Q8-Nx
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 18:15:09 +0000
Received: by mail-yw1-xc44.google.com with SMTP id g194so2729136ywe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 10:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=4URaJZgH8FXMoyxrFNcjoOcddqjBhVcQuxxw0ZXZLpE=;
 b=X1sHMIctDPunp4OKjEWfJJEw3mt/QeHA/7Dwlyv+FO4b61tq9PcnpL4fytzbCshYPU
 ASA2VAs2jWbLkAL5tS8YE/BytuWfGNS/abwj8csbZQp786uDI/uvUEzwcH+fWGFhAQAK
 GcVFffvv7lIWJAZY8iT1PNBmFkht0p88REhRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4URaJZgH8FXMoyxrFNcjoOcddqjBhVcQuxxw0ZXZLpE=;
 b=rT6KW6yhxhPkkvpCJANtpRQlSiPXLZjxFHRxzagnL4i7Sn4MQM0OmHt3DFM3Knxr+f
 IYvQn3PaDsCjueKaclj4Gp2Gemd7Y17CvLnUf4xhy4sHzuMqHQneZiy6FGnU2TTfSpG2
 A43X0z9db6+OJZuIihshnZ5DL3P982VFjQERmtNJijhk/FuT4k3Owc+FET/3Hs0JRbtw
 xqUe0am2uZuIY/ax9kshUqa4qso6NEMy7OY6Nb6qfGfII+Zw5BD1aE/Zq66t11gypUEq
 NokkwGrWqoTUJmWhGxNAXxtWlPl/ORA8fGpEIEUjFZ9cKEhl5KXavAWeSzHGjzQSKdu/
 Htdg==
X-Gm-Message-State: AJcUukcQfzXdkWTpaRqoOioZ/0RpkIBGCygGwtMKq7yWy3cJ4W3ayFf8
 4Q50lUMExT5IhJC+bdIr+UcbYcoka5uv894lfHwCo3+vkBWmGOtMkPFqrr2LGxXjs+8QpM/eEqB
 wDBDBrBcSmQgfpnPpPrrsr5XtlQzimTeJs3iA6iVlqaJWReccJXci5adldmlhh9Qk6Mw1aPyNQP
 M/ESoCDn6QvZKEYAFZak3fLA==
X-Google-Smtp-Source: ALg8bN7lG1DCEVAK5K4XqjP28cwXatn/WipoDWH9ooBtl8484KPLw8jCjA1+V4AHYugyTO5IM6sUiw==
X-Received: by 2002:a81:87c3:: with SMTP id x186mr8604403ywf.147.1547662505977; 
 Wed, 16 Jan 2019 10:15:05 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id s185sm4658831yws.69.2019.01.16.10.15.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jan 2019 10:15:05 -0800 (PST)
Subject: Re: [PATCH v2 2/2] reset: Add Broadcom STB SW_INIT reset controller
 driver
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
References: <20190115184406.3164-1-f.fainelli@gmail.com>
 <20190115184406.3164-3-f.fainelli@gmail.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <7bc8d9ee-5be1-1765-55dd-b7407cff962f@broadcom.com>
Date: Wed, 16 Jan 2019 10:15:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115184406.3164-3-f.fainelli@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_101507_793541_E6DC78E5 
X-CRM114-Status: GOOD (  25.11  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2019-01-15 10:44 a.m., Florian Fainelli wrote:
> Add support for resetting blocks through the Linux reset controller
> subsystem when reset lines are provided through a SW_INIT-style reset
> controller on Broadcom STB SoCs.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/reset/Kconfig         |   7 ++
>   drivers/reset/Makefile        |   1 +
>   drivers/reset/reset-brcmstb.c | 130 ++++++++++++++++++++++++++++++++++
>   3 files changed, 138 insertions(+)
>   create mode 100644 drivers/reset/reset-brcmstb.c
>
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 2e01bd833ffd..1ca03c57e049 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -40,6 +40,13 @@ config RESET_BERLIN
>   	help
>   	  This enables the reset controller driver for Marvell Berlin SoCs.
>   
> +config RESET_BRCMSTB
> +	bool "Broadcom STB reset controller" if COMPILE_TEST

Could this even be:

depends on ARCH_BRCMSTB || COMPILE_TEST

> +	default ARCH_BRCMSTB
> +	help
> +	  This enables the reset controller driver for Broadcom STB SoCs using
> +	  a SUN_TOP_CTRL_SW_INIT style controller.
> +
>   config RESET_HSDK
>   	bool "Synopsys HSDK Reset Driver"
>   	depends on HAS_IOMEM
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index dc7874df78d9..7395db2cb1dd 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
>   obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>   obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
>   obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
> +obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>   obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>   obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>   obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
> new file mode 100644
> index 000000000000..01ab1f71518b
> --- /dev/null
> +++ b/drivers/reset/reset-brcmstb.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Broadcom STB generic reset controller for SW_INIT style reset controller
> + *
> + * Author: Florian Fainelli <f.fainelli@gmail.com>
> + * Copyright (C) 2018 Broadcom
> + */
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/types.h>
> +
> +struct brcmstb_reset {
> +	void __iomem *base;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +#define SW_INIT_SET		0x00
> +#define SW_INIT_CLEAR		0x04
> +#define SW_INIT_STATUS		0x08
> +
> +#define SW_INIT_BIT(id)		BIT((id) & 0x1f)
> +#define SW_INIT_BANK(id)	((id) >> 5)
> +
> +/* A full bank contains extra registers that we are not utilizing but still
> + * qualify as a single bank.
> + */
> +#define SW_INIT_BANK_SIZE	0x18
> +
> +static inline
> +struct brcmstb_reset *to_brcmstb(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct brcmstb_reset, rcdev);
> +}
> +
> +static int brcmstb_reset_assert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
> +	struct brcmstb_reset *priv = to_brcmstb(rcdev);
> +
> +	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_SET);
> +
> +	return 0;
> +}
> +
> +static int brcmstb_reset_deassert(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
> +	struct brcmstb_reset *priv = to_brcmstb(rcdev);
> +
> +	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_CLEAR);
> +	/* Maximum reset delay after de-asserting a line and seeing block
> +	 * operation is typically 14us for the worst case, build some slack
> +	 * here.
> +	 */
> +	usleep_range(100, 200);
> +
> +	return 0;
> +}
> +
> +static int brcmstb_reset_status(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
> +	struct brcmstb_reset *priv = to_brcmstb(rcdev);
> +
> +	return readl_relaxed(priv->base + off + SW_INIT_STATUS) &
> +			     SW_INIT_BIT(id);
> +}
> +
> +static const struct reset_control_ops brcmstb_reset_ops = {
> +	.assert	= brcmstb_reset_assert,
> +	.deassert = brcmstb_reset_deassert,
> +	.status = brcmstb_reset_status,
> +};
> +
> +static int brcmstb_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *kdev = &pdev->dev;
> +	struct brcmstb_reset *priv;
> +	struct resource *res;
> +
> +	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (resource_size(res) % SW_INIT_BANK_SIZE) {
> +		dev_err(kdev, "incorrect register range\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->base = devm_ioremap_resource(kdev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	dev_set_drvdata(kdev, priv);
> +
> +	priv->rcdev.owner = THIS_MODULE;
> +	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
> +	priv->rcdev.ops = &brcmstb_reset_ops;
> +	priv->rcdev.of_node = kdev->of_node;
> +	/* Use defaults: 1 cell and simple xlate function */
> +
> +	return devm_reset_controller_register(kdev, &priv->rcdev);
> +}
> +
> +static const struct of_device_id brcmstb_reset_of_match[] = {
> +	{ .compatible = "brcm,brcmstb-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver brcmstb_reset_driver = {
> +	.probe	= brcmstb_reset_probe,
> +	.driver	= {
> +		.name = "brcmstb-reset",
> +		.of_match_table = brcmstb_reset_of_match,
> +	},
> +};
> +module_platform_driver(brcmstb_reset_driver);
> +
> +MODULE_AUTHOR("Broadcom");
> +MODULE_DESCRIPTION("Broadcom STB reset controller");
> +MODULE_LICENSE("GPL");

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
