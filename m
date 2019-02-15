Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79186C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:51:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2252192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uVl4NatI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2252192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7GrkRrX6OPS/ASlTn4VkuPkJ3YLzCTQitUOdJaf4DXA=; b=uVl4NatIjwpdr8
	wWr/74QKR439GEmWMf3UZcHAi5MquqmY1j83uTrL9Wonb/sVJ6fcf2vbM/uBnAj/3fZV/yh6m0g5r
	FqQn69X9Nw+4HgSHOiu8FEU8+lNan3l7qu0bmt3kADg7f/5I3/vMnzimFGeWP/+u8jYA5z+VU8O9G
	yKW+ZP+99evWVj7aoIqsUA1NgY0KXe/cdGM7Vw9EZLn5a9jTq4IHrfpZuKhiMx05s8NEMsfielKbJ
	pkOb/j9ZfICx1WTNDF8RBMDi8DnsV/A0l7GkFhPfJ3Uv92xn75Ybl8YwrkgN99qMX57xkx9iNRurX
	LDrZnD6Wm13sOiPKbR7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guflv-0005Oa-2Y; Fri, 15 Feb 2019 15:51:27 +0000
Received: from mail-qt1-f175.google.com ([209.85.160.175])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guflq-0005OB-IC
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:51:25 +0000
Received: by mail-qt1-f175.google.com with SMTP id b8so11309134qtr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A0ncvAvs0CopAEtFBxtYq1Wuv6rxjnhVhXjZh7nwbog=;
 b=dttih4TxlVQjUh+lSCsZjCukelLkno7iHFsUwYZoWrP0ICvSa4fgsIqt/ilJnTbwna
 IHCOmW1M6My5U61f0UfSsZvBOsLGRhvJlyljbyrc+rkmCwi+HPbzgx+y7KANmKTgAPpv
 wbhQbwh+TUq52p3I88MJyF/PENv4jXAINswerHjp8HXNMdNzSKo54wrfO1RpJmSRksuW
 W6YnawTkTFV2rAq5s0cCnjnzmsJNZ0afxNR2l7Eno4GfKIXrOpkJarlPpiJ6YigKfZAo
 eRcuxt9GfF6jrz/RvO0Qk4kKY0WHqLR3Nxt8dr/UyOmGa1Dxr1dvjbU1m7t/fu1ESDmk
 Hr6A==
X-Gm-Message-State: AHQUAubZ3V/oRO0XswMhec/Qz5ga+v2IjuktWTWUzKwnRgOiVhCSIOPd
 xZKdTZn7sfPU+3bBovMXDvUZXGj2M8KQsbGKS84=
X-Google-Smtp-Source: AHgI3IbXcWmxobt6d+bj6oxqQphA3P6rtMtvx8tc/IQPbo8UnJTzxAKeSWx6xoLd/ZAG65MHWtrXnaaEJRrBdHUc9Aw=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7951945qtl.343.1550245881500; 
 Fri, 15 Feb 2019 07:51:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549622798.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1549622798.git.horms+renesas@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:51:04 +0100
Message-ID: <CAK8P3a12JVQX4EktSQDvC35_2=JHKQ5fW0ne9zpATGANRBmRDA@mail.gmail.com>
Subject: Re: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v5.1
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075124_237526_8D2AA15F 
X-CRM114-Status: UNSURE (   8.24  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 12:13 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> Renesas ARM64 Based SoC Defconfig Updates for v5.1
>
> Enable:
> * PCM3168A support which is required for audio on Kingfisher daughterboards
> * R-Car thermal support
> * Gen3 PCIe PHY support

Pulled into arm/defconfig, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
