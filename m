Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B7FC37124
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:10:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A038E20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bO4Qz+bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A038E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i3ZrJaLe1UM8ING4meJN6vlSi85jlCVPn3vLOfItQZI=; b=bO4Qz+bYYjwuk4
	sE/lsuRYGWbW9QHfijy8VXUyQ/HK5sxBCh4+QQs/DUhHbxUVzc5WZpm49vAvgDzDOvJgQm8a7G4Ji
	o/JO6O4sh3TqigsHYC7I1HdwnHz2cgTfWR4wppyMMUVXrs4jyQv8/BJgZ/tkwlTwJu9qh7gnM9AL5
	4jZd1MtGSxsFUXEQD8773ELPR+NM2SMd29x+tAPyNi1Grc/n4qGKcfqqDHHebjYKkCzyVN7e59+fU
	bz/CSKTqvFry1+69BU5kiDFVbnsn+gmPrgyPumZIHcWwrCNOg831zOPmZfN3SbD78iRBcMtCE8GcU
	17lFeJwlow7d2Jtmxikg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glka2-0006q5-Qg; Tue, 22 Jan 2019 01:10:18 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glka0-0006pl-98
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 01:10:17 +0000
Received: by mail-oi1-f196.google.com with SMTP id i6so16075867oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 17:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TQvnxtgbnj8D4bzHvlMfTgl05BtygG41c+UHljen430=;
 b=m3HnfdCbS5kUZRJ2C1XVjhgdwWRER8kqSl+BPs1IcYQK8ebK8S3SdBjRKp1Bi+SCjS
 DL6qCvNTdpCOloZ8emuRdLW3bjSRqMrw870t3hVB6ofbiaL6UfB6kvQ8m1e3PC9cZ5N+
 rIKkjHXJzejLwGqL/N10/qRDAUvYNg1DEzlQbMh6TT0ZS9lPLOccl5Zm76gdvIgqIoO8
 hgn+KaAn9ogyLYtQNnfAkkhtM/8vyLCf4wB1Mt49Tr4XRJ8LoLQRRff8JtPH+3/7oEUt
 BwU1Ey0RvcoK6xZxfuLtjIngJOc8pnpbcGwa4F6426YJqdQCU+B6Tn+fMijwU9b/E7Y9
 ClZg==
X-Gm-Message-State: AJcUukdFiE2Ja1h3piELlVTWEFk9+ZHLeAAgYpCXfgs73c/UNFyJ5DpT
 0PhI2FhdfHSvWkqASJ0yXw==
X-Google-Smtp-Source: ALg8bN47kY7j+oz6B7SATJ6Zmbg2S5peA7VBanTyTT4sO/mRSaVKdyC6Peo2GJ97TfMIe+H37tbrnA==
X-Received: by 2002:aca:3b83:: with SMTP id i125mr7256699oia.53.1548119415253; 
 Mon, 21 Jan 2019 17:10:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g25sm6505910otr.30.2019.01.21.17.10.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 17:10:14 -0800 (PST)
Date: Mon, 21 Jan 2019 19:10:14 -0600
From: Rob Herring <robh@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation
 for sama5d3 10/100 interface
Message-ID: <20190122011014.GA25211@bogus>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_171016_321388_74C537DC 
X-CRM114-Status: GOOD (  16.77  )
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

On Wed, Jan 16, 2019 at 10:57:40AM +0100, Nicolas Ferre wrote:
> This removes a line left while adding the correct compatibility string for
> sama5d3 10/100 interface. Now use the "atmel,sama5d3-macb" string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/macb.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
> index 3e17ac1d5d58..f5c414b10e27 100644
> --- a/Documentation/devicetree/bindings/net/macb.txt
> +++ b/Documentation/devicetree/bindings/net/macb.txt
> @@ -3,8 +3,7 @@
>  Required properties:
>  - compatible: Should be "cdns,[<chip>-]{macb|gem}"
>    Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
> -  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs or the 10/100Mbit IP
> -  available on sama5d3 SoCs.
> +  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.

Where is "atmel,sama5d3-macb"?

>    Use "cdns,np4-macb" for NP4 SoC devices.
>    Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb".
>    Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
