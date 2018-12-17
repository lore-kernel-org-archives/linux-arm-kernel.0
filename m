Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15513C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:52:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B9F21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VrKU5psR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B9F21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zhLZQYryWCvAJ18+r/lIeZmVNN9y5gt4SgRrFh0oZ3c=; b=VrKU5psRrzv0+L
	vRd6LJuqmcPzzSwPZoWDLRNDUgGkxz+f5zMu0+va0Kn4tFleWcjLm1Q94/FiWxlCjpFZoUDGbKhWH
	ZlGwIAHtw4Mr6uNB1lRGvmQzpgXLGCGPosdEEE+n/RLs9CUPEXx6WfjHfRZ41ABnFKmuSQ8wggRnM
	BaRilK/3ngAjKCgTUItWg0Pe/3EENvdcRHpTnhvG4OBYQuhQ+y6TxAShWeOq+ZEnl4n0W52DAuD28
	9XEl+KnDWqmUbWbd+DQXSGhpBJRZSR9MgASZQgRAG7U1igp1r9iJb50tTqfi9pPO0HL1RhJg5b1bb
	Tad6LlrQGCO1LKElOrqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ1k2-0005Ey-HF; Mon, 17 Dec 2018 22:52:02 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ1jy-0005Dh-WB
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 22:52:00 +0000
Received: by mail-ot1-f66.google.com with SMTP id 32so13790564ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 14:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ztfJrKBFiuuBhdghvmEiQyMDcD+CmMVAz6025JRdPEQ=;
 b=rT3hEbfU+D7rX8c0/5pF8qpl8Q5qb33RX3+Zqlk4mVX36fRLMaFXbhlUX5mmd0lQGF
 +gsV0YlCXVhwgONzm3yvsaAWhbyJZzoGQRucTdth/RU++0CMFQfJSi90TxXYEvjGoH/v
 BeE7gJytLipc1kAp3Icxr8S5PosVLzCyYRxpqRlBey0Kkm3h0EQl31/6aIkOJ4rbpn72
 18unWRIk+pfjE3wX4dtVwPEr1pEyxAv/7yAUiBhoGAdDWZGaEWjiHj71vC/5/UkakoSa
 ivbLZ0/uLhWkvp3zg6pD3rF4ZCarxRu1J2T/8ZxSPjRql2PfASxVJin5OO9To1wJrx7w
 E/BA==
X-Gm-Message-State: AA+aEWa/DI6qYsTtAJr17zpWS/8tsmCTBtk8xD9qZFAKBJr/i0kQYm+L
 xTiMKa77AZ4CUfXiNZGSOA==
X-Google-Smtp-Source: AFSGD/VbX28FfNmzAXVheP4CBNfefQh49QY4iydQkGI+5bkLHcH4pcxKwjvuWpobcu27Y8S7Hs9N5w==
X-Received: by 2002:a05:6830:110f:: with SMTP id
 w15mr10468672otq.222.1545087108013; 
 Mon, 17 Dec 2018 14:51:48 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com.
 [70.114.214.127])
 by smtp.gmail.com with ESMTPSA id q203sm9473549oif.33.2018.12.17.14.51.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 14:51:47 -0800 (PST)
Date: Mon, 17 Dec 2018 16:51:47 -0600
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
Message-ID: <20181217225147.GA6109@bogus>
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
 <20181217023827.7947-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217023827.7947-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_145159_034030_A049C2E8 
X-CRM114-Status: GOOD (  13.00  )
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
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, p.zabel@pengutronix.de,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 16 Dec 2018 18:38:26 -0800, Andrey Smirnov wrote:
> The driver now supports i.MX8MQ, so update bindings accordingly.
> 
> Cc: p.zabel@pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../bindings/reset/fsl,imx7-src.txt           |  7 +-
>  include/dt-bindings/reset/imx8mq-reset.h      | 64 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/imx8mq-reset.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
