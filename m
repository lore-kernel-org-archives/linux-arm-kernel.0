Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C70C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:01:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151C520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Noa4HBls";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lS5gLECn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151C520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ai1mqxhS6mXJEpbKDf3SZksceOFh5tDD3FX8h61v7A=; b=Noa4HBlsqjZ/sj
	aPt/RiTBWUQYWFRdVxWIg9nlvqAw8fl2u3foTo4lUDUbkVEROW5+Uy93snnSDtaYI8wUoTF94wAMO
	vftOzHy86+LK+SwCbEy0zV5+TCP9lRZ7HUKHhfkm0Fnx8WDDhqMwqaVmMJXzj1BWdx3C8bw+ranfs
	3FEmiN5PT0Ar5b4Ft4BXjiadELwMWYZD3l8ldKse1o0oSzTIAc7tPNrVbq8e3iGCo5slE9qvaX77F
	IQjFFCRNOs/KeKuKDfZrKHLoWKQ5/YxqdrA3GsTzZfYjh8ytdni1V8FBGZSQfRnXqaR26MZ+Y3ASh
	2vBJ3/TeRpuGtlKaBGYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUAKk-00060W-4A; Tue, 04 Dec 2018 13:01:50 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUAKg-0005zg-H5
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 13:01:48 +0000
Received: from zn.tnic (p200300EC2BC7BF0029609E2C84DD7E59.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc7:bf00:2960:9e2c:84dd:7e59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5FDF1EC0946;
 Tue,  4 Dec 2018 14:01:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1543928492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=SYCpgmgcVTaXR+Qry6e4hKIOQx26RI78wBrdZ0lQw7M=;
 b=lS5gLECnbmQQlhe5CMsxHOuydrfQAO1n0MjZBxfquzShXmLV74usS5gOa0wJBUCADC1Tq8
 Pm0I88p/agU7rxtUpqf/mr0w9biLSzDq9OhV9fCDjYJeWsEjejENpWQ3v1HXhprqD5gklB
 /rf7mP58i01VBPf8XOxak3o5p8L7mP4=
Date: Tue, 4 Dec 2018 14:01:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 03/25] ACPI / APEI: Switch estatus pool to use vmalloc
 memory
Message-ID: <20181204130124.GE11803@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-4-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-4-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_050146_723224_AFC5817B 
X-CRM114-Status: GOOD (  21.60  )
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

On Mon, Dec 03, 2018 at 06:05:51PM +0000, James Morse wrote:
> The ghes code is careful to parse and round firmware's advertised
> memory requirements for CPER records, up to a maximum of 64K.
> However when ghes_estatus_pool_expand() does its work, it splits
> the requested size into PAGE_SIZE granules.
> 
> This means if firmware generates 5K of CPER records, and correctly
> describes this in the table, __process_error() will silently fail as it
> is unable to allocate more than PAGE_SIZE.
> 
> Switch the estatus pool to vmalloc() memory. On x86 vmalloc() memory
> may fault and be fixed up by vmalloc_fault(). To prevent this call
> vmalloc_sync_all() before an NMI handler could discover the memory.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index e8503c7d721f..c15264f2dc4b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -170,40 +170,40 @@ static int ghes_estatus_pool_init(void)
>  	return 0;
>  }
>  
> -static void ghes_estatus_pool_free_chunk_page(struct gen_pool *pool,
> +static void ghes_estatus_pool_free_chunk(struct gen_pool *pool,
>  					      struct gen_pool_chunk *chunk,
>  					      void *data)
>  {
> -	free_page(chunk->start_addr);
> +	vfree((void *)chunk->start_addr);
>  }
>  
>  static void ghes_estatus_pool_exit(void)
>  {
>  	gen_pool_for_each_chunk(ghes_estatus_pool,
> -				ghes_estatus_pool_free_chunk_page, NULL);
> +				ghes_estatus_pool_free_chunk, NULL);
>  	gen_pool_destroy(ghes_estatus_pool);
>  }
>  
>  static int ghes_estatus_pool_expand(unsigned long len)
>  {
> -	unsigned long i, pages, size, addr;
> -	int ret;
> +	unsigned long size, addr;
>  
>  	ghes_estatus_pool_size_request += PAGE_ALIGN(len);

So here we increment with page-aligned len...

>  	size = gen_pool_size(ghes_estatus_pool);
>  	if (size >= ghes_estatus_pool_size_request)
>  		return 0;
> -	pages = (ghes_estatus_pool_size_request - size) / PAGE_SIZE;
> -	for (i = 0; i < pages; i++) {
> -		addr = __get_free_page(GFP_KERNEL);
> -		if (!addr)
> -			return -ENOMEM;
> -		ret = gen_pool_add(ghes_estatus_pool, addr, PAGE_SIZE, -1);
> -		if (ret)
> -			return ret;
> -	}
>  
> -	return 0;
> +	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
> +	if (!addr)
> +		return -ENOMEM;

... and if we return here due to the ENOMEM, that increment above
remains.

I see you're reworking all that stuff in the next patches which is cool,
thx. So I guess we should leave it as is, as the code before was broken
too.

IOW,

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
