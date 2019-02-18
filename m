Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25DCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B394E21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JiWhEXLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B394E21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w6xA1XwnL/XGvVkveDG4QR4ZSs4gRUTahQPQW5T+RxQ=; b=JiWhEXLpTOZrOv
	fm0YljfJZ02L5dTcVhwAR7lmZQ0fhMVejGT3IAF2aMrn309fL0aKx663PIRUKBZH1cZjSV6b6+O0o
	xIxOtJcP649RWTkHUTPPXkF0CZmPUFTSg3r5l/3IUhlHmV36fAwC3BOcgX5FDi4e2iP1urkZNF2d2
	h/m8PTiLWyhNCjOau/8cW088ROgzrREJnGVv58YET7F2jFfM5dyVRDPdKVM2O79qkAeDrGKFrz/NS
	WiTwlXmiKEYtCvHXB14QBN222wiG9VpSRw+C7tI5pUqZUF3k94+EICT9vh7DKNxAeIaKV8fPS9XZn
	DnBMO1fb4T/KfjTCi+QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvq91-0005fD-BQ; Mon, 18 Feb 2019 21:08:07 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvq8m-0005OZ-11; Mon, 18 Feb 2019 21:07:53 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MwPjf-1hESyz1HV7-00sQM3; Mon, 18 Feb 2019 22:07:28 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Subject: [PATCH 5/8] unicore32: Fix __ARCH_WANT_STAT64 definition
Date: Mon, 18 Feb 2019 22:07:09 +0100
Message-Id: <20190218210712.3503891-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:e5iV7jAPMPcGjRPi5MYNZ2dkznZ8Mrfx++9ngOzQfg3eN/TiQ1R
 189AXFIfz0cS7YjZUjf7xpRIC+5HGDzQrVDpbwnWeWZYnSH6gDE4OS2+d9PddhFkBcsqNC3
 gkSMnhQ/1X5TPh7cDtrVgQk3tG6Ere1m238Mf0fY6tAGIKRw+GnPuguBJ/QmmtfBExPQkwj
 K2FyVc6iNYGZicULIu0mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gI5wfFjSFEE=:LWNxFn7RL5I+WsBjHLIVXM
 omzfoUukQpkdif1Aifk2CaM+uCLu97sodQrVqAKEmJNvL8vU6Rz9au8I7/6LYLLZ2Xefe1eyV
 yLVyxmJITR7cFaGJFSJZd1M+8eGYej0R3l54Fv/8S8RG9V6H+NHo+21tr+XgtPZI1lIZyCX0V
 7+2ZkslAxXFR1f9dW/f+LURiJgEol+sc9RxYBxrPxZmBSXpOXmIAIHIEUaLPlX3lQmfG7INRy
 6t/+5EEqHWX8EiwZ+IzrT7I4TV5KQwHVLcFvL1bUEHe7VJdUTsEuTWu0cnXqpwfffnPGKU2LE
 fwCgv2n584SKNZjerSO2/h38m3glzmb+jAPCsjG531KFMC3DxlWx/ODxizOg2YBQaaWJAGOrM
 O5DJRP/rCYfLXHLEXJznQHzpFW0iXSrQUdPx8Fqy6+JmUP87frzv0lqxkUp9DBTYzIcAnL23M
 PevSFPAOiAyZDx8D76O37xtLpeUKAZ3WqrhLhuR6rScgKhDLYRZhQAn2LU0ZCuh0pKi2EwSP4
 P0RK0vT6L/LizZRXGqGbc+xOyK0lTz1D1TR1UDUD7KuKGcgcde5rioT/7YltNq2n4OdsmcFkG
 YPsdOCZDgRO/gIiVXOoFxrCLvlhT3KuPIu2ZmnZyKHx7c+72B0dzBTBCtMVIQ96cojUzrxUL/
 g2+5u37brMmdGBJ2Snq66VsTdJMLw2bBbRfwT1aOBa/kfbVBefs52sMhbLLuIaM1hKxxDc79r
 lj/4nMMwaxinhvIehCaknN+7V1PQlxYngbqhyw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_130752_369831_932AB812 
X-CRM114-Status: GOOD (  10.49  )
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
Cc: linux-arch@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
 arnd@arndb.de, yury.norov@gmail.com, linux-api@vger.kernel.org,
 Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 linux-hexagon@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@pku.edu.cn>, Stafford Horne <shorne@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The __ARCH_WANT_STAT64 macro must be defined before including
asm-generic/unistd.h. I got this right for everything except
unicore32.

Fixes: bf4b6a7d371e ("y2038: Remove stat64 family from default syscall set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/unicore32/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
index 4e5e624f5d7e..54a7378a70b1 100644
--- a/arch/unicore32/include/uapi/asm/unistd.h
+++ b/arch/unicore32/include/uapi/asm/unistd.h
@@ -13,9 +13,9 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_TIME32_SYSCALLS
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
-#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
