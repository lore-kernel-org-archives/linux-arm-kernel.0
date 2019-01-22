Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DD9C37124
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:05:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D2D20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="djS1bYj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D2D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kRgFXanBVPkdHJQHFQ6yINugMZXt4EPdXZm26PGv4hU=; b=djS1bYj3HXEBkA
	P/s4vXbu2aWl80nxiicEI1ILfWBUYNrQNnpXgHzVuP3AAIpRSUyQI8po57Ut+nypgK6XnJYJuZxYG
	K4JwcNfEYYoe9dIV9Fz1ZohpxiosnsYD33BOi3bTPOElsQZBawJgBaeqf9aFUElC8+Z/T5plXeg7t
	JlzUKRH05uPpzNArbmHJlDQVcBU2Cdg6n/ox2BcFJGAJTqVYdR2w6HLsYpWYzXPJhwewfWFFjYIVP
	Q381qguvdTFOZ+S5yAnOIuOvKD/JmyqzkiUxpQhuXp6IUAv9BPWpT6YGUyLPzGOdYr6tOwU7VhmEs
	rlIvjoGggXdl6mkKRQLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glkVT-0004mh-Ck; Tue, 22 Jan 2019 01:05:35 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glkVQ-0004m8-05
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 01:05:33 +0000
Received: by mail-ot1-f68.google.com with SMTP id v23so22172570otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 17:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Gxl0VBPO7E+5K/VBg1k064AKPgPuNyZ3QDJgA/cl13E=;
 b=T1bDXxlUpgxiRWytaR3bAaLkdefG8AD1zp4K1K/fZSJ05jembFyyiqGNxgxUDffyOK
 2uSpejoqzTEHhHwaGqNAQ1ori4ecxB8p9770YYw6ytJ0Q+2p1pXHa79u20r3Q2iPFGrK
 +5BUqVBDOlajfTFkVW6dyD6OhtW5gS+4YMHxyj3blKE6QJEp5BhTQY//iuC4jxDBpYwa
 9fw4zY+NHjg6zYItpBGb8aAvDn9ttObPEqRKLUY3PBnnfFohOlpplV9dsAMX6nPKP+hm
 SYRGdHnNrQKIxVwt1rh/dOsBNg6c86foiEUGMGiSnWyoH8DSl87hIEKSeSdeajph6xLx
 VMmA==
X-Gm-Message-State: AJcUukfELvsoVw+Tu/85XHKM6NHeJANGDHlo9d28qmQqBEgWtwu3jMWT
 hDmjPla3snPDsXmp1tnuZg==
X-Google-Smtp-Source: ALg8bN6RDyQxrnw2O99C8eF2VvDyPMoFMJ09B6GINUOIQ+dqC8pyHPH3HPonpWPmVtuwYfbTfKqTXw==
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr8012993otj.301.1548119130119; 
 Mon, 21 Jan 2019 17:05:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n185sm6967674oih.18.2019.01.21.17.05.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 17:05:29 -0800 (PST)
Date: Mon, 21 Jan 2019 19:05:28 -0600
From: Rob Herring <robh@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 1/8] dt-bindings: arm: atmel: add missing samx7 to reset
 controller
Message-ID: <20190122010528.GA20975@bogus>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <b073b46ab85e9c855640e674f12f2a0801876140.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b073b46ab85e9c855640e674f12f2a0801876140.1547629763.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_170532_094252_7C22B955 
X-CRM114-Status: GOOD (  11.19  )
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
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 16 Jan 2019 10:57:37 +0100, Nicolas Ferre wrote:
> Add this missing compatibility string to the Reset Controller
> compatible string chip list.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
