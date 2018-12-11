Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0824BC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:39:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AE820879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L/EwiotR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AE820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5DValdEIXcAjy8nfBHB5zfQ8DuMOo8gBL0v9GF9dhWw=; b=L/EwiotRGMnDm3
	H8fHeliJr0Og7jdFCWzzzhzMSfRbOS0KYQB/QNS+8FbVecXmL1Jlar6PQKl2Li5u+T1FUrKFMWp60
	9itV7ad/UHYcvZhzsjlZRcNtXrTKqUEWw3UudneAcQYIdHcykPz0S2uhtCDEAYXsixgjP7z3PUR2h
	8nTd/vUqQBS72j2kECLQxlBl8pG9yoYtwrtSV2nRVC092GZ+q4qjhhQ1qyfKSejxThFzPcq3IjfkL
	M8M6GjNJnAQFzyS+3PA3tYvLwE83NHfpb04ynIA9t6F4wBjasU64ncJE4jyQLp5UXmNboLQC6eoE3
	dw0PW07Q8ncb2tnyBzRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnsU-0004Zv-28; Tue, 11 Dec 2018 19:39:34 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnsR-0004NN-Bn; Tue, 11 Dec 2018 19:39:32 +0000
Received: from p5b127a5a.dip0.t-ipconnect.de ([91.18.122.90]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gWnsF-00086u-4H; Tue, 11 Dec 2018 20:39:19 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH v2 4/4] ARM: dts: rockchip: Add internal timer support for
 rv1108
Date: Tue, 11 Dec 2018 20:39:18 +0100
Message-ID: <5328135.xSjgCaBnB4@phil>
In-Reply-To: <20181126173506.24068-4-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
 <20181126173506.24068-4-otavio@ossystems.com.br>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_113931_607463_759D679C 
X-CRM114-Status: GOOD (  10.32  )
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
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Montag, 26. November 2018, 18:35:06 CET schrieb Otavio Salvador:
> Add support for the internal timer peripheral on RV1108.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied for 4.21

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
