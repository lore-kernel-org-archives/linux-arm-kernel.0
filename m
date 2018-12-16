Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E37C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:15:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E8A2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NnvfuoCU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQnh9xez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E8A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2o7PXC2UzWAxsYpv+cLZlp2IghSZiiG2sN3JOe22lt0=; b=NnvfuoCUtWXwrm
	Wvu1WllHX45ueosOta6NjWBzlKIp7UF4QP3CGzhgs4gUZnehtyLMHVA1Jtnmr+Uj9p2uH1bv1ewn+
	JjvajVtKDKxDCPTBPnmS1qL1GJtPjqOJ9A6xZuGhyCB8WiXA6JT04S2H5LXbpFBngM7xiIrN2PWNN
	z1ZerZtSltM0V5SE7Xf18MLyhGS1DUnedXzAjGGfFdX5FAXqFNCCAyCH82aSXiED7+qDWwRmqRJhP
	AH0RrDrgYiP52eolJxxlBTkwh9by8ql9/BvY30Mbx9AcPA/7VTKxAcFTRgYR4Hz9ZUZPOVjDL1UOm
	Vy3q/fhjz+UebBDFx62A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYSWD-0006Cc-6Q; Sun, 16 Dec 2018 09:15:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYSWA-0006Ba-1n
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 09:15:23 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 877BA2084D;
 Sun, 16 Dec 2018 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544951711;
 bh=XHnqJFO3m08OorIoFYzDH/5DyUHP264p43PG/ku/Rcc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OQnh9xezErZzbMJIxF3oRxKsHzhufUKLnnIn10mhZaGiOQr/UN5m/8oU9CJACS/uJ
 WywXU7+t70EKmPY7HyhJ1QqsUz9GP4z+InR4B+1nmmDN3fGu2aMUykzXY9q3hpElga
 OxkWHcQvaetTTwGqxMdijJhaD2STGkxFF2d4iwYs=
Date: Sun, 16 Dec 2018 17:14:06 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v5 1/6] arm64: add basic Kconfig symbols for i.MX8
Message-ID: <20181216091405.GK13243@dragon>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
 <1544365552-30270-2-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544365552-30270-2-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_011522_109934_5B7ADD92 
X-CRM114-Status: GOOD (  17.09  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 02:26:06PM +0000, Abel Vesa wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Add basic Kconfig symbols to make the MXC architecture available
> in the ARM64 world.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm64/Kconfig.platforms | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 28f0521..7e1545a 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -142,6 +142,20 @@ config ARCH_MVEBU
>  	   - Armada 7K SoC Family
>  	   - Armada 8K SoC Family
>  
> +config ARCH_MXC
> +	bool "ARMv8 based NXP i.MX SoC family"
> +	help
> +	  This enables support for the ARMv8 based SoCs in the
> +	  NXP i.MX family.
> +
> +config SOC_IMX8MQ
> +	bool "i.MX8MQ support"
> +	depends on ARCH_MXC
> +	select ARM64_ERRATUM_843419
> +	select ARM64_ERRATUM_845719
> +	help
> +	  This enables support for the i.MX8MQ SoC.
> +

As we agreed in principle that option SOC_IMX8MQ should be drop from
ARM64 platform.  I updated the patch as below.

---8<-----------------

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479334a4..3e177a332b92 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -142,6 +142,14 @@ config ARCH_MVEBU
           - Armada 7K SoC Family
           - Armada 8K SoC Family
 
+config ARCH_MXC
+       bool "ARMv8 based NXP i.MX SoC family"
+       select ARM64_ERRATUM_843419
+       select ARM64_ERRATUM_845719
+       help
+         This enables support for the ARMv8 based SoCs in the
+         NXP i.MX family.
+
 config ARCH_QCOM
        bool "Qualcomm Platforms"
        select GPIOLIB



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
