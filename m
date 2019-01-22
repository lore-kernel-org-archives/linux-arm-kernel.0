Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE7EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:59:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654BD21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WpnozPs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654BD21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7CweIerT9g+nPZFRwO/eq6SnxBvdxGJ66XxCB+85IIk=; b=WpnozPs4K8CywZ
	P/oxVeRFZprcswILkJlYFwzr+8+CY8LDwLHMFIMlrdbKAJJligdW6EQKTQBTDNRLEMg13mJp139mP
	kbxxZlp0agDcZNbLqDii2AGXgDCjiwDbCuINnhrwpn51svpCipBvhXv/wJXhkyNkT8bjZX96+3FRm
	2kbPXM/6ZQ08dzFj8ElVhVOoAA3WZLRJLOivCGM9/MD+6sxiOHG7apGt8OR9gFzdkTwSR9FGnkxrj
	YGQbzRce3JdfSESD13NVSvWDip9LBdi7VYRPOkzI2PwH235W+izOKz3nJHE1TMtswuuZBJk1s0qau
	drsIg2LctiSVqnV/Lzaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm51G-0008AL-Bh; Tue, 22 Jan 2019 22:59:46 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm51D-00089r-48
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 22:59:44 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 084B280F6;
 Tue, 22 Jan 2019 22:59:48 +0000 (UTC)
Date: Tue, 22 Jan 2019 14:59:38 -0800
From: Tony Lindgren <tony@atomide.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v1 2/2] ARM: dts: am335x-shc.dts: fix wrong cd pin level
Message-ID: <20190122225938.GB5720@atomide.com>
References: <20190122052623.1779840-1-hs@denx.de>
 <20190122052623.1779840-3-hs@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190122052623.1779840-3-hs@denx.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_145943_198829_C2D52499 
X-CRM114-Status: UNSURE (   5.60  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Heiko Schocher <hs@denx.de> [190121 21:27]:
> cd pin on mmc1 is GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH

Thanks applying into omap-for-v5.0/fixes.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
