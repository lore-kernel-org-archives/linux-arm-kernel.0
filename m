Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C82DC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:46:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3B820645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eQ0kqtkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3B820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3HtiVBvmltXmJldr2BWBGNdk3aDSgT6sisNnxdLUFGs=; b=eQ0kqtkZediyee
	7LDvO6MTMoLiPTWClfhLoW9WKFsINIemFZPGzXqeSXaFAhNU7y5TfLuIYQ1x2gc2U164dTaDcL4iG
	BFIVKUk6aNMy0yuRs1KJwOUnSecy/DzHwsi6c48aheMMu2wnSbDzMhgk/RDQhFiw+Jo6HkGhuWy2t
	cO8xletK9Lh4qNRs6tJ0CEwyHbCz7dsi5Yr6R/W8OA5xjwfnqGqCm0O/te2TOtwvIUkf5r5h9hoT3
	821mC8RDQ1tAB5TS9xwr0o/Le5y/sQ1s4BmnP5SsPHexdY2Z853oHTolba3JmowMuRJIz8hlZyGe/
	faPC0psyON6s+n6wpMPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqET-0000ZZ-73; Thu, 06 Dec 2018 09:46:09 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqEP-0000Xt-Vo
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:46:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5D293ACBA;
 Thu,  6 Dec 2018 09:45:52 +0000 (UTC)
Date: Thu, 6 Dec 2018 10:45:49 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v5 1/2] module: Overwrite st_size instead of st_info
In-Reply-To: <20181204141415.969-1-vincent.whitchurch@axis.com>
Message-ID: <alpine.LSU.2.21.1812061045320.17628@pobox.suse.cz>
References: <20181204141415.969-1-vincent.whitchurch@axis.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_014606_164331_BEAE636F 
X-CRM114-Status: UNSURE (   8.02  )
X-CRM114-Notice: Please train this message.
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
Cc: Vincent Whitchurch <rabinv@axis.com>, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, jeyu@kernel.org, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 4 Dec 2018, Vincent Whitchurch wrote:

> st_info is currently overwritten after relocation and used to store the
> elf_type().  However, we're going to need it fix kallsyms on ARM's
> Thumb-2 kernels, so preserve st_info and overwrite the st_size field
> instead.  st_size is neither used by the module core nor by any
> architecture.
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
