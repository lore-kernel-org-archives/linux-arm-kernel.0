Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833EDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:58:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD6620879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tk7iergX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EFuKjXkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD6620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D4aarbSd3csfbLo0fPlBoL8O0RE+XgX2FnK7EnbeOSU=; b=tk7iergXTrm935
	Bnr0ICVho6kpJSgfCs9RCKab6Idtwy8spJ57s1fyqbsTNK+VvDokJbzM8DFQdcsIO6Vzh4Kc8/ywC
	849zu8IQR0xtK3k7PRO3RxOrs4FqBw322dm1eg8GiiG+yXycqW3s1Fm9VrFfnxGU1/5RN3DY04LKx
	0wXpCd7C1uX+0bioCpAWFL5cW8cPAprOJAS7pp/fuLvbIJrRx4zufYyhG/F/sUxmCgW1hFMbWoVaW
	9x9AstIWlef4s1jXAP0BrSTi5JkONCDoapoaA9wMbwelkHqvfgyRvIF9ZUPEpyxkDzHyprrj/ob2g
	WYoV6Qx1GGEYgl8ZXbQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZuh-0008Mx-Uy; Thu, 10 Jan 2019 12:58:23 +0000
Received: from perceval.ideasonboard.com
 ([2001:4b98:dc2:55:216:3eff:fef7:d647])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZue-0008MZ-6k
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:58:22 +0000
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi
 [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 885B14F8;
 Thu, 10 Jan 2019 13:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1547125085;
 bh=4puNvOBoknhCNWs2atjqhIpgbrRg/eCecU28pHTvyTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EFuKjXkthiKKJqoS51u3F6wg4ga0DPhcm169JHzCKuydY7s2W+4rDaciAVkU2DvAj
 olVlqD+fI2/1RBzJpW7TsZYESCyZpAY+xFWuxE7ku4vKW/1mVn/g1KW38u2w3UorZk
 D6P5YQ6Jv5s7txVUMhTPdN0pPP1K5nwLvFxRdwZA=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: marek.vasut@gmail.com
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Fix backlight
 regulator numbering
Date: Thu, 10 Jan 2019 14:59:15 +0200
Message-ID: <1816865.hhpKvpXsC4@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20190109140045.17449-1-marek.vasut@gmail.com>
References: <20190109140045.17449-1-marek.vasut@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_045820_532055_07A84250 
X-CRM114-Status: GOOD (  14.69  )
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
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marek,

Thank you for the patch.

On Wednesday, 9 January 2019 16:00:45 EET marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> There are two regulator1 nodes in the Ebisu DTS right now, one 3.3V for
> the eMMC and one 12V for the backlight. This causes one to be overwritten
> by the other, ultimatelly resulting in inoperable eMMC, which depends on
> the former. Fix this by renumbering the backlight regulator to regulator2.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Reported-by: Simon Horman <horms+renesas@verge.net.au>
> Fixes: 9d16c4a10e07 ("arm64: dts: renesas: r8a77990: ebisu: Add backlight")

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Sorry for breaking this in the first place.

> ---
>  arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts index
> e0590c0af4c4..89383aa35d65 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> @@ -191,7 +191,7 @@
>  		clock-frequency = <24576000>;
>  	};
> 
> -	reg_12p0v: regulator1 {
> +	reg_12p0v: regulator2 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "D12.0V";
>  		regulator-min-microvolt = <12000000>;

-- 
Regards,

Laurent Pinchart




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
