Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E40C41518
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:07:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378FF217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S5wqjYb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378FF217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n8H7wGEnhSkVFGWEneOh4/3pMStI/XurNFFyssgVIko=; b=S5wqjYb1VfTo1s
	fZG02lp32oQiOQxIMtV4OPHdVxB/bLq704vk9w+tq/MRbuwkhSvjTDAz/dccmvfk1UnQbuSVcW3Q2
	gurxBZKUNrAPQu43UjMAkgMhSZ68VIUJS4JWaBirOVU8XCpIjm3aoV3tPMj85YNxiTxEcfpEg98JW
	wXggDEJ5CbW+fNvVJ5jk0lF9w1IMAXY5uIU+McHdho9d/VTi5dJIXB5OXbSWOyWJ1ccYTAQNN8HcG
	G4ZI1nQMZThzkioVFmdjJdVWg6TPgvdIOjP+Xj6p98x42bzUraKBFBrT5GxRNKKMBFzFMHrDvAG/q
	KhKft2Y2TfKRfewTpbCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glkXR-0005FA-Vg; Tue, 22 Jan 2019 01:07:37 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glkXP-0005El-8f
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 01:07:36 +0000
Received: by mail-ot1-f68.google.com with SMTP id i20so22254389otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 17:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=T/nRio5fAD0pW+N4ivHGzHMVFGGptuHDxNgOgJeP7bI=;
 b=N6Zqv6ZGTXMSoswty9k5eqIRO/KIJ8qZcdSjysTDheSqLsolND39IjIf04iTo5e2af
 E4uc9pGovpKxCsjjcpfJjK5FUEE70ydN7MKW1qN+SZZ7NseoOXoT+PzMiIKRdXHq8LVC
 TQQ2At2aYg1CoDQ9SLvZS3SWupERga5XPsCWqeh2doOXL0uGUbOiFvPSxGbBIJlVrd2y
 Q4Xcrv3Os2ijyYJ+3Wi/VALFgsrLkPRv6bgrMTYHJRDxE1YuMfrXliFKaS5EEo6F0LnK
 KHJMd/vE+G+A9TCM1H9bKN0FsVksOGAi5pyxtgvRUYvWP+GzoZNyJqoQBlpdWBbN6ID4
 G3Dw==
X-Gm-Message-State: AJcUukcvzqA/wPLG9nTiQpBEQ3li2Hpf20Odk+936kHGLwYkGFMr0qmp
 IhmAk4scKAWpuVtdhEqm+g==
X-Google-Smtp-Source: ALg8bN7MI+OIsDNpY+m/U1nuHHeYT0ce6NJzeh5KVfkcmtdXBafyy+F8aQkA+NV3zFrLtjwxnt4Jrw==
X-Received: by 2002:a9d:6297:: with SMTP id x23mr19478201otk.63.1548119254572; 
 Mon, 21 Jan 2019 17:07:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id z15sm6468070oib.23.2019.01.21.17.07.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 17:07:33 -0800 (PST)
Date: Mon, 21 Jan 2019 19:07:33 -0600
From: Rob Herring <robh@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 2/8] dt-bindings: arm: atmel: add new sam9x60 reset
 controller binding
Message-ID: <20190122010733.GA21139@bogus>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <ed46005be5beff6efc47d40cea304185efa2bcc0.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ed46005be5beff6efc47d40cea304185efa2bcc0.1547629763.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_170735_306663_C6B153BA 
X-CRM114-Status: GOOD (  15.68  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 10:57:38AM +0100, Nicolas Ferre wrote:
> Update the Reset Controller's binding to add new SoC compatibility string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 36952cc39993..badce6ef3ab3 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -22,6 +22,7 @@ Its subnodes can be:
>  RSTC Reset Controller required properties:
>  - compatible: Should be "atmel,<chip>-rstc".
>    <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
> +  it also can be "microchip,sam9x60-rstc"

How is this related to at91sam9260-rstc?

The 'x' is a wildcard? We generally avoid wildcards.

>  - reg: Should contain registers location and length
>  - clocks: phandle to input clock.
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
