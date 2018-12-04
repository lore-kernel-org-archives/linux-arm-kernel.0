Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:36:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3862087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KtGH5vvD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="o0WzruZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3862087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7ZAvgswVh7Qz/R/m6oFtCsZ+tTfaCAd/MzZRhhT3wJQ=; b=KtGH5vvDW3v9tu
	l0Ao6qYTJkXHun5NbZJJEXHB/siBMw6ULmRCNrE98wzGz7NFc2xa/i3HRkBemxevKybEbAhOw59hn
	LYXscNsSE+YKD12pjOfZZCJBR1bnTYreBZp0B4DCNxZSyLo+1tfalDQ98WCzoqCvLgaiQy4y7CDlP
	OWg/Sk6qoOVVqZ5OQaSd+V0l52815qAN3VHqBzcGUbDJhGmrSBTra18eL4iCVRUZUovdLlWMHqm/H
	0Cj3Fs0PtFF/0leaaoe789XswNytirN9PNbWB34/OrXqlUjUgZ4lq3caksoQ/qHXVz6tYUHZgG0t1
	kutnafVPZRY3sG2RdRYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU90D-00024C-Tj; Tue, 04 Dec 2018 11:36:33 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU903-0001sC-6b
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:36:28 +0000
Received: from zn.tnic (p200300EC2BC7BF007D8ACF05B2F0FCCA.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc7:bf00:7d8a:cf05:b2f0:fcca])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 827471EC0B8B;
 Tue,  4 Dec 2018 12:36:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1543923367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=lVI3Zlt4+NepdQz3m+Q4fCF1RSh7iMjnL43Bl/MkTdc=;
 b=o0WzruZCyDCMOg31SAxUWyTolifwapGlRrJSO1lD585Ms/ETMWZMS+V3qqOshk+NGpibd4
 qHU2nuYAe/9wWjQP2rGBhXAJWoBXlnFfBtM3PweMXLFZD51mMVaJFj+cLajJ7D+O/gFHsy
 q3vZfYNkst7oY8sb4UuMYrXc/OGFdY4=
Date: Tue, 4 Dec 2018 12:36:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 02/25] ACPI / APEI: Remove silent flag from
 ghes_read_estatus()
Message-ID: <20181204113601.GB11803@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-3-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-3-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_033623_851225_F420150B 
X-CRM114-Status: GOOD (  13.86  )
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

On Mon, Dec 03, 2018 at 06:05:50PM +0000, James Morse wrote:
> Subsequent patches will split up ghes_read_estatus(), at which
> point passing around the 'silent' flag gets annoying. This is to
> suppress prink() messages, which prior to commit 42a0bb3f7138
> ("printk/nmi: generic solution for safe printk in NMI"), were
> unsafe in NMI context.
> 
> This is no longer necessary, remove the flag. printk() messages
> are batched in a per-cpu buffer and printed via irq-work, or a call
> back from panic().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v6:
>  * Moved earlier in the series,
>  * Tinkered with the commit message.
>  * switched to pr_warn_ratelimited() to shut checkpatch up
> 
> shutup checkpatch
> ---
>  drivers/acpi/apei/ghes.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
