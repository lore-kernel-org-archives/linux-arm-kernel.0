Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1849AC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:12:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7332148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bjAXzvvR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjRaJwBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7332148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XYe5BPTd7oISpLQn0PjAAHM/Lqbo4o25EkYGnbcyVJM=; b=bjAXzvvREQJB9/
	s932g9/SpokqoheYTbcTRSkpQ/9YEIma/146zf8Kz+8zV+qxRpjTluc7so00Ve3KZyAwY6fN0jiAk
	h4+jWGe+wvIcQFsalg2zMzgMepZgPZ4hwM0mYEKRzdCHXVKJWt/WnQ2BD27hAIYQIvpiuhr7DeNVU
	i2rCTl8DBKy11cx4+1bJn4Bh6OcF9xchep4h68/xpkqu0hcSELup4QfIsSKxjv27EDrBjrW+Qmabk
	Wzrj0rPcy/dAO3Lnc52TRlp9sllw8s8mAkOdoKc/5DUoqV2lCKous792VwD7nvOKo2eFYi3Ez5EV3
	TAKjTNTvBhvoU9FygE7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5ln-0007FN-0k; Mon, 28 Jan 2019 12:12:07 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5lk-0007Ek-2r
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 12:12:05 +0000
Received: by mail-oi1-x243.google.com with SMTP id v6so12829266oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 04:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qFPDL98Wv0w+yOSf8HBr3978/aDzAtgUlWT3/qy+Jao=;
 b=EjRaJwBBKZJd351B5ZdKqFeUSDRztcHzfg0aKMnLMAmYWNNtZXUUtid0yf4JVskaRN
 En5wMSZVSBnWRTW3huQzcxb+KTbPIDS/9k1HEFtTt3xq7gJHBGEyx8FYG68M9MvAi7sU
 9i+OSMumVlJ0IT2+PCAYM1QfWI0Kvv4ZQe2YNpuyzM0PPWZO5G6snZGnOplQfQ1vPOCc
 yXAwXOKDaa6vE9M5o3mPKmv3jQNQ2fHuw3dn/5vX5Hr4wTxuzJUIEq+tmtAuUWt+p5se
 ZfvTL4yo9XW+wh0CH3G+WNZBVqliCKoQ+kBSerUJ4FVxF5rhxPwASSLzaKCpJnXx770S
 2/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qFPDL98Wv0w+yOSf8HBr3978/aDzAtgUlWT3/qy+Jao=;
 b=EJGl4IsXCqFf+jeS3V9BSrZLbigLEi3KOjD0t3S6dwk7wq9WUnwVXiKDiB3XLXKexR
 GlOopSkgVZ50surDrKEk08EACCB07PcQyYeCWeyYCo+/cf8D77oyO5q/VlQiNukQUeP1
 jz6/bxyCM/cPZVvrtKEVaOD/3oH1rpESYBNt73QljHrgU67oxKVdGKR9DFelKYW1qvrk
 YDrw2Sz0kAsF7T4Ke9Fm2G94jnJYau5cQU7t6bsLp7QRsXGztpFzvIfju5UhGez2qRNA
 lOizrG+mHJpDEFWkB5VXFXUBMLgfVvF8v13EMQ/V7gvAHr7vCI8hUFs9aEE+ELHQWQ0N
 eawA==
X-Gm-Message-State: AHQUAuYlROUZyRAAugwm+u77TpDem29uUceO5tHK+1X+TT97oO/Ktj1K
 ojZrma6dXj0ajragbWfmjoJhrvbEAas7evroUpw=
X-Google-Smtp-Source: AHgI3IaLeUwun8CEla30zRE2XWYK4XcjO/BoGZQRk0kcA/Ahl8cpU/TBCiIhsMsEl/b/160KG+gYfqvhZWALDkcYdB0=
X-Received: by 2002:a05:6808:296:: with SMTP id
 z22mr6074747oic.67.1548677522897; 
 Mon, 28 Jan 2019 04:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20190128095212.14681-1-ccaione@baylibre.com>
 <20190128095212.14681-3-ccaione@baylibre.com>
In-Reply-To: <20190128095212.14681-3-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Jan 2019 10:11:56 -0200
Message-ID: <CAOMZO5B1M9VPB=yXhyKDA8diXo7YuAusTa=uY1Uv6E+hWDqQHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mq-evk: Add fsl,
 magic-packet property
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_041204_119981_9694D340 
X-CRM114-Status: UNSURE (   7.17  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 7:53 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> Add the fsl,magic-packet property in the fec nome.

s/nome/node/

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
