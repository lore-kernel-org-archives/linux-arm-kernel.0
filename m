Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3121C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:15:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A982F21925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WsNRWlKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A982F21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HceeQ6PVXOtdAzUW0as5gVdIuwQr+Gg5GhAYVS1vu5o=; b=WsNRWlKHQaaiFG
	mKS7BsqNlp2LoSNmOFavgmWNEnBpkd08d10x4iCwjmgqSbuZxoKxZ5ph/1Z49RnEngfQkG3MZHqDM
	RRUS/UljFz19Z+eLvEYqu0aXJkfm5eq9P65oizwWqWe6jWOSX6twT+So+p78p4p7R2N3uajTLgnDJ
	A/H0Shv2ro9X4yTXExFaG0LxCozi6nIFPpsseakDvfzKOWvt2khEwzOj303pvxop7WUXYlicUGscf
	TIjJ5GOP2x7yhw2OPRZ8S+wC7DC04U7Gof7aBKWd6+u2NGCS0KbtICuxYns3sAaHQRlYdz42CbHxf
	cdaVRldx1q/pPV6c/I+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZZx-0007o5-VD; Fri, 15 Feb 2019 09:14:41 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZZu-0007nd-Mf; Fri, 15 Feb 2019 09:14:40 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1guZZb-0000Ao-Mk; Fri, 15 Feb 2019 10:14:19 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Akash Gajjar <Akash_Gajjar@mentor.com>
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: rockpro64 dts make regulator
 more readable
Date: Fri, 15 Feb 2019 10:14:19 +0100
Message-ID: <3848940.W0AIcLlWW9@diego>
In-Reply-To: <20190213170651.3210-2-Akash_Gajjar@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
 <20190213170651.3210-2-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_011438_884527_17145BC5 
X-CRM114-Status: UNSURE (   8.77  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shohei Maruyama <cheat.sc.linux@outlook.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 Levin Du <djw@t-chip.com.cn>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 13. Februar 2019, 18:06:37 CET schrieb Akash Gajjar:
> rename dc12, vcc_sys, vcc1v8_pmu regulators and make it more redable as per
> the schematic of rk3399-rockpro64.
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

applied for (hopefully) 5.1

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
