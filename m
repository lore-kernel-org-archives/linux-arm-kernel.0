Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE084C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:02:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA08214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g6N/d6zk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G832/cX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA08214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a1/k6aadYSIAzoGsTPSzRyKZGlVjgTLmH6IOhFD/yUw=; b=g6N/d6zkMORvB6
	oDxMfSHBOZypHXrET3nq5MmUoIVDVqELquaIc2Y+zi+4fD0/v5+OFdo5OcQOcYnKT4m/J1a2b0qOT
	mj90XH6BCNVUUJd36PXN9iIpY5o39OLy7wQH0JrPkw7rdwkoRdUj3sFX7FXmNJ8JlhZSgCDwov4RD
	RnkHgQF9Q8yKxEzjDe3DcOkNP3RN4aIeSZB61paLctNXiA3VfFKs1rpmjuhINa54gd/bdkWmwptWc
	GcWdVrPXQ/ZwMuZ9pJdYn5NIVfRioGOiWQiPvZOcrYm8WTAEixOn6yKrUrLcOB5JE3JDhE9jglb7t
	wP3CZ2fEye1DTsQW3jgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUjw4-000055-Ox; Thu, 06 Dec 2018 03:02:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUjvz-0008Ps-4A
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:02:43 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E0D12213A2;
 Thu,  6 Dec 2018 03:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544065347;
 bh=uMVl/415zAEKCE/beSy2RAy7Kd/gxyJ8XoOuAyCwDCE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G832/cX32djOmbgPII+0/8jTgOByL1wGZmJ+9rh6pRlMsYVo0dK+jVpD8WAxz6O+g
 YKRhJvHdLj0wTg2ZOXAhGAQdDspkifW4hvWsWSlAwN+somFiMfC+ULfsMkWNaiE1Pu
 57VbyHCMu9C66qucdQzEfw0tf4HuwAbBJYf74BA0=
Date: Thu, 6 Dec 2018 11:01:48 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Hans Ole Hatzel <hohatzel@jusst.de>
Subject: Re: [PATCH 0/4] imx7 sbc board support extensions
Message-ID: <20181206030146.GB3987@dragon>
References: <20181204110741.6943-1-hohatzel@jusst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204110741.6943-1-hohatzel@jusst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_190239_209473_91F203EF 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: fabio.estevam@nxp.com, devicetree@vger.kernel.org, ilya@compulab.co.il,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 12:07:37PM +0100, Hans Ole Hatzel wrote:
> The following patch series contains a number of extensions and fixes to
> the board support for the imx7 sbc.
> 
> Hans Ole Hatzel (4):
>   ARM: dts: imx7d: cl-som-imx7: fix pinctrl for i2c2
>   ARM: dts: imx7d: cl-som-imx7: WiLink8 WLAN support
>   ARM: dts: imx7d: sbc imx7: add uart2
>   ARM: dts: imx7d: sbc imx7: add uart5

I would suggest the subject and prefix like below.

 ARM: dts: imx7d-cl-som: fix pinctrl for i2c2
 ARM: dts: imx7d-cl-som: add WiLink8 WLAN support
 ARM: dts: imx7d-sbc: add uart2 device support
 ARM: dts: imx7d-sbc: add uart5 device support

Shawn

> 
>  arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 100 +++++++++++++++++++++++-
>  arch/arm/boot/dts/imx7d-sbc-imx7.dts    |   8 ++
>  2 files changed, 106 insertions(+), 2 deletions(-)
> 
> -- 
> 2.19.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
