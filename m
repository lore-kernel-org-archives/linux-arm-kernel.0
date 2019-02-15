Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC0DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:53:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673682192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EcL3ZNuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673682192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S70ho8ohLoCN2OfoE9oCvVtfXXE9tyxYkewuRwl8/yI=; b=EcL3ZNuHLvPxve
	DVcQhaL5xLCTt/Ie9PFH2F3woKciWMG/SvcU7+ZoIyfhcbvN0LhQAoiZKzE4KbBVEtsyRAifsCRzO
	BRTWa0WdBYo+WHa2sFyl3jIG/b1SlheFrJadt4H20GcF/kbNGPKRgzOjeKbC22cHaYYEiplZGDwt3
	Kk2z+eAJWE+Y2/YiWEmEFFK2lqK5OnZbqexLzweodejS/cc7h6OKwNudGiEzjsxan3FAxVou5N4vu
	Q7VQMgmAC1jFHsJ1S+Dk90tqNnZisiR+RrzwNe7T/BniQhtA6NHbSHP1+F00np6cP+MSjWHvVDksG
	F3aD1Bpoja2ICY8TfrzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guerH-00008c-EV; Fri, 15 Feb 2019 14:52:55 +0000
Received: from mail-qt1-f181.google.com ([209.85.160.181])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guerE-00008H-FY
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:52:53 +0000
Received: by mail-qt1-f181.google.com with SMTP id b8so11077162qtr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xOEfU/vecgmgsxfcgYEySDSwHKvdnVDMF3PpuFNdGak=;
 b=JN+EO17KkKeAjQ9bTI8GZd+2MFpVvENxXj8XneKBW9brDhN9+EnzPCi8HDHClm9/oQ
 2sdZujm3wxA/u5w1/fdEl2QRq5kYpFcrn6DR2H2gn8oVYo49fLXsKjTXEjQMF30nowz+
 3iY/47uBJnmXQnhmZDPPurQ+0bg52fvWlkmJheK7m9HCgX/6BBIaXhYuznLftgsNkMWQ
 Um0tOVLeZ7Hul9+Mxjunu3gS3RTyM2ddcgZn0Zblcbfzsc3k0UyW26S3JiwSL4LsTtWE
 7ZD+7pr8tqfxcl2bepExPAAtjG+luS34TCQbWw19aavh6KwhetDo+RCV2ZFEJ1UueKXZ
 6d9A==
X-Gm-Message-State: AHQUAuYq0JCGq9+ZWc7pPcuhQypBSq4pmkXjaM7UA7r1O6HAEfV9H6Pi
 G4MGEpdhSIC61eAKs3bOy0NKR/RihUsP753HDcs=
X-Google-Smtp-Source: AHgI3IY+Fs5b5iRT6CaZgQZw7jd4A4OXlKhTGyEL/buKL+MWp30iw0IoBnUY7KQovCOY9upNdd9YSW9LidgkDa6CVBE=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7709462qtb.319.1550242371353; 
 Fri, 15 Feb 2019 06:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-9-thierry.reding@gmail.com>
In-Reply-To: <20190208150935.32108-9-thierry.reding@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:52:34 +0100
Message-ID: <CAK8P3a314KvXsTLbKUwvRc08tQMfd_pjWDNBmce7Hq_t1vL+Cg@mail.gmail.com>
Subject: Re: [GIT PULL 8/9] arm64: tegra: Device tree changes for v5.1-rc1
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_065252_516945_13B192B6 
X-CRM114-Status: UNSURE (   8.39  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> arm64: tegra: Device tree changes for v5.1-rc1
>
> This contains a couple of fixes to existing device trees, enables CPU
> frequency scaling on various Tegra210 boards, enables the TCU as debug
> serial port on Jetson Xavier, adds various improvements for SDMMC on
> Tegra210, Tegra186 and Tegra194 boards and finally adds initial support
> for the NVIDIA Shield TV.


Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
