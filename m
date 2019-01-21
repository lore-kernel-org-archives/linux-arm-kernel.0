Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71389C31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:27:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4150B2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l/VPbYGu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AcJExkwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4150B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C3BwpLeE9WhXe7HKtxk8/fGyO8QBoeP5i/NOBGzA1KI=; b=l/VPbYGuwDq4Ff
	4718H4ju/C4nXDvlC8jeghyaRl7Oxi43BDOaj3+f2URP2YTphGpejYQsGfq6bOVSOfxhfcSNFqt3E
	Ufx4YCpfgKDO3F1W2IZM5uOdBgYEi93eRBz5mvhkeDI+9HMhpHsDVdHtrkbIorg8d/rOXL8HzhOQR
	4kSqprqUV40i6Jb/SAyj6KNvJhRwNm5w9cmYfAZn8FkEWWAvQ4SerpmlbwGliqtkcnV7Xj/aDWpgv
	gE/2Q+9wJ6kNAs93t/Vfys+qPmuk6QQ4L6tiZM0Rv2r3/MrfILgw5Z0kioVy/A3Wh4EJDuH/38A5A
	fo6SVZXcvYSS4380YS2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldMV-0007Xl-Fb; Mon, 21 Jan 2019 17:27:51 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldMR-0007NU-H3
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:27:49 +0000
Received: from zn.tnic (p200300EC2BC62500329C23FFFEA6A903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc6:2500:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 600ED1EC0242;
 Mon, 21 Jan 2019 18:27:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548091665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=ueK4rp2UMpM8xlD7kGNxbVehTmIUr8fjJZ30GNokY28=;
 b=AcJExkwn405enPROxAJOV1VO/UpAFXxtUMiHMHASMqmieeULv3Wskrk41S3xl8JiLZlaq9
 eUB0MGMRYZQc6uMiwUE+BEF7bGVknDYFfx5NREZA7nPdEiahrm4f4NEPjUII6QD89sKapB
 FUxf7FaxpFWRYaHrxS7heBXPVNhWF2s=
Date: Mon, 21 Jan 2019 18:27:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 20/25] ACPI / APEI: Use separate fixmap pages for
 arm64 NMI-like notifications
Message-ID: <20190121172743.GN29166@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-21-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-21-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_092747_724460_9C39905C 
X-CRM114-Status: GOOD (  19.11  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:06:08PM +0000, James Morse wrote:
> Now that ghes notification helpers provide the fixmap slots and
> take the lock themselves, multiple NMI-like notifications can
> be used on arm64.
> 
> These should be named after their notification method as they can't
> all be called 'NMI'. x86's NOTIFY_NMI already is, change the SEA
> fixmap entry to be called FIX_APEI_GHES_SEA.
> 
> Future patches can add support for FIX_APEI_GHES_SEI and
> FIX_APEI_GHES_SDEI_{NORMAL,CRITICAL}.
> 
> Because all of ghes.c builds on both architectures, provide a
> constant for each fixmap entry that the architecture will never
> use.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v6:
>  * Added #ifdef definitions of each missing fixmap entry.
> 
> Changes since v3:
>  * idx/lock are now in a separate struct.
>  * Add to the comment above ghes_fixmap_lock_irq so that it makes more
>    sense in isolation.
> 
> fixup for split fixmap
> ---
>  arch/arm64/include/asm/fixmap.h |  2 +-
>  drivers/acpi/apei/ghes.c        | 10 +++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index ec1e6d6fa14c..966dd4bb23f2 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -55,7 +55,7 @@ enum fixed_addresses {
>  #ifdef CONFIG_ACPI_APEI_GHES
>  	/* Used for GHES mapping from assorted contexts */
>  	FIX_APEI_GHES_IRQ,
> -	FIX_APEI_GHES_NMI,
> +	FIX_APEI_GHES_SEA,
>  #endif /* CONFIG_ACPI_APEI_GHES */
>  
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 849da0d43a21..6cbf9471b2a2 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -85,6 +85,14 @@
>  	((struct acpi_hest_generic_status *)				\
>  	 ((struct ghes_estatus_node *)(estatus_node) + 1))
>  
> +/* NMI-like notifications vary by architecture. Fill in the fixmap gaps */
> +#ifndef CONFIG_HAVE_ACPI_APEI_NMI
> +#define FIX_APEI_GHES_NMI	-1
> +#endif
> +#ifndef CONFIG_ACPI_APEI_SEA
> +#define FIX_APEI_GHES_SEA	-1

I'm guessing those -1 are going to cause __set_fixmap() to fail, right?

I'm wondering if we could catch that situation in ghes_map() already to
protect ourselves against future changes in the fixmap code...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
