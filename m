Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE02DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:20:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900B22075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ud7I9r69";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TqoR1UOh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2/TVk4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900B22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+QPZiLPrABQkTKzyODsqjdMvzBVPLOhBX+w9J+MHkvw=; b=ud7I9r69BPhXkz
	CvfgQ/tJZMVaa1deRQfVKAl5djQVHV3V+fS6uz+7fJY4Hslif0z5pmewRVVM3qjrtH53T3VsTtBon
	QHUQ7Eaf9SCB5cW5OpVBwnMfhZUbMIv8e1GtFoNsxBDTn7zdQkVkj8L/RSIXjZT8ug17dro4buoED
	6aNHElbghYOBfcBhPvadINob50MJNAPWSn0/CF+q4k3Hz9OHnpzV+E4K9XhOt/5nwacpRt+qAmnip
	rjm1J7Y6baG82wzT1kRenHslbLtHH+ga8hb+ut+995m66Jtz/DKonVHbhU69dpvOwBxbunr0RqL6h
	vArfitqOeOFF9f8NSy6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFR3-0007ub-9q; Fri, 22 Feb 2019 18:20:33 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFR1-0007oj-8D
 for linux-arm-kernel@bombadil.infradead.org; Fri, 22 Feb 2019 18:20:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Date:Cc:To:In-Reply-To:From:References:
 Message-ID:Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HDQIAG1kif7slV37LL0UhZcwKgc6WEavtUhc3s3O4hU=; b=TqoR1UOheFqaAhTNq0cHdKdmVY
 cn83DgRbdzlVhEpdNSnMwoAoSWDETMYjFq2DxnVnM6kAeQDz/L0i7+x3YB9HPLkyR/rAjPpTJ3Dwi
 C0fuyzfubg0A2B7ty7RAlEvrrslkrmJWKgg18084UURuoGNIuKIYOEtNiiH9THUKtxPa3q0941xCU
 CXXIoOYPn9MncC1qmKjNr+YGRwKefrgwiGLiIjEkCZ4cSZ16n14TjzrkKsDDFTI4PTe6YcrJOvnGz
 lbgUbMB8KkEvNNEWwSPQKPn7vSjfMIX6VxHRYFMKLw06OQ5muAP2jIBu/6Dz8geF5e/tLp1CXl/WS
 DGk21rJQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFDK-0003KG-RO
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:06:24 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DE5562070D;
 Fri, 22 Feb 2019 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550858780;
 bh=HDQIAG1kif7slV37LL0UhZcwKgc6WEavtUhc3s3O4hU=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=D2/TVk4c1tUtyJI3ZqBBGpKETWUL6tWKBniQfFEZwU6VN6R2niCqK/Mj/Cj3viLfj
 U2GYHG3fkt1efCumgJOQzL9j/Yft+ICzwk32mVkrFhk0Qw+JeyeP8jCZ2Pha1w0TXz
 HedanfiHSyj5sO3PJW3Zumtc/HsgD31+/7p4B6i8=
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/14] clk: qcom: hfpll: register as clock provider
Message-ID: <155085877912.77512.282683582779131155@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-8-git-send-email-jorge.ramirez-ortiz@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-8-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org,
 david.brown@linaro.org, enric.balletbo@collabora.com, heiko@sntech.de,
 horms+renesas@verge.net.au, jagan@amarulasolutions.com,
 jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com,
 mturquette@baylibre.com, olof@lixom.net, robh+dt@kernel.org,
 sibis@codeaurora.org, will.deacon@arm.com
Date: Fri, 22 Feb 2019 10:06:19 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_180623_074196_35FF343F 
X-CRM114-Status: UNSURE (   7.18  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:54)
> Make the output of the high frequency pll a clock provider.
> On the QCS404 this PLL controls cpu frequency scaling.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
