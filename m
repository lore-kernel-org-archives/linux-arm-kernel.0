Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D3C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:31:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C08218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AItbADYu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ACamr810"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C08218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/TAfPDQl4FdC860jS9rbbQZDzmQ/iZ80TXVYCWK9AVw=; b=AItbADYufVxvp2
	rTNjDDdLzMiIHW+/e/Fo6mq8DWGY6ujwX608pBU1lmwK1ode54hcIxJrT87ZATn/OJWeDe2dCBAih
	IgoBV41/bgKssvJwQk1cmVvcVdsYfB/F2WluGE+ENkBNjsWjX0UWrvIDTB+lwWwxadrd2uJBC1BJf
	t0b8Vv3fOhN2BRj6ekxLX5bjJWPsqz+5Q/PbZJEOrydkDo+Gbd5/LkaYceAB5HINI/jrFqUu+HrfX
	upuvK6hIsP5CwWoZhqcRRXiSOA/Y5oM2Gg2LlIVJIes3mHYDNORE8Y1lkcDXQNlog9yAFJ1qvzT6Y
	me8M5QoesIutQunMx5dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZqN-0001Nw-Fz; Fri, 01 Feb 2019 14:30:59 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZqK-0001NK-3l
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:30:57 +0000
Received: from zn.tnic (p200300EC2BCC5000206D6264C5583287.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcc:5000:206d:6264:c558:3287])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F3181EC00EE;
 Fri,  1 Feb 2019 15:30:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1549031450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=hGy3GLIGKGb9pinyZWtR7KgWAhS96C0NlmjqSrh8BOc=;
 b=ACamr810wxngmD5P7ITX3jRkAM8RnQ7lgDj8hCv8KJNHwpHtx63zQ1KgDxJiOuw016BmFd
 8Gw3WEaVgFuLB124lpF+r6Jqk5+KaT5sjn6tzXCeRkOAmp2WJgWgMho3FOgLi8Txztc4UX
 vtNr0ctoByEfL3wPDJrQJo4deuKdilI=
Date: Fri, 1 Feb 2019 15:30:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v8 18/26] ACPI / APEI: Make GHES estatus header
 validation more user friendly
Message-ID: <20190201143040.GJ31854@zn.tnic>
References: <20190129184902.102850-1-james.morse@arm.com>
 <20190129184902.102850-19-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129184902.102850-19-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_063056_362588_31AB478F 
X-CRM114-Status: GOOD (  12.54  )
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
 linux-mm@kvack.org, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Xie XiuQi <xiexiuqi@huawei.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 06:48:54PM +0000, James Morse wrote:
> ghes_read_estatus() checks various lengths in the top-level header to
> ensure the CPER records to be read aren't obviously corrupt.
> 
> Take the opportunity to make this more user-friendly, printing a
> (ratelimited) message about the nature of the header format error.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 46 ++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f95db2398dd5..9391fff71344 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -293,6 +293,30 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
>  	}
>  }
>  
> +/* Check the top-level record header has an appropriate size. */
> +int __ghes_check_estatus(struct ghes *ghes,

static.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
