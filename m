Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536E8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:15:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214A021773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="meHoRCQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214A021773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3aH1QoBgIyfiAcbqdkxeyLQuA/pGfAPAJwZz0EB46uo=; b=meHoRCQ7oxtMCF
	7cKjvu2U1LvVVDMnipnUQS3TFhlGHhYdrxsVLD+a6gCYPhzcmclUunGR+eMmB/5/UU7D+2/iopwfK
	6eqSqPkuRNkPh3DuR/b+v8RtJ2RoqAmjHBQEh+oTAuD8XWmK7GdJYSaS8+mOfT9VnqVbLjQd+0h4p
	T0Ek0QHdBLxtXcVgw8O8n6t6COxH7pL+qRQKE3u4csQLwMbAw380Xz2SbNq+fuswroHixWTg8C5nd
	sL2545/Ok1L4NHtST9DyxFTK/pFcXqJ8Yos+pksKayIdlBtWI4cuoemCbSHhz5tDuLC5/+zFVZ31q
	tegRALNw1uhnhMx6a3+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhpn-00038D-9N; Mon, 18 Feb 2019 12:15:43 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhpk-00037s-Tv
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:15:42 +0000
Received: by mail-qt1-f193.google.com with SMTP id n32so18813554qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 04:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KxG0a3/6eq8D7gGuNRV0Sr562TfMLTabfemllJBULjw=;
 b=rkDBR5jxbPFzE0uaLIwZTrRhsf1+J4TBvf79PhaqATntDp4BOssfFUeV3UHK9/Rw/e
 /hwT3UZjmNkfnLMESHoUXgkjXe7Iv9bRcfE/ek39Gt62xMo0KCMZgem8VGSCw+zTipk5
 +u1j6iEPq0LRLF1Z7CjOcixjQWECec+6A+JsdY665J2qs0hd+Pg2sGwi8ImzxGlZyzZE
 ZbTfLJiE9QsDUq4tfnBDrTlGzJySdtSk6hq829Tdcut50W4u1pbY9Bd2Opsb4KnhgQSn
 e93kzKUZJfLt4Wmqapfc85nxbHVusoyfU0DgvOQTwVeohYvnavAwfqAxOvsjYRtpRgw4
 3+dw==
X-Gm-Message-State: AHQUAubf+4L7pbOWI8QleL5R05EeKTU5HC6PCQl2RNECbBJdm6+EenTi
 r2D4IOzYnQBup/uNpt5t+Sw+a4a/F7DF4cXTDoxAWg==
X-Google-Smtp-Source: AHgI3Ib5sKA34QROB7/6HzwhSfKuCZIlz1qW1sEMrI2L7nY/UpeCSWSsY3EuQQoBe4kDAFkAMp2QdRFu7udzQjuqgu4=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr3788997qtb.343.1550492139241; 
 Mon, 18 Feb 2019 04:15:39 -0800 (PST)
MIME-Version: 1.0
References: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 13:15:22 +0100
Message-ID: <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] ARM: milbeaut: Add basic support for Milbeaut
 m10v SoC
To: Sugaya Taichi <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_041540_966848_17CA86C0 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 1:26 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:

> +static int m10v_pm_enter(suspend_state_t state)
> +{
> +       switch (state) {
> +       case PM_SUSPEND_STANDBY:
> +               pr_err("STANDBY\n");
> +               asm("wfi");
> +               break;
> +       case PM_SUSPEND_MEM:
> +               pr_err("SUSPEND\n");
> +               cpu_pm_enter();
> +               cpu_suspend(0, m10v_die);
> +               cpu_pm_exit();
> +               break;
> +       }
> +       return 0;
> +}

It looks like you left the pr_err() messages from bringup, they should probably
be removed now.

> +static int __init m10v_pm_init(void)
> +{
> +       suspend_set_ops(&m10v_pm_ops);
> +
> +       return 0;
> +}
> +late_initcall(m10v_pm_init);

This requires a check to ensure you are actually on the right platform,
otherwise you break suspend/resume in a multiplatform kernel running
on anything other than milbeaut.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
