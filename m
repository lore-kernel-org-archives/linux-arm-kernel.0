Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F67C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:14:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B3220872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lS+Gned1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4m/25Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B3220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ti+gpqlk+qJiWqLjM7oz81OU3XyPWSwQuEr+tcg8f2Y=; b=lS+Gned1P1moKd
	ahJQBGbsta34ZxnfwpzghkCpS9pW/1Z5zqaK/gH5fHM0Z5R1tRMkq0kJ1Ip/fMUs8sbp9PQ4MS0Hg
	jlG8HWA3HwbcEtKiSqzrOH+3GVcfY3yoIHemuFPUV1P7o6BlzEpm4tb4QM1RLzdRS2qCg+xpWA97F
	uLSZWC5SpPbrJgvwIDnJ8Fpqlwg7NykD/dcWV24XoTipbwTNKWhbVBRvx4Wqegj33MgtHJI5PJfG8
	Pivydk2uDtOVCXWG+AfQ9+sWShRiptjcC6P8NcGp4y7JnAIK2mJ0rAQf0NMKYl6m69xKO3zWiSEVp
	UZvKxQVxCF4IuWEbrNbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghr0v-0001BU-On; Fri, 11 Jan 2019 07:13:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghr0t-0001B9-Nj
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 07:13:57 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2489420872;
 Fri, 11 Jan 2019 07:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547190835;
 bh=Xou/b5cOrCg0D6LpRZ5P/Mb7Z/6I3Gan1uY4JyObIIE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k4m/25RyLufTCgXBBliXbvyHjbkWas2epSsDYJKjv0v67GHzVojp4tDNgzyWaIeD5
 lxyMPSYx/ty5Vj2We0zeBwunxRmBd6H8pqewCEL52RXeLtgkrKZ1bWOMYyUByLra7s
 pdC1J0RMQ/12BYfCCQzxadVYcTG3jKFGqCMiSOCM=
Date: Fri, 11 Jan 2019 15:13:42 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] soc: imx: gpcv2: handle additional power-down bits
 in handshake register
Message-ID: <20190111071341.GB32649@dragon>
References: <20181217153152.21135-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217153152.21135-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_231355_787574_5235E3D8 
X-CRM114-Status: GOOD (  10.99  )
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
Cc: devicetree@vger.kernel.org, patchwork-lst@pengutronix.de,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 04:31:51PM +0100, Lucas Stach wrote:
> Some of the i.MX8MQ domains have an additional control bit in the PU
> handshake (HSK) register. Documentation about this bit is a bit sparse
> at the moment, but it seems that it controls a power-down request to
> the AMBA domain bridge (ADB-400) attached to those domains.
> 
> As the documentation doesn't desribe the usage of this bit yet, handle
> it in the same way as done in the ATF implementation.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied both, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
