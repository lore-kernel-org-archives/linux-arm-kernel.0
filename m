Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBF921924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s4emh1kF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBF921924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DkWb4H04xCy38dEnt8nZjWpMKQYWU3IeXUXzfu1eYiA=; b=s4emh1kFAyA3UQ
	7HpDu61S7cDE7F7AoDMX5UewcAipjqSFcq9hDq9YOPMPs+4l9WPAdEv6C7CHBIQOiBIIcmGHwW0Aj
	+lS5wYtjfTaEs6QoV+WbxxXaKibJL5+xoXUkghH2O+ByTvLP0HDztq7dQba80hg+WlXP7uj+qJtvt
	U8p7PJk6MDkDhlW+nLkVPloqlDJM7kJmBRZrFm8hbISEB6qBwML8hLT9+enMZexhkSJRd2NDdeYpQ
	exkATjivEdrPMd8+UwLbG4G3cwtD567h4qF4Wk3M4YVSGrAyw451ceTqsElrdKO5xL90RVi28HeeH
	C/gjjckjEvFubuiDkGRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufX8-00057F-4K; Fri, 15 Feb 2019 15:36:10 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufWz-00056Y-Bm
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:36:07 +0000
Received: by mail-qk1-f194.google.com with SMTP id u188so5898596qkh.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rz0OjfHBarvD2PNI74KMI1aetYjLgVDg10C9/+Y9a0Y=;
 b=jNx7cM6Tv5elL3xRCwUHNLjhqIVWVV8saym25JdKvzR7xY3MIoNp2rLeXWEXEIxjNN
 XJMDrDDTczinS9c01LiLXHkYLYK+ORCL4Cy9bZ37Ohy+PIULk3agxhIj+WGBrdFHDR3V
 xwSwJPCcO4PruR3vTR32MOTRIGus3myoXUB1UFldp3pxQhlevVvIChZosH4lN4UpZNiy
 rzapOwpfRKLjZRDfsKkGbn+Wkv8nJZdy/uFIPDhU5VM9dnW0fVm1R9qicIHeCoX5XtNQ
 f6VUR+2To3skL4h52l1ZcYYk6rgcD3gYecASKk4kCyjBX3j5I9IGw7Lcss1sPpV64NQ1
 UdqQ==
X-Gm-Message-State: AHQUAub7jOiKhUhAjIRdILfXQ+LKwewJyV18dMJ4yqNtnLEr5SmQeiYa
 LfPRRbdO/LEmMXSmnUczsi7BUhSOxYOnbj21NtM=
X-Google-Smtp-Source: AHgI3IZju+w6Cnsguljg/WextdJ6M1aT6VdDaoLpQnYihxvqpGYAi9/t4gNRMEl2tK3h8mvfBjrWGPe8pVxPu5HEN78=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr7107627qkf.107.1550244960477; 
 Fri, 15 Feb 2019 07:36:00 -0800 (PST)
MIME-Version: 1.0
References: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
 <CAK8P3a1K+oUTrq903=8zfguJRXCQDvaXLT+TY-u6P8Obpr3myw@mail.gmail.com>
In-Reply-To: <CAK8P3a1K+oUTrq903=8zfguJRXCQDvaXLT+TY-u6P8Obpr3myw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:35:43 +0100
Message-ID: <CAK8P3a1opCPaXD=8NwR6ZdJUHAKTC+0iOJTuq7g33J-=ryWUuw@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 5.1
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_073601_449125_1C9A9091 
X-CRM114-Status: GOOD (  11.16  )
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
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 arm-soc <arm@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 3:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 4, 2019 at 5:31 AM Andy Gross <andy.gross@linaro.org> wrote:
> > ----------------------------------------------------------------
> > Qualcomm ARM64 Updates for v5.1
> >
> > * Add MSM8998 RPMCC, I2C, and USB related nodes
> > * Add MSM8996 rpmpd node
> > * Fix typo in MSM8996 pin definitions
> > * Disable MSM8996 VFE smmu to fix security violation
> > * Add I2C, SPI, rpmcc, uart, and WCN3990 wlan nodes on QCS404
> > * Enable SDCC1 HS400 support on QCS404
> > * Add a multitude of nodes on SDM845:
> >   SD, UFS, USB, LPASS, SCM, QSPI, PDC, DPU, videocc, GPU, RPMh
> >   bus interconnect, WCN3990 WLAN
> > * Add gpio ranges to SDM845 TLMM
> > * Fix regulator load on sdcard on MSM8998-mtp board
>
>
> Pulled into arm/dt, thanks!

I took it out again after running into build breakage:

In file included from ../arch/arm64/boot/dts/qcom/sdm845-mtp.dts:12:
../arch/arm64/boot/dts/qcom/sdm845.dtsi:16:10: fatal error:
dt-bindings/power/qcom-rpmpd.h: No such file or directory
 #include <dt-bindings/power/qcom-rpmpd.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
scripts/Makefile.lib:297: recipe for target
'arch/arm64/boot/dts/qcom/sdm845-mtp.dtb' failed

Please fix and resend.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
