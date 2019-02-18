Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F77BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:47:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39282184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rt4CsfUw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="q43yr37d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39282184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bZ0j2Plwej2wX3EocTkke8ukvebFfED/O7yJFu7Ml9k=; b=rt4CsfUwMYrOXK
	DKXvDdqwdKRytKGfVj7I0k/OyBMh20VsYR8drwn1J1XepwiXAHngmm8GH35Dedx9ztgV2qjkc9HzF
	VUf2E4gAr31v5h4dlD/ibOZ5P4rLHC9ZWU4StstGSODpg5+c0fQjlPCTxgm+DtohpEPwsFE8dDEGI
	BdAI6OVj6eCO/8faNuOeM1cI/IqZbIFcqd78F/FzTeMnqSEHdORdM1GS9bxHY7O6TzAoEU/aNf7Mc
	lUXUYLrP/S++vy8/p4Rx5lxEUvMwSii4q/H26YbzNNzgZoIIS1Xq6MPnCBMvkGvUBOn7As9ErCndm
	KgtwCGksZFYNsQRTFXhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvYxv-00081F-81; Mon, 18 Feb 2019 02:47:31 +0000
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvYxr-00080p-Qw
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 02:47:29 +0000
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5EB858025D;
 Mon, 18 Feb 2019 15:46:59 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1550458019;
 bh=n1alTCC7WHm6zo9Ntn3rKKP6y1i5sw0ivAch/0Pk6pY=;
 h=From:To:Cc:Subject:Date;
 b=q43yr37d5ZEeKVh3FltxlV03mPzWYQfbuXlwrStnrGAt/8bur8wAx+nT3PQDMrhR6
 UssJFDNQLhP5gLUE7Xsbvr9tDRgxcXf/eZeZ1Ng8a84SHe/6IVJMaF8ysuxsgjpCoG
 XJSRHD5rZ1WreLUCMdiugOUup2gz/krrxkdfSHryckMi8OKgyNEta8AcoTCji3IViI
 h6QVL/XvsLi3VAHXAg2EQjimIkC2L8dqQK85dpPIv+m7nzaa7cDCIyYNA7MNxqKWIM
 ESZaDPBQFDWXa+bxhDo/I1EjevObbLnqoqTAi5/JAYvNp3IoFFfp0fL0+0bejSj+OM
 vEuWlChZPNgBQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with
 Trustwave SEG (v7, 5, 8, 10121)
 id <B5c6a1ca10000>; Mon, 18 Feb 2019 15:46:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
 by smtp (Postfix) with ESMTP id 7918A13EEFC;
 Mon, 18 Feb 2019 15:46:57 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
 id 626091E111B; Mon, 18 Feb 2019 15:46:57 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andrew@lunn.ch,
	jason@lakedaemon.net,
	gregory.clement@bootlin.com
Subject: [PATCH] ARM: mvebu: kirkwood: remove error message when retrieving
 mac address
Date: Mon, 18 Feb 2019 15:46:45 +1300
Message-Id: <20190218024645.29059-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
x-atlnz-ls: pat
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_184728_105953_70ACD1A9 
X-CRM114-Status: GOOD (  11.77  )
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
Cc: Russell King <linux@armlinux.org.uk>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Kirkwood has always had the ability to retrieve the local-mac-address
from the hardware (usually this was configured by the bootloader). This
is particularly useful when dealing with a legacy non-DT aware
bootloader.

The "error" message just indicated that the board used an old bootloader
and in many cases users can't do anything about this. The message
probably should have been pr_info() to inform the user that the kernel
has been helpful but rather than than let's remove it entirely to make
the kernel less noisy.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/mach-mvebu/kirkwood.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 0aa88105d46e..bf3ff0f580c2 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -107,8 +107,6 @@ static void __init kirkwood_dt_eth_fixup(void)
 		clk_prepare_enable(clk);
 
 		/* store MAC address register contents in local-mac-address */
-		pr_err(FW_INFO "%pOF: local-mac-address is not set\n", np);
-
 		pmac = kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
 		if (!pmac)
 			goto eth_fixup_no_mem;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
