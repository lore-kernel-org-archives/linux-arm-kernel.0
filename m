Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DB8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 13:20:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22692082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 13:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LtXl+nXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22692082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/cuFuaikIZKq+w8j09Dd6B9YoWry6FHzfBnyd566+6I=; b=LtXl+nXMAFmZaenkya0ffjoWv
	w25sqfn1Tc2tOfVa4XX2+OJOnSmzb06B3baWyJdL+EKXY+6rmcqLnleSYsakMu/gSEzutVyvDe+47
	kgVLCi0q2zf/zRYR/z1EK9IWkqk320OgAEtc1GPVkrqVxXahXwYrHHlS/B3H7PeLN9ptX71+GbfSt
	2HMK5HG/h9DJCXG9er9GsB9/i5iISuNxyHy/uTY/7uGXs1XXxj7sjsugFGmBy2d+p1i8zubbPzwEq
	xE2J9RBKfbomERMZUT44lBZfXGxp0OubKSrUdcT3vkGrIWQXWzjZ5MtjtHPSIDC5mfIekj6dEkOxj
	NCPPM+5Qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTRfM-0006Yi-GY; Sun, 02 Dec 2018 13:20:08 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTRfI-0005QQ-7Q
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 13:20:07 +0000
Received: by mail-wr1-f68.google.com with SMTP id t27so9442800wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 05:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jC+3ss4wO7401zosvLLdutgL5nZc8czM1UdLviYbqD8=;
 b=KJQPAvasAqvJ3sh2lmD3mBHcLTF0zD0GFaAKH8VF4yXSMINqJhB5EWHOlz53wbY1Lk
 OSV+VgGHipqDPdj7wEDB9Xm8/gNTXUEH7pKvQnksla/KFMtHFqZWK3xqC2Mwr3ZqnYDG
 aSePKoVMEDR9xCRpzgAWSvEUpOoEVNmyylIEl3LNmlTsmQFVboWrSJFziG67jUiEu7XG
 UIeM9PwQfz6lQlYX4WbRYnm5iXFrrmd+2g5swTULHb8a2XnLZnqqrAGjArcOeYUug9UJ
 EUjSHmGQoEpNFo0X7bkulQQISO5yqqcvREx4vJ6sZe3qUs5rD8sMGKJVGwHTtM1w9Pga
 YX2Q==
X-Gm-Message-State: AA+aEWZvh8MdJkTNsYDKijSNAzgZyr2vwGtmn+4dRT19w5bMuwGT4HUa
 peeoUO4Rkb11PWUGqhFT8h7Lqw==
X-Google-Smtp-Source: AFSGD/WprAZFPaNj8n1cUYZxNfXpLVmE7tqfTpdDRbI/ImflU0DMxy+5Ql/tQlKs+RA2iqpJPi69WA==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr10725903wru.222.1543756792252; 
 Sun, 02 Dec 2018 05:19:52 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id y34sm27971181wrd.68.2018.12.02.05.19.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 05:19:51 -0800 (PST)
Subject: Re: [PATCH v2 1/6] ata: libahci_platform: comply to PHY framework
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20181130153833.11421-1-miquel.raynal@bootlin.com>
 <20181130153833.11421-2-miquel.raynal@bootlin.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <0517746d-3fca-db57-8dca-8976910dad9c@redhat.com>
Date: Sun, 2 Dec 2018 14:19:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181130153833.11421-2-miquel.raynal@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_052004_273306_C2C47068 
X-CRM114-Status: GOOD (  30.87  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 30-11-18 16:38, Miquel Raynal wrote:
> Current implementation of the libahci does not take into account the
> new PHY framework. Correct the situation by adding a call to
> phy_set_mode() before phy_power_on() and by adding calls to
> ahci_platform_enable/disable_phys() at suspend/resume_host() time.
> 
> Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Much better. Some remarks inline.

> ---
>   drivers/ata/ahci.h             |  2 ++
>   drivers/ata/libahci_platform.c | 19 ++++++++++++++++++-
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index ef356e70e6de..982638b37fee 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -254,6 +254,8 @@ enum {
>   	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
>   							SATA_MOBILE_LPM_POLICY
>   							as default lpm_policy */
> +	AHCI_HFLAG_MANAGE_PHYS		= (1 << 26), /* let the core manage the
> +							PHYs when relevant */

Using a hflag for this is a good idea, but the MANAGE_PHYS names is a bit
generic, even if this is not set then ahci_platform_enable_resources() will
still enable the phy. So I would name this AHCI_HFLAG_SUSPEND_PHYS to make
clear this only influences suspend/resume behavior.

Also see below.

>   	/* ap->flags bits */
>   
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4b900fc659f7..f5a64eb1fea8 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -56,6 +56,12 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>   		if (rc)
>   			goto disable_phys;
>   
> +		rc = phy_set_mode(hpriv->phys[i], PHY_MODE_SATA);
> +		if (rc) {
> +			phy_exit(hpriv->phys[i]);
> +			goto disable_phys;
> +		}
> +
>   		rc = phy_power_on(hpriv->phys[i]);
>   		if (rc) {
>   			phy_exit(hpriv->phys[i]);
> @@ -378,7 +384,8 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
>    * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
>    *    or for non devicetree enabled platforms a single clock
>    * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
> - * 5) phys (optional)
> + * 5) phys (optional), PHY handling during suspend/resume will be skipped if the
> + *    flag AHCI_HFLAG_MANAGE_PHYS is missing.
>    *
>    * RETURNS:
>    * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
> @@ -458,6 +465,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   		}
>   	}
>   
> +	if (flags & AHCI_HFLAG_MANAGE_PHYS)
> +		hpriv->flags |= AHCI_HFLAG_MANAGE_PHYS;
> +
>   	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>   
>   	/*

Interpreting a flag passed to ahci_platform_get_resources using a
AHCI_HFLAG_* mask is asking for trouble in the future.

Since you are using a hflag for this, you can just drop this chunk / change
and in the caller of ahci_platform_get_resources() do:

	hpriv = ahci_platform_get_resources(pdev, ...);
	if (IS_ERR(hpriv))
		...

	hpriv->flags |= AHCI_HFLAG_MANAGE_PHYS;

Settting hflags like this after calling ahci_platform_get_resources()
is already done in several place.

Once this is changed, this patch looks good to go upstream to me.

Regards,

Hans




> @@ -738,6 +748,9 @@ int ahci_platform_suspend_host(struct device *dev)
>   	writel(ctl, mmio + HOST_CTL);
>   	readl(mmio + HOST_CTL); /* flush */
>   
> +	if (hpriv->flags & AHCI_HFLAG_MANAGE_PHYS)
> +		ahci_platform_disable_phys(hpriv);
> +
>   	return ata_host_suspend(host, PMSG_SUSPEND);
>   }
>   EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
> @@ -756,6 +769,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
>   int ahci_platform_resume_host(struct device *dev)
>   {
>   	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
>   	int rc;
>   
>   	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
> @@ -766,6 +780,9 @@ int ahci_platform_resume_host(struct device *dev)
>   		ahci_init_controller(host);
>   	}
>   
> +	if (hpriv->flags & AHCI_HFLAG_MANAGE_PHYS)
> +		ahci_platform_enable_phys(hpriv);
> +
>   	ata_host_resume(host);
>   
>   	return 0;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
