Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E95BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:40:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADD52086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pWRfOqE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADD52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jD4PkV/2qMsyFY/25D5DNp1nfD3IbtaNJl8jRfdEyEI=; b=pWRfOqE2zH6iBJ
	GDYKgt5/WR0ZexzZd1OU5al6eFjLCezMgFrhyJILriQA+gaACcizPByTKgMxk+svIRGGesxd3RbPX
	yXIiJOFhIPAA//zB9INBFY4Z9fm+2qQ0GmbSfNQnzp5lscaV0FDjLJB46ktJdmAMKRdV4PA9AwCgq
	of7J3+8Qc+OcwM/IDuqq85V2LLlQVSKmJvao2iBmLKfIWr2R0UbudSdL76ZVPW8sLsRNV0vYYgc+J
	qEwF07uGb04KMdzBRjb+ZUNsxJZnIMMAMCAE8zqcX7E9wkCXqAw2PNsuMRE4b91vFnwZt+wArKDjt
	lGni/8tRuw0d5f4PM7dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjWRk-000682-UU; Tue, 15 Jan 2019 21:40:32 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjWRh-00067b-Br
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 21:40:31 +0000
Received: by mail-oi1-f196.google.com with SMTP id m6so3331274oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 13:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=S5gV17x4oTl0njUrPIb4oKxcW9iZO+WeMmVfD3Ki7HQ=;
 b=mubJAT7NQEUAC0sjnq2hpuBRFvGnzN62aB7+N4LmjvaZOo7NE/Ce6Urfch+22zD5/4
 bwVpo2a8eVb772H4uV4hLpn3ZCblppGg55b7FlaJu56yIYiwwvfHzm8f4UQ+JmOKMTfx
 zdllTtrGp4fC2ifExutabpew3zdkCTguRrZ36bcAEfOZJZEq2ZpdIorwZSaccgh21rOW
 HM6Ypxim0i5uFyswxxw3QuTPebpfJnAyyxOFjOj8T/ZUuXm9zo3O9J8Y/8GoQxnN3YMZ
 HPoNTNgztRwZFyH/UCn/HazQ9yQ+FAeoGfimKQGAWppfaNp5l7CXzWYkoaPECjCXeunJ
 PElQ==
X-Gm-Message-State: AJcUukcSqLQBYmzCr836KgnWOoFpbUnNXCcoR3iEEkQseyO5TzC9gFQa
 0x9N7No7Rgk8im/03MgEBA==
X-Google-Smtp-Source: ALg8bN4KLYAh6iGyez5g9YaK1vYopoNMAw0dLx/d+ynT8L0y4ymNxTrBmZU4+oq/88DklmpumD2Zag==
X-Received: by 2002:aca:3a55:: with SMTP id h82mr707168oia.86.1547588428308;
 Tue, 15 Jan 2019 13:40:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r17sm2033412otn.0.2019.01.15.13.40.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Jan 2019 13:40:27 -0800 (PST)
Date: Tue, 15 Jan 2019 15:40:27 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: fsl: add imx7ulp system integration
 module binding
Message-ID: <20190115214027.GA21610@bogus>
References: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_134029_406583_AA95CFE7 
X-CRM114-Status: GOOD (  10.96  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 11 Jan 2019 06:22:40 +0000, Anson Huang wrote:
> Add i.MX7ULP system integration module (SIM) binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,imx7ulp-sim.txt           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
