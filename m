Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1454FC2F3BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA1F2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IL4SNm4t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mfnunxL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA1F2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dEmH7TuejHB3PbclISe8WU8lh6a5hNrhS+6u9awEWCc=; b=IL4SNm4t7PZxj5
	mmzQ7UP/gmT9pHcPLC+jG9IkmCgvyp78DgH8V1cnp1He2xe7D/ptyTvhg6kn3KOGF6lH+ixwvKjxo
	YUX8nXnHKs6IACGdPlHqlcDJnc0zZwqvXBJQuT3fa57Zi6fewqI2eVQ29PeqO5fBrzdV/IVRqgV5A
	OzaH5WUfncT7VzreGqtyNnUXSU/wjeujkts+8t3i6gAjVROBiB0E+39MZ2bw2GeXhKiclVhT98vEj
	QhZVOLkLGvQvTZvuNX/x418XmuS8WBV2NOmhpw4Ww8Qk6LAMAIr450b6jxxxd28l+b3blfC7FJjT6
	6aSyD+LaT++oxH0kgY+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gla0p-00039E-8q; Mon, 21 Jan 2019 13:53:15 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gla0m-00038n-5x
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:53:13 +0000
Received: from zn.tnic (p200300EC2BC62500144FAFA30BDB3DA7.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc6:2500:144f:afa3:bdb:3da7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83C501EC035B;
 Mon, 21 Jan 2019 14:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548078790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=cP78pzFD5JiXNfMS8pi87e7ZqpkvOF3N0AoMlgJTb0I=;
 b=mfnunxL03+aYpJVhilf1btZr9ly8dHuOV63myCeKQ8ryrq6eGv3PBCg/PknJ8L42xDa46g
 HLRRhWwtuyRf7BidguHmNtcshwqdlvIFFnMhw4JAzO7H8ZhH+ZzOVhrVJPWpmRr+oP2XFa
 nbLUOoTgvsltazH3vq3At8nbL9aEKHU=
Date: Mon, 21 Jan 2019 14:53:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 18/25] ACPI / APEI: Split ghes_read_estatus() to allow
 a peek at the CPER length
Message-ID: <20190121135304.GI29166@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-19-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-19-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_055312_375438_080FF6D7 
X-CRM114-Status: GOOD (  21.75  )
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

On Mon, Dec 03, 2018 at 06:06:06PM +0000, James Morse wrote:
> ghes_read_estatus() reads the record address, then the record's
> header, then performs some sanity checks before reading the
> records into the provided estatus buffer.
> 
> To provide this estatus buffer the caller must know the size of the
> records in advance, or always provide a worst-case sized buffer as
> happens today for the non-NMI notifications.
> 
> Add a function to peek at the record's header to find the size. This
> will let the NMI path allocate the right amount of memory before reading
> the records, instead of using the worst-case size, and having to copy
> the records.
> 
> Split ghes_read_estatus() to create __ghes_peek_estatus() which
> returns the address and size of the CPER records.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Changes since v6:
>  * Additional buf_addr = 0 error handling
>  * Moved checking out of peek-estatus
>  * Reworded an error message so we can tell them apart
> ---
>  drivers/acpi/apei/ghes.c | 59 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b70f5fd962cc..07a12aac4c1a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -277,12 +277,12 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
>  	}
>  }
>  
> -static int ghes_read_estatus(struct ghes *ghes,
> -			     struct acpi_hest_generic_status *estatus,
> -			     u64 *buf_paddr, int fixmap_idx)
> +/* Read the CPER block and returning its address, and header in estatus. */

s/and /,/

> +static int __ghes_peek_estatus(struct ghes *ghes, int fixmap_idx,
> +			       struct acpi_hest_generic_status *estatus,

Also, we probably should stick to some order of arguments of those
functions for easier code staring, i.e.

	function_name(ghes, estatus, buf_paddr, fixmap_idx)

or so.

> +			       u64 *buf_paddr)
>  {
>  	struct acpi_hest_generic *g = ghes->generic;
> -	u32 len;
>  	int rc;
>  
>  	rc = apei_read(buf_paddr, &g->error_status_address);
> @@ -303,29 +303,64 @@ static int ghes_read_estatus(struct ghes *ghes,
>  		return -ENOENT;
>  	}
>  
> -	rc = -EIO;
> -	len = cper_estatus_len(estatus);
> +	return 0;
> +}
> +
> +/* Check the top-level record header has an appropriate size. */
> +int __ghes_check_estatus(struct ghes *ghes,
> +			 struct acpi_hest_generic_status *estatus)
> +{
> +	u32 len = cper_estatus_len(estatus);
> +	int rc = -EIO;
> +
>  	if (len < sizeof(*estatus))
>  		goto err_read_block;
>  	if (len > ghes->generic->error_block_length)
>  		goto err_read_block;
>  	if (cper_estatus_check_header(estatus))
>  		goto err_read_block;

Please make this chunk more user-friendly, maybe in a separate patch ontop:

/* Check the top-level record header has an appropriate size. */
int __ghes_check_estatus(struct ghes *ghes,
                         struct acpi_hest_generic_status *estatus)
{
        u32 len = cper_estatus_len(estatus);

        if (len < sizeof(*estatus)) {
                pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
                return -EIO;
        }

        if (len > ghes->generic->error_block_length) {
                pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
                return -EIO;
        }

        if (cper_estatus_check_header(estatus)) {
                pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header!\n");
                return -EIO;
        }

        return 0;
}

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
