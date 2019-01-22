Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9421C37124
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:49:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0952085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CALaaP24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0952085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=asu5f+BEcZXixT1K0HkqjSPtM1Q8OKGGQgEmcKgUMs4=; b=CALaaP24Kw05G0
	E3t+i3uzcwGGBCz/X4APK3pAvzb6880iQgeWW5FQEnsNiYFtn06YmZBVG5FA0ZSDCbJC72POT36iB
	XV/Y+D5TWSAkRmcIMx5BHFnJgS+VZdzFTQrQ1TZY2bw359WiG6eDfrJqB6WfOaNKjlOxWsVNNpWFO
	H4/WbN67yf6ZxLtcvEu0MWyJ9qJ1Bp1ErD/E3RMhOGNN2BIE42UWFLV3nZrJx6FECzlc3GJSl93gI
	y3q/cgvtgEtVyj0o6b2RoB2yncHnsrz5Vi81VXiXcrKzBWTtlnSJpVyRJ1+gfeILgTFDwnHFYmxK/
	v22Nh2xw19QB7ZcfRBFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glkFy-0006Eo-2c; Tue, 22 Jan 2019 00:49:34 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glkFu-0006EP-Lf
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 00:49:31 +0000
Received: by mail-oi1-f195.google.com with SMTP id j21so16031450oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 16:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GK1M7ZLRzfjVuxsLvZ27kbQ7/+tFZcSW6FfgmMIT5ZU=;
 b=C2l3NQJ9iUMo7VlcRowtoHlyybVpx7qi+g15JMQmWVdb7sWlyp1RFbgyycN/VhdGvZ
 h7coqp4XbYJ+yNmbxrX/NXkul3yf/zo/lw/K69l0CGDEStU3WyUKADU50XLrOMRthVJe
 f9WV18v55zxzD21IRCLITolNwwDKTOgg0egyI5Tm82Ho1OT15VUvXeFA16KvKcmD3iM0
 MFTNszvoiiGm0s2DNqN5t5JU+8Td7mlq1AQcyLfnYuZE0y6ZmM2sFHxrUlBK/yPy3De3
 SwzQtFvY+UhMJdxbs5usm0cmEnXH2DlXw4TiD0dEr2DIFi0rpxqn8BC4e+JvLo0ZzQJB
 NvOQ==
X-Gm-Message-State: AJcUukcUQMP++6FVN3NnqIGyLJRzgK+gCjLXboqR9eg8ojw4y8J3/yLN
 3eEzF45HZw+uyJqYI3PSqU2M+LDrjA==
X-Google-Smtp-Source: ALg8bN6EJF7NDc2qizWaNYDm7ZLZulkbSKUk3l5f4HKVmQ6Eie3LMys6CtdjbPwKJRyrxHAeFPun+w==
X-Received: by 2002:aca:401:: with SMTP id 1mr6791963oie.335.1548118170007;
 Mon, 21 Jan 2019 16:49:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x4sm6160207otk.37.2019.01.21.16.49.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 16:49:29 -0800 (PST)
Date: Mon, 21 Jan 2019 18:49:29 -0600
From: Rob Herring <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RESEND] media: s5p-mfc: Fix memdev DMA configuration
Message-ID: <20190122004928.GA26160@bogus>
References: <4235afdd39766f11a3bf4c8daa0d1f4e6a1cd6dc.1547476835.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4235afdd39766f11a3bf4c8daa0d1f4e6a1cd6dc.1547476835.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_164930_705950_1BD9DADE 
X-CRM114-Status: GOOD (  14.44  )
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
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, frowand.list@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 03:14:14PM +0000, Robin Murphy wrote:
> Having of_reserved_mem_device_init() forcibly reconfigure DMA for all
> callers, potentially overriding the work done by a bus-specific
> .dma_configure method earlier, is at best a bad idea and at worst
> actively harmful. If drivers really need virtual devices to own
> dma-coherent memory, they should explicitly configure those devices
> based on the appropriate firmware node as they create them.
> 
> It looks like the only driver not passing in a proper OF platform device
> is s5p-mfc, so move the rogue of_dma_configure() call into that driver
> where it logically belongs.
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Hi Rob, Frank,
> 
> Bit of an old one bit it's rebased cleanly - Mauro reckoned[1] this
> would suit the OF tree better than media, are you happy to pick it up?

Applied.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
