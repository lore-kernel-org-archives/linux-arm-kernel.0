Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B71C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:18:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B2C20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SQadgjDu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mihmaLc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B2C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p+JeX59AIXStpC56a0Ajx1zSxr3yKwxWOc5I2Osko8s=; b=SQadgjDujHppVx
	gmqZQuJK1gBRhwiKQdyvTth1Wi1gOvU2b3d9sA26ao6vNM7ct9z4n/ScQ4t0Dc+w8an5eUjYtKCMm
	LCi84kXlv7BIBpCWSuSzl2/xfrkJe4ZN7yuloMkxOMfGVFYRb3ogTL39AtBZ0DNNren1tUbBXeNih
	PHlumG3ZoJfKw6X7wVnUVDc2rukNen0cOKbe03BvVzutU11dBe38IJsrohJMVd9KVa0Ga0VAaBVTR
	Y+BP3M+M3YRCSRFT6/NYpR2BdXgZog15VKg8VftEg2E/zoRFxXXKpAeb7oKMbeilJ6JOsw6OoGKDJ
	6ED8IDfOCLutjuLYONiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiHd-0007aQ-PK; Wed, 16 Jan 2019 10:18:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiHZ-0007a3-Ru
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:18:51 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 595CA20840;
 Wed, 16 Jan 2019 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547633929;
 bh=hVjEbg8VL5BMvgSJdJDSg89ynMOeMWzqZJPxzWsNX68=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mihmaLc9+Ghk9AQLj1xu42qUbq9mkpFDIDkJE0hFcQXl53es33nPGg/idDg0hup15
 sFAr19dTzd1JolungRAFlCsORJacbgo+XJn4r9MSX0KbBLtiPeXYUyH0Nq5HOlhe8+
 jjpdbVOs70bsD8XlOyAx1r8/d1W2zUr92cdFvW18=
Date: Wed, 16 Jan 2019 18:18:25 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/2] arm64: dts: fsl: imx8mq-evk: enable USB nodes for
 USB3 host
Message-ID: <20190116101823.GJ15808@dragon>
References: <20190115110325.13236-1-l.stach@pengutronix.de>
 <20190115110325.13236-2-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115110325.13236-2-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_021849_920077_ADEBD549 
X-CRM114-Status: GOOD (  12.35  )
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

On Tue, Jan 15, 2019 at 12:03:25PM +0100, Lucas Stach wrote:
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 64acccc4bfcb..ab6d609abce6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -137,6 +137,15 @@
>  	status = "okay";
>  };
>  
> +&usb3_phy1 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_1 {
> +	status = "okay";
> +	dr_mode = "host";

Please flip them.  We usually put 'status' at end of property list.

Shawn

> +};
> +
>  &usdhc1 {
>  	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc1>;
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
