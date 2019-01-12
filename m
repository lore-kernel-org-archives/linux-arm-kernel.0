Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C9BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:05:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A815B2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T9JHQbM5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6HRFJgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A815B2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lSsAdmvVToVnuSxHKeTffLDiRUizQcMTXpaGcSU4L1c=; b=T9JHQbM59djPCa
	bM+MG8I+ZHbD0QZW5MzuX0hXDskAMjPCDHLuUuNCyea1yrROBMx0LTT7mJCTggvg4cIdS/x8dAan8
	BD30vesiUhlxJXav0VfM+bholnEZvVsoF0x+1tc3SNPcXVCebU7fIlrs7qnxErm3pu8T15fXPP3Zy
	1qAuj16mp4XbLzqw2xfYnsdvKmWpnNQZ2hHV9QWEU3/XR8LDSUyzaaL5TJw/juBIlcOo8X5OSQZFM
	EqftvbYt9g01JoVqTJTZnXXfRSsj3uPoG0x6RAVNy8n36KNCmgRnTwqTux9fo0/v43gCC4yV2P5o/
	voFgsHXwcvkbpel7obCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi9bs-0003GH-CI; Sat, 12 Jan 2019 03:05:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi9bn-0003Fp-Sj
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 03:05:18 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2196F20870;
 Sat, 12 Jan 2019 03:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547262315;
 bh=ZAsm7AOzTIFhwyWeeeNpV3efhAtUAE17nS3pjsX9/Cg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p6HRFJgl0V5SQmrJWtOAseE1L3fJrTe1XxAPkJRFf6zLSj8DGK2T6lLWyU6sUOAAO
 UmN+vm7vwa6C5WU0BMa3e0WtT8/5fr2VAolit0Fq9XTw6cawKjShE+9a/Mfcf3DV5C
 dQpR6ELWoLXWEol3pwRDgXfo2gW9mXpw5Oku+H7w=
Date: Sat, 12 Jan 2019 11:05:01 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 1/4] ARM: dts: i.MX51: Add device_type to Digi
 ConnectCore memory node
Message-ID: <20190112030500.GR32649@dragon>
References: <20181223060342.32054-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181223060342.32054-1-shc_work@mail.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_190515_961438_5A303664 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 23, 2018 at 09:03:39AM +0300, Alexander Shiyan wrote:
> The current imx51-digi-connectcore-som.dtsi lacks a 'device_type = "memory"'
> for its memory node. This patch adds it.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

It has been updated as part of Fabio's patch [1].  Applied #2 ~ #4.

Shawn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6a9681168b83c62abfa457c709f2f4b126bd6b92

> ---
>  arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
> index 5761a66..82d8df0 100644
> --- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
> +++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
> @@ -17,6 +17,7 @@
>  	compatible = "digi,connectcore-ccxmx51-som", "fsl,imx51";
>  
>  	memory@90000000 {
> +		device_type = "memory";
>  		reg = <0x90000000 0x08000000>;
>  	};
>  };
> -- 
> 2.10.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
