Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA85C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:40:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18AA62173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PleV6lNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AA62173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a9MyZ53m7bFtcs766+OsYqCReAqns1QeFBdy1X0cSfU=; b=PleV6lNlgqlf4L
	emE+7lr91/6gyIAPR0Q7FbgMjljK0Cl2ox4ZeOxtaM8Mv5z2Da714AiOzGc3SIr76a1+DIPWIrZl4
	b17h+5+UPMuL0fvuYE4sfwHB5hvkGq5+ho/uRypH9YRDTe3x08L68Dn32wrP29ntf/BGPLlKrxABo
	8pyIF9djlIPvYU5cdRfH3Zt3Y6IJXw66GYGcIph+X5Y3tqtPimSLIEwpZ5YaQRHV2fyNJNu1pwQDT
	4eWaYKr0ic34bA3d7hjDEVttog6Sspc2Tcoz+LtgfXNCyDmSMSm2+9ASTbSQKHCbd9QsHTX60qpiH
	uMkf57qpZcFP8+XdI4Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgLd-00033y-R0; Mon, 18 Feb 2019 10:40:29 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgLa-00033I-1G
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:40:28 +0000
Received: by mail-vs1-f68.google.com with SMTP id b20so9338436vsl.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 02:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sg95qEAEiZV7zSnEbBDMhaa4KPf0tdb8zbEhyX+Hsqk=;
 b=kel+r1ozY641ZBINFkYJpMcKgPQFGzs1jcOUtQnUwifskgEUlJhaNFYkSHflxk4/G/
 Tr3AY/VVA+XrL7sT3w3EuYtIKw5emMTHOIlHEYtmNlYJhC10XrBOVQMWkBzrR8raCzX9
 LUdF8CDOuIA8CasTuDO1m5QjkX8RKAL8+XODuQoxWfqCASDn585q/+TVXod97yXteSJX
 Of3kceY+u1q3puvb34XGbHCZGhJL2Cvyk0SPEegieqoa4qp2SX9raWKSycEZgQrSPXsc
 T/36gTXXlryL1Wf+PWx7xQ94Les16qyIE4vXNrg9LaofMhsEZ4EbE0CqSW4d0B6s4BHg
 YG2g==
X-Gm-Message-State: AHQUAuYjvRRHPBjtqPed2KP2eq0f+OSECAStPxMTAysuXos5mMO7eCi7
 kHaad+49mbLMNLRLCtzKYpYmGHhyyj+Ee8wQuow=
X-Google-Smtp-Source: AHgI3Ib/GZWZBo6DTp/AJsHCUmzUT2Yg78zWsYQKrzQ+GJz1vrLZ+P84m8x369n0r1YBE290uGGDq0Mi0deiVTVSG1Y=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr4261160vsp.166.1550486424200; 
 Mon, 18 Feb 2019 02:40:24 -0800 (PST)
MIME-Version: 1.0
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1550484960-2392-1-git-send-email-krzk@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 Feb 2019 11:40:12 +0100
Message-ID: <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
Subject: Re: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on
 setting driver_override
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_024026_353450_0C453DF3 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: David Brown <david.brown@linaro.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 linux-samsung-soc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Russell King <linux@armlinux.org.uk>, linux-spi <linux-spi@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
 Tomasz Figa <tomasz.figa@gmail.com>, linux-clk <linux-clk@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Krzysztof,

On Mon, Feb 18, 2019 at 11:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The problem
> ===========
> Several device types (platform, amba, spi etc.) provide a driver_override
> field.  On sysfs store or during device removal, they kfree() the
> existing value.
>
> However the users are unaware of this and set the driver_override like:
>
>         pdev->driver_override = "exynos5-subcmu";
>
> which obviously leads to error.

IMHO driver_override is not meant to be set by a driver, only from userspace,
for binding the device to vfio (is there another use case?).

>   clk: samsung: exynos5: Fix kfree() of const memory on setting
>     driver_override
>   slimbus: ngd: Fix kfree() of const memory on setting driver_override

I see all users set override immediately after allocating a platform device.
Can't they just allocate a platform device using the override name instead?
What am I missing?

Thanks!

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
