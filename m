Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264ECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:44:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E5220823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z2QE5g6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E5220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QUgybpVylWA8jWGdLYnD8Ua+8KnID8SZotEdOijnPio=; b=Z2QE5g6owAjGEo
	68mdVCW2MYUM8568m1YYfxa16xrlOBOxpcL7HB4yc8hQ9cx05FifRxBM1OUvzfPL+dDJG40pIlrfw
	cS5G5uP7YsoSljTKrrK5jPMNsLhgPu7+k6hw7Lz6wkFuKuZom7NqBJqzcnXirAGHi+XWTUc5Ve8XS
	R6AAlEGwcYYyi1Zd9uty/VilP4+9VtGq0SvOYfLWOpDuCMH5lL/dj84dR1w//GfQ5tpqHY44n2zQ/
	UWTYJHPEHMj92uCouIv4CVgpNBEQaNCBOPvTh/buPDhYvO9//wVuLuAuHSSpdQWet/wsuyeVOYisK
	3qhRHrLjY06RXNs3xMig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqWc-00038f-KU; Thu, 21 Feb 2019 15:44:38 +0000
Received: from mail-ua1-f66.google.com ([209.85.222.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqWZ-000388-65
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:44:37 +0000
Received: by mail-ua1-f66.google.com with SMTP id j8so9622766uae.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6eMh2+4Dzu8fH8dTG8IuUcw3i7yHGPBUrizuhfdjbzM=;
 b=ToeC0JBL/MG8yMVvwRBt8m0Dqd1K9rC4U/4RmYgGY428KQ0aKi6sup6QGYKRSCpicW
 TunojHoq+4/HixVyOZrZPJmGU9HpjxcxEhxcH5LGZdIuemh60tKWfeFMMEH8lhS9WzTL
 xIMgdGdCJCEbgBS7nBndghV4lI2qjw5ZhUjuAwoaIFE3kKEjJSfFltiFK2AiOZe6ps6R
 nCxsUS6aNihzDUiTe5VckAm4rjBafz4JFnwujlYd6EekyXeBkmCmx2RL9PMfhzwaXbkE
 NlU9tYC3grpXfuS4c3Ffdu6ZDW5B6RB/lKElRAoxq9sCJn8CqpI+JvGaJxCb5pWpaqJM
 CiUQ==
X-Gm-Message-State: AHQUAuYFlDsUtcJE7Kmryf9v1Ba1GGNoDHMzFn/lV+/TKpITpDG5UWBV
 DpZ55ZX/bjRoDEABNkG6K8IarJJCTbawYrT6zbqdsjpk
X-Google-Smtp-Source: AHgI3IYHR/rvso6r8oBc1YsmiKIWozJLbR7EZ4EqqZKb7c/uuOjbi1ImhsdIK1jqouVkO8hMKu9y1o7UYKxdNt8694g=
X-Received: by 2002:a67:ead0:: with SMTP id s16mr17405341vso.63.1550763874055; 
 Thu, 21 Feb 2019 07:44:34 -0800 (PST)
MIME-Version: 1.0
References: <1550749552-8133-1-git-send-email-krzk@kernel.org>
 <1550749552-8133-3-git-send-email-krzk@kernel.org>
In-Reply-To: <1550749552-8133-3-git-send-email-krzk@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Feb 2019 16:44:22 +0100
Message-ID: <CAMuHMdUFvrW5RuhJxCoZdjzbYobJydcdTttkZTaRtL3=7Ao_Fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: samsung: exynos5: Fix kfree() of const memory
 on setting driver_override
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074435_229101_4E3E5679 
X-CRM114-Status: GOOD (  13.48  )
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
Cc: linux-samsung-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, stable <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 12:46 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Platform driver driver_override field should not be initialized from
> const memory because the core later kfree() it.  If driver_override is
> manually set later through sysfs, kfree() of old value leads to:
>
>     $ echo "new_value" > /sys/bus/platform/drivers/.../driver_override
>
>     kernel BUG at ../mm/slub.c:3960!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>     ...
>     (kfree) from [<c058e8c0>] (platform_set_driver_override+0x84/0xac)
>     (platform_set_driver_override) from [<c058e908>] (driver_override_store+0x20/0x34)
>     (driver_override_store) from [<c031f778>] (kernfs_fop_write+0x100/0x1dc)
>     (kernfs_fop_write) from [<c0296de8>] (__vfs_write+0x2c/0x17c)
>     (__vfs_write) from [<c02970c4>] (vfs_write+0xa4/0x188)
>     (vfs_write) from [<c02972e8>] (ksys_write+0x4c/0xac)
>     (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
>
> The clk-exynos5-subcmu driver uses override only for the purpose of
> creating meaningful names for children devices (matching names of power
> domains, e.g. DISP, MFC).  The driver_override was not developed for
> this purpose so just switch to default names of devices to fix the
> issue.
>
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
