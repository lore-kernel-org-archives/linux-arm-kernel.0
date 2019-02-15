Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EE9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33022146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fKZtjiN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33022146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fI6MVqi2uIRwnttz/8HSWBaDv8x5q/dwey9mmrzjH60=; b=fKZtjiN8p8+ZkD
	VxzxKECO6DioB/nO3WqCpWqtVz7tFQPkPwRJFiVJUbFCBXUS+qiGYCK9GuLk6fr0X55U+LWE+JQpl
	qp5oWiQ8z9jO+9QuNEahY77hptBfwCH7aOHmc2cvZZW2CdCPJps7eGNyo3OWhxraEHSUqeEBtYDep
	qp8ZOrPYH1iOMYj1GdPSuweUADVuJjsK6u4VMP6NfalCqe5IEFE6C5Lu+UXSkPnpnH1o1qYUxDSIt
	SmSKXCq+pgQTgXjWQXaI+YU48LSzxfo85CbfCuMSnHPAwKegqK8F+lOtTdYd72iqSouiLqvjzKNLf
	ERTscFESHTeCkfztIYJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guggU-0005JI-3g; Fri, 15 Feb 2019 16:49:54 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guggQ-0005Iv-Hf
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:49:52 +0000
Received: by mail-qt1-f195.google.com with SMTP id p25so11310767qtb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=umXdk4llB4ngUI3cuju1TS9i8jo7BkhbigS9c4y94uk=;
 b=tYAxtCiVyry5dY8Ma6UNYyvJikHHJ1CMiF7nXScqW+dfWE3Fe3faD3pf+f9I3d6Ypq
 cym6S2rESUfnerqsqHtB1Db0mg7HADrVL7+gzh1XUCO7BPEINdsQCscWKEaqYFyvajXf
 NoV59t1VzHONBF7pWEeCXLrwGmiJh65esPIHVrlHzWQ9tFQraVtPff2KUr420f0TUhrE
 xWZbtEeWoari0z5zg2ebSsxYDB9ulyBAbVQTV1MvTF/7QzkgXqSndafkLt+L6fwtx/Hn
 v9eMLk1elmkhKGt4iH+iVHHoLNLYW+VSac3zc6DlIXKMnvZb1923ARUQ3jYfLwUtBPih
 neSQ==
X-Gm-Message-State: AHQUAubgz1aeBUzmL7XdjGLWzx0oy+6JXhppZ0ZzyDbxEQRYketg9AKy
 9Wepy87apX82anx0At7Wbe/TvPTzwVi6BzM1Zk4=
X-Google-Smtp-Source: AHgI3IZfYEDuSR2GuxCjF7nP/5SpEuXy7+iXx+NC/hbkgzObPy43O1wsWcQKzVCggdVSCOeOK1IsgpHTHYpydirn3xU=
X-Received: by 2002:a0c:d791:: with SMTP id z17mr7816725qvi.149.1550249389280; 
 Fri, 15 Feb 2019 08:49:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549622472.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1549622472.git.horms+renesas@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:49:32 +0100
Message-ID: <CAK8P3a0prd-4eyVOVUpp2Bhn1mGOVZwA_we79TNjSa4FF5DP6A@mail.gmail.com>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Updates for v5.1
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084950_587196_C6E566D7 
X-CRM114-Status: GOOD (  13.73  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 12:14 PM Simon Horman <horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC updates for v5.1.
>
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-soc-for-v5.1
>
> for you to fetch changes up to 5347a0203709d5039a74d7c94e23519eee478094:
>
>   ARM: shmobile: Fix R-Car Gen2 regulator quirk (2019-01-07 13:24:07 +0100)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v5.1
>
> * Correct shared IRQ handling of R-Car Gen2 Regulator quirk
> * Add missing dts files to MAINTAINERS

Should the bugfix be marked Cc:stable and and Fixes:... ?

Pulled into arm/soc, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
