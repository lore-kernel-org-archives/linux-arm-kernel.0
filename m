Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E845C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:06:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08A521924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s5ThXUzi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8TexAzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08A521924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SXl4RFYwX/J+E2yeQHYgnCG3TbWbsIT8EG96WqwflZA=; b=s5ThXUziYAYSZU
	xwOHuUh0RCdhbXJDtBi1j10OBmW4rYkO4QYBK6CjjcB8NN/fsyngTUUN1ompqoCvg8UfAvrh2wnxq
	Js2eigTv2yIy0pf9Yyiw1OaPyprUP42vlovOlNms6TjBCC+kJ2zzN1vG+AXMOCBjc59ihE63j6DZm
	UkVmCszycLmKi6qKY4OAkuc883wVf9i6765uVG0k7usfrcycMQPW1xG+CVXmE3NgeV1VFqE5+O9DM
	I8TevHHXlWuEDshxDy+nOe4Ix4uYhFrNb07HMqZXY7gQhF20cwV9WPl0PTXrZQe1xKLUNejgB/Sqa
	lhq8vb4l5QYVjaWgXxTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugwf-0000dT-6S; Fri, 15 Feb 2019 17:06:37 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guguD-00052I-Hi
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:04:33 +0000
Received: by mail-ot1-x32a.google.com with SMTP id m1so17669755otf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 09:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=miXbWaIU8wPDDx7VC54CvAbAwSoi+OILVSoIzKHrgws=;
 b=a8TexAznKAxPgFB7TuDLpaA+/I3cIjyD4GayNNU/3hPWV2MVmtasOjgf7GTWtbSGk1
 bHvFBrYLkqY/zLD5T+YqTTSYKVfOKA21/V8RBIE3T9csPVjHVH2xepJUssi2OJzwMie0
 JQ8aO8UDP5zABk1jLCpFB8WkWVom+fnKsN2SHyUT0Y057aZ/Hl0gAS7ktitAzu+dPY3j
 zDx4uvAtk3ESmbSvpLBv15+SwtFSLyWpbPNdc+HrLycmDSWARyUUDVq2Rt39TajIlPYc
 aX8FFGYHDNG2nCRMKB+iGPdOmagOxhOlSBlC2WE6Vblj/NdJ6RkLuNk4GItFF+VW2e2H
 0myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=miXbWaIU8wPDDx7VC54CvAbAwSoi+OILVSoIzKHrgws=;
 b=aRe4u4u2xAs0WgJeed7fKHYoDQ+goatRoSQ72/VnRtvg+pm+ZofgmRR9tiTltPtL5p
 vA1OOapySxbYseWOv/7r8ACzGs3ccQQfgMU7wsA/XlrgTmtPbazYgk9REQjUDP2JvSXb
 FCwAIlG9BFrsuvQQE0QijtyoHu9hQS1mWRJ87xwi4CgoqBZlasBYBT3dsEQT8TlMoTTq
 AtEAOgsl2X6EfbWG5YK3bPHkReB7ZgZa/ZnCv2JYPHXwBU0xFU40smMjkNvxsCM3ygr7
 sW1nIgysMRvRWZt/zo9sH0wKGcMitH9wxfFI4VIzj2U72chs8NLo/sfMCVRT1kp7rjI2
 GMcw==
X-Gm-Message-State: AHQUAuZneZS5mAawv161AQTWRAYhvLTUZHPWZ/jdso3BcTXXcTHI5D2B
 /DzCFniV/5Cn6wbJEivUxSxfIBTYWy7zU2ZQiXk=
X-Google-Smtp-Source: AHgI3IZiEIH4dU6pM263D3B2ykM3dQLtA7ExPj6lBD5oN2PFcV5hpZRXexr+DOoTNKwSVU78TEMyAfTnl33eqigTTbw=
X-Received: by 2002:a54:4e11:: with SMTP id a17mr6500113oiy.75.1550250243998; 
 Fri, 15 Feb 2019 09:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20190212112126.572-1-shawnguo@kernel.org>
 <20190212112126.572-7-shawnguo@kernel.org>
 <CAK8P3a149udLq=Auz48=+0-i3m_iMvPbB=nBMFtR7xDU12PO7g@mail.gmail.com>
In-Reply-To: <CAK8P3a149udLq=Auz48=+0-i3m_iMvPbB=nBMFtR7xDU12PO7g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Feb 2019 15:03:52 -0200
Message-ID: <CAOMZO5ACSgGFxmQazL+=xJyTbdy+qYSmc8girab4oykUPd9AVw@mail.gmail.com>
Subject: Re: [GIT PULL 7/7] i.MX MAINTAINERS update for 5.1
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_090405_899884_BB680646 
X-CRM114-Status: UNSURE (   9.27  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On Fri, Feb 15, 2019 at 2:39 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Pulled into arm/soc, thanks!
>
> I briefly considered adding it to the 5.0-fixes branch instead, as we often
> do for MAINTAINERS updates, but it sounds like Fabio's old address
> is still able to receive email and he just prefers the new one, so I assume
> there is no rush here.

That's correct: the email change can go to 5.1. No need to rush.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
