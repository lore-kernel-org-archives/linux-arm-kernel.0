Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546AEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:25:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D610620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qGLgSsvc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="CF2Qcit5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D610620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dRlcfPVN5kWRO098uVKRDKlWxfNKpHGovTnSgbjLxHA=; b=qGLgSsvcOUk0zEnoNU3LcAYMB5
	qdE6jEvyIMLw0FddocPfXiQsoGETr2vrAD87wr301pWlRwEBvVrfc+K3oz1llkXnPJLtntrX0S/gK
	7DUN+b3Xgl6Wq0ZUtDVQD59m0ZA0L+5SHUCKpxc1/HJ3zIIbujHNwV6aGEFz19DUL8qg4cFQGV0Eh
	hRQqfGpaoWMAzCeq65E0ni8UlXPMlxxQOdqUhZRvVwPqsyAeruWPlqrTvrAzyNffWgTbAqfbffYOW
	tBcmvIft/iqFqheHcyhttfsfZGa/v/gGIyGBGB0DPy1IEwPHWdkb4LbkCreXQC6Mirbgt7g7Jq/Ly
	0Q3uhSZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4HE-0003br-Jv; Fri, 08 Feb 2019 11:25:00 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4Gv-0002SP-P4
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:24:51 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 1956225BF20;
 Fri,  8 Feb 2019 22:14:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624472; bh=xjiK41YEs0DmzW1kYnR7YzTGqSgTamUKXBuJZ47aMLo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CF2Qcit5ZVlF1A/ji1TS2Lr8vhUJ6xDbONocd+TcIDHeX3PklsqR8+Ic5yGn9+2tI
 jSyMKYVYovzysiqw3p18arUfEKCFputu0HfYw4sTZ35ySTtVAOtvTkzKcpo+cxgQU8
 VjOuf4QdIPhZKZjW3kMDVDkaTMgiJFPUMIvRUK3w=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 63C079401DB; Fri,  8 Feb 2019 12:14:30 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] ARM: shmobile: Add missing dts files to MAINTAINERS
Date: Fri,  8 Feb 2019 12:14:27 +0100
Message-Id: <8d22020a7e1e540592e801a0aa0aebe938599f47.1549622472.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549622472.git.horms+renesas@verge.net.au>
References: <cover.1549622472.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_032442_164004_79992F85 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add some more patterns to the ARM/SHMOBILE ARM ARCHITECTURE
section of MAINTAINERS to complete the list of maintained dts files.

As of writing dts files covered are:
* arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
* arch/arm/boot/dts/iwg20d-q7-common.dtsi
* arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..f4c805c1a34b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2109,6 +2109,8 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm/boot/dts/emev2*
+F:	arch/arm/boot/dts/gr-peach*
+F:	arch/arm/boot/dts/iwg20d-q7*
 F:	arch/arm/boot/dts/r7s*
 F:	arch/arm/boot/dts/r8a*
 F:	arch/arm/boot/dts/r9a*
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
