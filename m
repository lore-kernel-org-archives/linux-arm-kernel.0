Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC76C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:33:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D87A20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nlsltuJX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vn06AA/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=epGDdcqaaiovsoF7u4GDaOqjIoyoKhEqPLQr5krQV+s=; b=nlsltuJXvsAK8i
	R8jHhLYsXVLpdZX2qgTsAf5vFg0ce423n/RC0RQprykmuLqGf03O//vaiHgDnn3a/OWZl4TIl/rPk
	EquLPSgAT44iUNbWApBfvHCjBuXXIh8A6rCKVJxrO/6Wn+ifGerdigEho96lkCNlPSMDX6eTcTUc7
	Zny2WXSE7btPM+C57BrSQn3FvGlozR2joKp5PbBWtt8m2CagHkBb7QMlvhtF2aFaISTV5boXWkr1g
	XokS1zk/Lq5FYbM7NGTSSS5K6A7RuLKkqT/ftcG0rJOXt7c14Z9Wxfim+G0Htd9O7l19RbUwBq48G
	8d3ofLsXPuIffHzIS4Bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPmi-00017q-DH; Tue, 15 Jan 2019 14:33:44 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPme-00017T-3U
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:33:41 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FEXdMY108286;
 Tue, 15 Jan 2019 08:33:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547562819;
 bh=9Gtv9agAugy5zPFMqFW2P3jNSSC8INY6j5BCjE8sIyo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Vn06AA/SOf142E4sAB/uo4aG2fEyblO7RRj0OfOYzAoDh8ZWdCCZxULqX5Qxm/ggD
 RR9sSHN1SdSenOa7rCVq2t/GhNBz4sxX1aYZBq71N4kTpqOHuNsKlPPcgst53X76YC
 Q0BtGUc7Ae6tGTCDGhWnXBIoO17gGcXKAtEc9h28=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FEXdiZ058053
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Jan 2019 08:33:39 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:33:39 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:33:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FEXdh9022713;
 Tue, 15 Jan 2019 08:33:39 -0600
Date: Tue, 15 Jan 2019 08:33:06 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/3] arm64: ti: k3-am654: USB support
Message-ID: <20190115143306.wub3y2c2zsq7byy5@kahuna>
References: <1547200861-17795-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547200861-17795-1-git-send-email-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_063340_189490_77D5C964 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, t-kristo@ti.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12:00-20190111, Roger Quadros wrote:
> Hi,
> 
> The AM654 SoC supports 2 DWC3 USB controller instances. The
> AM654 base board supports the 2nd (USB1) instance in high-speed.
> 
> This series enables support for USB1 instance on the AM654-base-board.
> 
> To test, you need to first apply the below 2 series.
> 
> AM654 USB2 PHY support https://lkml.org/lkml/2018/12/5/908
> AM654 DWC3 support https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896101.html
> 

Please clarify if these have hit linux-next yet (I dont see anything in
the threads as to being picked up yet, may be I am wrong). Once they do hit
linux-next, please rebase to Tero's latest tip and repost.


-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
