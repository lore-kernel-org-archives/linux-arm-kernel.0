Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D492C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:23:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5702081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b9/szcke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5702081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hMB69JUMge6sGEagBv8MnzeEUSXznSwpSY9ewt1DClI=; b=b9/szckeKa+kCT
	tIqPZnn0pOfKcDI2DP0k25nXMKKkimSsNegijScFiTu5if618OEoHF44MkOFmBaIqV3aRH5+kfkaP
	5ix1yKaKEKwrGYt98N8O3Pz7UA7QCu2gTwmTxQtqIzo+kziyl2A9LSuJVsFD2IMpn69VKhheO5Sou
	f17jX89hIgUV7zdY4bc+5uGS+H+acqTdJT5W0OtKSZc/ANn4BjSgu1+2vIU74p0VsSgVgXCW+jcgg
	lEWFd/f4v2ufTXPWvoRYfRJfHJfTDFPXxpqTr3yzx46Teld/0/csCJI4u3O0kEuEVYUK7nin5ygS+
	GOK5VLkrkw0Xgfp9gwjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtoK-0004G1-5O; Mon, 03 Dec 2018 19:23:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTto5-0003w3-J3
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:23:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 568341688;
 Mon,  3 Dec 2018 11:22:51 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 271493F575;
 Mon,  3 Dec 2018 11:22:51 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 335161AE1062; Mon,  3 Dec 2018 19:23:11 +0000 (GMT)
Date: Mon, 3 Dec 2018 19:23:11 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jackie Liu <liuyun01@kylinos.cn>
Subject: Re: [PATCH v5 1/2] arm64/neon: add workaround for ambiguous C99
 stdint.h types
Message-ID: <20181203192310.GG29028@arm.com>
References: <20181128010901.1052-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128010901.1052-1-liuyun01@kylinos.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_112302_243223_16581122 
X-CRM114-Status: GOOD (  26.10  )
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
Cc: linux-block@vger.kernel.org, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 09:09:00AM +0800, Jackie Liu wrote:
> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
> for ambiguous C99 stdint.h types"), this patch redefines the macros that
> are used in stdint.h so its definitions of uint64_t and int64_t are
> compatible with those of the kernel.
> 
> This patch comes from: https://patchwork.kernel.org/patch/3540001/
> Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> We mark this file as a private file and don't have to override asm/types.h
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  arch/arm64/include/asm/neon-intrinsics.h | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 arch/arm64/include/asm/neon-intrinsics.h
> 
> diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
> new file mode 100644
> index 0000000..e378766
> --- /dev/null
> +++ b/arch/arm64/include/asm/neon-intrinsics.h
> @@ -0,0 +1,34 @@
> +#ifndef _NEON_INTRINSICS_H
> +#define _NEON_INTRINSICS_H

We tend to name these with an __ASM_ prefix, so it should be:

#ifndef __ASM_NEON_INTRINSICS_H

That said, I notice that the commit you refer to for arch/arm/ actually
places this stuff under uapi/. Is that needed?

> +#include <asm-generic/int-ll64.h>
> +
> +/*
> + * For Aarch64, there is some ambiguity in the definition of the types below
> + * between the kernel and GCC itself. This is usually not a big deal, but it
> + * causes trouble when including GCC's version of 'stdint.h' (this is the file
> + * that gets included when you #include <stdint.h> on a -ffreestanding build).
> + * As this file also gets included implicitly when including 'arm_neon.h' (the
> + * NEON intrinsics support header), we need the following to work around the
> + * issue if we want to use NEON intrinsics in the kernel.
> + */

Could you elaborate on what the ambiguities / conflicts in the types are
please? I think you can also remove the sentence about directly including
stdint on a freestanding build, since it doesn't seem relevant to the
kernel afaict (we only pull it in via arm_neon.h).

> +
> +#ifdef __INT64_TYPE__
> +#undef __INT64_TYPE__
> +#define __INT64_TYPE__		__signed__ long long

Do we need this __signed__ part?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
