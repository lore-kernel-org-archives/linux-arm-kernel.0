Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E501C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:44:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA43217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V69Yjdx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA43217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wl929sRvDiTFTXkCOEFnaXZBNAFHdNQS83Cq35VYMqQ=; b=V69Yjdx3G3hf6v
	OjT0IxRmaEe8MG9gxVnEcvEhBEvy5klKZZFXc8/fiyHm0IIRlxQHRvnD+bwu6Kq/KtqaUIHn/5wwZ
	ydTOb91qkvg2o5344oh3vzEI7qFJsa3H5uqCva9rgnh+TThR7nkD2gQ6BdvDcKTmoHF/VZ+dS5qMx
	Omx7MXjQRq70IeaWEp0/r0JAqsid4qMt97EFh00cnMQsQ9u4w223mB8g4q16kRmvnR59JrV1/ldl+
	eMZkCAfpF/rUKOM31krX7zQHQbSsneuM9XB12zvw59c8qKRlQuLvp5gRsucOID2AWREtdCTtVhS3I
	6XilsSiVEreq5iggBqWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf5B1-0000Br-CR; Thu, 03 Jan 2019 15:44:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf5Ar-0008S9-Eg
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:44:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEC2715AD;
 Thu,  3 Jan 2019 07:44:44 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD10C3F575;
 Thu,  3 Jan 2019 07:44:44 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id D720D1AE0BD1; Thu,  3 Jan 2019 15:44:44 +0000 (GMT)
Date: Thu, 3 Jan 2019 15:44:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: Lingyan Huang <huanglingyan2@huawei.com>
Subject: Re: [PATCH v2] arm64: lib: accelerate do_csum with NEON instruction
Message-ID: <20190103154444.GD16311@edgewater-inn.cambridge.arm.com>
References: <1546417860-30214-1-git-send-email-huanglingyan2@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546417860-30214-1-git-send-email-huanglingyan2@huawei.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_074445_882760_90411A52 
X-CRM114-Status: GOOD (  14.41  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 02, 2019 at 04:31:00PM +0800, Lingyan Huang wrote:
> Function do_csum() in lib/checksum.c is used to compute checksum,
> which is turned out to be slowly and costs a lot of resources.
> Let's use neon instructions to accelerate the checksum computation
> for arm64.
> 
> ------
> V1 ==> V2:
>     Change NEON assembly code to NEON intrinsic code which is built
>     on top of arm_neon.h to avoid dropping into assembly.
> ------
> 
> Here is the comparison results of function ip_compute_csum() between
> general do_csum() and neon instruction do_csum().
> 
>         len(1000cycle)      general(ns)        do_csum_neon(ns)
>           64B:                58060                 59460
>          128B:                82930                 83930
>          256B:               132480                 73570
>          512B:               230100                 86230
>         1024B:               426600                 98200
> 
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Lingyan Huang <huanglingyan2@huawei.com>
> ---
>  arch/arm64/lib/Makefile        |   4 ++
>  arch/arm64/lib/checksum.c      | 140 +++++++++++++++++++++++++++++++++++++++++
>  include/asm-generic/checksum.h |   1 +
>  lib/checksum.c                 |   8 ++-
>  4 files changed, 152 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/lib/checksum.c

I received five copies of this patch :/

Can you send a v3 (just once) so it's clear which is the latest version,
please?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
