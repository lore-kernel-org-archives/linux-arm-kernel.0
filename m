Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91D0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:04:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9940A217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eX3IR3IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9940A217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jPfjPPBEqEPl4vYgp1jUsTZt5yfNXzrUy8uXBSA1I+k=; b=eX3IR3IB/6mx8s
	sj4zz9fP4INEmCnmHtiRCdiY/h4uBzWWBnDkRDIQeMVjSdnlK5l8VJsrRbebGBqxXv+Miy6Ho2NTe
	ij2WmNWHL6Pbu5afkuew5eaDQ31KTQncJqXPU5fokf2OpNRjKN5FxdLQC85PkgnvW+eBo8ZQYL7hU
	rfANFzM4TbURNVmSKrt0UHUIj9LF+jnxYjDzgglJIg3OXTdesNrgbU2TPaK7PazqRw57YGrWgLIdt
	smPWlN9+tdK9x74CM5tZxfhSnn5VPr8m/ORtNUghPAF2jElWPuEQFBmQpFIZSGQi40p3Fey/ydpyB
	Ruz/hM5JKAM979QYvxOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp9Q-00070R-LR; Mon, 18 Feb 2019 20:04:28 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvp9N-000707-EC
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 20:04:26 +0000
Received: by mail-ot1-f65.google.com with SMTP id s5so30334482oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 12:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6mQejXwrgFZ3BedX4HMo1jkw2T0ZfRCg3meLh2nX308=;
 b=SNnkDOnmtSH30jm+I9YxIn891rIQ2SQDUf9Fq+5VS+dVH9pLmOnDNBpS2tJ38Ix6Lo
 dzo1iGIXx9HyknLB70x2MM9IeEOEg/yv29In+2Bc91BkOFoOiUt5P6IEZOMsmIGfXrlP
 GMIAx/2s5FratcO3/cMarw+Cbs8L4fOweN2Fi//rt9hKzd8Lq5i5AIV2Cr5slQfGKZkx
 2fyykD+8adKmbFqKYeD1lBcDB8enUX1Bn9FLIsB6TmrJjZ/L9zgkSw1qdPKmplsgMt1A
 2dqMmdbnyvlx4rdmd8MfmZ+Jt/rG1tlzROllQHXGJ/ohmz+ww+Vv/kx2D4JftJcpu2U7
 ePJw==
X-Gm-Message-State: AHQUAubLVM+Iqt+sZnThytENkF2FRH77AKJg3wDlyCbFdJF/yfSYYzWm
 DPP46T80N8lK61b2y3r1emDr5Og=
X-Google-Smtp-Source: AHgI3IaixQlhzZD9Jv9/uFagyhE8+21Lx/r1Lt2VfpKsAe2PJ5JhV21JlGTxNfJD27IgiVREBNJsRg==
X-Received: by 2002:aca:cc0f:: with SMTP id c15mr363896oig.105.1550520264694; 
 Mon, 18 Feb 2019 12:04:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id e13sm3014589otq.61.2019.02.18.12.04.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 12:04:24 -0800 (PST)
Date: Mon, 18 Feb 2019 14:04:23 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Message-ID: <20190218200423.GA2582@bogus>
References: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
 <1550115535-14488-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550115535-14488-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_120425_478856_E32F1AA8 
X-CRM114-Status: GOOD (  11.44  )
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
 "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 03:44:25 +0000, Anson Huang wrote:
> Add scu general interrupt function support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	no change, just update the patch based on latest next branch.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
