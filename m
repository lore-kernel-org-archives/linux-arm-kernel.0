Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FADC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:19:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A421320892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q6kL7wco";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBALWxGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A421320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RX5UT9DUcMwN4FNe+glCkC8bV5Xo+AgbuR1XeZlLFBk=; b=q6kL7wco3+zE92
	9Ahe7GCv71guYvFP8nw6vkPCwPekgkIyGJfgp6ITKnhgntX7yHo6ofJNdxmgeupabHVYu8A+Rf+dx
	GmTU/E9RuGh53iX9t89HnRS7R2dfj6ra1tEu+iNN8P2PSvmf2k2PM+cAAK0wFh/jTR3z3Nk3Ruc4E
	G2S0G2EfiGVbtGp5Dk7LyqA04zKIQvaOe70O5f9ggKfO/Yk8f5i6E9XDtGbOA1102iyJeNRt4+8rG
	tlqIg7ppctW+fz+7S6Y09cKzi7vP6A/NXFYPc5hVE9zYLD367X6KoYYMocYBCoxi+oWkvp4DLZnFp
	bfd8rtBDKoFUExQ6wBqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGyA-0002Ei-RJ; Fri, 07 Dec 2018 14:19:06 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGx6-00014V-AX
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:18:14 +0000
Received: by mail-ed1-x533.google.com with SMTP id x30so3848634edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OGXuJ3+WVgETvhVR2LIWTZYv5XoC8VnWdbD6If/Xo0U=;
 b=BBALWxGrY/5IilPi0HT29rdP70iExZ2rCucAXI7hs3ShF59klyD+xRrdByAhHsCztG
 XBGpkDedcmRqoY5BMB9gRb//3LZCd6N0ccNa9x6qLX0tZzj5dhsA4NXEnPZVuLYVtWla
 Dmy6PRnujXjrRG/DhsCoHujnP9/ryfowor9rVM5JVEu56aTeIEoV8kj/aFnFOHnWinr8
 mIFYamfZN5eGJh8/CaUb7DYeNRTrvj8ZngpZIV16esKdS/o20VIn5QYVLV+pMId1IFNs
 +93jMXz153zlQf0jX5TvwwNge8XR4PBpgkM+gVixorS+5oLhh0lalGR2Vk519Ofb9c5m
 AuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OGXuJ3+WVgETvhVR2LIWTZYv5XoC8VnWdbD6If/Xo0U=;
 b=QBijQbA2a1qsJaCZYdPEyIgbutHzoSXak0V4M6AhFHMt53LpYnpBSPPWtWgd7i0R7e
 dDMwY8OWgfP1RYCmumr+s4CLcSI/vXclqw6+tjQzFxtpiwq75z1imwHqOJxPd5F0s4f7
 0CkNDVNEYT/ttXSJpzLIiTsCKQzlZhVYqbT+lOjHlIvdi3yE+MR1PGCLCcm0pQLAVW1d
 H4J/6AmKQAWB6jSmVK4ZMGrastXuQVTb+fQ9JNIU5MgnIQzYmJJ1BZTCSvyTx/leBDgn
 QjxfpM7Mmo96qAjpEQZNFNysy8rfior35jyWS/PirLo6h7uFUyU/Rs3WQaB3+TpriU1v
 +kCQ==
X-Gm-Message-State: AA+aEWZU4UWkBLiJowf2Cq7Cb5pm/c0AyiuZk5juNgfuoUqv8pxpXlJU
 esyplJqFjkoovk/Mu+xEzeg=
X-Google-Smtp-Source: AFSGD/WMTAqlkCwUiPe8gZA9dNelBhWisTy8KVzHCVtOHbudPYFbI/X8ojcNvab8DKIIVSDK49vc6g==
X-Received: by 2002:a17:906:6c97:: with SMTP id
 s23-v6mr2030979ejr.79.1544192267556; 
 Fri, 07 Dec 2018 06:17:47 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id n22-v6sm565040ejk.75.2018.12.07.06.17.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 06:17:46 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 5/6] ARM: tegra: Device tree changes for v4.21-rc1
Date: Fri,  7 Dec 2018 15:17:38 +0100
Message-Id: <20181207141739.9085-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207141739.9085-1-thierry.reding@gmail.com>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_061800_762149_EC0B0EB9 
X-CRM114-Status: GOOD (  11.89  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-arm-dt

for you to fetch changes up to 3dde5a2342cd204df15b6b0b90ee0ed4542225ca:

  ARM: tegra: Add VIC on Tegra124 (2018-11-29 17:07:31 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.21-rc1

These changes add the external memory controller on Tegra20 as well as
the VIC on Tegra124.

----------------------------------------------------------------
Dmitry Osipenko (2):
      ARM: dts: tegra20: Add interrupt entry to External Memory Controller
      ARM: dts: tegra20: Add clock entry to External Memory Controller

Thierry Reding (1):
      ARM: tegra: Add VIC on Tegra124

 arch/arm/boot/dts/tegra124.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/tegra20.dtsi  |  2 ++
 2 files changed, 14 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
