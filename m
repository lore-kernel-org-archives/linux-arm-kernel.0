Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD1AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:41:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113F421855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IngkH9D4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WeRt6eDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113F421855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qAqh+rH9KL+RVAw95L8jauaChSlQ6bPd+a4TJtB28uA=; b=IngkH9D4+h/UYR
	7UP4J5NXTKWKnCclSZOQfJh58i+nxpt9OEsTe38MwRksxy+bc7fOqNBGo8Q3MewsM8SCMEdxzvat8
	Y4xs1Hs137vy1vKy74t5smckfZlTcsuqIyJKalc4BkOkTs6WdAFPRTlR4zRT5AoV+paesVhjTuSdG
	4/5EWS5CNbkzj0M3UaCQ1b+r2DNfwqPcNtNDWBmdm4Fc5J38awJdj2NSRMz/AYw3kApgewUP2gZmm
	EI3Vlh7bxImuXTmclJDtxyDWyHSpeAljQWFfpW+hrXmztLunNjEqpZzZydYSkuApL4ZQG+OQHcamO
	CxUG864IbEcfO1UYtiPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmeJx-0006wm-GT; Thu, 24 Jan 2019 12:41:25 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmeJt-0006vF-Du
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 12:41:22 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0OCfCLe073092;
 Thu, 24 Jan 2019 06:41:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1548333672;
 bh=wTVy7VEM2fhvlZdcq7ItJxQnWRTQjdNEquXUhwSs6mU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WeRt6eDolHQjzENEgzzwK+VUyFs4lJCDeOw7sXYSsEmH54BiQmhPcOYTBqeBATyBe
 GaPh/lJ5JxZ34WP3FjB9IkLXYQo4Y91x5ZXS/qPRCnA4jLn03NlcxbRYqgSxSgWB9x
 M6P+dP+yueHHRdQAioTqs7eT0JInrPbLhU1ZCvP0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0OCfC6Z024914
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Jan 2019 06:41:12 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 06:41:12 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 06:41:12 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0OCfCtc031163;
 Thu, 24 Jan 2019 06:41:12 -0600
Date: Thu, 24 Jan 2019 06:40:32 -0600
From: Nishanth Menon <nm@ti.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3 0/2] Support for eMMC in AM65x-evm
Message-ID: <20190124124032.aqp4ctqkpozbttwl@kahuna>
References: <20190117094424.7683-1-faiz_abbas@ti.com>
 <d75a123b-9e97-a3d1-1e3c-41ef6942dffb@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d75a123b-9e97-a3d1-1e3c-41ef6942dffb@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_044121_505340_DE1A0064 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13:43-20190124, Faiz Abbas wrote:
> Hi,
> 
> On 17/01/19 3:14 PM, Faiz Abbas wrote:
> > The following patches add eMMC support on TI's AM65x-evm.
> > 
> > v3:
> >  1. Fixed patch titles to only include eMMC
> >  2. Added dma-coherent to the sdhci0 node.
> > 
> > v2:
> >  1. The SD card node is under debug for some usecases.
> >     Only upstreaming eMMC support for now.
> >  2. Rebased to latest mainline.
> >  3. Removed status = "disabled" from dtsi patch
> >  4. Fixed node name to not include '_'s
> > 
> > Faiz Abbas (2):
> >   arm64: dts: ti: k3-am654: Add Support for eMMC host controller
> >   arm64: dts: ti: k3-am654-base-board: Add eMMC Support
> > 
> >  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 14 +++++++++++
> >  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> > 
> 
> Gentle ping.


OK With me. Tero: are you publishing a next branch? could you
pick this up please?

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
