Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB468C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:21:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89778218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lrgYTMb4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3pMYRmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89778218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nHZAb0Zsdh8E/ihnH0R0O/gh0v2S2FBw9oVMbtjAgfo=; b=lrgYTMb47KwFwH
	o/dFeHJQ5Vu1CrQIK8jFu341dB7QOzrJhHOJqu/ObDj7z4MMel8nxqMStBrBzfdM0/lFf9HbeC5ew
	j7XkFrTe25YPbGOxZ7/lPlhey31oepCmVZOcrRj6fi/0i1b5gd+5YVLvtGNqCQ8WlCSn1mt8tYnL4
	XVj9RD13Aa7jnJhoy+xIF4rAOuh7vxKYEhmcDBbkoyDERPVmWw/A75EE1O0vDUEuBHuX5VhN5IZIL
	tLwZwxhRjB3lIYTbhjR31dBXlCuke9zp8bbAas9p+ImtiEmG8Xsfg57zeEJs58hmVNGHF3UFiyXCX
	jPNheKC2WZM8KfDtIztA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmpFd-0008FC-Im; Fri, 25 Jan 2019 00:21:41 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmpFa-0008Ej-5h
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 00:21:39 +0000
Received: by mail-wm1-x344.google.com with SMTP id n190so5104282wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4rB9sUXPOkujSSjXj37blp6SmzJRoYTe2XJCSqdXnzE=;
 b=G3pMYRmyMisCgjAj/8Sr+3Onppmzxc9Syj5AbYode3BbpmSfbgoYzmU+K+vCijQEvR
 Hqgn/KwbWm3rafyqS2PbWnYgtnDRAsLeaG/md5fOlGLevSPEy2F4PmvcbQ+3Pn46x5df
 7nuehxljpJ8fivcN2r45jTEjfT38gIltEADEJe+nAbt+h2fR6087Xm9XVmzxKgVZEp66
 BG/YZxM3kbHhLKflrSNZ8VKBadOtx24mPGTvDewRTOuKO5hHs9OHH6T3gpo73D7S+37B
 lRN6B2ScdgrtAeghfnSz8gCjPoVR7TdF9WmSOHi3xHj+ijtJJU4HEghFzuVmCinzbrf4
 7mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4rB9sUXPOkujSSjXj37blp6SmzJRoYTe2XJCSqdXnzE=;
 b=XOam6xZaCrFTVksR2NVcriA/y9YM8cgZi4NOvzkW6ymbDofP8LaZXG+sNF6tuqztHN
 x05fZds3XCYaJZ3X/mwnCg2SJOrpL1cLd9d1URD4uIfH80cG53ioABZRr6oyyHVjoPB6
 JeYMwx6XS8/n/kte22ykZKfWo5+Hu+JRNRJqkHRH+3OKqeJDF65ZSKxkUjMraQtoWcH6
 ef8ZopMIhh1suJcEhQbQZZrJRPTkU/tqku0FbpehmKWiFxQNDKOeeP8POfAHnEn+T3iC
 F+ngPIFrbk/ApeHoa+f1LwjmMfkkCNgYccnkg/C+SDO6z847vniBc48kuAYeY0V60V2S
 EHPQ==
X-Gm-Message-State: AJcUuketaTi0RxALpXx0NQM4hEdiu9FFVf1+5SrngVC5cLDWmMzrTA97
 9kHpfSToLl8/WhEZvKLxKPqMBUEaOPaUVIggadU=
X-Google-Smtp-Source: ALg8bN6N77DYUVSRPlpBtPOH4st7qTSS19mu3vnh9AYae6Oq/4q3UvJLUKx3ZnTH4oxEYuWQOKlDHo+3DVW0XhtmB5Q=
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr4620332wmf.27.1548375695902; 
 Thu, 24 Jan 2019 16:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20190122021043.25449-1-andrew.smirnov@gmail.com>
 <20190122021043.25449-4-andrew.smirnov@gmail.com>
 <1548240560.3904.6.camel@pengutronix.de>
In-Reply-To: <1548240560.3904.6.camel@pengutronix.de>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 24 Jan 2019 16:21:24 -0800
Message-ID: <CAHQ1cqFx3b2fTy8YbpwC0fGJYpO4BLO4FW9q-Z2Np1tVktrKpg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
To: Philipp Zabel <p.zabel@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_162138_237483_9978D350 
X-CRM114-Status: GOOD (  11.99  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 2:49 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Andrey,
>
> On Mon, 2019-01-21 at 18:10 -0800, Andrey Smirnov wrote:
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
> [...]
> > +static int imx8mq_reset_assert(struct reset_controller_dev *rcdev,
> > +                          unsigned long id)
>                             ^
> > +{
> > +     return imx8mq_reset_set(rcdev, id, true);
> > +}
> > +
> > +static int imx8mq_reset_deassert(struct reset_controller_dev *rcdev,
> > +                            unsigned long id)
>                               ^
> > +{
> > +     return imx8mq_reset_set(rcdev, id, false);
> > +}
>
> Thank you, applied all three to reset/next with a small whitespace
> alignment fix.
>

Thanks again for applying this stuff. If that's not too much to ask,
would you mind creating an immutable branch, so I could start sending
patches that depend on "dt-bindings/reset/imx8mq-reset.h" to i.MX tree
without waiting for it to trickle down? If not, no worries, I'll wait.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
