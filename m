Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF018C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:56:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4952083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YN7QTQdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4952083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QeB82l2JE9g8UpuiL45e+0496x7NHsPx8u5HmZE1aBM=; b=YN7QTQdoSfqxk6
	H2HER0/TdB2c9NOAen6/GU6H5VXh4h4SkmU7OKN4L2T8gvKEfJoviswJ/Uv+G2k6IIf/fNoNv1ddd
	CZEwxyWk2jgMyJ1JVEZhUK1Bxh+ucSVS5fo9FTQjXyr3ZI8HpcY49sWprZsZBAMAZuZJiBdw21MLX
	7AjQIkpxjQBYdKb/eIuL/+z/35JGMIso8kAu9HRoRzar64Owh/GfAme11WZ71HST/3WCaPk9DgQdR
	UEkWjFzeRZDxrwFj5MXnSkfCdxX6xWF82PovLREBWBXwjkNCFVbIGp+rcydVPUouvJGhTlUTOJkMU
	62HOdFmkZ4EAlJUqCNyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVMF0-0002aW-8m; Fri, 07 Dec 2018 19:56:50 +0000
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVMEw-0002XU-JV
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:56:48 +0000
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6BE99B3F;
 Fri,  7 Dec 2018 19:56:33 +0000 (UTC)
Date: Fri, 7 Dec 2018 11:56:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH V5 1/7] mm: mmap: Allow for "high" userspace addresses
Message-Id: <20181207115632.6d5cb691d65cb92917f9d21d@linux-foundation.org>
In-Reply-To: <20181206225042.11548-2-steve.capper@arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181206225042.11548-2-steve.capper@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_115646_662498_CA3C672E 
X-CRM114-Status: GOOD (  12.13  )
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
Cc: suzuki.poulose@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
 will.deacon@arm.com, linux-mm@kvack.org, jcm@redhat.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu,  6 Dec 2018 22:50:36 +0000 Steve Capper <steve.capper@arm.com> wrote:

> This patch adds support for "high" userspace addresses that are
> optionally supported on the system and have to be requested via a hint
> mechanism ("high" addr parameter to mmap).
> 
> Architectures such as powerpc and x86 achieve this by making changes to
> their architectural versions of arch_get_unmapped_* functions. However,
> on arm64 we use the generic versions of these functions.
> 
> Rather than duplicate the generic arch_get_unmapped_* implementations
> for arm64, this patch instead introduces two architectural helper macros
> and applies them to arch_get_unmapped_*:
>  arch_get_mmap_end(addr) - get mmap upper limit depending on addr hint
>  arch_get_mmap_base(addr, base) - get mmap_base depending on addr hint
> 
> If these macros are not defined in architectural code then they default
> to (TASK_SIZE) and (base) so should not introduce any behavioural
> changes to architectures that do not define them.
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Andrew Morton <akpm@linux-foundation.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
