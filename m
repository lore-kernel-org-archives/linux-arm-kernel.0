Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D277C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CAD0222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ojfxqZvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAD0222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sqL2xHiKKPhz0xua1BHiFSQwDNTL+eI9PZfJx06mObQ=; b=ojfxqZvXc/x3/o
	KH0flApJ3m4kCEpROuDdyPDuxogF4n3iOFyWliijG48MtOKTpOnuAKaiFdF4sciEanghZCu7vhAP4
	ZyBJHVRkkDJGjsi4Uv36Pfl5mInPpp+9/WeGIkWnAkTcXAbiYoHQP/QDFgVRVO96RwRXIGy2/qfrJ
	1RUOw6B5v1B4cCpH7YeIOTv2vksfSAtqwRfIylomw+G/Ulz63HrWJQ1QCPbsQSuXotvT/uFDcIQEy
	yr3wz+T8E7SQyO50iEHOYm1GynSlf12j2ku4RPABRoQ0C7quuykF8Ze+gX9U8c2Umlo+Bb4KCIA6c
	EaudEQ4p2vDh4anZ/rwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugsB-0002pE-LT; Fri, 15 Feb 2019 17:01:59 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugs8-0002oT-Tv
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:01:58 +0000
Received: by mail-qk1-f194.google.com with SMTP id x6so6094537qki.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 09:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d4gAd08wOsXQrZ9OvoS8VQeefIqyEOS+mJjDr7SN3gk=;
 b=cjCHMGOKaPXA4Pv7QAqwPbqXQU2r0/+a2c9krHU6yEQDflsySKaZl7ZWWs9XAD9RrR
 gR+eM5ouO/dkm9xGEEU3u/wiwmFGA/3gHD6Fb3+yFTnuUCe53kj1+NZzh0zOhOb4cp/2
 6oRkkKRgApJ30Sqqcnay3l2UeF2xYmqf94GXMrzkJeB/J5vlh5VOJ7JtrYz8fD7WF9aY
 wkvyApUwWao8q4VMlAkmzXwxH7S/tsornXqHWNhMEzqBI7WnadqCsZ/k1o0cktDJ9Z2r
 kfPc0GaQwGbrhjd2OC26HpAeiKb/uDNLxsNpMmcDy5Ovdp6Az76d9TRaHsDC4LvhQSg9
 vO0g==
X-Gm-Message-State: AHQUAuaYYeyLqrLBcls0KupB8Rp+A3NbOU4uBiHRFpUjzhz1sa8hIW6B
 P8Gz+7U0esAdwALNJOJLYjzeJ0GdpyWiwnlVV6I=
X-Google-Smtp-Source: AHgI3IYZI+gde6ffO3ZFrKXlq4Ihb0V5LyR1p7rojW/wqOS4MZ0/K+KlIVMHW6LQlXU2wIP6BwVG6DWdWYGfFE9lx5g=
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr7782510qki.291.1550250112070; 
 Fri, 15 Feb 2019 09:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20190202172237.11147-1-f.fainelli@gmail.com>
 <20190202172237.11147-4-f.fainelli@gmail.com>
In-Reply-To: <20190202172237.11147-4-f.fainelli@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 18:01:35 +0100
Message-ID: <CAK8P3a1P1ZmZWJQcc1_OnSqettXkXhV6W6tOdZ855P9nnRB5sA@mail.gmail.com>
Subject: Re: [GIT PULL 4/4] Broadcom drivers changes for 5.1
To: Florian Fainelli <f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_090156_964035_4CE49385 
X-CRM114-Status: GOOD (  17.20  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>,
 Scott Branden <scott.branden@broadcom.com>, Kevin Hilman <khilman@kernel.org>,
 Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
 arm-soc <arm@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Olof Johansson <olof@lixom.net>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 2, 2019 at 6:22 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-5.1/drivers
>
> for you to fetch changes up to 50de64947f40f869dc5b9306891b750f317135ef:
>
>   Merge tag 'tags/bcm2835-drivers-next-2019-02-01' into drivers/next (2019-02-01 11:29:21 -0800)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM/ARM64/MIPS based SoCs changes
> for 5.1, please pull the following:
>
> - Stefan updates the BCM2835 SoC driver with downstream properties and
>   uses that to implement a reboot notifier to tell the VC4 firmware when
>   Linux on the ARM CPU is rebooting
>
> - Eric adds a proper power domain driver for the BCM283x SoCs and
>   updates a bunch of drivers to have a better and clearer Device Tree
>   definition to support power domains/breaking up of functionality. This
>   requires converting the existing watchdog driver into a MFD and then
>   breaking up the functionality into separate drivers and finally
>   updating the DTS files to leverage the power domains information.
>
> - Wei provides a fix for making a symbol static

Pulled into arm/drivers, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
