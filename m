Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28B2C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C822083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B27o3qD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C822083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Bc5Od1NDveGWHrA1fBQpPYWFyuPMJQNhTEP28ldyas=; b=B27o3qD6Z/6Mmj
	HH58c5X5HBa4dmvGlidN9MFd4tipjXmIvHIDgMZVf2lAin389XYBz0rS5x3UrjXKc1OHhUG8LboJj
	plR5fwbGrRWqFnh/O5EH3G0Jw3Fls0HxeefW2uoMxe1goFZghRIRtNFwe0ZydjDRmWtaU3CoNyilR
	6xS7Py7zdKhCUtYuq2aiUHmx+SA66P1ADdV7wgDZKYqG5tPN0Nw3iQezqTU7FVagB0iQmZDtj9ZsB
	/e3ZrVv1TS19mfWuAazmoEtKBp0vzhN6jK/22KUlrTCMytoMt4ST/Ln11+6xwRd1H6qYc45nOUVSn
	5DtQdCDKv6CQAFq/Sytg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqvnQ-0005eu-9y; Tue, 05 Feb 2019 08:09:32 +0000
Received: from mail-ua1-f68.google.com ([209.85.222.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqvnN-0005eX-AI
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 08:09:30 +0000
Received: by mail-ua1-f68.google.com with SMTP id v24so829418uap.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 00:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4f0mxm4pSfyynVg3Goy8qkhLVS9QN/bqzJBvFBfgEcY=;
 b=Y9CKnsY4KGt/zLCGKnPINwrEgkgGVJHuuFhhcSO9tKCuSDS2BpLlbNkAsied9/khZH
 2vXEW2ahjEzkKB8mKB7lhqoq89Gup4e38P97CNtnK0bBId5k9m53/5dRCW7VXmQkbEOQ
 YEIbsDldDx8C0upyGbpUUGus8ta6vxuGaNfr8t7GxEYTG0GcYloYczaubZmca2WIuvaw
 AWkN0nMYEq19n8IaPOlmEGTze8nYNmvITGChdEA40wzLgVk6f8GYzYDr7EMbxOdnLSLk
 2HcbAmLRRllDn/lPntAD13ozPIRjAEJ8jv2duhaPMuYjnG+uFV38zh3WfjBDsM6B94wk
 2AMg==
X-Gm-Message-State: AHQUAubS2Z/BB864MvI57VB+nkCs/Vc0ypXD3pTwqIOpYxjGZBIkuCiC
 hO3KcV/ZKM22Ac1PntoNR9JYcFAwXRV6cAkbpbA=
X-Google-Smtp-Source: AHgI3Ia0bT7YAXn+IYW/x2UQQfwjuOSOmO6PWGZAMIo0Fb9bwf8Z/2c186Fh8+gWYagHGPaiad3Y0wLRA/+Yz/sFXag=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr1339032uad.78.1549354167812; 
 Tue, 05 Feb 2019 00:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20190204203747.7376-1-tony@atomide.com>
 <20190204203747.7376-2-tony@atomide.com>
In-Reply-To: <20190204203747.7376-2-tony@atomide.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Feb 2019 09:09:16 +0100
Message-ID: <CAMuHMdV68HxMzyMAgy6Cy_ECussJmpVTh5=vDAHwD8rA-BWsTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: Update for moved options
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_000929_353132_BF88AA87 
X-CRM114-Status: GOOD (  10.43  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Russell King <linux@armlinux.org.uk>, Olof Johansson <olof@lixom.net>,
 Simon Horman <horms+renesas@verge.net.au>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tony,

On Mon, Feb 4, 2019 at 9:37 PM Tony Lindgren <tony@atomide.com> wrote:
> These options have just moved around, let's update with make
> savedefconfig to make patching the file easier.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks, this matches similar changes to shmobile_defconfig in commit
4162325afd0d553c ("ARM: shmobile: defconfig: Refresh for v5.0-rc1")
in next.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
