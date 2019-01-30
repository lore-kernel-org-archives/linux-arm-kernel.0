Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A9BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:34:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25992087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MQmltIhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25992087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dPTJzOD1YI0J3Wb0gxqD3vkkAxrCF4p1OmYkXqdQeMg=; b=MQmltIhN5KT+gu
	i9RBP8k+SCpIy7Nt6tP5bbBWXYSMux5R0DHFBzEk9SDZfSwlklPtYHzhhpu7F8rWASw+5xhCVjKZD
	6GU0hSaeEVaw/AWcuMXWN1Qn5v2PaqkTgcsvi8+YxuDT7o2UY6cw2pKIyTkzFE+nwRsqb8RcrYfjB
	nsC8ya9vN17ri5wYfuOeirI7JNvHdbGmntz9YqrmOMvkirvoeOYHwaTYrLT6mWUN6JL04phogT66s
	0lUt5EemmgZ5AVY0bSwltqlg6xIc2Pc7YqlUcvbL2igKfmZw9WsvklInj/lTZNbwPwPonEbzvSMMW
	k07NpV6Lk3fS/eF6ySoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosoc-0001tr-Mq; Wed, 30 Jan 2019 16:34:18 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosoZ-0001tW-JZ
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:34:16 +0000
Received: by mail-qt1-f193.google.com with SMTP id e5so107443qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=euuV6RNzmdpfE6XW8Kl8bVDvDGr6dCVxskMSvSuszAo=;
 b=Skm17mPfGBSNxS9avKFG7fWoV7UeuMT2zuH1hj9+OULJ0KKBE4J09+UId/r4nPJtme
 INAyZsUAWR2WMvsZNpPMPt2Ktt9t+w4zcUW1SctJrnmCwYKKqN6AraekIflkHaCFBF0X
 rmBuPeZqlrtXsVJULS4vUE+dXcaGuL6mJBPLMExXPNQfl53gHtDcvGovoLK3dUNpzR8O
 /L9TXKBu99eV8H1+SsbKpM3m1D2tuCtHfQzq0kxY0ls8OZyfDbIAyEbshFq2tl6PzeF7
 NTtDZuDuO+i00ToE79R+Dvqg+482atrtMDiPcOHP5gPAqki3r2hYfOX9kkoWjgErrgIq
 uAvQ==
X-Gm-Message-State: AJcUukd0kjGjjDGKV+vt9yyFRq0u60t1EMrg44+lZNES9TJFpHMz9dZZ
 BBoBdNwRIrBetfJO7UjSnljtcWKYJI6a9JCNl/0=
X-Google-Smtp-Source: AHgI3IYQuoq+cjxzwUiUrZQHM71psYfzLKuW+YSxHM4NOpLDw9WRFnyLQ+jJUX2YZGMbOzO4P/+tcXyxnmJkAhM3BhA=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr19213617qtl.343.1548866054768; 
 Wed, 30 Jan 2019 08:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20190114174533.6134-1-robh@kernel.org>
In-Reply-To: <20190114174533.6134-1-robh@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:33:57 +0100
Message-ID: <CAK8P3a28_=urR1h95GN_wvYxJSOTUr_gL-cOzk9Pt1CZFGnJCA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: Remove inconsistent use of 'arm,armv8'
 compatible string
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_083415_692682_BCC099D3 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
 Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Wei Xu <xuwei5@hisilicon.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm-soc <arm@kernel.org>, Thierry Reding <treding@nvidia.com>,
 DTML <devicetree@vger.kernel.org>, Scott Branden <scott.branden@broadcom.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, Will Deacon <will.deacon@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Chanho Min <chanho.min@lge.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 6:45 PM Rob Herring <robh@kernel.org> wrote:
>
> The 'arm,armv8' compatible string is only for software models. It adds
> little value otherwise and is inconsistently used as a fallback on some
> platforms. Remove it from those platforms.

Applied on arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
