Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:30:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6AC2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FfHAX/j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6AC2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YITah5EnSKYdilGIgPXGqpZB32dhkBt7bwiBF1TB8ZM=; b=FfH
	AX/j5N/3hZmhNNPIl28g/7h1NF7WTNR8+ulExyEM0ljfh3Z8Ruwci54r09QWj9mitOQDlwZBoKQpH
	Bb8yAnL1fT0Wtvry0OCeQsWKGGmU2IN2Qa11AxBahSXbg+XTUb1P77FMBEBh4htTUP+dPMEhwqDyT
	xqj+8c+tjKJSMxJZnxYt0lSA5qk/YGkeWJi7hvEcTDE3qTbVKbG5e/JdPJa0TqvDzMMl0grtqJLeT
	C6hCDw7pKlcue6Msl8Msx8VLReMW+CS+xdRty9m9k+ArH1vM7RbDp/UCbujfk3XI2bzVEWw/f7Zhd
	l99wnK0UFgM857QB3dD6OeNX8Rs0MvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfQUK-00062a-Fh; Fri, 04 Jan 2019 14:30:16 +0000
Received: from mout.gmx.net ([212.227.17.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfQUG-0005lR-Nw
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 14:30:14 +0000
Received: from localhost.localdomain ([113.116.156.175]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LtDpH-1hKQNS0TEJ-012rzF; Fri, 04 Jan 2019 15:30:05 +0100
From: Chengguang Xu <cgxu519@gmx.com>
To: linux@armlinux.org.uk
Subject: [PATCH] arm: fix a typo in decode-arm.c
Date: Fri,  4 Jan 2019 22:29:36 +0800
Message-Id: <20190104142936.24930-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:g9CNcVXS059sjRyOmesSfFjRmjjhnW1DybmLq1J+2ko5n3q34Hb
 IykVnAGbAlri9T2RJjh+N5Gvj7tMg1yiRS5Zzf6e6xnjO7ilbO2vArPOao4BwUPScljHOtY
 ygJQx6l9qcgahZPDuXRFkCR7owTF3yU7HApJft5v4Uu7S0Zl/YPFn1K2SZGhISpdstdHxmy
 KIFGmG83eEtV40EXgIkHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mn46Kwdr9E8=:iDQpRxDkIwO3/8Nio3WB9F
 vF+uU97Dk6i4eQwiuVtWxfX+5J3CIu0EsWHdoFowQXufqd3YLwYiZ1n8lvl1d8hTl4nJByU7v
 HVA5N+LWz0iBGspUbuytfDpTB1UjU+itU+Ym5aAkU2+WguGCu8jMIcviFIpgQmdy6Az4fP1uX
 90M8hUWLluGGmrabkwe4z1aWwJjjNTmsUVaUAemzPkjLW0QU+4cwLhv4YlcnUU4+AbzcWdK3V
 5iiGpnHEtxX2PuK3jffSZ/k38u2VcfXYRxjfUaMsp9fvjDWhStFIbT9ILMsuS7fqB5MQSzbSk
 g4+XL4ZM7cA4Dh9KnDV0DOg9OF4QhoC66Yhmi5FBbtz37fA/VdTdiLTub/fxpmlfCBIgJQu4W
 DyGoxBJ+yfbZYP9FAIVHT1MyhbPsytEazFF+P7yq3vDfhqQSCzoWdQzbKeB0cWSH4rlUdOgCA
 NSebeXbW7HBCe8GARARhtKZL0sTBKn9ByptI0WbE7cAwkYiL11Dwqn5xZNpoxJsSx55QUGZza
 2b/arCjvSPR4mpDIZBQDugMsQMChY53Iav8rS8W9xc1SH5NcldWRcRfVGe9vDua84iaNj555h
 GrEuzV+j4jqxPTjsyEQovcEH630WGtz90QQtZTINCQiPS73APgGPZv0kqKe5BX+boxlieeJeq
 XzdVT9F38GabFRxPBW9m3Sf8aLJmXZLJs6O7cnoDqEeH9aKTFSLAGldKFmcpM+Qalw/MBxTUD
 CxRiFf5j8xGu5G0aBVdIaxDKEJ5NUYHG78hF0EBWKkX1R5dUMD1ue1v854lV85sMtVdBiUQgH
 o9RytvR8h0BQSVHI3eNv0caDr+qpChUX96TUs4EgpSEpZQdoj/sDhfOTt4XF4kuCcGQt+rJAS
 +vdkoBCsCImR1c7W46gzlHwBk3tci7IB2/2eCG3Yk=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_063013_080553_EBA557A4 
X-CRM114-Status: UNSURE (   9.27  )
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
Cc: Chengguang Xu <cgxu519@gmx.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Just fix a typo in decode-arm.c

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 arch/arm/probes/decode-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/decode-arm.c b/arch/arm/probes/decode-arm.c
index f72c33a2dcfb..70fdbe48d3b5 100644
--- a/arch/arm/probes/decode-arm.c
+++ b/arch/arm/probes/decode-arm.c
@@ -29,7 +29,7 @@
 #define branch_displacement(insn) sign_extend(((insn) & 0xffffff) << 2, 25)
 
 /*
- * To avoid the complications of mimicing single-stepping on a
+ * To avoid the complications of mimicking single-stepping on a
  * processor without a Next-PC or a single-step mode, and to
  * avoid having to deal with the side-effects of boosting, we
  * simulate or emulate (almost) all ARM instructions.
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
