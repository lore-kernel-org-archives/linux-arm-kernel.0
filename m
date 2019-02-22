Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E4AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:07:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EC62070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JWyc5zeP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZTSI7Li+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EC62070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y1Biq+J0UOFiCMCeZ080vgBoQH4xjVu9TOkSN0zdRD0=; b=JWyc5zeP5dp8XR
	lPlyvMkmzpP+R7IoEJZBswiVpuuDa4myEJooqMPr6c9o5NiHe5INffZKHgq0dlFoVxPHVgXAhiYBE
	zsx1qsbJiaBuQ13Gl78A0QvgGO5Y90ocKSWWy+AMgwLNBUU9uGjko+s5YjT/1ZJusQnPesnIfI38w
	U/jVaIuRy6FvHHWc2hiJqZM6XbHZVbUd+diPPsiqdIBPj9HZczTW2Vb5jPqnTVy0U2/lflz4dHSL1
	p3yxSHLwDd3pUB76xD9OKJ0jrjclPtHfYwCoTyZUJ82OZAL6ajePohxc+uOzVFVJGhh69VRoxLce1
	Z4ypal5DStU3gBKn/aIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFE9-00023L-6c; Fri, 22 Feb 2019 18:07:13 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFCl-0000jq-M3
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:05:57 +0000
Received: by mail-pf1-x441.google.com with SMTP id a3so1434741pff.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KubzSsGIl0mpzxhYHGlSJ+rcugeREyH930Tvr54KTUk=;
 b=ZTSI7Li+97fF6ojDRVb9B/lg0Qqr+c71bQNlQweT83JeDv7/VjHdSuTXFTmV/d4zaB
 j0DKp8/TBUG1amAfiE28634QqwogOleCrfRtvSTksqoeofxc31DxIREWk3ZyD7SPV/tN
 o7C98Cj/dUfxZQnRutIYg7LAANIpIrpN0bJKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KubzSsGIl0mpzxhYHGlSJ+rcugeREyH930Tvr54KTUk=;
 b=cO6kCYMYb26Z8oymQmR1qXklrcUDzZxpDQRIU08/KyDB6PIEPKK6nk8ZvgOwvR8jMI
 PUogFiYugK8BB2fYM8Y39W+FyfmI0lRtV07QMuWydSAkqGIxdWa+EoqqjWu/Q7+GW7X7
 BgLtalrvtA1IoxIg34pl92lb07mVfH0Y4A6q7gyPN1rGzEqcBqCZCno1wfHjll28h17c
 hXABoaf5c/YQAZrvlGJjLm8oVN2z0ERCj+ZlkcDoMrqk5r93d1mzNT4pkZ5vVoER9fdb
 7/VPQQ8fiJRoba1H0k1KAZ4aAdM0WpSxQQHK/oyuDLoHcsCpZwfQ6XvwsMhiNCO1C74M
 vfqw==
X-Gm-Message-State: AHQUAuYAv/uqm0q0f7FBXEH40AEY/T5bRGAEKknrrEI5aMiXi+PBlrIX
 VhYMQDxV32TjUQR38IQMPHV7/A==
X-Google-Smtp-Source: AHgI3IavGDOBO0lLpGTAhsMakepsHGlvesjtlBjhOwE6wUKvv96jHsyNE7tCT7EfBYyQ9bu2xqrjBg==
X-Received: by 2002:a65:6091:: with SMTP id t17mr5213979pgu.416.1550858747224; 
 Fri, 22 Feb 2019 10:05:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id s1sm2706322pgv.30.2019.02.22.10.05.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 10:05:46 -0800 (PST)
Date: Fri, 22 Feb 2019 10:05:46 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
Message-ID: <20190222180546.GB223791@google.com>
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222003403.128243-2-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100548_186276_5940EBED 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, linux-arm-kernel@lists.infradead.org,
 Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 04:34:02PM -0800, Brian Norris wrote:
> There are two USB PID/VID variations I've seen for this chip, and I want
> to utilize the 'interrupts' property defined here already.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  Documentation/devicetree/bindings/net/btusb.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
> index 37d67926dd6d..43c96c3380a6 100644
> --- a/Documentation/devicetree/bindings/net/btusb.txt
> +++ b/Documentation/devicetree/bindings/net/btusb.txt
> @@ -9,6 +9,9 @@ Required properties:
>  		 (more may be added later) are:
>  
>  		  "usb1286,204e" (Marvell 8997)
> +		  "usb0cf3,e300" (Qualcomm QCA6174A)
> +		  "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))
> +
>  
>  Also, vendors that use btusb may have device additional properties, e.g:
>  Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
