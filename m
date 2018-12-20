Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83865C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:43:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3448221903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KaB7tp2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3448221903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oRxEiL7YYEa0ti28jJeG3XEmLh011o9PQyjmxtZlSxw=; b=KaB7tp2HEPjUNJ
	h6UiF/fkVtT9tO8juGvj1Gt50BJo7kPe57q+1pCubUBST8CfylwoBd7fRFmvQz5cF1k99axM0Yln+
	Pg9QMmDcLBfaaTMqNJ4eNxdvpYd9p0M72LNfg16/e93ZWJcoU38Evm1PF/hezKRzZyWoLJwNPA03E
	NqppOTi8pY8UrC6V6/tYee5YjL+LnMqoRLhb2+EmSXcrMLDNbFrS1EZ9n5WWmVr5XSRe8gfN0ORxf
	4Y3hG7MCkPBtwk1gHhaVlQy2wavmEtrJvcvrPOWtCNAl9L//upKweoVxc4+aqqJOinqT2waDXcF3e
	N0j++aYVY58ouZzgYiOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga66R-00037p-EV; Thu, 20 Dec 2018 21:43:35 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga66O-00037I-Hn
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 21:43:33 +0000
Received: by mail-oi1-f194.google.com with SMTP id t204so3152883oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 13:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Xf+zgetJ784oJoKuallGRh1oGR7CSm8pe1zQX2EXtf4=;
 b=IHFU+42KToShZuwA6NMYQtOUFCsQFxa4XVv+DxxAsxeR1//zz23gu9M/Vw0DyomEY5
 3j1pabbTBOul8dblxhcziJaofhbYp6LA6H9Sp3iVzy4jTaBQsx7LDgnqMJwtB9/LpBXZ
 Bb06/R2JISmTieS/+7JL2FApuNJSa/prxyldZB2MOZZ5XsJ88CY6EswMqXc7VsYy/CMx
 3og0+rL3teDHKZD37+/gFWmlJgqKEtgVdoqy8yhpv/N5Ggsw+SfmriS2vZGyteQKZEsg
 A/WRETl6lGA3um5iWH8Zdy9/MSMjkzur7iyI9C9gTLYBgVnKKWQWRBHB1Um2BoDjKVbO
 UDzw==
X-Gm-Message-State: AA+aEWbOoh8nyEDp4M6jL361e2cDqRXI9cRo2N8MBQaVnBiQti8QHxFT
 Z6Xz7iYPb1zg7FyJFUuDmQ==
X-Google-Smtp-Source: AFSGD/W/sUQ9jBWTS18FEXlMHNLmIGeqkhq7zbtCTwiI7lW046i29OfsxH/Al1TT/NR9iOV8Iccbhg==
X-Received: by 2002:aca:d4c9:: with SMTP id l192mr281963oig.307.1545342201877; 
 Thu, 20 Dec 2018 13:43:21 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id w5sm10104282oif.48.2018.12.20.13.43.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 13:43:21 -0800 (PST)
Date: Thu, 20 Dec 2018 15:43:19 -0600
From: Rob Herring <robh@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/2] soc: imx: gpcv2: handle reset clocks
Message-ID: <20181220214319.GA16103@bogus>
References: <20181217153152.21135-1-l.stach@pengutronix.de>
 <20181217153152.21135-2-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217153152.21135-2-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_134332_640701_828986FD 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: devicetree@vger.kernel.org, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 04:31:52PM +0100, Lucas Stach wrote:
> Some power domains handled by the GPCv2 driver need to enable the clocks
> for devies inside the domain, so that the reset propagation and proper
> power-up sequencing happens. Handle them in the same way as on GPCv1.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../bindings/power/fsl,imx-gpcv2.txt          |  3 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/soc/imx/gpcv2.c                       | 60 ++++++++++++++++++-
>  2 files changed, 62 insertions(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
