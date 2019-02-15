Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:43:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDF92192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V36FPvpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDF92192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IpbqRscScn/gqOa0RrCEIg90YC4hF8ByojN2RRL/O10=; b=V36FPvprwCIaxF
	oDRF3KNtcoJkAcHyGU81uzA6t86qNlPrKPEphqi4lH531j6J4mLoekXpdQF8UIRuSCX7a4N+3/FjQ
	dmHnt+uRCdDTNCQkqDHD6zVS9xjALkjWmU4ZaoreXiXT3U2ZOttCVpy9WBr7WuABt56tIWH/qsLOj
	2B9/6iA5e/D9KLne5euaNw6x5jz3ZznKrKDuS7HP3F3Ff8qiNxtHhnIg5yE4+9KDJY6RxLhqKSUSF
	g6RF9JQJqHewRkRf0uFY2+AnzQhJi/8iSui1IYPW26Kn7ajUXGaaYa3tc2p9r9huNTbWv317f29sm
	WMZSZKCxnI4I49nHf/0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugaH-0001oJ-Rf; Fri, 15 Feb 2019 16:43:29 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugaD-0001nU-Tp; Fri, 15 Feb 2019 16:43:27 +0000
Received: by mail-qt1-f193.google.com with SMTP id 2so11569675qtb.5;
 Fri, 15 Feb 2019 08:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RBqJ5IWUmwRJV/cvG5CH69c948r05XGEsJxT1osW13I=;
 b=tdogEs1yUvotrNRKCjYx9LJksG3iC2SGZjMXIsYzMWT7CuDs1VPWYF9RAPCe9cUrB4
 K0CoY9VHOta+gTlixlYj3/HGP5AMkYVMOaBwLiNe0AU/WHeOCzC7Q1GU7zpCNk2Hs3n2
 l1jT6iE5ByoPFsjJkM+iEJyxMSXU92KCmmictpmWSk+0VLYblIRlV6k6CPAnPx+Ctytc
 KfGYCcTiQoUu9lEoqlI7far5ycQ5r6uIhKo6KXmhGIbbN2XiQGO41e2g5OXzvkTpLqRo
 kOiiLLqcxVFrNQgzZdwLoHvSWNs85/k7h24IvasJ/tGF+vXuIy4jmJvwC4VjNrTeNOnO
 VeEw==
X-Gm-Message-State: AHQUAuZyNLye9xl0oyOAYGUot6nochUF/liAp4geVrLr1vWe1LBbFSUM
 dblNtP+060x0T6sJTZIcb7dMoqk0aZSS9JoM2MQ=
X-Google-Smtp-Source: AHgI3IYc2CMiWrAhVQrzmOrpxjcJftsP9f60xTpYJ9oC8fiLQtFKj9mnuQYonPDRj0yX/NDuIHrvYOfSHeGW/jmcjfY=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr8148123qtl.343.1550249003569; 
 Fri, 15 Feb 2019 08:43:23 -0800 (PST)
MIME-Version: 1.0
References: <7hftsudp9j.fsf@baylibre.com>
In-Reply-To: <7hftsudp9j.fsf@baylibre.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:43:07 +0100
Message-ID: <CAK8P3a3szjhUZKX9BGHa0jNFWbYt=N2DXPwBF3cOs-rP4PO7wQ@mail.gmail.com>
Subject: Re: [GIT PULL] Amlogic SoC Kconfig updates for v5.1
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084325_958954_9944C35C 
X-CRM114-Status: UNSURE (   9.01  )
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
Cc: "open list:ARM/Amlogic Meson SoC support"
 <linux-amlogic@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 9:49 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-soc
>
> for you to fetch changes up to b3077ffcfa24b05c05af3b990d97a392ef88b22e:
>
>   arm64: meson: enable g12a clock controller (2019-02-08 09:30:25 -0800)
>
> ----------------------------------------------------------------
> Amlogic SoC Kconfig updates for v5.1:
> - arm64: meson: enable g12a clock controller
> - drop unneeded COMMON_CLK_AMLOGIC

Pulled into arm/soc, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
