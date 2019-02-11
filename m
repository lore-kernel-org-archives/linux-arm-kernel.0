Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A12C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:58:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A952084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXfEslhZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHucjQlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A952084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tV30kDXemwB/Rkn550dXVxg2lx3JglGHWdBsRCqwc84=; b=bXfEslhZSkq2aW
	CBbq/HwXfv1WgHgFYCBXmjnahzII6PbjskWlv1WOJGp34PkpRqM71JuYm9+3LltBzFw5yWqAbyJA1
	PVxCogGSNT2o3n1ODv/l3Uv9TZ8y/EZOjaQW6LVRtzHeRHzBjP27yRB+Z1K6HbcX0bGTEVG5R3vC7
	zCfkJF6OiDDfqk0PK/ByfmrCJ6m3BlSpkjSDfkp9WKwJ1y3sUy79FkDsnpWP1+BHmJjUNQzKctkZi
	kH9lszkRiORrCGAumFB/QJd1fez7qmq32hfpiQSy5utYDr6JFArAt6As/BeGxG+NecAch/VBHpEqy
	PK9I361njMQlHuo0qztQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt0rj-00086p-9i; Mon, 11 Feb 2019 01:58:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt0rf-00086V-So
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 01:58:33 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 347BB2084D;
 Mon, 11 Feb 2019 01:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549850311;
 bh=Nx7zq0otEa/MnWMzX0u0T3g6cbg5Sqn2cDfooxzAi2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vHucjQlkLObX+IfylHPcyeh7f65GjrpTcOlCzm8+QZ8RPv+mLfjM64BnqrfVqVbLa
 uC07e9Iln4BviyroZcWxkn7Gt3DvsXEYSJXlYXbdCuvb82SjSxAdR4rH3xX4yZiRbA
 x4+OQfPAx1HFNMV35bMHTOyRYDIDkqouIkZmXBiw=
Date: Mon, 11 Feb 2019 09:58:21 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: imx8mq-evk: Enable the QuadSPI
 controller
Message-ID: <20190211015820.GB22487@dragon>
References: <20190130120511.11555-1-ccaione@baylibre.com>
 <20190130120511.11555-3-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130120511.11555-3-ccaione@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_175831_943960_E6F57E4A 
X-CRM114-Status: UNSURE (   8.59  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, s.hauer@pengutronix.de,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 12:05:10PM +0000, Carlo Caione wrote:
> Enable the Freescale/NXP QuadSPI controller with a proper pinctrl set on
> the i.MX8MQ EVK board.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
