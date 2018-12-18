Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:00:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE0A21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D/d9Avxn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0NUtnsUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE0A21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Subject:To:In-Reply-To:
	Message-ID:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fWZSyJWj4ORU+LGhl42B0dzobXN18qW4qRgL5su1imk=; b=D/d9Avxn6APc0O
	f2iBJR2Ves2Nxcq97z+ECIOsKQjdv5eBeiBStVePUiiQ9g1txL36VRF+i5IYKZ1BUIWWvbZYrPF3K
	Q0IKTnDNurR58qRGIEPfBa1h2o/wBYFYqqAZwg8uu31Njqw6cyQYfUTg7/vrhZmorffjHStLR+pCG
	XFt9ntKtHE/QHcey5rSaRWMjvVNfjdgDVEo7TzJ9ZtunmfUvvt4VN3JHrswN7V3cOl8Ht4BadceYV
	TprgtN8Psh0kDxDQZhCf3UdLU9lV5PaSK5trKfldefbApjq/JSq2EXO0tnuoOYhK+Sr6aZf+njSTp
	E10W/U9PwYVQ9UZnZoEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZJfb-0004Ij-Kd; Tue, 18 Dec 2018 18:00:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZJfY-0004H0-8b
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:00:38 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E43821871;
 Tue, 18 Dec 2018 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545156025;
 bh=Jlx4fvIO9bYrA/UcZjSTMyi+Z8qOqjdt0deYmzSL63A=;
 h=References:In-Reply-To:To:Cc:Subject:From:Date:From;
 b=0NUtnsUUCbTTb6lTHz+h2iOuYKqW2ri8qt4e8/s0i90Hh5QoWZxgjqMKoKMKk/EZa
 BJQF1Oe+FVzTWy4/LwikHui59Phqj9f8y/px0w2/twLdGSG7Tt6cfQhN1vxd7EBC4F
 VKLysM5KliXHktls9k10n++IDtreufQUpKtdQAEM=
MIME-Version: 1.0
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-11-josephl@nvidia.com>
Message-ID: <154515602466.238328.7202899555618997431@swboyd.mtv.corp.google.com>
In-Reply-To: <20181218091232.23532-11-josephl@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>, Joseph Lo <josephl@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V3 10/20] clk: tegra: dfll: build clk-dfll.c for Tegra124
 and Tegra210
From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 18 Dec 2018 10:00:24 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_100036_312709_D12ABC97 
X-CRM114-Status: UNSURE (   7.67  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Joseph Lo (2018-12-18 01:12:22)
> diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
> index 7ddacae5d0b1..57902ab43f4a 100644
> --- a/drivers/clk/tegra/Kconfig
> +++ b/drivers/clk/tegra/Kconfig
> @@ -5,3 +5,8 @@ config TEGRA_CLK_EMC
>  config CLK_TEGRA_BPMP
>         def_bool y
>         depends on TEGRA_BPMP
> +
> +config TEGRA_CLK_DFLL
> +       depends on (ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC)

Nitpick: Drop the parenthesis please.

> +       select PM_OPP
> +       def_bool y



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
