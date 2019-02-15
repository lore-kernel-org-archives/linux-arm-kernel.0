Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2264C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:53:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE672146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QRI/AmgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE672146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PbmXY3obh0gQL3FKbgmpU5n1WGjJsU2YPzFjJwp13fA=; b=QRI/AmgLfxFZyF
	5hwltRvLKGeEnz2sFnRIzSCTxoxxIWKgx+xlnIv6FBvKVd+qVEE5jc3tnnsA4cE8idN4jUZ6jAzhD
	Gu6CXqwTlBZHzqx45deBpOrpzeGqd3tUFuv4H0HC6p6Ak2ToeHBK+oTLBF3B45I0dglMmrsTyI40W
	9Qk08ElcRctAWK5WxsNrsyJ/lgaBe58EGQL1dje9NnJVitt6yQuz7UZHr3HozhQT7kT25nProNM59
	oXMTHLPBrGLwTpiOufJgAk3vOmYIjU3LgDczMsgYtRoBbGhCijh97v2FvKrkf4r0Yfqddsr3eIbzj
	n6IMcJ8vuz9hjZFqlNfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugk7-0006zi-B4; Fri, 15 Feb 2019 16:53:39 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugk4-0006zL-3K
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:53:37 +0000
Received: by mail-qt1-f195.google.com with SMTP id y20so11524153qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c4Bc20h888PBV8TfGq4n9osloADn0UmPwX3rzXTMSnQ=;
 b=mZ3ni/Yg+QqwNa/1Kg+o2XIcIXE3EfQjSyRUUv63HMsIqtX2MeEjuk6ocGlAt4rVD9
 2BCkYSbLEmTf1V09PWWum0tm6oXD64GBOKttU+Zf3Ak5Z4Fc91VNKP/JI6tiwPHzdVdV
 OUwOuLEGlFBUGJh3T0tKqjlqWPBfEa4lB5sF8MFREPkEBB0mq4WmJo2JI265edue3d3T
 nSVBhl1mtewBEO6/SjXborELSt7dc3BJiz5T45wMUdAyOFzhnEJxZteAuCGOqh+X4IF0
 5tik2V0qirlh/QUvZf5Xz9GIS/Yof53st6xB6fO0LqUvLDpkQ/3bYzwc0XiBh+EpZHzm
 8iYA==
X-Gm-Message-State: AHQUAua8qVaebu1DcZ9SV+samOLChd580sU4W7BQQN8ILI0wkObVIBDL
 Bk7VRbuYumPNfnxzOsFvlkb4yrJjG9l5hzD4Qkw=
X-Google-Smtp-Source: AHgI3IaGVzOfaikRgDDEFqMmEmKlFJZhtklEHj944cj+VUJmqpO/T68R4Lx/+43fGm2cp0FhWuH45yboDJ1MdqA5YRo=
X-Received: by 2002:a0c:c60f:: with SMTP id v15mr7888354qvi.40.1550249614725; 
 Fri, 15 Feb 2019 08:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20190203212936.17053-1-vz@mleia.com>
 <20190203212936.17053-3-vz@mleia.com>
In-Reply-To: <20190203212936.17053-3-vz@mleia.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:53:18 +0100
Message-ID: <CAK8P3a0hO+u_pONptqjCFbiFXw9kM=JHiwixQDsM6mH271R2QQ@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] ARM: lpc32xx: NXP LPC32xx platform changes for 5.1
To: Vladimir Zapolskiy <vz@mleia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_085336_140130_36885145 
X-CRM114-Status: GOOD (  11.53  )
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
Cc: Kevin Hilman <khilman@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, arm-soc <arm@kernel.org>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 10:29 PM Vladimir Zapolskiy <vz@mleia.com> wrote:

>
> ----------------------------------------------------------------
> ARM: lpc32xx: platform updates for v5.1
>
> Here are the changes for ARM NXP LPC32xx platform files:
>
> * removed a superfluous record to kernel log buffer under OOM condition,
> * use kmemdup() helper instead of kmalloc()/memcpy() pair,
> * removed platform data of ARM PL180 SD/MMC and ARM PL111 LCD controllers,
>   since now both are handled in devicetree files.

Nice code reduction for phy32xx!

I wonder if we ever go the pl08x DT support to the state of removing that
as well, I think Linus Walleij also looked into this in the past, but we still
seem to have this on spear, s3c64xx along with lpc32xx.

Pulled into arm/soc, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
