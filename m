Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66ECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:26:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F10D2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mRCrkjrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F10D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xWnZEsW8z9Vq+uWWYZRRkP0lwaSMD73It+/d4bW9bYA=; b=mRCrkjrHyEF1SP7NU9RzwH4wn
	MKd+RK45rnplidvrPyZvMPUJJh1Dy0rRf2bkHHxOEWhNfl6ISoVE4r8b7PrFh0+Fv3FZcl38KMZ0A
	N3tz8fy2GYkrr2kCV2qxyoI0iif2KaZtdpZpWTjK6rOBD76+cw+Zp0Q1U0zSqmgITNPxsLtIrfCwH
	/tiDHIdLp+uORaZJjL3xe4YERImHijpragvFLjmVly7FAeFPauARFXdaWso2CKS0O5u2y3omX/xhl
	h5rhGtB8gTJIQpXtdpdxRbT04qwJzfnfbTrZESmqUVtkDjA8J1XVRrSKewNCbQd3np4tTfU0nLO2u
	fSXFzHGcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCiI-0000eF-N9; Fri, 22 Feb 2019 15:26:10 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCiE-0000dU-AJ
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:26:08 +0000
Received: by mail-wm1-f67.google.com with SMTP id q187so2322140wme.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UQOSmELrhzZp4LoTIELZVlXN9ZfB2f37a7ivz0qoX0Q=;
 b=qgSF18bxXeuOF5lHZMM774KdwMLAWE+6ewPjLBBSIg6uKehdCQGcWX3eadVmhndX6d
 57lPQRWUvKuqd/7oD+wY/QVEAOEHY87ByeqLaHDREVJWI7J98w0AF1+sZ9uyw5LJclJ/
 +KlU9hvqcT6hVGLvC3wKqRJxZ3+I9K8fbA9yHbn2GykKGSsVLArVHLbSYPQ8BYe0ifGm
 BFm3fXE+gkuu0qLeLI0w9Tz9Sf/JhmZ2H3kazzn0Vg/RwaYiEWOOCxO3S30bJ+YW7ik4
 /5YxaO57ZiudMJ1ZnmcWe1GeHMR/aYsgapQGXnHpAjOfpHn6IOuyaTnNK4UhX1VvxMKL
 Im4g==
X-Gm-Message-State: AHQUAubolZs1MZklCVhgw2c3HIHmZqDcm2hlxkd+r9va1qSj2bmjuLGf
 UVP4QTanaETKe4fPbEPzXj8FJA==
X-Google-Smtp-Source: AHgI3IauM9i4/vQ/uSuLPTqZHA7AHbQbWJivsU/IxnA6P6SIHnJItzycJVVjwDTvfNDAWPCPpSrV3w==
X-Received: by 2002:a1c:d147:: with SMTP id i68mr2948855wmg.41.1550849164096; 
 Fri, 22 Feb 2019 07:26:04 -0800 (PST)
Received: from dhcp-44-202.space.revspace.nl
 ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
 by smtp.gmail.com with ESMTPSA id m4sm2195414wmi.3.2019.02.22.07.26.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 07:26:03 -0800 (PST)
