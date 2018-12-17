Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C520EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:38:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9045C21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qGZvMThd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cskX/z7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9045C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6cEZjmkHGp5U0RAqqcw7DSYMtoatxU2ciHzvp38Z18U=; b=qGZvMThdBT56jb
	ejWGjfEOBDrBnhp/tFdzhauSyxk3ppfEcn9IDmfzKrol1FcKce2g4eRs3+Ct0AgJ0aXWyQRR9F3vJ
	yxP/82kTw92RpOoPXRmAj3TbYSaO2egFJz30aqMS8jQK8aRU32c73+mZdLjgqJ7RPm2IZRdUyQ2VO
	eM85fpork643x+5J8PYUrZDfWiEwjZ+P+1IDX+pOmvMQlJYzNdlV1WTAJg7qTKPty8LWikensj/MP
	+nwBJbTdV0sUsV2qt3l1inPa18GE4nTLY9D2q8WXEk01z/4ESv5a5d63lLX34OG116PnXw+xlGRvR
	aSY4koAlRsEUqkk2AGQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ2SU-0007vn-3k; Mon, 17 Dec 2018 23:37:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ2SQ-0007ud-Vs
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 23:37:56 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7192121473;
 Mon, 17 Dec 2018 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545089864;
 bh=gj2hFrDV8DBl78DLxZork6C8cH4ex1vTohsBODmQ0JU=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=cskX/z7A7WlSRutBJVE83hoZcdL6zoW4sd0uDAO0cXF7/AoEbRQrX8PAPCPBlSPVP
 9hyiCSMnGQU64803+1H8yHZqRPK/cEpT5X6+K5eu1G4cciu5T96gzPIcdpwa1Gt04I
 Awzux9xrXIoDexxku2y0jq9ZfbHpctGznXzl3lrU=
MIME-Version: 1.0
In-Reply-To: <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
To: andy.gross@linaro.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
 jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Mon, 17 Dec 2018 15:37:43 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_153755_044640_CD427EBB 
X-CRM114-Status: UNSURE (   7.36  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
> Allow accessing the parent clock names required for the driver
> operation by using the device tree node.
> 
> This permits extending the driver to other platforms without having to
> modify its source code.
> 
> For backwards compatibility leave previous values as default.

Why do we need to maintain backwards compatibility? Isn't is required
that the nodes have clocks properties?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
