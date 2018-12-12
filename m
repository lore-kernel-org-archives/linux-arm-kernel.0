Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E3C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:35:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304822081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fonvs2h0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSVrndYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304822081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ldsumzQ3d2n11aeCQSFcCv+il9p8g4SM7TBVEkttNag=; b=Fonvs2h0+oNDTv
	+9+Kjgz/jz0OpkenRwERQ8soQMSrbEuiTrySpBDEXqh5ubV/6O/KfsqdIiFY9NQ+mQ42eLTptsvHB
	NhKAuHQXW7W9Xnp+ZuX1bnrv4Lby/Kz+JrUKuZgdIWyBz0cW7B9PHNLji6UVAkQEWDnTBN/vv7CRE
	MwL6xnQ2Zm3pNDn3YE8rJVkTT0VoiRaGzxtFS2+pv5/Eh3Ek1u1VV7VCpTxJBlctFgWhsttrB5Z8G
	MLDkHWf/v3d1rsbbKu2wrNgiyREOPyFN1RAd1EBO50SQ4ZFkjFQx/B186vmOs/B0xFzNhiFaX2Rg7
	pKNldvx6IWP/uNsH532w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWtR9-0002fZ-7r; Wed, 12 Dec 2018 01:35:43 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWtR5-0002eg-Kz
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 01:35:41 +0000
Received: by mail-wm1-x344.google.com with SMTP id q26so4184123wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 17:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H5H2li2R33XJbbHxFVIsAyEewkATsOICi72EGgRBsYQ=;
 b=SSVrndYywnMGlAXVieSYSU+A8j8iZ3hz5hHMOj+B/TGgrBg0vKFNfkjvCmu30aZd9m
 qkmcDOmqETvbMkDrz0WcRBOwfQKUkMnNA+V2ZXuKLhUUgkktkM7JmbHHyidadJcQQh4L
 qNjzOTJTmFa6k0AGVnBeAyyynKgISeGhxxi0hg6uJ209Lw7oL45FcQW4vVQSoN6aLYQb
 HULLPfkSG0KEv5fidCxDAW8EqAGsOoDjYvF6wtlz4hB+eUaEdKB3obzdCdd0wMvDnS/6
 eIE7dcrc1Z7kUSEnYS4/WbrKdVxY/4xh0o7SQiHrmx/M/0o4fPXNIHlUPfC/CT4jDoy0
 6E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H5H2li2R33XJbbHxFVIsAyEewkATsOICi72EGgRBsYQ=;
 b=FwkxxcRAghX9jTj0jbYG5JJLtCOkHPtQYWb6LdX6H78FyVTiNgGS0Agz8gxhLwjAq7
 7JdmtGCohOqpcA9BE5lC1sv2/CIFUF2pn9unTWzj0kS/W1u6lnmPYgFwwNN2t2RG5jIP
 QMDrpGPk7GbkNY/lOfjpISnFwKyiY8E8Ny9cjU400yFVLzIt9eyDbDJiRAI7ZgRC97gm
 szK/qSZCggivvBDT2LkgZgG86/DjxMcAaKPulln8B5CKyYzEKZptCJ4s0yjO3fJj62wi
 BagcA4+AcM+Mv+dRvw0CcLl9SSsqyOh0LJz3OvrfxeQRfgG2sedt78o0GthEdiXYi1f6
 gdxw==
X-Gm-Message-State: AA+aEWZ8Gvqffr25fF2vXUVKgV50UPjEnGrf7j2w1mJhLWEJo7jg2TeN
 VWwVsbBRaMB4PDWIp4mc/OXiKie29cotD73qXEQ=
X-Google-Smtp-Source: AFSGD/W74rsJvZY1ubJdvL4SrrI/hfGyehCLgnE/Flyr9XpWUQn93AieMwHbY+HrIth4afV7U64VTLySqYzpGPMOGXA=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr86449wmf.127.1544578527719;
 Tue, 11 Dec 2018 17:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20181128043738.12714-1-andrew.smirnov@gmail.com>
 <20181128043738.12714-3-andrew.smirnov@gmail.com>
 <20181211224349.GA30397@bogus>
In-Reply-To: <20181211224349.GA30397@bogus>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 11 Dec 2018 17:35:15 -0800
Message-ID: <CAHQ1cqHH5Vef1e7bXBXWQdSzmAOpwj1vdyG-t83PkRyLifVFuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_173539_695998_8699028E 
X-CRM114-Status: GOOD (  11.91  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-imx@nxp.com,
 Philipp Zabel <p.zabel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 2:43 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 27, 2018 at 08:37:37PM -0800, Andrey Smirnov wrote:
> > Add bits and pieces needed to support IP block variant found on
> > i.MX8MQ SoCs.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/reset/Kconfig                    |   2 +-
> >  drivers/reset/reset-imx7.c               | 106 +++++++++++++++++++++++
> >  include/dt-bindings/reset/imx8mq-reset.h |  64 ++++++++++++++
>
> This goes in the binding patch.

OK, I was following the precedent of the original submission:

https://lore.kernel.org/linux-arm-kernel/20170227205408.ajeu3stjpl45dnqf@rob-hp-laptop/

Will split and submit v3.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
