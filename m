Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0771CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:51:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C709121473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kX3Bn4v0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C709121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YCrJdh88vo8RQybKpEmwlMagzZxn+UUbkcFkA3UPIIU=; b=kX3Bn4v0toHxAs
	SJPbdPkX3ExFcy2Px+x3Xk8KLOEd6kDKxaaqI3g3h3SnGG0z40t9P9yO3tnHpxMp2lS2MmfouSUHJ
	OO3QlHrKd/M2D3P9KTsmvHDEXuxQ7OsNLsBhT71VT4ajoK9Ebx8LF2EcdBpg4+BRgGskc882aJ9q6
	zBMm2/2xieSKGi4fuCkyLDh3RVQC0aW4IQxfwtHalAqR9/5r791N3pvhqUGPZtwKtVAtw9dHUmXGJ
	cLf+7HuJYPf1mqSDngst0HXcPeay1DMHSbY/RO6EyEhGEts05NdBXc8LQkXT0zLraHjT3uyEDHENg
	Qwe5nr62Wegnq98DwzHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gos99-0006Ym-5p; Wed, 30 Jan 2019 15:51:27 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gos8g-0006AI-Ib
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 15:51:00 +0000
Received: by mail-oi1-f195.google.com with SMTP id y1so19534435oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 07:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=05UvbpA+SO3/QdrZgEcALrEGdL+Mq+yrGswYqrrf44U=;
 b=XfO786pfOk3ZnXmPgj7DxThkySOpXKJG5mEq1PAp66Lk97xiocDFPdVf+Ms8oC/ELO
 yVh/SjJ2JwNSlVyhV7PVBFjPtPM7yp3cErHAdRmbRQ51Ic8HhFbVlfu6k2VjTUNGmj+h
 PEfPe8+aeB1K4hOOxl9+84mMB/oms0JuA0yQrNm33tZFs+dUMh9h10gxiWjaOl/q0wht
 YkUMh2WIhLJvoNcInsQ8nylcH6LvxeziUt2ZwM1hzcDkyEvX8Pzhz4yR4BjGUfMnPLKp
 /DcEuNUFfYJIuBnHe65Fye9QGORYhpbkg1f84Q6HoICEr29DWQAD04L7LTQ42ZjK9uwX
 Dn/Q==
X-Gm-Message-State: AHQUAubZfmnzT3/flSn84EUGZ1ZfTDEXLGDyhwM05vY9UdpDztGLL8+P
 P1J2ugpcQf8Nc5FHhWCETA==
X-Google-Smtp-Source: ALg8bN72Ne5t03XE4AobX6pT4fLRbfP+oNoK62UjK5QXWyHpowmhKmB1v68TCkX7r+z8W3d9i/tcKw==
X-Received: by 2002:aca:b58b:: with SMTP id e133mr12934157oif.25.1548863457510; 
 Wed, 30 Jan 2019 07:50:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id k16sm646894otl.58.2019.01.30.07.50.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 07:50:56 -0800 (PST)
Date: Wed, 30 Jan 2019 09:50:56 -0600
From: Rob Herring <robh@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v2 04/14] dt-bindings: mailbox: qcom: Add clock-name
 optional property
Message-ID: <20190130155056.GA28494@bogus>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548700381-22376-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_075058_789206_62D66FF1 
X-CRM114-Status: GOOD (  13.72  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, bjorn.andersson@linaro.org, david.brown@linaro.org,
 linux-clk@vger.kernel.org, jassisinghbrar@gmail.com, sibis@codeaurora.org,
 andy.gross@linaro.org, jagan@amarulasolutions.com, devicetree@vger.kernel.org,
 niklas.cassel@linaro.org, arnd@arndb.de, linux-arm-msm@vger.kernel.org,
 olof@lixom.net, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 khasim.mohammed@linaro.org, enric.balletbo@collabora.com,
 jorge.ramirez-ortiz@linaro.org, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 19:32:51 +0100, Jorge Ramirez-Ortiz wrote:
> When the APCS clock is registered (platform dependent), it retrieves
> its parent names from hardcoded values in the driver.
> 
> The following commit allows the DT node to provide such clock names to
> the platform data based clock driver therefore avoiding having to
> explicitly embed those names in the clock driver source code.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/mailbox/qcom,apcs-kpss-global.txt     | 24 +++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
