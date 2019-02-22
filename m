Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6018CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:47:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB442070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u2s0R+Pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB442070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ez214HbfucfssvQtYvNR7LyoDl1hz901Z603KDIKj0I=; b=u2s0R+Pcs0+z/8
	ysrIIqv2lYMoXGjWaZjeTkCEnqev4atQWyvY7NhJVq67+Z/xg4hre3yqB5hNXgkFQpssNS5DBQA9W
	5boS3wT9KVoxH6LEj85OyKv7yoJPZQIfgEE7sbXJ9ZE5I413dmGdjL535QdeWteO/IiEyrzB1oJ5S
	r8qCIquSY4Gyc1p7/MzhH3KJ2YAqvD98KilEHhq8JXPI32CsLtltnfdFDUi1NwkaBxpleJ9f5bK7c
	SY4/jPS7BZPtOPiebhPWJohCMIBa4k8/FfLdeAKoFOeRN3OW/pyCCpnyEX7fOIzdE1HCJfGJMozBW
	PsP9pxxDmR9dTZzCQQWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGms-0001vo-Nj; Fri, 22 Feb 2019 19:47:10 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGmp-0001vP-7N
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:47:08 +0000
Received: by mail-oi1-f194.google.com with SMTP id u128so2665374oie.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EjATWlf0D3UqiXU7UDCKyghVgCFxa4nCPUaTMC9D1kA=;
 b=Kk8WdWIv2AO8cLOp4+Cxc6TTnlL4Aze3atEuOD8UUP+aWOOiGuKkOeerRDEmmpdYEk
 E1+HQ8vEUyw7sBHijFD25I99rqm8r4jJt0qMpggwDAH72dMZE/95C5e2sOd77tVxdHf6
 Xns2NvgvHLvjyw6x267LTCnmmeq4X8YndDn7x9sLrTecun/6Xap8eweezyFaQ5TXf7n2
 idt6DV4GiYx0EVmP70XPJyzDXfiVzTUwf6IKxBizU3TeqI8sIDpjxGKHhq0gCLn4Y5Cv
 JWw81UMXpDGd1DnWBkVHdS8CoDWeLd4jcK1g1Pz7OY0Agdxrlxc/LaH1iTuH0DC8j1iN
 abng==
X-Gm-Message-State: AHQUAuavlyFHxwtYpgb9QyGrQhj/CPbafd6CkmiSeBi2KJVhbXUiQAvS
 59nQqJWRSidXd/FzuF0v5w==
X-Google-Smtp-Source: AHgI3IYO4rqhLD3rQttIBcwd4gXYLfTeGgD0WDXHjwzwijVft+Me4FdHtZnAGtZsH33A+z/GO1HwiA==
X-Received: by 2002:aca:ac45:: with SMTP id v66mr3374705oie.134.1550864826498; 
 Fri, 22 Feb 2019 11:47:06 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g128sm945913oia.32.2019.02.22.11.47.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 11:47:04 -0800 (PST)
Date: Fri, 22 Feb 2019 13:47:03 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V3 2/2] dt-bindings: imx: add new resources to scu
 resource  table
Message-ID: <20190222194703.GA16450@bogus>
References: <1550673029-15910-1-git-send-email-Anson.Huang@nxp.com>
 <1550673029-15910-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550673029-15910-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_114707_263027_5A6E46C6 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 14:35:06 +0000, Anson Huang wrote:
> Add new resources as below according to latest system
> controller firmware for new features:
> 
> 	IMX_SC_R_PERF
> 	IMX_SC_R_OCRAM
> 	IMX_SC_R_DMA_5_CH0
> 	IMX_SC_R_DMA_5_CH1
> 	IMX_SC_R_DMA_5_CH2
> 	IMX_SC_R_DMA_5_CH3
> 	IMX_SC_R_ATTESTATION
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes since V2, just separate the patch to 2, 1 patch to remove resources and the other is to add new
> resources.
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
