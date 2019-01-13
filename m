Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:39:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1192063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="amIfVm1Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYgwKNWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1192063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GOfHTEU3bK14PYfvw/07nOyfGPVtfwKuxyqBvGIfSmw=; b=amIfVm1Y6i9MiU
	NyPLYPkR+tGKTqj6rRq0ibZ3e0DPDoWeMOSTNuEEr9DMZVp8YUQ6uuPu9umZSQ1xnXfKlGEidkuom
	mS4bvAHcjNw6muW+xcOV1i28kn8Rq3sW8gIhjQWgXOB4G+Xti3upeLUXIxA2iCxGmWeyORqF2L5jX
	dCfGmPlAfzhnYGh8fE8C9IjmyFOUigiFRDI5CdC3d87rz9jj8tNeQbb52SNq3SJWt8B5X77MTcXfM
	Sk6TksKVpX4bA6ZDl9oiOgxVKuHMW9+qqOYVk7bLn5uiL/n/a+cUchXG3pqYIcA2Nv2m+/KR1t/mH
	xSfrYPT3i3fElMsoTUmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giVgW-0007p9-0n; Sun, 13 Jan 2019 02:39:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giVgT-0007ol-6n
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 02:39:34 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 02D862063F;
 Sun, 13 Jan 2019 02:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547347172;
 bh=SeJpcP12P3J27RM86yL9ZEms1dAxFMm1QQgQhXNo3P8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FYgwKNWKxg97X4fK5rG5aBpfxZOR8joXvT2AzTkvt0S8EnXUcGiR419MdfaLIRff5
 2rnpyr0vK+Xck26rKSiYJ2HUIbGiO1ca4xW5agQCynkTduUv0QoOWCEmqvWEcK30PU
 s5+qyKZ/w3DAXiFtoE3oQM51nqQm5vxNDJ69Mtzc=
Date: Sun, 13 Jan 2019 10:39:18 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: Re: [PATCH v1] ARM: dts: ls1021aqds: Enable the esdhc
Message-ID: <20190113023917.GD11426@dragon>
References: <20181228100251.25697-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228100251.25697-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_183933_262588_9FD67A3B 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>, leoyang.li@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>, yangbo.lu@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 06:02:51PM +0800, Yinbo Zhu wrote:
> This patch is to set the esdhc's status to "okay" in kernel.
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a-qds.dts |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
> index bfd3746..98e562c 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -334,6 +334,10 @@
>  	};
>  };
>  
> +&esdhc {
> +	status = "okay";
> +};
> +

Please add it after &enet2 to keep them sort alphabetically.

Shawn

>  &sai2 {
>  	status = "okay";
>  };
> -- 
> 1.7.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
