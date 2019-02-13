Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D0CC0044B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:17:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84D3218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eJo73FtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84D3218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KSQmQVw8FyfYHIsN+nJuDjSxVyvvxgHW9Jgto7mgNeI=; b=eJo73FtRxTNh9k
	3f9YzNMhcJBDlHXeDt5qTd4218zjvVeFuSuCgHJhUtC1+OO39u5ThhWli2YYIZIbIn4BGZg48KDnT
	OuMscGnSUcf9VLXSUgbByk36YZ2Y5C8W++R+2HdMGOq/553QwB7wkhdk2q4w7JEyAhfbFLO9EwlTC
	xz994033gxrSf1rOZl/CvnMozvbpmT8EkO9Wb8xd4PcwiR7r+tdGqsoBSoQxekzWwmUPp7wuprZrM
	lNwKsIRPdAWIMkju+Ey8uC8bBf/XB5AAWBdrES85SEm51b4W3vSnCpWXj2ZmJmwePefOxtxNbXp+F
	2G3wkYPIasA8jFJnpmiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu1tp-0003Rr-GY; Wed, 13 Feb 2019 21:16:57 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu1tl-0003RK-TX
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:16:55 +0000
Received: by mail-ot1-f66.google.com with SMTP id b3so6853821otp.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2DZkzOaCdmECHd9/Tro5kM6BhxtTzXxaZeY3lv9NQYs=;
 b=YbuPSbefWxkadlETyIyadxqWPJYuGMhVB1QsJp7aRwq3Jr4sR5g6GqSqs/dnzKVaFr
 va8A7HqOBRkHg2QzAKwTf9qjIRaGcGz0nyLmHwNbRZtah97CD19T5aEMA9Sxx2cL9V4b
 qxOAjqCRMQiXvUy0DjWQntyhabm1/ysIRXu+wQBbvRfrcWq1wLwoDOLnOuMd4ofLNPFo
 hjEGNCtEKvoAQw2EehSpDvqFDKhq9//0Ju8oDtB355HwCFJ6TZWfu7DIswl8+WqXzHmU
 MoOTijRts72cfPpCGVKitdCpSFp6/fbUMqWx86zNBuAtsu7PFrH/2FM+ph1bK/3ZNQUg
 Hd6g==
X-Gm-Message-State: AHQUAuYWLoAuQGc4VJbV5RAUbJzL3ARGd3MZRh5hb6+u7K9lmGrxV5Mp
 R/vphFcG1LeKni4+4NrGlQge8Fs=
X-Google-Smtp-Source: AHgI3IagL6J8fXhfkzCCUwWODGWh3Kadto7gY+Q0Rc41xW5RbbKrex+ntI2EloJyTTEA+VHNFbNNRA==
X-Received: by 2002:a9d:6205:: with SMTP id g5mr105690otj.277.1550092613121;
 Wed, 13 Feb 2019 13:16:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id v3sm190172oib.57.2019.02.13.13.16.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 13:16:52 -0800 (PST)
Date: Wed, 13 Feb 2019 15:16:52 -0600
From: Rob Herring <robh@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
Message-ID: <20190213211651.GA10705@bogus>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-4-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204231554.87666-4-ray.jui@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_131653_953638_A3BA15DC 
X-CRM114-Status: GOOD (  17.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
> In prep for the introduction of polling mode into the driver, update the
> binding document to make the 'interrupts' property optional
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> index 81f982ccca31..d3a3620b1f06 100644
> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> @@ -9,9 +9,6 @@ Required properties:
>      Define the base and range of the I/O address space that contain the iProc
>      I2C controller registers
>  
> -- interrupts:
> -    Should contain the I2C interrupt
> -
>  - clock-frequency:
>      This is the I2C bus clock. Need to be either 100000 or 400000
>  
> @@ -21,6 +18,13 @@ Required properties:
>  - #size-cells:
>      Always 0
>  
> +Optional properties:
> +
> +- interrupts:
> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
> +    polling mode

What determines when you want to use polling mode? I'm not sure DT 
is the best way to control this unless it's really a property of 
the h/w. Driver behavior is really outside the scope of the DT. u-boot 
would use polling even if an interrupt is specified, for example.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
