Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:25:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54B42082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uxfbfmhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54B42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3jUZkoee41DN02QKoJz8/echgkM95z0DmeN/yKI7Ato=; b=Uxfbfmhl6UyGC7
	eQbNukXtjRDFgzsx3alZs91vnLpI86wCvgVV4IpOQa9T/gbIJ9zsZLot7v1GrG9UfEXNQZYB+ZFzJ
	ATgegRd81+d9ltQz1QkktXWVKTfXJg6iOp7zU8IQtY/2A1Mnnm3HZjlZDtRyVTCgPyvEpeSTq1Csy
	j2lwh0yUuhxLocmP1zs3+gdvk5aaP3yHEqw0BqCnWk2qTPwchmFmPqkGB7YkRm5u0vplkBi7lAZvu
	F5Su743EaZAfJuXlCc3nDCzAYsirmvXDyrNSRIc54RkSzenqQV/1Zal9aIlIlc28+278nbkUG+5LM
	uHnEFa+OYW3bdxQMAgaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTzU-0002oL-7h; Mon, 10 Dec 2018 22:25:28 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTzR-0002nh-6P; Mon, 10 Dec 2018 22:25:26 +0000
Received: by mail-oi1-f196.google.com with SMTP id y1so8609826oie.12;
 Mon, 10 Dec 2018 14:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DPnX9FgNasZsQgRsZ+0K4q5mDFGqah2kTqdXu776lCU=;
 b=s6E7H3fqSjwvfA5Otr/vebBi8Kx3YMCSyT3+Kpg7RarPDWuqe4NL+lM7wLccy0BUoK
 G+4BSRYBSuGyLt6e7bH3f/qUQoB5yjavjk5untp3MWDKuWnh5GnOPYasEFtnFjLIDAgW
 SO9VpsNGv2SKsa6PzCCHYPNM1yrWiAeqNvwsf8NgILjGa0xFa4ZgE3aA431kSKjAl71/
 56EQtkDcvDBJAUQKSxXCszPPbsXYvOS06fuFMvbUkvWTi4zl3d/plyvbvgcC2QkKXPN8
 f+Un73irJgOjDe3QsHxz+61GDAEf5zJeBXqtoz9k2QbC9/oExEc1D1UWy314ewLtVtJG
 zMoA==
X-Gm-Message-State: AA+aEWb6l15EBQOBiIZpp/OV7wFTWHpStrCCyKEPJhY19hPxaLNqhwQg
 6smm84rN1PjJPMZRD9WbKA==
X-Google-Smtp-Source: AFSGD/V0RicQnLBkvZ9ouH3JjTzPSMQ+izc06d5U503qFczusrs/bjBf5ykmPw41R+0rT0O9iecaew==
X-Received: by 2002:aca:5508:: with SMTP id j8mr8873898oib.240.1544480714127; 
 Mon, 10 Dec 2018 14:25:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t201sm6357180oie.37.2018.12.10.14.25.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:25:13 -0800 (PST)
Date: Mon, 10 Dec 2018 16:25:13 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Message-ID: <20181210222513.GA1326@bogus>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-10-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210173550.29643-10-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_142525_238895_2D505078 
X-CRM114-Status: UNSURE (   8.99  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, jason@lakedaemon.net, arnd@arndb.de,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, olof@lixom.net,
 tglx@linutronix.de, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 afaerber@suse.de, linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 23:05:44 +0530, Manivannan Sadhasivam wrote:
> Document RDA Micro RDA8810PL SoC timer.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/timer/rda,8810pl-timer.txt       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
