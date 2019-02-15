Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBE3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:12:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095C42190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TgynmaRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095C42190C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5rh+v6VYW8wo2pnyhDBLkQXMlctaitoY632k5Gum9Vg=; b=TgynmaROROm12x
	gW/CA9H7wF5++/7Xx/DV/FGZZXNRVw3OI5A7NmY5uKSw+UFLT8GgZuYJfqKtAV1WJiy0ZKdfnECKw
	5cLf2c/afk3feqYCnRFD0HGe2Zlbnu3SIvI1byXbmGorPphu4eOYriylYMQKMRDkVQrb+9okjKMtt
	rJTXt2FsmAcaAyvMBWQ+yMX3wBYBNpLEJJYM3eNrl5Arzau/gxzVZo2uanpFsybNnenQ5MX+ENbzc
	R/bX3ifX/IrKoYr64QSWGGU7NqzxPjyecatxjDnGj9lTF3NbMyQJ/kSS5n9JLzJQkFqA/VH5tB6tr
	88CNvlseZh9TlsTiXWxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guh2R-0003Cp-W3; Fri, 15 Feb 2019 17:12:35 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guh2P-0003CW-0P
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:12:34 +0000
Received: by mail-qt1-f193.google.com with SMTP id y20so11604406qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 09:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Svl3Tf9cObv8pydT4/WakO/aDbHRdoKj3PqdhyfbYGU=;
 b=Q3DFqLrcOxrFKa3wa4meIAgqMXxRamt6S1Z1IAla0k7HN0YZdPMdqvDGMne0aNsk4T
 KiklsCNI1cVMjEamIJghJew/jsegN/Cdfv/LnqoliNdPX0sycI1nf4eF6OX6IRIl7ee7
 LCffuG97eYw/QiDGmOtCMT/6uBDAA9eWx8cNVbFh7z3/omzjuB3PaV9affxvkeVOMHM+
 zgHZMWYDiXXHvLeNKvuwLq2wztvKWKGGsff1tK9TBQzw3EUlTQ8KPglJ8sPQSvWnb7/x
 4DxDBOwqi5sW1wJqFOwpYVV3dcFXKiRZyF4KxmqFwBE9b4wQ+PenZKQyPNVfchxbzGrJ
 lf/A==
X-Gm-Message-State: AHQUAuZi9M4J3+aIw6RnGHmMXHpRq2AO2bTR7Fm7T9NclcafaTf+7DhL
 iYaqHdSf70/6G9sT6RT1hXpN1thnYU85E//8KncgjA==
X-Google-Smtp-Source: AHgI3IZ3ekvKVp7uj1qdXqjaqiw4YlShO+su8TIDT3SlVgfe0Gzi48kq2iu7SgPaEJoFdl+85ioc1TUqZKQfkVyjqlU=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr8056138qtm.96.1550250751927;
 Fri, 15 Feb 2019 09:12:31 -0800 (PST)
MIME-Version: 1.0
References: <pull-1550167274-497763@atomide.com>
In-Reply-To: <pull-1550167274-497763@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 18:12:15 +0100
Message-ID: <CAK8P3a0+jV9Vp-wYOCLQ0jVMSDJb+sZdY8t5W2t8bLjO2zkEWw@mail.gmail.com>
Subject: Re: [GIT PULL] Fix omap4 and later lost cpu1 interrupts for periodic
 timer
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_091233_047795_883A7116 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 7:01 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit dc30e70391376ba3987aeb856ae6d9c0706534f1:
>
>   ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized (2019-01-29 08:54:22 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc5
>
> for you to fetch changes up to 50d6b3cf9403879911e06d69c7ef41e43f8f7b4b:
>
>   ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug (2019-02-07 07:48:22 -0800)
>
> ----------------------------------------------------------------
> Fix omap4 and later lost cpu1 interrupts for periodic timer
>
> A fix from Russell that took a while to get applied into fixes as
> I thought Russell is merging this one.

Pulled into arm/fixes, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
