Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECD9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:26:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01782087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TXd8aX8J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="grGsq47V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01782087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Tr+RxdgJJIkYQVJRmeuxLfNTlzBECfX8hBFkJoOKME0=; b=TXd8aX8JZ9+M7b
	89m2JWoBJTwQznOXFYOlWYccEb0cIRV4fl69sEGXugMTxFY5lSz8vS88uK71YD8z+ZudwCq6aRaBo
	I/ZcXsWxKuyDUAINXbvG/8U3ND6kMFeAX/SUlwfkjZT+1L0QU4V0tmS5zBcrt7745oouy7IJqtK/7
	bJUPtcMCBktFR1XfsW2cbqkdbu+WzO0xp0YK0siW/j8NiG0R+3cCO1CdJKtkKOTXLywHO+TkJ4TJb
	xXkRbCRpDMsbG+qymHUF/XpEwScdnrjQ33MPogfG1GEUe8TMRM49/Jf6ZeizS+OdkINfhFAYRUIYG
	Y5wTLD2dxNa5g86dvbtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU9mf-0005fd-4I; Tue, 04 Dec 2018 12:26:37 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU9mb-0005es-A9
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 12:26:35 +0000
Received: by mail-lj1-x22d.google.com with SMTP id l15-v6so14709570lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 04:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Dda4lOs2zW4dx5jVqQc/qfmj9NTXLLKeS8NtINDVmnA=;
 b=grGsq47V9Jfg/ahynXX/Sw9iC2s3/CL+HjmpZtRg/qwSSMRi0db+UmclMmzLKcTzMk
 s5p0KxqOsZlg2jDCIimvnmcKYOrQeMYT7i5hHDkYqJListxIGwhaa6Mtl+XaRNXQmwCf
 faYrYjHLnrbZ1e1WGfFv40U+vnTH/NM6FVOxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Dda4lOs2zW4dx5jVqQc/qfmj9NTXLLKeS8NtINDVmnA=;
 b=BjowE62YoKtwFy+M4xvSCqb+X+x1cyNKv/QCvbFEWUuUUNqHukthLTO31Q/D3tiqCP
 l4eoC2Wh83DjosKjLnSe8VKVmDkCfwae8xgnUG/OL1+d5DpZ9BY8Mh2TVwgtzhEmBTLu
 duIOTWT9djE7cZAiCoZJECn2gVe0A3cILx38I1UnUiCjsO2sTWpHigEiikwLd40qLzVr
 fqpHHXdVxoKVbpcp95GD6G+MIBhG1lrSlbCZ0t1pbMHHrGKzH9yfXwhOjeRYiSJXzVIf
 j70CnO52N4PX/nBrN6tGDvBkLuMYDtIrV/jz+K9Sn2McbBNYzuMQQqNU+FtxMU31VXYD
 ty2w==
X-Gm-Message-State: AA+aEWao2rZY6IQw1jQPa9JgLlMwP1rCSHuiTYmeJkkgvKYyu5a50og6
 EPQtop044JbGx1+uyispOiOIGO57f+/ur8PJnIG/OsZgzwY=
X-Google-Smtp-Source: AFSGD/USqL74wVSCxY7vU1LOS34PGG2ZWxMVTIZWi1T4QYsmeeMuaNDnL/bMgIpYmvnOe602O7QMd/A1hwzxc3vSLqc=
X-Received: by 2002:a2e:92:: with SMTP id
 e18-v6mr13660079lji.130.1543926380409; 
 Tue, 04 Dec 2018 04:26:20 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 4 Dec 2018 17:56:09 +0530
Message-ID: <CA+G9fYsvJkW5_hruVYzLX3g9_5scj9nnL240rOMQ+DSz70dqqQ@mail.gmail.com>
Subject: Linux-next: Build failed
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_042633_502993_4BD67EF0 
X-CRM114-Status: UNSURE (   5.23  )
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
Cc: Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

FYI,

The Linux -next build failed due to below warnings/errors.

include/asm-generic/bitops/atomic.h: In function 'set_bit':
include/asm-generic/bitops/atomic.h:17:2: error: implicit declaration
of function 'atomic_long_or'; did you mean '__atomic_load_n'?
[-Werror=implicit-function-declaration]
  atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
  ^~~~~~~~~~~~~~
  __atomic_load_n
include/asm-generic/bitops/atomic.h: In function 'clear_bit':
include/asm-generic/bitops/atomic.h:23:2: error: implicit declaration
of function 'atomic_long_andnot'; did you mean
'__atomic_test_and_set'? [-Werror=implicit-function-declaration]
  atomic_long_andnot(BIT_MASK(nr), (atomic_long_t *)p);
  ^~~~~~~~~~~~~~~~~~
  __atomic_test_and_set
include/asm-generic/bitops/atomic.h: In function 'change_bit':
include/asm-generic/bitops/atomic.h:29:2: error: implicit declaration
of function 'atomic_long_xor'; did you mean '__atomic_load_n'?
[-Werror=implicit-function-declaration]
  atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
  ^~~~~~~~~~~~~~~
  __atomic_load_n
include/asm-generic/bitops/atomic.h: In function 'test_and_set_bit':
include/asm-generic/bitops/atomic.h:41:8: error: implicit declaration
of function 'atomic_long_fetch_or'; did you mean
'__atomic_and_fetch_1'? [-Werror=implicit-function-declaration]
  old = atomic_long_fetch_or(mask, (atomic_long_t *)p);
        ^~~~~~~~~~~~~~~~~~~~
        __atomic_and_fetch_1
include/asm-generic/bitops/atomic.h: In function 'test_and_clear_bit':
include/asm-generic/bitops/atomic.h:54:8: error: implicit declaration
of function 'atomic_long_fetch_andnot'; did you mean
'arch_atomic64_fetch_andnot'? [-Werror=implicit-function-declaration]
  old = atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
        ^~~~~~~~~~~~~~~~~~~~~~~~
        arch_atomic64_fetch_andnot
include/asm-generic/bitops/atomic.h: In function 'test_and_change_bit':
include/asm-generic/bitops/atomic.h:64:8: error: implicit declaration
of function 'atomic_long_fetch_xor'; did you mean
'__atomic_fetch_xor'? [-Werror=implicit-function-declaration]
  old = atomic_long_fetch_xor(mask, (atomic_long_t *)p);
        ^~~~~~~~~~~~~~~~~~~~~
        __atomic_fetch_xor

cc1: some warnings being treated as errors

full log details,
https://ci.linaro.org/job/openembedded-lkft-linux-next/DISTRO=rpb,MACHINE=juno,label=docker-stretch-amd64/407/consoleText

Best regards
Naresh Kamboju

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
