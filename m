Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:32:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E971B20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AUFWZTVf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GARWiGgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E971B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PSQ1sEJNQMQx6twkdz5OkyBhrgWCwHABhB0TmpIEEyg=; b=AUFWZTVfE1ZJs1
	Tkw/SgFIDUphhlR/B84bp/04Ev0pxRDrOpJNIQKF33Uh6tFBee1/4KZVg2/CqWHhVpAACf3pA7SzP
	6Oc7fz1WzHQWTDH2Wx+C1Ns5MMwaswDxgwSS9whcE9iUejb7DaCUIELLK1M1/HFkHrj3ewOw6Pd1z
	zohhzKlXf+RbXgu/0tyk45xCKu1OiziSK+W4Xh/KbS26gH0DGi0TWMKDYl2Kcwy4Gvp7rBv6e1AY7
	u7cTfjymC2L3jQI/pGaPf6oFhZDSr5KJqUjRVxRP/m+rOht5tvw860HhEpSexcJg3Rb4nrJXR8z52
	c7mB+DPqMOgeJb70M2WA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV500-0001Hv-U7; Fri, 07 Dec 2018 01:32:12 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV4zy-0001D3-Vh
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 01:32:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AKdhjSTvTqGKMd8lU/xs/o2+ByWUt+TlCbLxQYPDo34=; b=GARWiGgYr+Rti2gU0lHPar2V0
 DgSUEiM1yQUR+R/IgDWqD+6LRY0YKbLiVoWwCWO+TVXsbifqam1P9dglb1PUdR6EHQj/HTfFrpTSj
 OPHVTj37kmTHtaziTiFFj2U7xENB30uLqLMAnYHybLqtpCIs2QvXuAnS8XTo3COVGXM5ugEXaRVXI
 /tlGY6BEDvmZTgc0ShdBjcJS/cMNz4Md3WDJCv3K1ekiZgdcJXNUOe9ZCBk0Ruh2hCPD47vAffm68
 AgpBpJWVBzoecSX0D5hC2k0eJ1SUCtP4n8PmsFzwwYpHpcky0smHqeeLfMcwLQNl45lamNW0jL502
 Q7t0u5y3w==;
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV3LI-0003AO-Fw
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 23:46:05 +0000
Received: by mail-oi1-f195.google.com with SMTP id c206so2001947oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 15:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AKdhjSTvTqGKMd8lU/xs/o2+ByWUt+TlCbLxQYPDo34=;
 b=h5wmyb79VHnJi+Fqsr77L6i3xxSCtJ/V4jqgwjfS87SYsc+0YQEQw2DTNvBFIlYHnD
 hjRhideir2CWkVv97J8oIj5f0M4S3YBiOXZJ5FHAP6Wb5zt2PrYgmdJVCd5C0XBqh/r+
 dfFEFQyTrlAc94r0tjx09APhQILlya1Sm3Oxv2Chf5edUQ00Mpc4e7d2e8KLN0SQHdTB
 XNDsFJTWgMIXreoHfRZT8lAEyl52Pi9q5o4aSA8rEBK62bHBBeRRk4R9uaevhqe6YaPS
 zKBALoDtkOnn8YSA6e1G7LPrlil2KWd3TbFp8w1Bn8bBZ3WO1LjpJ6A3kjbD24/XgyM5
 HfpA==
X-Gm-Message-State: AA+aEWYMwvlOd3GG5izD2OnpmVDdsYV7UQ3ZD+U34Wnp6xka7j6QJ+Xj
 xWQQwk/ZdPTFovPDzxxBaA==
X-Google-Smtp-Source: AFSGD/Vn7JUiezD+ASGIYqL+Ny8Sf2QRqBdHeVNnvg7lKz3PlGtX1jsPayYVeylgnOjaRNJ7jDc4IQ==
X-Received: by 2002:aca:e346:: with SMTP id a67mr19571969oih.81.1544139951481; 
 Thu, 06 Dec 2018 15:45:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id y20sm1633940otk.66.2018.12.06.15.45.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 15:45:51 -0800 (PST)
Date: Thu, 6 Dec 2018 17:45:50 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen.Hristev@microchip.com
Subject: Re: [PATCH 2/3] dt-bindings: drm/panel: simple: add support for PDA
 91-00156-A0
Message-ID: <20181206234550.GA3012@bogus>
References: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
 <1542789804-4584-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542789804-4584-3-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_184604_544912_83907742 
X-CRM114-Status: GOOD (  18.99  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 thierry.reding@gmail.com, Cristian.Birsan@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 21, 2018 at 08:48:00AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
> Adding Device Tree bindings for this panel.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  .../devicetree/bindings/display/panel/pda,91-00156-a0.txt          | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
> new file mode 100644
> index 0000000..52f0da9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
> @@ -0,0 +1,7 @@
> +PDA 91-00156-A0 5.0" WVGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "pda,91-00156-a0"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

You need to explicitly list what properties from this are used. Does 
this have a single supply or did you just forget to add supplies for 
example? I don't know.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
