Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5715C37122
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:31:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921D021721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FAhTKuc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921D021721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2XHSVgHIejF9aEK4m8EAdCnfyx9uqHlgDKN7RLGBZlU=; b=FAhTKuc7IswQxU
	n/I7LNOEBF2BA++rZtd3QCYMCZrKYDgxXaa7maQo4EXvmWRHANyFdIVPCFZFz5Ixr6HK7/VoiDK9j
	VbaU6OmPdip22QLjA6BZ7QnKjGZKJBiLa3d2sooABppZHZQkK+ashvJR4NIzyKGn4PpZ2OWgXCEMG
	jC0eYj7rMn93RCbao0hxECp3lIM8v7YcrL0Ii6n2J78gkGB2zHDHksvXGJKkoP3xfqxxMcSZpo+Lr
	n2GpvovxDGL7H+zSCXrXqOss6OZ5NZYeVa3ioNCRnWZ4tWR6PTztrYqFTmMFTgy44f+3UOE7cVrrl
	oiPYsloipODmOZ2lxLPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gljyh-0007qe-Tq; Tue, 22 Jan 2019 00:31:43 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gljye-0007qG-0J
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 00:31:41 +0000
Received: by mail-oi1-f193.google.com with SMTP id m6so15997106oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 16:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JWoG3DHHJ3PJYTklhTubbZN/R0wYZS7KWMnjHDZtnIs=;
 b=fe1L80DBRWKpJJaUFtloKn1ZnzrAjoWySkrMkmu0wIQ42MumC8Uiqct2QaarAaBECQ
 5v6LQ8EECN0KHkwUZDb+o6YUg1cLQ8V6Qugh4gcr+vlFeLHFZr1MAwU9GCWmR82pj/3+
 QabQhUDYVYXzwfqsNH+FC5XO4DYUHHvB3Gwrw9UI3hPd0PExWITxSELCRJ1fVD+648Qh
 aD4tyzXlepIk5PAsvDl0q6PvGSvstH3pfed8OjHpIBZsYe91Vk6JERuqGysF3pAWvcfx
 SBko0rB40OLbXLY2IOxmIywmHYk+fFXI86el4kRAQ37FfFEj1jWJzKlJ9FTSt3f66QuU
 b+cw==
X-Gm-Message-State: AJcUukfVZ5SAfw3OYGT202z99DkMfrUXTsQxyhCbkAumwPR4Kyg4/y0m
 gAbi/wYYcnnTSbO0zBfKcg==
X-Google-Smtp-Source: ALg8bN6rm9MBZBYIOmoNq8rKDAN88J0am2wZTgXOQfF4BF4TGfZ8w7fAOQ2gKlwNHvMyoL8wkTI4uQ==
X-Received: by 2002:aca:b102:: with SMTP id a2mr7204461oif.180.1548117098243; 
 Mon, 21 Jan 2019 16:31:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id k130sm7158547oia.47.2019.01.21.16.31.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 16:31:37 -0800 (PST)
Date: Mon, 21 Jan 2019 18:31:36 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 03/24] dt-bindings: PCI: keystone: Add "reg-names"
 binding information
Message-ID: <20190122003136.GA30537@bogus>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-4-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-4-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_163140_046630_8A42B314 
X-CRM114-Status: GOOD (  13.72  )
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

On Mon, 14 Jan 2019 18:54:03 +0530, Kishon Vijay Abraham I wrote:
> Add "reg-names" binding information in order for device tree node
> to be populated with the correct register strings. This will break
> old dt compatibility. However Keystone PCI has never worked
> in upstream kernel due to lack of SERDES support. Before SERDES
> support is added, cleanup the Keystone PCI dt-bindngs. This new
> binding will also be used by PCI in AM654 platform.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-keystone.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
