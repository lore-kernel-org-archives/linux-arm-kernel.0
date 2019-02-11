Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86703C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:01:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556B3218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qYt4cx2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556B3218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GPBYk+l/P2k2WJ15m986+JwDacZKth6oTp7COw8211g=; b=qYt4cx2iwpGtPt
	6iUDTTNvAZ5CS48WUQ0yrxoMrwSuklXWuq55RkeFVgQLuxljEoGxryCOqsbgbFT9bCkEgieCd2ldf
	jLDnAGBOM10AxvdFaUJFPZcB4K5hSxphIGFGCz17VpnT+XkuHz2bdIayMbAHkCGhUZtkTp1Z9H/Pp
	UojJwwuDpL3J0l2GB6NeVS3x4/J/DYeUbKwGU4fHawPF9D+KN95FxneUgX4alDcvSSgkOvQtvMVEm
	tDt4+qKXruz3pPZze3YAofVlgmWJ+0MQ3wq6iddhRUJpk7KSuaz5TQdF4ELOI/uKcdqrir2+OeDO3
	uc/gqNssUw0ZmTd3NkcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBD6-0007Bp-0L; Mon, 11 Feb 2019 13:01:20 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBD3-0007B4-0E
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:01:18 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gtBCx-0003wm-Eh; Mon, 11 Feb 2019 14:01:11 +0100
Message-ID: <1549890070.2546.7.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mq: Add on-chip OTP controller node
From: Lucas Stach <l.stach@pengutronix.de>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 11 Feb 2019 14:01:10 +0100
In-Reply-To: <1549886597.2546.5.camel@pengutronix.de>
References: <20190202150638.13672-1-ccaione@baylibre.com>
 <20190202150638.13672-2-ccaione@baylibre.com>
 <1549886597.2546.5.camel@pengutronix.de>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_050117_195297_DC2B309E 
X-CRM114-Status: GOOD (  12.55  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Montag, den 11.02.2019, 13:03 +0100 schrieb Lucas Stach:
> Am Samstag, den 02.02.2019, 15:06 +0000 schrieb Carlo Caione:
> > Add the node for the OTP controller. The IP is the same as on the
> > imx7d.
> 
> This is not true. According to the reference manual, the OCOTP
> controller on i.MX8MQ uses the non-banked write mode, same as i.MX6.
> Thus it is incompatible to the i.MX7 OCOTP.

Actually I need to correct myself here. While the programming sequence
description is the same as on i.MX6, the register layout looks like the
i.MX7 one, so likely someone copy and pasted the wrong documentation
snippet. This means the controller is in fact compatible to the i.MX7
write sequence.

> Also the number of fuses is different, so we really need some driver
> support for the imx8mq compatible and can't declare the controller
> compatible to some older instance.

But then I think this is still true. The changed number of fuses means
we need some driver support and should not claim backward compatibility
with the i.MX7 controller.

regards,
Lucas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
