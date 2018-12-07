Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AEBC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:38:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F11F20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/LDw4zY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F11F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nG9e7PkncG+jTY5duuiosN9QeWYeIjHeV/eSUkheTbw=; b=Q/LDw4zY/c8YDI
	iF+kLYuUU7CumzaiZ6TVTTYr2/+JwQTBjJeT1hYtpW4bNGJjx46O3EOQPPboF77A+CCN56+b/xsW1
	K5N/2H/pxvTUWp6sHKf1DJ5qh9gwsny5mc2o/JGM1Oo0hOEDmtbKS9rJ++3uPtBqthZwFAMggCC3l
	GeBS4fB4pYdcP9hNv7brgUAAGicvC5ssvbMvt3K5vd8w1rnMUb2fgiCIu+IMYwJGlwwuy+Q/Y2yTl
	GYyMDf6np9e9xH6SARA7ZS4VxHWnUp2xO3NtCihh7kGMYG+gXuf6xAZX9iseueCCZjCzt6qFHOU8x
	X8giHCCks/AjTAFTiz0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPhY-0003qp-BO; Fri, 07 Dec 2018 23:38:32 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPhU-0003pA-UO
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:38:30 +0000
Received: by mail-ot1-f67.google.com with SMTP id u16so5383658otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nG8P17RN+8oM/kVAEOd7qMfzukdzmGp422c5HNUsoj4=;
 b=rFAOVVk4B5qul2ObvKGhOwm+4wxMl+6suhI9xAAqq7wUaTIsDodLVPqnLe25a4v0kt
 w5atmgZb5Nw8cQOGipdJxm+kD4u4B/QsfS3aoZmg8lRp0UY0T8d6Q5ce9/5lmf/G9lUK
 uIMDLbQ4yMjG8+wxyC2IMLfbeCzpGRWyPCkSVLeVGB7l4onXq64AEdOewJ31h5TTiRgV
 VvRBAedN310zyEjUAZgtLT2E4c8XUXcmjsAYit6X4loNOZv6KnvC81jzI2OVaujnO7lg
 IuiDQX9zXqm8II8a4ZmrbFxtDrJB9VjFBamPx9aYFWptdMBxiyjua0NwNayqgA/RmhYB
 GJsQ==
X-Gm-Message-State: AA+aEWZ6zUA/fIJfKzXrVWdkanCvDo2JRxHg7bARkWIFdLcWWDKEYFyt
 99hu79zfgHWnZGSlixEYAA==
X-Google-Smtp-Source: AFSGD/X20Gfp0hzWG/8UOSQaXxrv+uwjl1YPSrg8QOLl525zqGscdZVPpQvQ6tb0RZ6St6NsYRtLlw==
X-Received: by 2002:a9d:c6a:: with SMTP id 97mr2605973otr.163.1544225897874;
 Fri, 07 Dec 2018 15:38:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s13sm2287255otc.40.2018.12.07.15.38.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:38:17 -0800 (PST)
Date: Fri, 7 Dec 2018 17:38:16 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 04/15] dt-bindings: interrupt-controller: Document
 RDA8810PL intc
Message-ID: <20181207233816.GA13681@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128135106.9255-5-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_153829_187656_94EF6CA9 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, jason@lakedaemon.net, arnd@arndb.de,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, robh+dt@kernel.org, linux-serial@vger.kernel.org,
 jslaby@suse.com, olof@lixom.net, tglx@linutronix.de, overseas.sales@unisoc.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 28 Nov 2018 19:20:55 +0530, Manivannan Sadhasivam wrote:
> Document interrupt controller in RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../interrupt-controller/rda,8810pl-intc.txt  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
