Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042CFC37122
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:32:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C741E21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TErP1/qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C741E21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HIut62hkfdLKjzcfhuue/g4OyTW6KzSnDUsTD8xGblM=; b=TErP1/qcZq3Bfs
	IcHtBXfHbciM9uH1YNp85nURvn4Mt7XDuz+3dEi+vfXLqriKUcJsje5juo2kCR4gLGm+DKSrXLLgw
	wpSzjSFi8mRS9zBDC+ai52Ir27lCLg+huTycs6WAAsL3Ut5otGqfHuxiSLXuRICoZnuhD7dPq9sRS
	Go2ov0z4I0UjuH/HoYpmV/vNDHtocNn4REFOQ1QRHYD4H3nY4L3c81sDRLFyWPZ45zregFyq+nr00
	7vT/+JJ6ax6O3HbWfDt2NGxqQ0erxR7aO05euS/BmyEDUBc9odnDEsFrJlwDvxg1PEy7a1FN4DakT
	sULWTWkUIHSm11Ya/Qjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gljzY-0008IF-Bq; Tue, 22 Jan 2019 00:32:36 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gljzU-0008Hf-OE
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 00:32:34 +0000
Received: by mail-oi1-f196.google.com with SMTP id i6so16020185oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 16:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P5zXHGW+iRkj12tqNTKOGuFs9OGMy582LkfL8vcrIWE=;
 b=ZvrBC0r1pj/HNp0vbYmrecc37jQhXDaD9wxTbN/kHJG5vFuwAipQwmt5mdpapHIIwg
 J5nLCYBpgw6YfpI4JyR5o3k6Gy4tu1gwEBLaqNlAXT8cLdueZEDFk5oharmh8aPUl/42
 Ywk/Ca4OvD4BvH/SsuuYYO979syqnLeFqnQC+XphnmrPkaxLgCEurw7eyNVA7D7WAl3j
 pb1CQpFuLMc+mPsjDjnr9efFazchHuxb1kKATP8euszMqyV0Kc4mTNOYWqAVd64MaSDE
 b/VvQfM4WE+eGzApF5sVQFEyur7iYU5aw1Oki60tDR71uqEsOJC9NnWDhJkRYYRXEcJy
 IPJQ==
X-Gm-Message-State: AJcUukfwFMft8nZeeYy7G9Ymgq50ig/anEqPHchq3gbMEs4WqdsKe+aW
 aQHMAGq0pf7Nowd3+aL8ZQ==
X-Google-Smtp-Source: ALg8bN6RYfvMbB6qz3r+UmOPafGYjJCH16ElCfli0n7ZfMm24qFQt4BHwyIv7Qj6ClXXJqkZcvqM9Q==
X-Received: by 2002:aca:cc0d:: with SMTP id c13mr6858665oig.150.1548117151727; 
 Mon, 21 Jan 2019 16:32:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id b128sm7087461oif.7.2019.01.21.16.32.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 16:32:30 -0800 (PST)
Date: Mon, 21 Jan 2019 18:32:30 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 07/24] dt-bindings: PCI: Add dt-binding to configure PCIe
 mode
Message-ID: <20190122003230.GA32048@bogus>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-8-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-8-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_163232_788066_9FC85324 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 14 Jan 2019 18:54:07 +0530, Kishon Vijay Abraham I wrote:
> Add "ti,syscon-pcie-mode" dt-binding to hold phandle to the syscon
> register that should be used to configure PCIe in RC mode or EP mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-keystone.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
