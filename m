Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3285DC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:39:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042AB20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XbIHoNFh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGP2Guyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042AB20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5wt1i77l+3pSAWu0PJytL2h/2VxMgHsgOFZi/eI8u+E=; b=XbIHoNFhTSQ2iI
	bfLixdrci3+lXIhcEtHbCgMaHZox4yS/KNkEWHqoYw3rsMUVUe2zDcAWSgm51B4o2E38o/kmg442h
	1mJI1J9SYmW8qD1jKki2R92zjPtxLOzlKG68mO1REKJId066mFLZkkYN9F5eHN5OVRVeigyF3NQQ3
	CragtDEh2Auz09L/UiKcVqEImV8jjIOz3u3LRJd0KxG4a/zhsK6FWFZdolsEm9aMvvKeQq4gWuHp6
	SXwsdSFKlF/3QUWV2JJFojYz0yT/7sCGv0SSl52CDofyVZmcBO8LmCng+nm4LkU6ryLGTi7tnTDml
	gBx2or5eHJoRtSzp68rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPft-0006uS-3w; Fri, 01 Feb 2019 03:39:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPdH-0004hh-Sn
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:36:49 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D8EA920815;
 Fri,  1 Feb 2019 03:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548992207;
 bh=IWzmsHFpszhTs7TF5E8ZwvQobKHoMTnvd370j1pGuiU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sGP2GuyolzfQnhK5k6cyctAxZ11903px1ql39KmOLUk0yXsXeBz6batfhS7bepW6o
 ktnUKHZx2dXDLyEMwAdopY6KqeAuaivxERIl6djD4aepDSLYISGTpCjz2RUdcuG0xe
 1pIQzvedJx+VPQKf728KjIRuNLXus2JX2Dx8abHc=
Date: Fri, 1 Feb 2019 11:36:34 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH 0/2] Adding DTS to support STMPE811 ADC on Toradex Boards
Message-ID: <20190201033633.GE19882@dragon>
References: <20190122132135.5012-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190122132135.5012-1-dev@pschenker.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_193647_974416_1FC96639 
X-CRM114-Status: UNSURE (   7.69  )
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, marcel.ziswiler@toradex.com,
 s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, stefan@agner.ch,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 NXP Linux Team <linux-imx@nxp.com>, max.krummenacher@toradex.com,
 linux-tegra@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 02:21:33PM +0100, Philippe Schenker wrote:
> Philippe Schenker (2):
>   ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
>   ARM: dts: Add stmpe-adc DT node to Toradex T30 modules

Applied both, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
