Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746CBC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:19:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3920920821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kQ0na/MU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opTfF3Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3920920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H/RTCb7+6SQYVX7LjvbfH8+gCZDBHbVCZfKlb7cVsrQ=; b=kQ0na/MUIQEsiz
	jrg7+SRS6f9TBu59/OpxFmJ1KIhdc/igGQj5MxSxH4lIWpDCrbd8FxtItcv16A23e/eY22o3u8gBg
	8GWGOWzDOwa2+kG2H7eB9KLAvrhbCbC4HouS+lRaL/uQZAdaIfLE8m6tROv52+JEGkkjSQ9IxIFwE
	5EX/R0Nla5nOrgiL++6Zd7oEoqIecYdCDYYMaDgHgHfpHVE5FQQpaE4T+xGbzj++bZAHBsXx1HXPq
	sw03XjF12gjHkgt3Vq0PxB80PO6ChLJLdLRUL+jkPwy4GE4xigPKPoOcOYvK4ZTnqM1eCyDsV0oGv
	a2g738csKEIph1W6fU5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grPul-0003xf-Eh; Wed, 06 Feb 2019 16:19:07 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grPui-0003xL-Rk
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 16:19:06 +0000
Received: by mail-ot1-x343.google.com with SMTP id e12so12833968otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J/MlNxx7onIZae2ADdXPAvQIq+0yU2SszK3ycIbelSI=;
 b=opTfF3YqCIJtLnZaWTsRyPT2D2Yt59weq7FyLW+uOUbOVBzx+5rGh+h1JEpkVtZbEd
 bMlotVbwxCia+irCJtIOVvzqSBDnW8oX3L7Z/8XYFimIdOhoAQzPFepxKi/3bl0dfRXt
 pT/8CZLbgSPLi5LiQ3JKDvldaxh4UImdiSqqPU0G7JvW+GDPkXJzx4cREcQ1xHW/TJBK
 bup3cQj20WpqXZ0npkW0OQ+IHZYrZEiKZ5+ACJYHxffx/nS60RSL2FlgMnqJGPnuwe+k
 q9uckukStCIYyCPf1/ta1R72nWFPUnGa+spDfVGpu8pdpviJ0gRCuetviXW+Yn/4g3bE
 JtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J/MlNxx7onIZae2ADdXPAvQIq+0yU2SszK3ycIbelSI=;
 b=HTa0w8pl0s1dhkeTYtBvL3qdo49A3Yyv5ZiHMXIpJ6WGyEbTIYu7Na9r/50HhaNW5T
 XZVrW2zVhRcqfcTu8rpCD7SGShJFG+m3KW9ZCv+j9cQyebnXZMbKJjqNq6m1B1q9Ond2
 YUIRvXz+fQqzmxyYeGkm7dzIkoSicQ5fMVtR9XyTtfuyVlO6Kmb37xXm6rH5jRRqg30f
 uLHKTA0+5MaMAe9ohspm/WoXCxvUTcC28VmvSecXs8qNP77RZNFyQ3zD4d5ZUi9swAY+
 l3HwlxFXPdaAz8a2C41oeUPxa2/xSqVTwqdi06ccJ9eBtl3LxaOEPVu5EETSKJziJojF
 7+tw==
X-Gm-Message-State: AHQUAubf15Opv3vJC+GHufz4rGWES+E0Ky/+OKKhLKd9aek3aHi+kORq
 5TVCCVieGsVAa9Gp1lAs8AmOQ770M5KyXWg0TDc=
X-Google-Smtp-Source: AHgI3IZTElTt8oH/6GLyIcFiV/aM5f6QT+iJsCwsfW/vwBs2sglXBOuMc5BzJG6dT3DC5UKQyQVJGFuOgLm/2AGquAM=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr6384616otq.255.1549469942486;
 Wed, 06 Feb 2019 08:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20190206143737.25368-1-ccaione@baylibre.com>
In-Reply-To: <20190206143737.25368-1-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 6 Feb 2019 14:18:49 -0200
Message-ID: <CAOMZO5BmgJ62U-u22RFqJkmBv3kW2=zocKi2663bk0doFE2dvA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Add IMX2+ watchdog
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_081904_920454_3A655B54 
X-CRM114-Status: UNSURE (   8.45  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 6, 2019 at 12:37 PM Carlo Caione <ccaione@baylibre.com> wrote:
>
> It's needed to properly reboot the i.MX8MQ EVK board.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
