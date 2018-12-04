Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B70C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:48:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CAC2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SAYmc5sJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CAC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tfntoiWCEXbFIQWxtGzrA02B/fYxaJCt00Dn/GwSVKk=; b=SAYmc5sJnE63k1WQ87i8p9gza
	iDJbyTH+FEb9grqitvmvkiIfaD4PnYQCZULKVq8dQFT7wuRVmzOSE/jx6z9yxJr54He48OjBoMBQ1
	iMd3heoIyEBXAOKuNx2qiGncwSoAUJc+xOGWw+jqfmTz8vc2Sni8of0E+kB8vQV8EGgeosxI5iaDG
	KqRWYashXWyoi0/at7TKRClii4LQEZ3KHq0aIfJtzcr3ssOxA8pPUWpNjhucraUvb9hd9nPgqXRet
	aTXdX/QO3uej3whsjVVof4cu7/E33ZsirN+CZhtaLRE+AviA74ixMStsjL7QlN3IEXPhuuyFgbubg
	hPUNy3NFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGgL-0003nO-NE; Tue, 04 Dec 2018 19:48:33 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGgH-0003md-5I
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:48:31 +0000
Received: by mail-wm1-f66.google.com with SMTP id a18so10622414wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 11:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oua3x01qFWl4Y/tphDKQn6dosmSIuL8v8p2C2PAu2EA=;
 b=ZSDSS7dL4r04OLfWDh6iDEmDMI8uNkDjmwWqvW6hmVSR76N38Nl3F2rYCL02d8Ja/V
 5GdbCfOZ9wzHaF0j4xO94CgPKWBulHrWBIHwbdZnE87oTKfWaKlZeEgGLcoJpV7L/S6r
 omgm+kYT6OuKmyfUuiCgLJkeMPmK1o20j3mnES1S8oXadmYMVNESF4XNMiscAiwZo3eu
 qEQGkk52LVgapgNKKxzik2fSXG6/5mzyo4AVB0H/QOqeKdLtNGpmAxdZrytHO5JqlJ0m
 Wo8RfBtCIMnm3DBxx5Q1dX+/dksM7Q6tL0QqRxEq3V2PkExYEfj3xKGCPu5lzZ2vDHir
 DRkw==
X-Gm-Message-State: AA+aEWY8M/ms4jCPR5KzZkKZ09OhlIVMj6lmC57RBiKcaFe3iJlp5y1E
 QsfqchXNhExfqLb2uMlZdFu9Ww==
X-Google-Smtp-Source: AFSGD/VMDKlzAaB8T39Wzj0TnuBN6vuRtbgr6nFH0kNxc97Gr88RgG+/j4rbxgas9pcnk2SuHEmN2w==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr4658638wmc.55.1543952897215; 
 Tue, 04 Dec 2018 11:48:17 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id f66sm12703048wmd.28.2018.12.04.11.48.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 11:48:16 -0800 (PST)
Subject: Re: [PATCH v3 1/7] ata: libahci_platform: comply to PHY framework
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
 <20181204192831.12440-2-miquel.raynal@bootlin.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ccde58fa-badd-dcd6-9834-7ef689e922e2@redhat.com>
Date: Tue, 4 Dec 2018 20:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204192831.12440-2-miquel.raynal@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_114829_199034_0F7E60DC 
X-CRM114-Status: GOOD (  25.77  )
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

On 04-12-18 20:28, Miquel Raynal wrote:
> Current implementation of the libahci does not take into account the
> new PHY framework. Correct the situation by adding a call to
> phy_set_mode() before phy_power_on().
> 
> PHYs should also be handled at suspend/resume time. For this, call
> ahci_platform_enable/disable_phys() at suspend/resume_host() time. These
> calls are guarded by a HFLAG (AHCI_HFLAG_SUSPEND_PHYS) that the user of
> the libahci driver must set manually in hpriv->flags at probe time. This
> is to avoid breaking users that have not been tested with this change.
> 
> Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Patch looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rest of the series looks ok to me to:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/ata/ahci.h             |  2 ++
>   drivers/ata/libahci_platform.c | 13 +++++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index ef356e70e6de..8810475f307a 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -254,6 +254,8 @@ enum {
>   	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
>   							SATA_MOBILE_LPM_POLICY
>   							as default lpm_policy */
> +	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
> +							suspend/resume */
>   
>   	/* ap->flags bits */
>   
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4b900fc659f7..81b1a3332ed6 100644
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
> @@ -738,6 +744,9 @@ int ahci_platform_suspend_host(struct device *dev)
>   	writel(ctl, mmio + HOST_CTL);
>   	readl(mmio + HOST_CTL); /* flush */
>   
> +	if (hpriv->flags & AHCI_HFLAG_SUSPEND_PHYS)
> +		ahci_platform_disable_phys(hpriv);
> +
>   	return ata_host_suspend(host, PMSG_SUSPEND);
>   }
>   EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
> @@ -756,6 +765,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
>   int ahci_platform_resume_host(struct device *dev)
>   {
>   	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
>   	int rc;
>   
>   	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
> @@ -766,6 +776,9 @@ int ahci_platform_resume_host(struct device *dev)
>   		ahci_init_controller(host);
>   	}
>   
> +	if (hpriv->flags & AHCI_HFLAG_SUSPEND_PHYS)
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
