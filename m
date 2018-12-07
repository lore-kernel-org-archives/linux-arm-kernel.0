Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ECAC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:41:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30BC208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S3Rda08z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30BC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JWHTJrCkw9BCJiuHVFD0hWqaxFGz/lQE6kb8JJnOqPE=; b=S3Rda08zs/UfP5
	NUXiWEBVDeBb+JLvzDD0zvfbFLF6WdJMU0M+k8I7nXgCydOIrcPBDCefjw99zEwO9+5pVSRSLM3uj
	ZJ4oqV23WFF3qC6zLzxtjF6RvwxYRvezfWX99MxVGz/i2XiCLtUC28TldCOHaQPiSZoq0YDMmM5rK
	w5wovS7jiv5EJSmRy8188re64Wf/zSGLTunh1td8Sz3t2zF9s3db1DXPR1tnM2HTej8QWFjnpBOFH
	jSjkQd5j2lWz1Q6hrANCq4UCRy6GqP5Y+05IwWKd5YH8ryZ1p6yAlOa6xB+UUKCDmxdgmwGniW+Ue
	hdF78D/g2LqUSmSORTIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV58a-0005TV-MN; Fri, 07 Dec 2018 01:41:04 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV58X-0005SP-Sf
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 01:41:03 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 07 Dec 2018 10:40:50 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 1350460062;
 Fri,  7 Dec 2018 10:40:51 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Fri, 7 Dec 2018 10:40:51 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id AC20C40304;
 Fri,  7 Dec 2018 10:40:50 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 94AF4120304;
 Fri,  7 Dec 2018 10:40:50 +0900 (JST)
Date: Fri, 07 Dec 2018 10:40:50 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: arm64: WARN_ON_ONCE issue when resuming from hibernation
Message-Id: <20181207104049.5F64.4A936039@socionext.com>
MIME-Version: 1.0
X-Mailer: Becky! ver. 2.70 [ja]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_174102_042421_A13C4E28 
X-CRM114-Status: GOOD (  11.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello all,

I found that a WARN_ON_ONCE dump occured in the resuming sequence from
hibernation on arm64 SoC (I use UniPhier LD20 environment).

    ...
    Disabling non-boot CPUs ...
    CPU1: shutdown
    psci: CPU1 killed.
    CPU2: shutdown
    psci: CPU2 killed.
    CPU3: shutdown
    psci: CPU3 killed.
    WARNING: CPU: 0 PID: 1 at ../kernel/smp.c:416 smp_call_function_many+0xd4/0x350
    Modules linked in:
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc4 #1
    ...

I show the result of reading the code, however,
I'm not sure that this issue occurs in other arm64 SoC.

In the resuming sequence, once all CPUs are stopped and local IRQs
are disabled [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/power/hibernate.c?h=v4.20-rc4#n450

In case of arm64, flush_icache_range() will be called after that.
This calls kick_all_cpus_sync() to sync all CPUs with IPI, and
since local IRQs are disabled, WARN_ON_ONCE() will be called in
smp_call_function_many() [2].

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/smp.c?h=v4.20-rc4#n415

The following tree shows a part of the callgraph.

    resume_target_kernel()
    +- local_irq_disable()
    +- swsusp_arch_resume()				/* for arm64 */
       +- create_safe_exec_page()			/* for arm64 */
          +- flush_icache_range()			/* for arm64 */
             +- kick_all_cpus_sync()
                +- smp_call_function()
                   +- smp_call_function_many()
                      +- WARN_ON_ONCE(irq_disabled())

What is the possible way to solve this issue?

Thank you,

---
Best Regards,
Kunihiko Hayashi



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
