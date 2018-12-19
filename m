Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A56C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:08:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D0A218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z45wD5Xa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2hyBUv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D0A218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y4tUPzN4NMzIWDcDiXxXBu3hOotNKdESYivvEs1IUXI=; b=Z45wD5Xa7UT9mW
	/pKrhAkRI36dtPgcHr5E2SKaNkTNvA8x+aJRDXxlhPN5wXdtKsAG7EyxDzgAZW2WTqWoQRkQYPMwG
	6zLK1vdicEhZXBTfE6fKYLgvnVS70yyUDb51flqK/Yr9kKPhskBrtv7KyhgPxBFhszfTeCfPIFisZ
	9JNtmsuU36UU9xfqP/WodyrZqude5sJmPhrny4NC0jygiyaOkZUDjNetNekwjK4iAh6uof/nSvx+e
	+GrOi2qLytgwL81YIq4iV0QZl7WVyFE88Hem6rS5Hjsun+2g+bxxTiqdDRcXAjuyMoh3KQ9orUHFB
	WfcdOq0btrWsPPMXwpnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZfKU-000445-3W; Wed, 19 Dec 2018 17:08:18 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZfKQ-00043T-OZ
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 17:08:16 +0000
Received: by mail-oi1-x244.google.com with SMTP id y23so2202039oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 09:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n7rvSbhIF9NmOeNnYFxhPiV5rJQG6Q6/tL23qLEIa18=;
 b=T2hyBUv41S6gI5ZffsUY/u6A28XCQZ3+rOoTMfS683aXsU8Cw840AxZmOqO9J20hNH
 eTprTFkjsfUefMOQOlzNwNCJSQ4JT8Cc++mxtkBOWsQzrZVCTx89OBsHYZJnhNpFhDje
 +TeRD3v4vYnTSiL2yt0mv1C5Tpo+Ge22dlm8/u708t6k6zLizFmGAkGLVmCQJ8Na0DTa
 To9HgyWYaNSDMBucH/yL/Kwo6+VTF7luMrMqkAJLRYwA/0UzxapqrKFkMO7ZEt3aRufw
 vndIwmnCti+3waSI1VmsSSGDXn3Z9/eUHEpMlwJDt60HXFbKXa0hXMes9DkQGceG3cP4
 xCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n7rvSbhIF9NmOeNnYFxhPiV5rJQG6Q6/tL23qLEIa18=;
 b=PxtKrRGGczbiRMD6mCuVSjhBt7Tw+brKk4esewZR1zKNxcUdEkO+kaKealWa+pfurD
 1VT7ZhRvbWRCVeKnDxL/PCJsYpAdzxRd904QeMru9IoVKoYv0XEb9Z8+exy56z+iH8qq
 +aDCurgiI3nKbZw8MGOl4sDCAnLOwvFUl609HtUdj6AmTJEXhSS/Nb9mV76w4Gx2oSLB
 0Gxa5r5hVoLECfoJfKfwBMfMCa5QpFqUmOqo1gSeacukHaoY7Yu74F5c/WPIYHTu3EDf
 0oJeUq44Su1t8q7544VFhu8BMpcKEObQchUFz32sgONgzmHZpuS6FrSUPdLWCaXzYQa+
 KGOA==
X-Gm-Message-State: AA+aEWaU2hYn7e/noWC/zWVjNGtBhNOpgbg9F9Xqmcy/z6yJ4tNjNk2Q
 Dqx+iMH9+83BXQLtnqW9UPwr0lXN2k93fIqVw9s=
X-Google-Smtp-Source: AFSGD/XcUJUC1nsVuwWF/6wLjKv/TuSaM0/fCtxDnFWKaqNQvidFqDe2KVbZekRickJ2Jj6FqvZwsubKsgUhL0xvWxE=
X-Received: by 2002:aca:ab53:: with SMTP id u80mr1662728oie.261.1545239283507; 
 Wed, 19 Dec 2018 09:08:03 -0800 (PST)
MIME-Version: 1.0
References: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
 <1545232888-9302-5-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545232888-9302-5-git-send-email-aisheng.dong@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Dec 2018 15:07:59 -0200
Message-ID: <CAOMZO5DzMpMp-Tf74iM3SuHoFpji8z-dxM-UsC13GeDx2bZYgA@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: imx8qxp: make the name of clock ID generic
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_090814_825929_7C4990AF 
X-CRM114-Status: GOOD (  13.87  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Aisheng,

On Wed, Dec 19, 2018 at 1:29 PM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
> Let's make the name of clock ID generic to allow other SoCs to reuse
> the common part.
>
> This patch only changes the clock id name and file name, so no
> functional change.
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8qxp-lpcg.c        | 146 +++++++--------
>  drivers/clk/imx/clk-imx8qxp.c             | 152 ++++++++--------
>  include/dt-bindings/clock/imx8-clock.h    | 289 ++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/imx8qxp-clock.h | 289 ------------------------------
>  4 files changed, 438 insertions(+), 438 deletions(-)

This seems like unneeded churn. Just keep the existing naming and
other SoCs can reuse it without problem.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
