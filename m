Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51321C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:05:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A1A20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UaEBa7HR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A1A20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=op8mY0t/BDKhYSfTL6t77zSnTrn+1b4T2XocURZxf3M=; b=UaEBa7HRj4vkdn
	kJAhklCjLq0h1r92QSeZ964xPQKc7JjAdmFI4V9218Hx4gpFD1GsVUMveLMv+7u2xFVodxbQ9ay2e
	Txul29N6yd19Sn1G2HmqTMrdUhGOzqTTOVCxvnqnayneQ7Vwy+0mBQM8T3LcfDwaK46fjFGpUmWi2
	KKMHPrDnED8BiGa0tT0E8n0NEiMt3J1prufCfiMYBsDgmCFZK0qwhVdYocE1DwVs96djNISuRzIU9
	LCjoqj4tTbyXgvkgqdHF7gFzqxUwVCZBX3mY1yvtCi6/ks0cXROOCBhVa1zsfD4qIPgjEy+zCDanh
	oUZb/UTene1ERrfSHrhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUcJ-0000oM-44; Mon, 10 Dec 2018 23:05:35 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUcD-0000mJ-W3
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 23:05:33 +0000
Received: by mail-ot1-f65.google.com with SMTP id w25so12128089otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 15:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KetSZEIvoIidxwAgGAIFTCW0jHcgEGJVg8aSdr+Ma0s=;
 b=TuHL+QmlIk4WG7jpAEjlf+C8LhQ3DEaKlS0UIQhFlfXQ02Hdyl/TzBYMqIEdRquZ+8
 yCJh9LBoXslU2LvvhSyqzKz4vhM31dwXTbm4iWZAeysHFrd4UyKcNTGa9D6GSrgs2RiB
 YhEIz/fzuKFtS7yrffAvnW++XVAywftXcmKNdPqArN4fxZVt52Zf5UfjpyiBx+hYdbV7
 BMnjgKmSJCIe/9vYDuXH9Qp1TbhREURpZjZBvVyK4ow3UmbjjO4O1aez8wfgFG5nD5KR
 1EOGK6uUL288UcjZbDtaVtv2001TBu+SCs47rVRSMiB0aiTtNbtNjozQxEYHoM7DTUXc
 zjCQ==
X-Gm-Message-State: AA+aEWZfFoHm8IYq/U1B6XJPpWyn5oc5aooBgdhJOpSZTRGCMMnztZms
 Rz/UJESJGz7CNYp+4sPSnw==
X-Google-Smtp-Source: AFSGD/WqAfrRQthVAczrC4d6vSR1ki36kTd6LzpUwxB2K+aSHELkWEXxHpd/1keCzLa0MONvbOz5OQ==
X-Received: by 2002:a9d:6353:: with SMTP id y19mr10053377otk.336.1544483119232; 
 Mon, 10 Dec 2018 15:05:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id k207sm6434289oih.58.2018.12.10.15.05.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 15:05:18 -0800 (PST)
Date: Mon, 10 Dec 2018 17:05:18 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 4/6] dt-bindings: cp110: document the thermal
 interrupt capabilities
Message-ID: <20181210230518.GA10816@bogus>
References: <20181204190332.10351-1-miquel.raynal@bootlin.com>
 <20181204190332.10351-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204190332.10351-5-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_150530_119932_3E6D0483 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Eduardo Valentin <edubezval@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
 David Sniatkiwicz <davidsn@marvell.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue,  4 Dec 2018 20:03:30 +0100, Miquel Raynal wrote:
> The thermal IP can produce interrupts on overheat situation.
> Describe them.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/arm/marvell/cp110-system-controller.txt     | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
