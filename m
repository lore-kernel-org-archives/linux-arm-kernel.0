Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C528C2F3D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:30:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E540B20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E5s4iMyh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ci2JZzI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E540B20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1G6LO+9C/uP+L7T2baARlpwhx5wfAAwFJBJgY72rRB0=; b=E5s4iMyhgio68l
	XThuNMYJbvOtBK4eB9nlq9WaPOS91FXiYaXAyS6gJiP1KH1XypPKoR7MjPEYQtXjU2r4SCsE72vQE
	0dlxn2DnHunkiCWXn5PQ/4bemRXYNC1Tiwdo4MceSAtvM/UIprHXi87ejn4VK+MpA1Gqgk8uEGPKI
	Aq+dYGQNziNUNW7zvqYU4OqWNl2d51AEIZHjIbtx1A6mon3ajImSW0ROkPZTfFzIM3dqf8zyxOvUs
	UjBBC+kSpx3tEx2lpLAj5Ip+tJhQnZOj4i45VgfUqpDsr29x8BmZ1zhhq6ETD5Na63H7rGQ7dZ+r3
	NBViqklUwNUYfgsBAM9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glaaz-0003Z4-GV; Mon, 21 Jan 2019 14:30:37 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glaaw-0003YP-3m
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 14:30:35 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 713CC5C0DDF;
 Mon, 21 Jan 2019 15:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1548081030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8TpjwAbO652mHYXiF9FJrLILmgvaCiBjhUMapdS/NQ=;
 b=ci2JZzI4ukuzyQd3PmMDSntR5gn1pN6+5Jbt3PfFSCojzLv1gLNp1BxjlndwodsqVfDw0a
 XJrAmWNeZDdadiRAi2Kg2s3A7FeUPR6JLilFAPJ9DrDah6AKsTjpXplA6MhmFMBgRBqlhb
 nEpI10T4X2h+GXgqZsf04uzvcSbOusg=
MIME-Version: 1.0
Date: Mon, 21 Jan 2019 15:30:30 +0100
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH] ARM: dts: imx6qdl-apalis: add phy-supply
In-Reply-To: <20190118133218.19917-1-stefan@agner.ch>
References: <20190118133218.19917-1-stefan@agner.ch>
Message-ID: <54c6b91cf908bd7553027d77244414f8@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_063034_306060_F6C7FC82 
X-CRM114-Status: GOOD (  17.46  )
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
Cc: kernel@pengutronix.de, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, max.krummenacher@toradex.com,
 fabio.estevam@nxp.com, dev@pschenker.ch, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18.01.2019 14:32, Stefan Agner wrote:
> Use the VDD I/O rail as phy-supply regulator. Technically, the
> regulator has multiple rails, but currently the driver only
> supports a single phy-supply. The VDD I/O rail has the highest
> power consumption when software power down is used and hence
> the highest saving potential.

Please don't merge this patch. The vgen5_reg is also used as a pull-up
for USB ID pin, it would not be safe for the FEC driver to disable this
rail.

--
Stefan


> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 0b47aecf336a..cf66f9ececbd 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -241,6 +241,7 @@
>  	phy-handle = <&ethphy>;
>  	phy-reset-duration = <10>;
>  	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
> +	phy-supply = <&vgen5_reg>;
>  	status = "okay";
>  
>  	mdio {

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
