Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ED9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:51:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF8E20831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dD4KLcUX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xVSECJ1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF8E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oWngvvceE80vzWHub0M0E0FgYO6PJCKcm9euln4OrzY=; b=dD4KLcUXm5/Hx8
	QXtXZtxveojl/+P9liCrMoM8a8TTujGIUE91sTtRTFyj4CcV54LzK19F7XLbY2VxXf9MPVirLaEOa
	y2Debd2xEbUEfaxb7yr4QpqnqBfcQpuyPXAgJizgzgAbb+dZ04Xoh8iklMayWFVblTLF+w7+C3t1c
	SOl3PvRBZOEGsXBdF+hiWNb7kGglHtm+YzYapRojX2eSpxYOyzuyN1bq7jXu/6+EXKo01MgA8jU/L
	Gf3aWXEBZY86uGzCzRlVjSzS948WdtpJk/l+vkGGZs7XUdT7aPrFQYDsNhgumeuqfhR4x3dkllC1d
	HYG94LZ8C6ip/erzWsTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVyYA-0003iG-8n; Sun, 09 Dec 2018 12:51:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVyY7-0003hD-Ch
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 12:51:08 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2EB5920831;
 Sun,  9 Dec 2018 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544359856;
 bh=zOr9gCr1YQksQ4Efd8nd9wFvYrPiM35M1JKyA3ETjH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xVSECJ1lYYn9soS8/NOnS2vKL/CrPLENvYm+M67xgB46UYNvhe7RdR1K0Sl61f9Oa
 1RIWelkR95UAz1YYf6L2hqdKbXDLgNRtM90gL+0pqLIIMToCBoOv+x6D/msiP/YSmv
 KyvAuwiVZLSCGcpnW5i+0KuAdbg+SMtEU2D4RbwA=
Date: Sun, 9 Dec 2018 20:50:08 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6ul: Remove extra space between node name
 and {
Message-ID: <20181209125006.GD22960@dragon>
References: <58cf0fc7b3e0037344de3a02ecc3b210abfbfc28.1544123990.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58cf0fc7b3e0037344de3a02ecc3b210abfbfc28.1544123990.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_045107_448847_8BEE92E4 
X-CRM114-Status: UNSURE (   7.13  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 07:22:16PM +0000, Leonard Crestez wrote:
> Fixes: 7d1cd2978664 ("ARM: dts: imx6ul: add gpmi support")
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
