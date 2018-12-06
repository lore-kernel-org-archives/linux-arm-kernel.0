Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12374C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:22:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D785420700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aW2AtW/+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI6dPT30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D785420700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hv5CmJcMRGUrb8cmCsdaJQWm8gWxlzUa1e834bL9sqU=; b=aW2AtW/+D51qPU
	SaAoWnCSsiddX8t2gfpln3Il/lOYwikwwF8kz1yOHDikZgdo6oH6cXa+DWzFNIrTgIARTnKUECFAq
	iUStHI7rEi9cDl9Nch3hudDOr7dHiBZcmy8J8SqPLhOgIslxhonZrsMIYx6Xn6Rq+uD9JRc7F4XPw
	+jiNY/Yz5rONcUqVwzkGNM5TjXwYrDUY4lsTLmsgUIThfMjVDRF/6hnGhGMlCt2SxRrdt+Egf62lv
	UxXXq+87AGpjxeZbHscKNTG5b9h9A9d3HA4VTwZZB2+PjzEslkJZxvisewwoCDMsW0R8U7KLosGIn
	EM3fs9x2b7opqTlbqkIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUjIi-0004O1-5I; Thu, 06 Dec 2018 02:22:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUjIe-0004N9-Oy
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 02:22:01 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2CD3A214C1;
 Thu,  6 Dec 2018 02:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544062909;
 bh=XGYqxKhIAn4Ydw+ilNgQAMK8PTyjozTe/Ce2LjWztg8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hI6dPT30M9laF4oLHiHBI8LkL1mNNFglfiHBOpv9XBEfzwYKnmd0D/juyw081YYZa
 Bc7TPP8cANq8/isjPm0x5q1ZumNQgoXS2Qx5gP9TwkSaRdkTppfq22VwsFf9X3FgVS
 lwF80Ay5pUPwLm5PEyLgNWxCuK0T2NSW96MWhb4Y=
Date: Thu, 6 Dec 2018 10:21:09 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH RESEND V2 0/4] ARM: dts: imx: Add flexcan stop mode wake
Message-ID: <20181206022108.GY3987@dragon>
References: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_182200_828096_C63A2F3A 
X-CRM114-Status: UNSURE (   8.71  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 05:20:16AM +0000, Joakim Zhang wrote:
> This patchset intends to add flexcan stop mode wakeup support on IMX6/7 platforms.
> 
> ChangeLog:
> V1->V2:
> 	*update stop mode property(stop-mode -> fsl,stop-mode).
> 
> Hi Shawn,
>    This property has been merged both flexcan bindings doc and kernel
>    driver.
> 
> Best Regards,
> Joakim Zhang
> 
> Aisheng Dong (4):
>   ARM: dts: imx6sx: Add flexcan stop mode wakeup support
>   ARM: dts: imx6qdl: Add flexcan stop mode wakeup support
>   ARM: dts: imx6ul: Add flexcan stop mode wakeup support
>   ARM: dts: imx7s: Add flexcan stop mode wakeup support

Applied all, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
