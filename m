Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C422C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:43:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B7121841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mCwznCRn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pPYhB9Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B7121841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fkLvleJco17egHRtWe4OwzQqAwzKoq2Yh22n7KsST40=; b=mCwznCRnw1CUi1
	F37lWZmMrq+sP9g/9J3ON6zMNX6RmtzNpXVQ0aReKkFT4XNzA/QsaMh+Xzj8d9NU1dvpHuDM/IJk6
	B+rPgIwnqsNitAmThRo2GN55ULJKntHD4TS+bKDcmGzezmAk3eLvs1taEFNKnCwyooVcgIkvgP/15
	gjzP0EGdn+PnJwaaqQJd5JONYca4f5IMFjfSqdx0/7XUgCgfm0NS1F9ZmZ89RYUt21sobRZRQvGEW
	py/sAIsPnKqPiMrC/g/4POcZaSgy+p3eLaXTD7J6SaU9BFjiq0FuJOeMYdqahIySaaohExbJ0TSnh
	9VWIdWq5yvQn9OHzHodA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZd3t-0005qg-Gf; Wed, 19 Dec 2018 14:43:01 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZd3p-0005p3-AA
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 14:42:59 +0000
Received: from zn.tnic (p200300EC2BD1DB00D1DAB63F540AB861.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bd1:db00:d1da:b63f:540a:b861])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9DD5B1EC0BE5;
 Wed, 19 Dec 2018 15:42:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1545230558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=A5JcMVWyBC72XWO+DzwAdYh6+hI84ksx9LPWZbpN/C0=;
 b=pPYhB9Kb3e2zZI0q8GqjU4L/qTN8Qg7SuTtDIGw3MTDgu/c+Ui6ni8PCBjaoxEPgy5IstC
 PqgHKuu57vN9bT6hDjNVFlz3Mp9d+eorTjQIwf/mY97ho53Bl688S3ARevcgUY9hD1g7w4
 yVp9pxl6DmYo07JyGWmFQX6WVuYvvf0=
Date: Wed, 19 Dec 2018 15:42:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 04/25] ACPI / APEI: Make hest.c manage the estatus
 memory pool
Message-ID: <20181219144234.GA31643@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-5-james.morse@arm.com>
 <20181211164802.GI27375@zn.tnic>
 <ad48f9a1-404e-7878-3173-f8a4a417a723@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad48f9a1-404e-7878-3173-f8a4a417a723@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_064257_506218_20698563 
X-CRM114-Status: GOOD (  15.29  )
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

On Fri, Dec 14, 2018 at 01:56:16PM +0000, James Morse wrote:
> /me digs a bit,
> 
> ghes_estatus_pool_init() allocates memory from hest_ghes_dev_register().
> Its caller is behind a 'if (!ghes_disable)' in acpi_hest_init(), and is after
> another 2 calls to apei_hest_parse().
> 
> If ghes_disable is set, we don't call this thing.
> If hest_disable is set, acpi_hest_init() exits early.
> If we don't have a HEST table, acpi_hest_init() exits early.
> 
> ... if the HEST table doesn't have any GHES entries, hest_ghes_dev_register() is
> called with ghes_count==0, and does nothing useful. (kmalloc_alloc_array(0,...)
> great!) But we do call ghes_estatus_pool_init().
> 
> I think a check that ghes_count is non-zero before calling
> hest_ghes_dev_register() is the cleanest way to avoid this.

Grrr, what an effing mess that code is! There's hest_disable *and*
ghes_disable. Do we really need them both?

With my simplifier hat on I wanna say, we should have a single switch -
apei_disable - and kill those other two. What a damn mess that is.

> I wanted the estatus pool to be initialised before creating the platform devices
> in case the order of these things is changed in the future and they get probed
> immediately, before the pool is initialised.

Hmmm.

Actually, I meant flipping those two calls:

        rc = ghes_estatus_pool_init(ghes_count);
        if (rc)
                goto out;

        rc = apei_hest_parse(hest_parse_ghes, &ghes_arr);
        if (rc)
                goto err;

to

        rc = apei_hest_parse(hest_parse_ghes, &ghes_arr);
        if (rc)
                goto err;

        rc = ghes_estatus_pool_init(ghes_count);
        if (rc)
                goto out;

so as not to alloc the pool unnecessarily if the parsing fails.

Also, AFAICT, the order you have them in now might be a problem anyway
if

	apei_hest_parse(hest_parse_ghes, &ghes_arr);

fails because then you goto err and and that pool leaks, right?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
