Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51227C37121
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:26:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1718E2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WBTtU0Fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1718E2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AnRPc/YHvDXp+8fbaFSkcW4qCuKtAM/jdtLk7IiEjE4=; b=WBTtU0FrNGXVJ8
	7vnyrWSHZvSowzh66d+b5N1XAXM/XQ9knFhksUqfZZFUptK2rCA/ax4DHirakhmYW0YrLnQAcE+TB
	FB9R70h/EUqnHbYNFpbw/n4qmyYYPIqQ0O5rY1D3BMG+S1GIKPwUPCsqY1OA3rgnL9fBTNRT2RKjr
	p+aWU8Rk4Oe2pn69zv0G1V755Ifk1QRitbSIp1XK6l/K8pO1HGaoXBYNRX1VDlLGtTXdIJeMZXuMT
	xWKYxSSaEogvJ3R5upE2mvBjjYlgLZ9mVY83GoC6ooY/j0xm6ZRf/VSNWH1kAvJi4M9BHbtnQc1dA
	XiAbQlK+u5fLdWmZkWfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glix9-0006ef-AN; Mon, 21 Jan 2019 23:26:03 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glix6-0006eK-1g
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 23:26:01 +0000
Received: by mail-oi1-f194.google.com with SMTP id v6so15933434oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 15:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WmTQWk1tuBBNXtE3quj9vUE/URNM/tFV42TrtrkRjgQ=;
 b=AJNqbeK6iRY/I4qeabjzlGEBTuV057ONTh23infMO0bTENdJTFPKVqOb20c2VkaGhM
 R7Wfj/6tcMLwdLf2HqqcCgwFpiajHvM/k34Y++PzbL6a4Z26rCZ4F3sF6rKKuqmQxmAU
 TzHAQE0jUCn7whTnUOm+9/3b/pkoDr5WkLAJG/nQZmumqiT0CXKNWPKal+03OVyA/aFx
 aU4p21GGOxzFoWo0AKlP1svCd98qMJ5vMA/HwzbbUAS6CbBoGTzLAWs+BbtmbNBj3Q0v
 IxPDRUhiXYpQnp/kjMut60qzH0YGqZ3kfcd7VgQPPNMigNcO5a+8i+OhGkNUtLYVTaid
 DIoA==
X-Gm-Message-State: AJcUukfPCUeUKMevb9FOEaTy3sSk+vxKdTtAd/9vKBTaBdWv8YTToDMZ
 QjRGWBPUJxG5UQyhGGYb1g==
X-Google-Smtp-Source: ALg8bN7m0tkrqSqNG1qXNtkUsrzARDXJzoXBMMN8z78PD5etWwRyXXrxaYtAVjevxsjxkGAblpb8zw==
X-Received: by 2002:aca:ef0b:: with SMTP id n11mr6719829oih.116.1548113158823; 
 Mon, 21 Jan 2019 15:25:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s66sm6805802oia.55.2019.01.21.15.25.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 15:25:57 -0800 (PST)
Date: Mon, 21 Jan 2019 17:25:52 -0600
From: Rob Herring <robh@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH RESEND v1 1/4] dt-bindings: fsl: scu: add fallback
 compatible  string for clock
Message-ID: <20190121232552.GA22199@bogus>
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
 <1547207400-28307-2-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547207400-28307-2-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_152600_090018_6FDFFD6A 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 11 Jan 2019 11:55:56 +0000, Aisheng Dong wrote:
> SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
> Let's add a "fsl,scu-clk" fallback compatible string to allow other
> SoCs to reuse the common part.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
