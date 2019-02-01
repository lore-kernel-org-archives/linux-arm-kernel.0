Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB6BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C24B20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nw3kvF1p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="P4GKAA7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C24B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uOVFDjIgSn+puRwy+inzfQlKdRHeIGWpCDKqpN8U6SY=; b=Nw3kvF1ppl+jQ8
	tKAy8og43NwsG6rsYqLm1/v/KOC55yazAm+sT6N0eaaidhStjtGW1x17o9ff0MaJn+ZBiMPMZcJVT
	2+13bVDMgSRcOGX5mZMCJDnrIxdLjSBy8JxSqG+DILPPIcjRDZGfAtzuxw/ZkaXlNEKim+NA4JTQ7
	1sL2cfooHZkA2YVgbm6SwB6zGLRrJCsN1V+mGrpqc9ssAlaXWG3FPFJYSJA5E4rNxbEnCK+Xs8t1g
	ryu9moIaGhJZYWL8NEyd+Smsux1i95Qykfc7TaY4jH38Yihp3S7qP3uqbKGZ8nhSL3IdLiMe4UmMI
	alhRik+nEE2V5QfLHX1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpYkn-0007cE-Rs; Fri, 01 Feb 2019 13:21:09 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpYkj-0007bg-8U
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 13:21:08 +0000
Received: from zn.tnic (p200300EC2BCC5000206D6264C5583287.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcc:5000:206d:6264:c558:3287])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 456CD1EC04F3;
 Fri,  1 Feb 2019 14:20:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1549027256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=7L1X6vKf/wnbcTvmjqUAGShbPUgIPy8g7a7ScRxOFMM=;
 b=P4GKAA7JCnK8zMwSkARxItVovCaDmkYO3eSkRp4d1+WS0j+ZngXPe/Eux9wZ8zOzUVBsUJ
 AVicI0193MpIC9IQL10Brr8pLyCcYcRVv2K8fxgQtKkFCMjrvJi3WRKo560iAY+P0xYnEb
 vp7v7QRkio8eq24FzVGVezsW7d/Bnic=
Date: Fri, 1 Feb 2019 14:20:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v8 04/26] ACPI / APEI: Make hest.c manage the estatus
 memory pool
Message-ID: <20190201132046.GH31854@zn.tnic>
References: <20190129184902.102850-1-james.morse@arm.com>
 <20190129184902.102850-5-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129184902.102850-5-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_052105_604326_90576E51 
X-CRM114-Status: GOOD (  17.34  )
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

On Tue, Jan 29, 2019 at 06:48:40PM +0000, James Morse wrote:
> ghes.c has a memory pool it uses for the estatus cache and the estatus
> queue. The cache is initialised when registering the platform driver.
> For the queue, an NMI-like notification has to grow/shrink the pool
> as it is registered and unregistered.
> 
> This is all pretty noisy when adding new NMI-like notifications, it
> would be better to replace this with a static pool size based on the
> number of users.
> 
> As a precursor, move the call that creates the pool from ghes_init(),
> into hest.c. Later this will take the number of ghes entries and
> consolidate the queue allocations.
> Remove ghes_estatus_pool_exit() as hest.c doesn't have anywhere to put
> this.
> 
> The pool is now initialised as part of ACPI's subsys_initcall():
> (acpi_init(), acpi_scan_init(), acpi_pci_root_init(), acpi_hest_init())
> Before this patch it happened later as a GHES specific device_initcall().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v7:
> * Moved the pool init later, the driver isn't probed until device_init.
> ---
>  drivers/acpi/apei/ghes.c | 33 ++++++---------------------------
>  drivers/acpi/apei/hest.c | 10 +++++++++-
>  include/acpi/ghes.h      |  2 ++
>  3 files changed, 17 insertions(+), 28 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
