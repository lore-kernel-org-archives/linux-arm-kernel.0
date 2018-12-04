Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8BDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:52:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999B920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SXreJtxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999B920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qUi7crK/UBs4k3czOiwVP1gtsxCgZs6S6hDcQrSd1EI=; b=SXreJtxz5cezEq
	mHQhMkewTsCIZ8oa7112TCAmziZoUuQ/JF3W8JdbtujDwFBVBR+bTdj39W06I4FJyBGv5ZdzYWjGt
	dGGRHnc+bT7I+OHRas7qPV2QgeGFXGNITkgyrBBdpBf+GaF27ZnnTKwoAXGh/hipLxDag1y3phUis
	WASI2qKfuBODVtQjZPhoM67COP4ZA88cgS5Bl9MVPvwqtqiKiprfZR5O2npQinCJWmW0lnq94Q+Mz
	IgGy6cSSBrDuxVm8If2NHBMkVyKqnKisEBhsGQIqGvvS+D9gltL77Vm7kxLlcZwhmOIO2Vkjc1FbE
	CMDZPc/IUOBBv1Otit+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUABi-0002LJ-FP; Tue, 04 Dec 2018 12:52:30 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUABf-0002Iw-P5
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 12:52:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7050C80D;
 Tue,  4 Dec 2018 04:52:14 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40A143F59C;
 Tue,  4 Dec 2018 04:52:14 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 7AD041AE10C5; Tue,  4 Dec 2018 12:52:34 +0000 (GMT)
Date: Tue, 4 Dec 2018 12:52:34 +0000
From: Will Deacon <will.deacon@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: Linux-next: Build failed
Message-ID: <20181204125233.GA1519@arm.com>
References: <CA+G9fYsvJkW5_hruVYzLX3g9_5scj9nnL240rOMQ+DSz70dqqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYsvJkW5_hruVYzLX3g9_5scj9nnL240rOMQ+DSz70dqqQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_045227_812563_3256A443 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Naresh,

On Tue, Dec 04, 2018 at 05:56:09PM +0530, Naresh Kamboju wrote:
> FYI,
> 
> The Linux -next build failed due to below warnings/errors.
> 
> include/asm-generic/bitops/atomic.h: In function 'set_bit':
> include/asm-generic/bitops/atomic.h:17:2: error: implicit declaration
> of function 'atomic_long_or'; did you mean '__atomic_load_n'?
> [-Werror=implicit-function-declaration]
>   atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
>   ^~~~~~~~~~~~~~
>   __atomic_load_n

Ha, I like that the compiler is trying to get us to use its __atomic
builtins here :)

Anyway, you're seeing this because of this previous error in Mark's script:

.../scripts/atomic/atomic-tbl.sh: line 183: fold: command not found

even though fold is part of coreutils :/

Do you have grep? Maybe the diff below helps.

Will

--->8

diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
index 9d6be538a987..81d5c32039dd 100755
--- a/scripts/atomic/atomic-tbl.sh
+++ b/scripts/atomic/atomic-tbl.sh
@@ -180,7 +180,7 @@ gen_proto_variants()
 #gen_proto(meta, ...)
 gen_proto() {
        local meta="$1"; shift
-       for m in $(echo "${meta}" | fold -w1); do
+       for m in $(echo "${meta}" | grep -o .); do
                gen_proto_variants "${m}" "$@"
        done
 }


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
