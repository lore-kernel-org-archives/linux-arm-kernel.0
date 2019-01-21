Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4755AC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:35:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B34214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ej0zRSjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B34214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4h2cDf6usYxKpfnunqSPciPoLYc4II98OtqLSZG5mr4=; b=ej0zRSjY6/vTUd
	JNl2sYXeS5ovEU4HD/JpjKVY/SzG52gtcgdAqjLtw+5TfVm+Nz8jIUq/ZRVihzMi2EpUaJ2aaK3Wc
	36aX7Bb19z6vodjobo6Zme8qMmDn/4RZ7Ory8N03sCogr2AA0wlaksTLFcedGwNsVRqg8Nh4+wUGC
	dV4eFqGzzFJ7mKiJa/BQcsRzk0m4AeKnic8nqn1UK/ohq6EYdzTFk9dpycd7uB3plH0ONbncgmJOy
	IZIMdxGWJC8j9/0V3I1GtE6HAwypkLkPw6mHNroc+NPUVynZzyUIexu5JuNOH6zXjIyj6JPqcPdgJ
	bDdsfh5OpK9oAJ+aaAYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glV3i-0000eg-5l; Mon, 21 Jan 2019 08:35:54 +0000
Received: from mxout013.mail.hostpoint.ch ([2a00:d70:0:e::313])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glV3e-0000bG-4f
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:35:52 +0000
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
 by mxout013.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1glV3S-000Lzx-I8; Mon, 21 Jan 2019 09:35:38 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
 by asmtp012.mail.hostpoint.ch with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1glV3S-000K6H-Du; Mon, 21 Jan 2019 09:35:38 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
Message-ID: <a5af06ec3d694263ba85a030640b5611de40c5cb.camel@pschenker.ch>
Subject: Re: [PATCH] ARM: dts: imx6qdl-apalis: add phy-supply
From: Philippe Schenker <dev@pschenker.ch>
To: Stefan Agner <stefan@agner.ch>, shawnguo@kernel.org, s.hauer@pengutronix.de
Date: Mon, 21 Jan 2019 09:35:37 +0100
In-Reply-To: <20190118133218.19917-1-stefan@agner.ch>
References: <20190118133218.19917-1-stefan@agner.ch>
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_003550_180793_34EC0F22 
X-CRM114-Status: GOOD (  13.55  )
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
Reply-To: dev@pschenker.ch
Cc: max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-01-18 at 14:32 +0100, Stefan Agner wrote:
> Use the VDD I/O rail as phy-supply regulator. Technically, the
> regulator has multiple rails, but currently the driver only
> supports a single phy-supply. The VDD I/O rail has the highest
> power consumption when software power down is used and hence
> the highest saving potential.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>

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
