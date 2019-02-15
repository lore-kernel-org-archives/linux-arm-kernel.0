Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8A0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:42:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980192192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WFmNz0w/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980192192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b6+f8EnGx3zaOQmwWQAFKrGfjAg7RYm0cDD/+OhqhMw=; b=WFmNz0w/EnkO0B
	HVUB7Tr2aQqMPWmXYpsGmW8hoNKouvRmaNDfCTLITfX/DgeCo+MD4Bu5iP2EZTVCu+VkZjMXQ8Pu6
	6kXq/+AMYn+G2LjGQ5dJWY4puY0suDu4xb5OPDril3T4YZ3+9o9hNvxFWn4Xo724dB8gA0xQIg7cC
	de8SKasG2t15a0esBlLN/2Y4n5+PcMBP+0pSWQOM2n2R0kaVhLvf5SO57YUH4XaRk/GH6Hw8rI5uY
	I+CQNpIdSo4e0gE2eCCcMNd9/C615NVNsIjdFluLzB2PCK4mGH6K8+0NRVBUvlhmrtidvAFCcZdlq
	+2Ddu8vv05e3iTnDxpnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugZR-0001TP-K8; Fri, 15 Feb 2019 16:42:37 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugZO-0001T2-5j
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:42:35 +0000
Received: by mail-qk1-f194.google.com with SMTP id r21so6029829qkl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wVjh0EAb2o+0rbDNo9FjplxF7Jzwp3fPtvcTRPNjtq8=;
 b=mFeKztFlAKANVxEjuGFnPrK+nBnidjnndRdWwIejAN3HmbP1wsVveI2d4lbzUc4Ang
 V95aXDkjDov2wXd7tm/86mhywoThE33HHqkQnnfExl78qnJ8DNt6xEtBL2bVL53eniXT
 JTgHZ0lux9cc0A5kc4Kd6WrK7RxfXdH3tB29tRn3kaAl6lpRILr3Kd1juilNC3zEqJfC
 AogU05JGBnwaokImfUzvzKWkTB9QOKkrswQE1LHSQGM9RNvN/PtlsSWl9KglqVdmyl23
 8AiA8oZ9OtVa7yOyxdeiJpXPdfGTZX7G6G1jxxiV0Kam9SFclAiM+ma5RSkL83HmBYEl
 HcOg==
X-Gm-Message-State: AHQUAuYYxpEUXHe+abgw+c5GhGeGScqsfcThLQS2CTuUYJry3E71KYxR
 8mDWCqPZ9Q8pa0fawFfrj5pt15vBdN10FNENiLE=
X-Google-Smtp-Source: AHgI3Iaba//6Q8Ch2yi4ilniW/RJqtNdGxxTCOIyTmGqM8mLge7coTgkFviQOLwqiTXtS8ByBUcPI58YkvnLuUHLVQw=
X-Received: by 2002:a37:d492:: with SMTP id s18mr7305736qks.343.1550248953239; 
 Fri, 15 Feb 2019 08:42:33 -0800 (PST)
MIME-Version: 1.0
References: <53340003-0b43-7b5c-9a24-5f2e4d8f8a3a@ti.com>
In-Reply-To: <53340003-0b43-7b5c-9a24-5f2e4d8f8a3a@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:42:16 +0100
Message-ID: <CAK8P3a0Y1CZHMt=NEcaXg+gk-q6yDX05DYS1DW=zOsbQvkGPZw@mail.gmail.com>
Subject: Re: [GIT PULL] DaVinci SoC updates for v5.1 (part 2)
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084234_225692_539E0EE1 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 ARM-SoC Maintainers <arm@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 11:40 AM Sekhar Nori <nsekhar@ti.com> wrote:
>
> The following changes since commit e430685f496928240a328708b976c17929541011:
>
>   ARM: davinci: mityomapl138: use device properties for at24 eeprom (2019-01-10 13:58:00 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v5.1/soc-part2
>
> for you to fetch changes up to 23fa70e40a42e8dfeac654b8cc0e5b463e54af25:
>
>   usb: ohci-da8xx: remove unused callbacks from platform data (2019-02-12 13:48:59 +0530)
>
> ----------------------------------------------------------------
> DaVinci SoC updates for v5.1 (part 2)
>
> This pull request contains changes needed to help get rid of
> hard-coded GPIO base value passed from DaVinci platform data.
>
> The OHCI related changes also help by moving over-current support
> from board-files to OHCI driver making future DT-coversion easy.
>
> The OHCI parts are acked by its maintainer.
>

Pulled into arm/soc, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
