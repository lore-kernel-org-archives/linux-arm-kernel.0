Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA322C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:39:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988C6218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M9Q0c+kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988C6218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qPlSIRjJgAKs0Ux+TMd1CEmbk6aduSeT97EampkM3k4=; b=M9Q0c+kj35rWJp
	dWCd+wsNrNMEGJn7buMVNOdWuH1t1Revcupnt5LAf8vqtKf/Kr89tF+JQSNi8VJ2JHyGy60GrBYYx
	+sXlaWPtbB8APB3dX2E1CRkgtM/mf+r638kMrl73fv8pRmEBtudCwRhDS9VRjyohvaZJkel19Y1fr
	UTmgRpiqBJ1vUJOaj5EgRcZds3KxsuyhuqcGWcitYX+57mfj2U80xWNszt3j/yrNY7FxpOC+hxR81
	a8CDoVuU6GnvGoUu0fANyah1+KDFmazTaRP9ArLNEVmx/fi1bAoL6LC9Y5p6rBU/9mIxWa0I5C18y
	BWU3Yq8UHX8NRQYwzESw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyPq8-0003mo-U7; Mon, 25 Feb 2019 23:39:16 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyPq5-0003mG-4p
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 23:39:14 +0000
Received: by mail-oi1-f193.google.com with SMTP id i8so8826059oib.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3skj6VwdsJWrWyxCk6FDLLniIo4F8rwKPSvilmcScKo=;
 b=I4/gm1Nrprk9fKXdc/aUL6V675xdEt+4rh5Lk4khghjWg6kGJZoCWerG/pJu2jtsQf
 ioNhLESezmAHpRt9Wb6fj6sVEsUee9pPpaSR9guRESeqlgwS47OSbLDnLp340dSOewCc
 zqrzK+QWNRhYX0Zk+82zX+vNx19Av55aBQpdak7Tkd4nn54B58BGvPJF1GfUzYThjGAZ
 qF+UvhjdoPI8ymqGMbQgGbrQSq5SkH+4g/x6o0D/ReVg6iiPaO7hH6SKo52In/64P5NL
 MyOl+usu1ZzRrtLNTzxw+dGwzr1wpXxkvp1RfUKql9XYQETCfLG7D2xE0lyZ6ZFdGvAZ
 JgVQ==
X-Gm-Message-State: AHQUAuYQieNMSZ9AIY1rvcQsbr5niBzFiccmt3MC565+KtogIUTsTPq+
 P+rKiGi7LW+xmtZlMMbOgw==
X-Google-Smtp-Source: AHgI3IYSpE6y0er9F0bJSprmJD1D5l1k+sEl4k75wI9rsYhTmTg6RHlQ/9fVBiprcw8TvDJ2Y5A8NA==
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr573604oie.64.1551137951909;
 Mon, 25 Feb 2019 15:39:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n187sm4710378oia.34.2019.02.25.15.39.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 15:39:11 -0800 (PST)
Date: Mon, 25 Feb 2019 17:39:10 -0600
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: imx6q-pcie: Add "pcie_aux" clock for
 imx8mq
Message-ID: <20190225233910.GA2334@bogus>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
 <20190212015108.16952-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190212015108.16952-2-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_153913_188932_2E3E48DC 
X-CRM114-Status: GOOD (  11.79  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 11 Feb 2019 17:51:07 -0800, Andrey Smirnov wrote:
> Add a binding for an extra clock required on i.MX8MQ.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
