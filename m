Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563B7C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:37:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A92620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MiBWmuEz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ou4cZvPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A92620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4/wVoQBQoD+ccxISmWn70pv86WYWVGu17bQRdh0VzKs=; b=MiBWmuEz+GvuGB
	CA6ij18Fd+nCoKdlCMLXf2DCQLHp5+B4+Qpb+IfkQ6lEkIhQfZVLK1XgigvJxKWrf1xFd5dO29v/P
	LQx5xWFDyHtEZ3qTE6o2pScUAq6pOJl8tvqdgOuSIOGSu+b99SDb84xjl0Q7xsRnTvNAOzITSALm9
	vS41wr/Yb3961SOPF2tzW+bEZK1Fc3XM0GmnldZzNABQYvhj+5fPwvnJ2F8PiTuuYRrqIxz/MbgcH
	bjjsjmDMtxLEvDC9zpZck+qKyySQoz7T+Osp9UANZX6KVXIrQL+v7/8UbsssHEnL3vhTk/nM/SJ8U
	Up/j+389vDoSCgXyvohg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWmuF-0003fU-Pn; Tue, 11 Dec 2018 18:37:19 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWmuB-0003eT-Vb
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 18:37:17 +0000
Received: from zn.tnic (p200300EC2BCD2B003506E5B42EFA948B.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcd:2b00:3506:e5b4:2efa:948b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6E681EC09F7;
 Tue, 11 Dec 2018 19:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1544553416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=BDom7ff/dXHuV55i5Opzcs8n6L4cAKAP0xTS+3Futpg=;
 b=Ou4cZvPE7PHJCiwVA2+Eo3lGngZ66tFnX9joCSrOZWq07EXDu+X+Gp/8q4NOV3B7Uj00Nt
 pkmHKgeKgIxXs+KKdI8EHgTi4qvQJikzKIiCRu0Pby2EL4CqQB4A6nE+PsV1VnKrXcLb8n
 ARuOEtFreenEvUgGmKd1XEhc/wXaCio=
Date: Tue, 11 Dec 2018 19:36:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
Message-ID: <20181211183634.GO27375@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-11-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_103716_169349_236AB233 
X-CRM114-Status: GOOD (  16.87  )
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

On Mon, Dec 03, 2018 at 06:05:58PM +0000, James Morse wrote:
> ACPI has a GHESv2 which is used on hardware reduced platforms to
> explicitly acknowledge that the memory for CPER records has been
> consumed. This lets an external agent know it can re-use this
> memory for something else.
> 
> Previously notify_nmi and the estatus queue didn't do this as
> they were never used on hardware reduced platforms. Once we move
> notify_sea over to use the estatus queue, it may become necessary.
> 
> Add the call. This is safe for use in NMI context as the
> read_ack_register is pre-mapped by ghes_new() before the
> ghes can be added to an RCU list, and then found by the
> notification handler.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 366dbdd41ef3..15d94373ba72 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -926,6 +926,10 @@ static int _in_nmi_notify_one(struct ghes *ghes)
>  	__process_error(ghes);
>  	ghes_clear_estatus(ghes, buf_paddr);
>  
> +	if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))

Since ghes_ack_error() is always prepended with this check, you could
push it down into the function:

ghes_ack_error(ghes)
...

	if (!is_hest_type_generic_v2(ghes))
		return 0;

and simplify the two callsites :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
