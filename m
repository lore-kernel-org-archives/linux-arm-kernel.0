Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA45C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:58:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0976620989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mhx/X1xL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0976620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3DWQY0jJUg0laH/t908+mlKRCOJYpicedyHI71G6qko=; b=mhx/X1xLuvZ3fU
	nUrz4b++AjkpN0XB8qZ3f01ZsQxSkzeJPDxf1nrWCcsBANJbk3B0QCK2OA3lhaR3UTKtZX28fckKq
	1AiFj7QUw1VkvFUcf4FOeCI3v89pG6LTzQyagg508+02pgTbMcILpYhVvAslxpKGFk71a7f9zsQGJ
	PAJGZc6FUtzkwHDG+8tJ58BdTCZG7/IVmdp4LYrSRkGc+Q65KSDFV8dhpaSmjzqEBrabcbU2/01OU
	Mm2C1RHhuZDk/3aC20g4wZxijah6nNqX1vHQI2sCnNQE74U1AKcUMgCHS0crC47zzrVdiEDo7ahYC
	gyH9Ftk2/lILmxRcmOew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govzv-0001BJ-5O; Wed, 30 Jan 2019 19:58:11 +0000
Received: from mail-oi1-f176.google.com ([209.85.167.176])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govzr-0001Ab-Ni
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:58:09 +0000
Received: by mail-oi1-f176.google.com with SMTP id y23so719550oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2ZcYzu0XjnK7ywS/pcBhJtKfTj5X5hJvMdL0Iq5P8/Y=;
 b=MkDGuLoGaDlB5rH6Tyo+V/vF7WT/Cd2UyTM/Xt5b7zCshgM55jk6P9QcDKPC3VY9F7
 1cOttJA88ssPzbFf+grq8Ltz2ot9wimSa+noXgdqmKW/oefIoj61ov6YnMLQ7tC4J089
 rQ4KRcpBSc2il+DojxmFUzygEtjKElKCuS1W6sDKzg7GXO8NHxO5C7WIZ7ohET7MpPYH
 LtrobXLOOnB/2qLnmYrwmKwHOtw7jUtpDUfGFQ5hmWUFo0yCUm+lwPnH5+gWsSDoaCnS
 VcWh2qLB3B0V9IjCq6uVTJdOhUEZ57a3QfxK0ywCf4KdmEmb8HzC/GoIcBK1Ao5pmxbg
 ngpw==
X-Gm-Message-State: AJcUukdt/Qqw9o2CerRGuEGbvnbAzlsHHY6ocyteb/j97k5gKX94KSZP
 QDSIU1B3ZBIR6UvbPKeg7w==
X-Google-Smtp-Source: ALg8bN6hYc4WHO50wzh4bDO+i49t3fFwjsPXLqrIpVkGXV4X4Ic1T0rL0FTHyckX5dygEsZAoOTTAA==
X-Received: by 2002:aca:1702:: with SMTP id j2mr13514559oii.267.1548878285580; 
 Wed, 30 Jan 2019 11:58:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id c9sm945599otb.38.2019.01.30.11.58.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 11:58:04 -0800 (PST)
Date: Wed, 30 Jan 2019 13:58:04 -0600
From: Rob Herring <robh@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v2 0/2] USB SS PHY for Qualcomm's QCS404
Message-ID: <20190130195804.GA5908@bogus>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_115807_786077_B62D9537 
X-CRM114-Status: GOOD (  13.99  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jackp@codeaurora.org,
 shawn.guo@linaro.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, swboyd@chromium.org,
 vkoul@kernel.org, bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
 andy.gross@linaro.org, kishon@ti.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 12:35:13PM +0100, Jorge Ramirez-Ortiz wrote:
> This set adds USB SS PHY support to Qualcomm's QCS404 SoC
> The PHY is implemented using Synopsys SS PHY 1.0.0 IP
> 
> The code is losely based on Sriharsha Allenki's
> <sallenki@codeaurora.org> original implementation.
> 
> v2:
>   enable OTG mode detection
>   move vdd voltage levels to driver
>   use bulk_ control interfaces
>   ss-phy-bindings [1]
> 
> [1] ss-phy-binding discussion:
>  - qcom,dwc3-ss-usb-phy exist for a generic usb2/usb3 phy driver that
>  was never merged. Rather than trying to re-use these bindings (or
>  delete them) I  propose that we go ahead with the new separate
>  bindings for HS and SS: if  not now - investigation  in progress- in
>  the  future  it might be  possible to have again a common phy driver
>  for  which these old  bindings would be the binding agreement. 

Either use/extend the old binding or remove it if it is not being used.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
