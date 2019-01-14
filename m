Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06915C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:56:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51B420656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QOIosth2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFBksLaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51B420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Iz2jDltYHIFFlXSk1+Hpz3JDSsh6craggBHxsxChE0o=; b=QOIosth2nEiWk/
	I+adZzMediF59q9bAuiDY4iSNu2+wkZQFFvkJjW5ZSwH844oAE9H7JzpSIi9QcFguPZrM3apRauLV
	43jmPzZiPFXYfC2UW98UgyaybOi/PXGnckCwfc3/orMHzMPEeKVjq+iqmetulY/oigooN0SNObZSt
	5qv20+H1l33dfFLG6nRvX+EEhWTZCbLewhvchU5JFjwmqzv2p1yzVv/0zSbNhJyFRewq9+qbSsiGw
	popkBz3AIIJ/+bNnnXiU7wASZMqrjRfmceOWvbd3SBAU6FiwU/liOg/5IzFA1jybB8byz6aacFmFD
	Sk+3W52mq+KJNEm0Tpqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giqYB-0003Hs-UZ; Mon, 14 Jan 2019 00:56:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giqY9-0003HP-3W
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 00:56:22 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BD16320656;
 Mon, 14 Jan 2019 00:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547427380;
 bh=616qQYLjy0TWEpz1JCSpCs+flqKc1k3ChSUmgQ2vz/o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eFBksLaJYMKNokGYGFKML9tJy45VwWt52KdwmUahpRNjzU7AC6ot6BRXugOG3Q5MS
 MuOVhJsoSxWPglJKWBvIaLtJ+t2rQg/qZJ1DNx2tVT/j55YxsuiynWlBoFPXiMfAlH
 E2xlfKSXaxdvQDrMf27z5ZH27en3Z1zpDRgzTRLc=
Date: Mon, 14 Jan 2019 08:56:01 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Message-ID: <20190114005600.GN11426@dragon>
References: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_165621_165875_50D80F80 
X-CRM114-Status: UNSURE (   9.38  )
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
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 05:57:30AM +0000, Anson Huang wrote:
> This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
> states supported as below:
> 
> 1. WFI, just ARM wfi;
> 2. WAIT mode, mapped to SoC's partial stop mode #3;
> 3. STOP mode, mapped to SoC's partial stop mode #1.
> 
> In WAIT mode, system clock and bus clock will be enabled;
> In STOP mode, system clock and bus clock will be disabled.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
