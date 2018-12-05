Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F44EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BCD2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rNFCneK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BCD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sitkHwHjhpHHuSvK14Z1+HNnYbwzxrZ1bscGtlticNs=; b=rNFCneK0Aa36V/
	gNh5K7WKgksi5q3VBz3+KzGOA+Ayo6VtVLuXbDJqiNvxiv4MEbk+sibjEUHL1X/A/66nLOJevtsxJ
	LWa/XnEiIQYxstr37J3ybOczfLZ1oJ6nrVP701+D0gS3BQjrxoAedWX6vBVwyfkq+36OeRFh2jd6q
	z5iikKBUby4CG0j8KmoaYq177xLSh7Tj99eCKRHQw9kcYq84RzoNa8qe2K4fK6waSy4gDJK7iW4fV
	szBlLQLrumzQvA3JqcLUbNDvWwng0gAh8H9iLWtk6MCfMMruoRBOf5zkRuUrNjzNtjuip/PLJjOaV
	VVoOBgFx7CIPsRjlkHQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZBj-0005zJ-9m; Wed, 05 Dec 2018 15:34:11 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZBY-0005kY-6M
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:34:08 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id E46B613F8DB;
 Wed,  5 Dec 2018 16:33:37 +0100 (CET)
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: arm-soc <arm@kernel.org>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Message-ID: <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
Date: Wed, 5 Dec 2018 16:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_073400_789481_5473958A 
X-CRM114-Status: GOOD (  11.84  )
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09/11/2018 01:54, Marc Gonzalez wrote:

> Hello ARM maintainers,
> 
> v3: Keep CRYPTO_DEV_FSL_DPAA2_CAAM in patch 7/9
> 
> v2: Improve commit message for a few patches
> 
> The set of Kconfig options slowly changes with every kernel version.
> This patch series regenerates the arm64 defconfig for v4.20
> No functional change intended, except adding PINCTRL_MTK_MOORE to
> keep PINCTRL_MT7622, and adding FSL_MC_BUS and FSL_MC_DPIO to
> keep CRYPTO_DEV_FSL_DPAA2_CAAM.
> 
> Marc Gonzalez (9):
>   arm64: defconfig: Regenerate for v4.20
>   arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
>   arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
>   arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
>   arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
>   arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
>   arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
>   arm64: defconfig: Change SCSI_UFS_HISI=m
>   arm64: defconfig: Drop redundant sound codec options
> 
>  arch/arm64/configs/defconfig | 108 ++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 59 deletions(-)

Arnd, Olof,

Would you take this series for 4.21-rc1?

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
