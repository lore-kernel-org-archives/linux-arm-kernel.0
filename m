Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BE9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:44:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88366222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T65BQLUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88366222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sSuucDXmA7w2yNuYmXQHdktpk8SYZ7WJz/BCDv3uNWs=; b=T65BQLUkp6C28u
	AyTG5vOrZYFQsYHUyawFzG3TuCpgovQDCRb9wRJ7klBZiylTFDR2/mbxSPsVSOMy+R5O9zk36gE+l
	rncpOJ3uTeSknGgp/h0XRuDDoZN783feDb/DXopZZ2HM+NL4ebTmMWMQ0Wl+a+8ge75b8vbk5LP49
	KyDrW1MPVVdnJA/QNhJGMAZ8EOXrnucC5/pbp8xp/2SnHJvn9z3sBSiQo0eg31X6yLXoNzZYMjoc2
	BulJl3aa3KguBCRV5CQzELEaPXGiTxAGjknbONsJlHbvmwgYi6FhL6DUmbGY/RxDxaww2cP1kgKZh
	mLgaV3+S0dWj+nkFG5WA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2KS-00078Z-51; Wed, 13 Feb 2019 21:44:28 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2KO-00077X-K4
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:44:25 +0000
Received: by mail-ot1-f66.google.com with SMTP id k98so7011776otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qgeq9ef3JVUvr1rCSWxPRE1noszY4CjdYdlwSxQIIwI=;
 b=jYeTngUAWi9kBzVPMM1rIWn5KDayoaSN/1jPwAvQO6b21F+Dc2W++oYvf1fR48A5jq
 O9WhIMU6NbxqnU8nytWVy1A2E7TwHbkUrp2kyNh++hf5lnAHLBJ9VXkZaabjBN3hsOAk
 2XZetsNWZpN2ZxS2aAvvabeRNpfi1Httu6AI5KLzDZTUFg3FH41Oh9VfQeUt5aJCdAYv
 l6Ff9Dytr+zxVH63PZ3v8xJUec+/aDRp9n5Cs5sP5KwZdHIycSqFx5erg9scBmnP0l5Q
 UD4h12Yakc9clLThb82mGzj2639lWJgltBUvv6AXbJSByxDqOiow3Mk9JfLDYw87sXfH
 Y3Zg==
X-Gm-Message-State: AHQUAublWpJC7Aj6jssC5DeNDQ8vxDUtGKRB9UH7Zy/oDEdfX7loP7Ki
 igMnIuIRtjmgdDJ76H5eCw==
X-Google-Smtp-Source: AHgI3IZmuRVPl+drsV7gNz5BYUQ7QVgWNd4MtmZC5VuyWFmxr5vDhxxbwGjJSwma71fdeUyNA9aiSQ==
X-Received: by 2002:aca:f389:: with SMTP id r131mr222752oih.58.1550094263652; 
 Wed, 13 Feb 2019 13:44:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 11sm535442oth.35.2019.02.13.13.44.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 13:44:22 -0800 (PST)
Date: Wed, 13 Feb 2019 15:44:22 -0600
From: Rob Herring <robh@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: connector: Add vbus-supply property
Message-ID: <20190213214422.GA31951@bogus>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-3-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207111734.24171-3-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_134424_657921_C8FA0BE7 
X-CRM114-Status: GOOD (  11.72  )
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
Cc: mark.rutland@arm.com, robh@kernel.org, jackp@codeaurora.org,
 shawn.guo@linaro.org, kishon@ti.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, khasim.mohammed@linaro.org,
 linux-kernel@vger.kernel.org, swboyd@chromium.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
 jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu,  7 Feb 2019 12:17:32 +0100, Jorge Ramirez-Ortiz wrote:
> Some phys might need to control their VBUS regulators while not being
> supplied by them. If such support is required, use the vbus-supply
> property in the connector to retrieve the regulator.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
