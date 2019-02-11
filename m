Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87667C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:28:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A622146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OuRsIyMP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1x1QifAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A622146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=15a5C8qh+I0gDPtNetXNO7gjFxUtRdfTsJYLeMy27Bs=; b=OuRsIyMPQcNOx5
	U17hzOHnH3gYeZGsnPxX66B8OvSxO4NDVddN4TMxe328JAO8TKmTpQ8CZ1XyxoiJIgekqggcP2EHc
	Fr5YIkBexLRaqP8GLOu16wSi/WN/t9mW0SB7ouWcSaF57u+AkejmM1sWpN+iKCiRws+UY40pY0p+g
	pS+6alfM61RG8Gu0jpo21dgUFikecYewteh0nv6ij7xxKov0qgTExLywG43qM6m9Bml/hapAen2U9
	LbGMb7hKZGTlrVmi3o7ruIrH1zyA5cflxs9Ou72A5rsjc8pOVJPdfUuZQMa2zetyWunVg/7Gfducv
	d9/zcrNIV08bHVmkvEEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt0Oj-0006su-6F; Mon, 11 Feb 2019 01:28:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt0Og-0006sT-3R
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 01:28:35 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8F2692146F;
 Mon, 11 Feb 2019 01:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549848513;
 bh=ABbaA4b1OHcRTZAiAWye1+OtqQl1kXjSNZ/o4Rnkxtc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1x1QifAp5Nf2uIWjnDlvbXnhqztUfKLaRxonV8GnyQOOS2GkgDZBSYSPvsNd+IUBo
 wuGadKHN+x2ppOyLG2kzFBlSl59VTxqo1Yfw4RH3CTIMdcklnU9V+g8EuAKhyI/SZk
 Vui5fd+pJ2bC6p9bCmQv8o4vkVhtDJ1fp5bbAhzw=
Date: Mon, 11 Feb 2019 09:28:23 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Enable SIOX bus
Message-ID: <20190211012821.GB21496@dragon>
References: <20190111164936.7152-1-u.kleine-koenig@pengutronix.de>
 <20190111164936.7152-2-u.kleine-koenig@pengutronix.de>
 <20190114014034.GF15371@dragon>
 <20190205061746.2feq4h3sflpk3qoa@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205061746.2feq4h3sflpk3qoa@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_172834_158662_E615CD69 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Gavin Schenk <g.schenk@eckelmann.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 07:17:46AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Shawn,
> =

> On Mon, Jan 14, 2019 at 09:40:35AM +0800, Shawn Guo wrote:
> > On Fri, Jan 11, 2019 at 05:49:36PM +0100, Uwe Kleine-K=F6nig wrote:
> > > Now that there is a board making use of this bus is available
> > > enable the siox code to increase compile coverage.
> > > =

> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > =

> > Applied, thanks.
> =

> As you dropped patch 1 the commit log of this patch is wrong. There is
> no board that makes use of siox without the first patch. If you consider
> it important enough to care, we can reword to:
> =

> 	To increase compile coverage enable SIOX bus which is used on a
> 	not-yet-mainlined i.MX6 machine.

Okay, I dropped this one from my tree.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
