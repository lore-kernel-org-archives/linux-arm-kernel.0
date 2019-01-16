Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB61C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:17:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF47206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NgWcRB5D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BruWV3OH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF47206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ONXmZ3zn1c92i3J5g6VA40Yn5Chg1aYSrpyy87QmlQg=; b=NgWcRB5DOv+HYK
	p1l4VfakpmrVILeZMcPwXXKSVTdvpJuYO8+Hq0RWPPWVFJLbnaJTKKONMHIchI51shKlm5c4w7Zc1
	Cj7kSfExYn8E0tc3l7ABFg+BWDlxGBWflEDhOG7xmOCV9szG3E0b1QRfBg6qF4nRHBjXfMPLv7b4E
	q4qDsdA3duO3hxAS7uqkqogV3ZJN8A596QNo+gg7ltLGYJYU8TyTCyCZSjR4dVmzvRmp7UfsbFrTp
	2ucyOOedcmv4eQOYBE6dS9RnxCHOTrkn+i8/g7SUeggEkYNmbPfn1lvEmJnaQKbjrjR/WJT9BcGin
	qzrk7ZMrH0WB6zJDwl2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjbi9-0000tA-15; Wed, 16 Jan 2019 03:17:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjbi6-0000sl-2J
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 03:17:47 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0F6EA206C2;
 Wed, 16 Jan 2019 03:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547608665;
 bh=G37Z/ds1X03SQIrVtW84QPml0v6ytOrpxeeLzcMr+/4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BruWV3OH/qitZ5KZvXd+nNtrvKyJh9lqfb1evAUIhMfgELt4SH2FsAeo7PSAZ3PkG
 IA4R5yM+IBREg3l7jc2rJEOxYTIpCGs8uto0puRedpSxxpGqAg3/D/OKnT24aJTVt5
 87zXWVeToajnKpbZIpyjIqwG3GHt4lAdRdbDMReY=
Date: Wed, 16 Jan 2019 11:17:22 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 2/2] arm64: imx8mq: select PM support
Message-ID: <20190116031720.GF15808@dragon>
References: <20190115110145.11017-1-l.stach@pengutronix.de>
 <20190115110145.11017-2-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115110145.11017-2-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_191746_130318_CE560331 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 12:01:45PM +0100, Lucas Stach wrote:
> The ATF on the i.MX8MQ device disables all non-essential power
> domains. For correct on-SoC peripheral operation we need both
> the power domain driver and generic domains, so device driver
> probe gets ordered behind the power domain controller driver.
> 
> Select those options, as those being absent can lead to very
> hard to debug failures.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/Kconfig.platforms | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 251ecf34cb02..bb0d78d1ca4d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -146,6 +146,9 @@ config ARCH_MXC
>  	bool "ARMv8 based NXP i.MX SoC family"
>  	select ARM64_ERRATUM_843419
>  	select ARM64_ERRATUM_845719
> +	select CONFIG_PM

select PM

> +	select PM_GENERIC_DOMAINS
> +	select IMX_GPCV2_PM_DOMAINS

We would like to keep the list alphabetically sorted.

Shawn

>  	help
>  	  This enables support for the ARMv8 based SoCs in the
>  	  NXP i.MX family.
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
