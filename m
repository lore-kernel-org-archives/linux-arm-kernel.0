Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84BBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:56:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956BD2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="beatClRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956BD2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nr9q7YbkNa9ycHnfiV8+ru4J321m34G4E7Fii2WZ+7A=; b=beatClRdOwahVh
	j4egEv8AkkTLx8oLFseTEcyvScz7pwNBjzKby23hgOWaTesLPaT7bWYdAMyoRbpQe6WsRkybhC3zF
	uDf5/PmdpLRGU/yIiFHHc+4HGvDe8ueVrRlufFhLNcHuvIts/fCpQlomns6DqSk3EwXj5D6Ele3HP
	uKqsJwWm6VBLaeTjR4k8XbQhyraxz8fFoVy3gpS1OFTHcp++bNqOlfDuR/5BJZpiuMe9xUkBzu0RR
	jx68JcWAZbrRDfqFDcQgOJxdYLwbidC05bHZFCF2YOwdsef4biqUj2JlfxKajHaJE5WWgJbWoD1tJ
	01Qu6MtqPN89/lFR7uYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmDq-00028G-EO; Mon, 18 Feb 2019 16:56:50 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmDn-00027n-3V
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 16:56:48 +0000
Received: by mail-ot1-f66.google.com with SMTP id n71so29343495ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 08:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XqIHq3ykySJYHOEYwfZ2FR3gh67mIQGGHilq/g8Gmts=;
 b=sO+XltTiVyTJ1O/lVF5SZ0+W/RrTL4MQ61Ejgi88K4YZgFoHF8uJWC5dBWamgMrNRB
 0KtW/ZINFJWQJG+jKKLlAXkov6EaGHxrKqI1NLMgUxFRLngpe69Ig8jw3nGc4i0Hu4Zj
 d36da1r7zFX/g+RB2ffAMHfKM/NUjZj83mCNcH+ONm2/ZxK9G2u1Vv4+5QftdGJMRUr/
 +KOU59e+2huPKEKk9ZNdqjRx+gpG5QiP++9B6PV3BpA9PuHlZM5aZit+n27wwrw+z5WO
 R7YDwdaet6lLJLCnK8oRr6lHHZ0XtdDPkixRfT/QCBiC2DmLMCCtzOe/UpPoP15Wx+8Z
 s7Yw==
X-Gm-Message-State: AHQUAub+iXw8HxadfZMNuS5dWxM1p/5Jdk0lhoV+lA76jEaFuCOsKG3z
 JSl8uobW6Sem473IOx+mCMwyp6M=
X-Google-Smtp-Source: AHgI3IZcE/IDnzc2ZT2b2aMiNlbzm5Y4QS+33MKpfcaui0DTC4+ibTfSQX7KENKzzJGfCohoF5zsfg==
X-Received: by 2002:aca:3dc5:: with SMTP id
 k188mr14049199oia.108.1550509006149; 
 Mon, 18 Feb 2019 08:56:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n76sm7287712ota.51.2019.02.18.08.56.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 08:56:45 -0800 (PST)
Date: Mon, 18 Feb 2019 10:56:44 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH V4 1/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
Message-ID: <20190218165644.GA20200@bogus>
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_085647_149301_7981A11E 
X-CRM114-Status: GOOD (  11.10  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Frank Li <frank.li@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 18:03:08 +0000, Frank Li wrote:
> Added binding doc for imx8qxp ddr performance monitor
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v4 to v4
> * remove "standard xxx"
> 
> Change from v2 to v3
> * ddr_pmu0 -> ddr-pmu
> 
>  .../devicetree/bindings/perf/fsl-imx-ddr.txt       | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
