Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB180C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:41:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA27520850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IVUD/1lk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXVORLX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA27520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P8CBUQudH47kKsl+zYn97dBrKY+ZSMtiRl5FJpkvm5E=; b=IVUD/1lkqvtoOX
	1ZJV1R5jNWkPKszYLm3jlh+QYkw8UalQsiM1Kd/iR8rtPJLD1JnP1luMwWHQh4pHls6MbWYqNwkNo
	vjT5sSqbyUmb76gnenb8K2+eTzhEwUsDkv4G+9TmDn+LyFxdcXr3AkzDJIrDiLhWUxKGS3z1fUL+9
	h6JmjmN2iaJdPF78+Lo5IEEldHI8vAqWgm7wVyda9lZLV0f+ESdicHSnSS7x7p9+/yleg4rmIDvmt
	/zEZn01dUQWK2qufB46Lj0Mpqi9tW4dS8mb1lyKrRIc5dDBo/0UII5GyaI7vxBp8dufCeiqVTLS9U
	CuGOIUpAPthv40IW93ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gULFj-00043j-3I; Wed, 05 Dec 2018 00:41:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gULFg-00042b-PW
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 00:41:21 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7FD0E2081C;
 Wed,  5 Dec 2018 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543970470;
 bh=2HJMr2V0Opnry3M1tGRRd0Osp4b/tPxn7EHm5dORcDw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UXVORLX9gmZ5ZQIL7JkDIoyt1g0qk4Phih2A3keP9SYibyMvK7iqqxTiuGcjfmH8o
 UDUQOCENPANXkzPL1NG7IKbNe36zYEn3Lg6gz0WZ+WUlVzu8OItsu2vMiL3PvAWHDc
 ETRbBVDVw132Gf2sewKXIjgHYOroxelEPqdWh5uw=
Date: Wed, 5 Dec 2018 08:40:31 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alex Gonzalez <alex.gonzalez@digi.com>
Subject: Re: [PATCH v1 0/4] ARM: dts: ccimx6ulsbcpro: Add 10" AUO/Goodix LVDS
 panel accessory kit
Message-ID: <20181205004030.GA3987@dragon>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_164120_840191_C2AC48DF 
X-CRM114-Status: UNSURE (   8.06  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
 s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh+dt@kernel.org, thierry.reding@gmail.com,
 linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Oct 25, 2018 at 05:09:29PM +0200, Alex Gonzalez wrote:
> Alex Gonzalez (4):
>   drm/panel: simple: Add AUO G101EVN010 panel support
>   ARM: dts: ccimx6ulsbcpro: Enable AUO G101EVN010 lcdif panel
>   ARM: imx_v6_v7_defconfig: Select TOUCHSCREEN_GOODIX
>   ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller

Applied #2 ~ #4, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
