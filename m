Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01182C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66C92070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cj+LqcG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66C92070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lf+7Eer2pgtvjWfqrElV13vzfjLnw4o7jKvLAqIUrlk=; b=cj+LqcG6X9ZB0C
	gvPAj7Kd2RJJJY7bssWY8/LapapMy50Dg5irCGfD5hRZGQWyS3arTzTiRjB8A0oeebh5iF3niTrr5
	XjDSHjdK4CowLtNPluRw3NNqPAC2QG+jNkE8XbxBRz8RDLjYuIYep6JwwdzMRCLLhps2/Bbl6Bb4c
	UitFW4X/rjjNKRH4d/jeEVvL5ztEbzfpJMxZ5SmQqDJO/14e01hDLc9rh0WCpe9JNTCLQKyoVkI3l
	bbGuYR8mr6beLL6fMlX/jB4cdVGtt0LVnmq2hUJRN/WwmggrpwhiFtefCwFj5ii4DBb97DB5tltcx
	MbW03WLWfJ7kz+fjuUpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvk9t-0002Zg-Cg; Mon, 18 Feb 2019 14:44:37 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvk9q-0002Z2-KM
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:44:36 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id C6EB880E4;
 Mon, 18 Feb 2019 14:44:43 +0000 (UTC)
Date: Mon, 18 Feb 2019 06:44:30 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
Message-ID: <20190218144430.GE15711@atomide.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218143629.28392-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_064434_704889_F3A92851 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com,
 marc.w.gonzalez@free.fr, netdev@vger.kernel.org, nsekhar@ti.com,
 vkoul@kernel.org, f.fainelli@gmail.com, bcousson@baylibre.com,
 niklas.cassel@linaro.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [190218 14:36]:
> Hi,
> 
> cd28d1d6e52e: ("net: phy: at803x: Disable phy delay for RGMII mode") broke the
> ethernet networking on evmsk (and most likely on the evm as well):
> https://patchwork.ozlabs.org/patch/1028527/
> 
> v1 patch to fix the situation:
> https://patchwork.ozlabs.org/patch/1040617/
> 
> It turned out that the at803x driver is actually broken and need to be fixed
> along with the DT data.
> 
> The following series is proposed to fix the driver:
> https://patchwork.ozlabs.org/project/netdev/list/?series=92611
> 
> but the PHT mode needs to be switched to rgmii-id from rgmii-txid:
> The rx delay is enabled by default and the driver never disabled it so when
> asking rgmii-txid it actually got rgmii-id.
> 
> The patch can be backported to stable, I have tested that it is not causing
> regression with the old, broken driver.

Can the dts changes be merged before the driver changes or
does it cause the phy to stop working?

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
