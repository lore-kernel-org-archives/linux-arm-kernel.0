Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A07C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1DF2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qRYnFQgf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="X7tH25FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1DF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MKniF1qT7AcJ8eGD5uSf6HBiyBmzOvyj2rUBL29s/+o=; b=qRYnFQgfJs3Uu7
	RqxqvrSoJxwJmhMka3goOr2Lne5+vFiX9nGfUAY+56Tkrv+mMNC/0hT52Sy9ynFTWvfrLUkHQj3AM
	je7Ybz4m6jyunV/iYaKZZP1cV6PyE274H7DRdptcJEx3rCf4pJXr3yM82BWmNK/tYUnk+Y1v5Rp7t
	JPTg+dxB+yksSKE8CXC4GjpNDc3UIgCpmQaaj2p+gLwvm8x+/bj4C29/+UEZpioHnBB99KEbAj54A
	qeHx6koWx4/D+7BL9DvFDa6cOiQUBA2FFZt0+R5DsLNWlGujnWfLuS3utZB7O5BWlwu0Q3pICHU6V
	EkKOM6WiioxIcxSutrhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlSo-0006O0-UK; Tue, 11 Dec 2018 17:04:54 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlSk-0006NS-Eb
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:04:53 +0000
Received: from zn.tnic (p200300EC2BCD2B003506E5B42EFA948B.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcd:2b00:3506:e5b4:2efa:948b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7729C1EC0432;
 Tue, 11 Dec 2018 18:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1544547878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=GmIymAZYMfNdota6j7MNGtTXTBx7DOEebljVMrrq8gs=;
 b=X7tH25FIKe3IP9jl/8kmVwsdWjQy7r9yztaJ9Ldy6DRKadhf/LlvZn3pS6fL3eJY5Mjg75
 Rq4GYBPJ9F/J+g6RE8hkmStTD6oRvBdWtTcgxlAum7RT/PNt2WWk2lskfJiyHBGahWWdv+
 9uM4J/40UDXtAzMneMKsyx13qFojKyw=
Date: Tue, 11 Dec 2018 18:04:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 06/25] ACPI / APEI: Don't store CPER records physical
 address in struct ghes
Message-ID: <20181211170430.GK27375@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-7-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-7-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_090450_646466_1ACBF1EB 
X-CRM114-Status: GOOD (  19.67  )
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

On Mon, Dec 03, 2018 at 06:05:54PM +0000, James Morse wrote:
> When CPER records are found the address of the records is stashed
> in the struct ghes. Once the records have been processed, this
> address is overwritten with zero so that it won't be processed
> again without being re-populated by firmware.
> 
> This goes wrong if a struct ghes can be processed concurrently,
> as can happen at probe time when an NMI occurs. If the NMI arrives
> on another CPU, the probing CPU may call ghes_clear_estatus() on the
> records before the handler had finished with them.
> Even on the same CPU, once the interrupted handler is resumed, it
> will call ghes_clear_estatus() on the NMIs records, this memory may
> have already been re-used by firmware.
> 
> Avoid this stashing by letting the caller hold the address. A
> later patch will do away with the use of ghes->flags in the
> read/clear code too.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v6:
>  * Moved earlier in the series
>  * Added buf_adder = 0 on all the error paths, and test for it in
>    ghes_estatus_clear() for extra sanity.
> ---
>  drivers/acpi/apei/ghes.c | 40 +++++++++++++++++++++++-----------------
>  include/acpi/ghes.h      |  1 -
>  2 files changed, 23 insertions(+), 18 deletions(-)

...

> @@ -349,17 +350,20 @@ static int ghes_read_estatus(struct ghes *ghes)
>  	if (rc)
>  		pr_warn_ratelimited(FW_WARN GHES_PFX
>  				    "Failed to read error status block!\n");
> +
>  	return rc;
>  }
>  
> -static void ghes_clear_estatus(struct ghes *ghes)
> +static void ghes_clear_estatus(struct ghes *ghes, u64 buf_paddr)
>  {
>  	ghes->estatus->block_status = 0;
>  	if (!(ghes->flags & GHES_TO_CLEAR))
>  		return;
> -	ghes_copy_tofrom_phys(ghes->estatus, ghes->buffer_paddr,
> -			      sizeof(ghes->estatus->block_status), 0);
> -	ghes->flags &= ~GHES_TO_CLEAR;

<---- newline here.

> +	if (buf_paddr) {

Also, you can save yourself an indendation level:

	if (!buf_paddr)
		return;

	ghes_copy...

> +		ghes_copy_tofrom_phys(ghes->estatus, buf_paddr,
> +				      sizeof(ghes->estatus->block_status), 0);
> +		ghes->flags &= ~GHES_TO_CLEAR;
> +	}
>  }

With that addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
