Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99883C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6142E20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FEt2shsk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="mwsxmpAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6142E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ies1pClNqlrgSd9I6W/jKQzYm96gAaD5NMeL7KzvFYo=; b=FEt2shsk4MJBec
	DzOq2SbysLKuTC+8GpRQCYwAsVpJDrtqPoroFlKPaQmSPnLSFWfZY+m0xP36WT2zGE9BG+e56yymr
	4xyIdFdqRe9GhGPAUb8OekBaMjEFvo1mCbEjzAczj0a5DHpIl1hq/fDVEsM8RflPe0geiAufzalAR
	seKqkQtbvW90nZE5drnMgCv9bj2r+DNzB2v2eFF/hihZ5L+PVdVrDvnKiYiiMZ9opezan2+wBxhwi
	2M7ImMQ/aI3IiYNogA9uEWPiiOKtI8tovgpkyRjqsw3lkffh8sZFaJDMCGVQYgNEkiPICsZdByyGj
	8NVoFoTxKfDevprKL3qQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvcG-0003aQ-Dg; Mon, 03 Dec 2018 21:18:56 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvak-0001kx-0O
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:17:31 +0000
Received: by mail-lj1-x243.google.com with SMTP id e5-v6so12833053lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jt5E6vyvAz0mkZElHAmBOprTx14/WxW3bJXJB0UsKao=;
 b=mwsxmpAUCRITjMM0KVmfN0SHTA/q1CuVMMKOyxA6mB9K2WntCdrIbatHGtwlJZpDR3
 bQrZ8ReEEOmhR7B0+BrnG7dLvEYEy4Jzd4ILtCnbvQ1pnj//0r85qZaYjVT8zLxc4hLp
 wZpic3m/Ol0jGCnX3nNPLhSzelZ1Jr7TjnUaTK2OS0k5DPBWKVpcqHUzNq0IcKIg8vgm
 2pdD+nKz2afK8pb33W/+/Hhnv7NWiBmZxNhyScb03TSh/sPIYcFxqxIXevhwnzSAYUgX
 euZwG9tXO6TjrT8bDOU1VOJ1Cr9A+GnNAORA42QfzQ+DsIyVCql9rAfyYkbBoyb79gYz
 zIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jt5E6vyvAz0mkZElHAmBOprTx14/WxW3bJXJB0UsKao=;
 b=Aa4yIrtJwB9RbRxZ1aA05WqyaMvY6XXu0uIZCN24hqcRwQlHDjrwLzWAHvbBVLuk0+
 xyurOkWLVnWATk2WhmmhIHxvLwXFZJoYfqZxbrd60NWe4BCwJT9/SeHeDkoWLj1DIni3
 2ZU8gJVhIhp0oFXJ4LS7Xj9Pbxpv+dKxhqfSh84lkyQTMzPyTLv7Wv3rS5GlOxvn0APV
 zgCWLyQf6Un4O2Mc4iQJeBgT/LHFdFMl+vKXpflZm0sIJ5MU9sDa0q+fNtlbj+kOVDKI
 AvxwiiZWKgoY5kAevLDJwhnPL/6yZS8pRAkkI31ZXD5GIeXBtqtU9CYkHqeBpu4x70ti
 kydQ==
X-Gm-Message-State: AA+aEWZ+xMM6zB5/nuyet/PgaCiv6rCh+510HbBxJrbUENGw7/nkLSS/
 VKEy+bUYkLSODvj6IQfWkqRYdQ==
X-Google-Smtp-Source: AFSGD/U61mkRZ5X5UWXuCd07O+/aXRK33ZYDFhmvB5if+ixavXFwagOVIg3uiaQ9Fd0wfCfbLs42jw==
X-Received: by 2002:a2e:4c0a:: with SMTP id
 z10-v6mr10969972lja.85.1543871830258; 
 Mon, 03 Dec 2018 13:17:10 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id i75sm2595181lfb.58.2018.12.03.13.17.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:08 -0800 (PST)
Date: Mon, 3 Dec 2018 13:03:42 -0800
From: Olof Johansson <olof@lixom.net>
To: Andy Gross <andy.gross@linaro.org>
Subject: Re: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.21
Message-ID: <20181203210342.kt2x32pejiyzlk3j@localhost>
References: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131722_533805_B5D3C9AF 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, arm@kernel.org,
 Kevin Hilman <khilman@baylibre.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 01:39:01PM -0600, Andy Gross wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.21
> 
> for you to fetch changes up to b0bd6f1c03b4670f3e4b2a328e47adb9f2f1684e:
> 
>   arm64: defconfig: Enable GCC and PINCTRL for MSM8998 (2018-11-30 15:12:46 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 Based defconfig Updates for v4.21
> 
> * Enable Qualcomm QCS404 platform options
> * Enable Qualcomm MSM8998 clock and pinctrl
> * Enable Qualcomm SDM845 options
> * Add remoteproc related configs

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
