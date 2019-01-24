Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B5C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:37:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298BF2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KcM9/S2q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="edc0KIOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298BF2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xm9MFoRNRLMWPIei2iSLj36WpjUey9QgRpK59fbbDlM=; b=KcM9/S2qvq1fD2
	8CQMsghJeUxRn/fpQwKnM7Xf2rjcgqf8zIERNWq4KDM1qmH5KrQ/D0m94MyLwk/IUub1JxY4aiJjs
	by5wTwjPjvkA7ehHan4u+UN6ZxAIT6XtvNFgtULOnJpEjUQsyLHajXQMHrLqMROBn8HvsSwY2QEnM
	5o3174g3yP8XL053Q3FES4YDGfXVUJSM3EYTeDMExzc7o3H7UhI1xyI/kMt9/70h24hOkDObKClm5
	OobIvfsZFJdM0jomf4tdBKY79CxzaBHIR4rvzU1SUo4kmoswexhn2qEesXxanHjFxua4lH1y2VPXu
	z1AJGSNTXEcAjuc1pF/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmXh8-00011p-7g; Thu, 24 Jan 2019 05:36:54 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmXh4-00011O-Pu
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 05:36:52 +0000
Received: by mail-wr1-x432.google.com with SMTP id x10so5039406wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 21:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=5yIXgh5ClIzcKCJxks5gSuDiVfQRQiDh4qIO7whQ3Hk=;
 b=edc0KIOvYs9YiUOG6K+qNWllGlatOPTAE6JEuuhFe/ejLXJbq3wQ/8SF9719KxtAOF
 AYNc/EaWbPaiWsceFswO6jp8xKgck97lAfMFKuZy2Muep3pCSlQIj5h6UpwbF+j0FV3v
 DIfwQ+QqGZxuLEqzGPSwXUfczN22w+Ce/+JBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=5yIXgh5ClIzcKCJxks5gSuDiVfQRQiDh4qIO7whQ3Hk=;
 b=aPGn8FyBMkAMdK869wuixdVmBMahf5LBnwUecJ4cQdx1J69mVHvHpUr0bvxWdCV4uk
 rZpYtKAX1OKg1iRwzW+DePRuLS1srcG1ny3JX2DUque429EGrCfPw9v5tBpGo7E5HnS3
 B2Rj4N7Z6bU9vZ5hb7ynRh+q49mWgBjwkQ9uN5KQ7TkNdtHnk5Yp6bIWSU/oqomznBar
 3eGtNBGYoZpAqWj5hDZfmUwgx6dCFEVYcIZOsyiRyeOu9SzdEPLRkQf/XzHPv8lilD7F
 mAru9XdCfj1DosMAPo1Yw8Q3qBNjPZtTxQb66HkoKkiRNzqkmHHsx8BlBYO6WE0iSIqT
 1sZA==
X-Gm-Message-State: AJcUukcdW+0iUTnSlC/6AMFA7Ksrqrnw6ZoczdTzGLUbDlZExoC8F0bO
 gZm8AoAJFMl9Qkjb8INtRChigV2tn0mKObNE8HYyNHNZUfuQcQ==
X-Google-Smtp-Source: ALg8bN7i1/XefSaynHlIXVr02xcuYRBBCi2Qm6o1wQeVYGLYj5jBgfk/uzoB6AbzPxngqQ1SoQAcF5dtxoRaR3xVAbY=
X-Received: by 2002:adf:9521:: with SMTP id 30mr5236107wrs.192.1548308208607; 
 Wed, 23 Jan 2019 21:36:48 -0800 (PST)
MIME-Version: 1.0
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 23 Jan 2019 21:36:36 -0800
Message-ID: <CALAqxLX0P6P4xnv=HgQsP-Cv4dkGJhkkMRn7jy-sbzZKUa1z4w@mail.gmail.com>
Subject: BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c:908
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_213650_838530_BFBB05A3 
X-CRM114-Status: UNSURE (   4.47  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 Valentin Schneider <Valentin.Schneider@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Trying to boot hikey960 with v5.0-rc3 (and Valentin's 2 recent lockdep
fixes), with lock debugging enabled, I'm seeing the BUG below.

Wanted to see if anyone else had seen this or had ideas at what was going on.

thanks
-john

[    0.183376] Detected VIPT I-cache on CPU4
[    0.183388] CPU features: SANITY CHECK: Unexpected variation in
SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4:
0x00000000101122
[    0.183399] CPU features: Unsupported CPU feature variation detected.
[    0.183417] BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:908
[    0.183421] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/4
[    0.183451] no locks held by swapper/4/0.
[    0.183454] irq event stamp: 0
[    0.183459] hardirqs last  enabled at (0): [<0000000000000000>]
      (null)
[    0.183474] hardirqs last disabled at (0): [<ffffff80100f2af0>]
copy_process.isra.3.part.4+0x450/0x17b0
[    0.183479] softirqs last  enabled at (0): [<ffffff80100f2af0>]
copy_process.isra.3.part.4+0x450/0x17b0
[    0.183483] softirqs last disabled at (0): [<0000000000000000>]
      (null)
[    0.183485] Preemption disabled at:
[    0.183493] [<ffffff801009b680>] secondary_start_kernel+0xc0/0x1f8
[    0.183501] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S
  5.0.0-rc3-00002-g4daf5b1 #372
[    0.183504] Hardware name: HiKey960 (DT)
[    0.183508] Call trace:
[    0.183515]  dump_backtrace+0x0/0x150
[    0.183518]  show_stack+0x24/0x30
[    0.183526]  dump_stack+0xa0/0xd4
[    0.183532]  ___might_sleep+0x1e4/0x240
[    0.183535]  __might_sleep+0x58/0x90
[    0.183540]  __mutex_lock+0x64/0x890
[    0.183543]  mutex_lock_nested+0x3c/0x50
[    0.183549]  static_key_enable_cpuslocked+0x64/0xd8
[    0.183556]  arch_timer_check_ool_workaround+0x208/0x260
[    0.183559]  arch_timer_starting_cpu+0xfc/0x2f8
[    0.183563]  cpuhp_invoke_callback+0xd8/0xce0
[    0.183567]  notify_cpu_starting+0x84/0xa0
[    0.183570]  secondary_start_kernel+0xec/0x1f8
[    0.183601] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.183618] arch_timer: CPU4: Trapping CNTVCT access
[    0.183625] CPU4: Booted secondary processor 0x0000000100 [0x410fd091]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
