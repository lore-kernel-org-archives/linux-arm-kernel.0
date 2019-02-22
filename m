Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C237C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:38:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59021206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pPORjX4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59021206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4KbB0Aq114EYMQDPggWIMX0bZbLVzti/U5EzA9j7pGQ=; b=pPORjX4apx5LHu
	yPNp2YnozJiLXVEQhfdkDA1vmCEjku80exdRZiJO7oYTLMykpIycigD9/W5bOBEx63MO78xGYoMlT
	UY0vaWT9WWbsW2LHYibg5KETepky4CQny8zhsGLIck2F94rV+ZzlPL+Ns7We1sGjKieCGIRaKgcn0
	o/qrdSFH7ov5izbbpRvgO44axfEP4smp4ydXlDjfYRwnfnjmoLI7IAIfkWW6bbrYqQrO9UQhbdbtL
	j2FsnZNRkIPh7bJH1Ef2BC619Ju58hleHUPstLd5MpfjsXjeKksxsSMJBLZ3tRQuJx0UXOwKn5nWI
	+FKk4W5cNKfcJthELLew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxEm6-0005lv-7h; Fri, 22 Feb 2019 17:38:14 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxEm2-0005lB-0L
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 17:38:11 +0000
Received: by mail-oi1-f195.google.com with SMTP id i8so2323759oib.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 09:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pGKE0LTWlBkzciALxi/Hk8127jnmY/o2lVvGMar+8NY=;
 b=XowF3YZaw1A4A4HDflRRmucnRshfklVVU1cSnY3zSnpOQgbnxTkuCQ1l8m0DFsUIBf
 jcfni29vh+eYcSFJ9EFWaHEqY7olCpf4Q6seTyEDdq5fQ3ZPNJkd0wVw+C0OxoKV22Sa
 fd9Gp8aRI+BRkX16D4crtyDb4Swax4Ob4aUqgoVMpC2Pz4Wel2JbEK3iFCYkrymkohw2
 RCwA+cwVz6ERIVM4Jjzg7DTBnT7P/2d89Y61HeDJDFjhJo4nhhndSiiGT1D7viJSCn2x
 L6OfdeEa/0Ah1XaePvJV3NIZN/XNO1sVjDLMQ0yTmZeDeg4UQGhOCS0m6hhl+GiTOBKn
 tiFQ==
X-Gm-Message-State: AHQUAub5RetuEcOxmckt9kmosxKQHCJrmf5zKiQBBGMe6SA7fImOXx2K
 L7j0P6aQy0MjHAYjG+AjeA==
X-Google-Smtp-Source: AHgI3IbxrNqBwXIiWfYgZSy8/4/qUGZjt2ODmIusngYJDU8IwG2XO1tYEIpIAQbz3y1KXAW/Q4FaMA==
X-Received: by 2002:a54:4613:: with SMTP id p19mr3313954oip.88.1550857089030; 
 Fri, 22 Feb 2019 09:38:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id e89sm1073290otb.30.2019.02.22.09.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 09:38:08 -0800 (PST)
Date: Fri, 22 Feb 2019 11:38:07 -0600
From: Rob Herring <robh@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V4 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Message-ID: <20190222173807.GA3023@bogus>
References: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
 <1550662447-8565-3-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550662447-8565-3-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_093810_043660_43489018 
X-CRM114-Status: GOOD (  12.15  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 11:40:43 +0000, Aisheng Dong wrote:
> One irqsteer channel can support up to 8 output interrupts.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v3->v4:
>  * no changes
> v2->v3:
>  * fix a typo
> v1->v2:
>  * remove one unnecessary note.
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