Subject: Re: [PATCH 2/5] ata: libahci_platform: Support per-port interrupts
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-3-miquel.raynal@bootlin.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5040d4cf-7da1-eefa-a8a3-bc4054d528da@redhat.com>
Date: Fri, 22 Feb 2019 16:26:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222145356.23072-3-miquel.raynal@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_072606_356611_4A19A4F4 
X-CRM114-Status: GOOD (  28.23  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2/22/19 3:53 PM, Miquel Raynal wrote:
> Right now the ATA core only allows IPs to use a single interrupt. Some
> of them (for instance the Armada-CP110 one) actually has one interrupt
> per port. Add some logic to support such situation.
> 
> We consider that either there is one single interrupt declared in the
> main IP node, or there are per-port interrupts, each of them being
> declared in the port sub-nodes.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/ata/acard-ahci.c       |  2 +-
>   drivers/ata/ahci.c             |  2 +-
>   drivers/ata/ahci.h             |  3 +-
>   drivers/ata/libahci.c          |  2 +-
>   drivers/ata/libahci_platform.c | 66 ++++++++++++++++++++++++++++------
>   drivers/ata/sata_highbank.c    |  2 +-
>   6 files changed, 61 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
> index 583e366be7e2..9414b81e994c 100644
> --- a/drivers/ata/acard-ahci.c
> +++ b/drivers/ata/acard-ahci.c
> @@ -434,7 +434,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
>   	if (!hpriv)
>   		return -ENOMEM;
>   
> -	hpriv->irq = pdev->irq;
> +	hpriv->irqs[0] = pdev->irq;
>   	hpriv->flags |= (unsigned long)pi.private_data;
>   

What code-path is going to alloc hpriv->irqs for drivers using this code-path
which are not using libahci_platform .c ?


Regards,

Hans





>   	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 021ce46e2e57..18bce556d85f 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1817,7 +1817,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		/* legacy intx interrupts */
>   		pci_intx(pdev, 1);
>   	}
> -	hpriv->irq = pci_irq_vector(pdev, 0);
> +	hpriv->irqs[0] = pci_irq_vector(pdev, 0);
>   
>   	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>   		host->flags |= ATA_HOST_PARALLEL_SCAN;
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index ef356e70e6de..1f1c00be5b2e 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -361,7 +361,7 @@ struct ahci_host_priv {
>   	struct phy		**phys;
>   	unsigned		nports;		/* Number of ports */
>   	void			*plat_data;	/* Other platform data */
> -	unsigned int		irq;		/* interrupt line */
> +	unsigned int		*irqs;		/* interrupt line(s) */
>   	/*
>   	 * Optional ahci_start_engine override, if not set this gets set to the
>   	 * default ahci_start_engine during ahci_save_initial_config, this can
> @@ -432,6 +432,7 @@ void ahci_print_info(struct ata_host *host, const char *scc_s);
>   int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
>   void ahci_error_handler(struct ata_port *ap);
>   u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
> +int ahci_get_per_port_irq_vector(struct ata_host *host, int port);
>   
>   static inline void __iomem *__ahci_port_base(struct ata_host *host,
>   					     unsigned int port_no)
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 66d4906a5013..25970138a65a 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2602,7 +2602,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
>   int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>   {
>   	struct ahci_host_priv *hpriv = host->private_data;
> -	int irq = hpriv->irq;
> +	int irq = hpriv->irqs[0];
>   	int rc;
>   
>   	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI) {
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4b900fc659f7..af3d65c09087 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -24,6 +24,7 @@
>   #include <linux/ahci_platform.h>
>   #include <linux/phy/phy.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/of_irq.h>
>   #include <linux/of_platform.h>
>   #include <linux/reset.h>
>   #include "ahci.h"
> @@ -89,6 +90,14 @@ static void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
>   	}
>   }
>   
> +int ahci_get_per_port_irq_vector(struct ata_host *host, int port)
> +{
> +	struct ahci_host_priv *hpriv = host->private_data;
> +
> +	return hpriv->irqs[port];
> +}
> +EXPORT_SYMBOL_GPL(ahci_get_per_port_irq_vector);
> +
>   /**
>    * ahci_platform_enable_clks - Enable platform clocks
>    * @hpriv: host private area to store config values
> @@ -379,6 +388,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
>    *    or for non devicetree enabled platforms a single clock
>    * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
>    * 5) phys (optional)
> + * 6) interrupt(s)
>    *
>    * RETURNS:
>    * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
> @@ -390,7 +400,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   	struct ahci_host_priv *hpriv;
>   	struct clk *clk;
>   	struct device_node *child;
> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
> +	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes, ctrl_irq;
>   	u32 mask_port_map = 0;
>   
>   	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> @@ -483,10 +493,29 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   		goto err_out;
>   	}
>   
> +	hpriv->irqs = kzalloc(sizeof(*hpriv->irqs) * hpriv->nports, GFP_KERNEL);
> +	if (!hpriv->irqs) {
> +		rc = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	ctrl_irq = platform_get_irq(pdev, 0);
> +	if (ctrl_irq < 0) {
> +		if (ctrl_irq == -EPROBE_DEFER) {
> +			rc = ctrl_irq;
> +			goto err_out;
> +		}
> +		ctrl_irq = 0;
> +	}
> +
> +	if (ctrl_irq > 0)
> +		hpriv->irqs[0] = ctrl_irq;
> +
>   	if (child_nodes) {
>   		for_each_child_of_node(dev->of_node, child) {
>   			u32 port;
>   			struct platform_device *port_dev __maybe_unused;
> +			int port_irq;
>   
>   			if (!of_device_is_available(child))
>   				continue;
> @@ -515,6 +544,18 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   			}
>   #endif
>   
> +			if (!ctrl_irq) {
> +				port_irq = of_irq_get(child, 0);
> +				if (!port_irq)
> +					port_irq = -EINVAL;
> +				if (port_irq < 0) {
> +					rc = port_irq;
> +					goto err_out;
> +				}
> +
> +				hpriv->irqs[port] = port_irq;
> +			}
> +
>   			rc = ahci_platform_get_phy(hpriv, port, dev, child);
>   			if (rc)
>   				goto err_out;
> @@ -542,6 +583,18 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   		if (rc == -EPROBE_DEFER)
>   			goto err_out;
>   	}
> +
> +	if (!ctrl_irq && !enabled_ports) {
> +		dev_err(&pdev->dev, "No IRQ defined\n");
> +		rc = -ENODEV;
> +		goto err_out;
> +	}
> +
> +	if (enabled_ports > 1) {
> +		hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
> +		hpriv->get_irq_vector = ahci_get_per_port_irq_vector;
> +	}
> +
>   	pm_runtime_enable(dev);
>   	pm_runtime_get_sync(dev);
>   	hpriv->got_runtime_pm = true;
> @@ -578,16 +631,7 @@ int ahci_platform_init_host(struct platform_device *pdev,
>   	struct ata_port_info pi = *pi_template;
>   	const struct ata_port_info *ppi[] = { &pi, NULL };
>   	struct ata_host *host;
> -	int i, irq, n_ports, rc;
> -
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "no irq\n");
> -		return irq;
> -	}
> -
> -	hpriv->irq = irq;
> +	int i, n_ports, rc;
>   
>   	/* prepare host */
>   	pi.private_data = (void *)(unsigned long)hpriv->flags;
> diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
> index c8fc9280d6e4..dcfdab20021b 100644
> --- a/drivers/ata/sata_highbank.c
> +++ b/drivers/ata/sata_highbank.c
> @@ -496,7 +496,7 @@ static int ahci_highbank_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	}
>   
> -	hpriv->irq = irq;
> +	hpriv->irqs[0] = irq;
>   	hpriv->flags |= (unsigned long)pi.private_data;
>   
>   	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
