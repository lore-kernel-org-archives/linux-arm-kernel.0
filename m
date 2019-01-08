Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D63CC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:31:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E8920827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GkloSs1R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gMmRvNkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E8920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NQL/4rpDElPUjSLm7+8juz+6hp3mM1DkYserdBPpRf4=; b=GkloSs1Rp8GsPa
	gu8L90V5zjuUyfZ3jjOfeQzeYQaTcpEg4tXB9ESlubya2v4N+RufJXiev7uwt6aSjRLk1Q4c2Lmio
	1XN+ojB+H/+AUMtq5RfYICdJwcpCn5P5vKe0SqIjP8X4stqfmI7ZNI2gav3R3hWWGs8qYkJNmFW9l
	Xse9nLHcjABBfupsa/ZHMtSYf5lfVmc44tEnNlHBXNJD4x7KuBCdXkF3ecWJJeMAvJ8wLVk26V0yU
	Dx+SW7fCd7qlRXZZ0NxVASBYJsMRr5YR4TOkcLB8rJaGgnbpVcewjOir/Itwvlj1z3IhAaFcTlRsm
	mb3cGj1RzIr8q+vxPT0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggrTj-0007kI-Gh; Tue, 08 Jan 2019 13:31:35 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggrTg-0007jg-11
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 13:31:33 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x08DVTUu075124;
 Tue, 8 Jan 2019 07:31:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546954289;
 bh=u/6FEYlxM96pwJ1Qm+SkmI5JogO6aWRB2nRQmlpOFAE=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=gMmRvNkgGIPsXslnbXAMXJt9F3y3xSnCzwnd10zH41j3BFIXlDlm+eQ7VyZ5a092w
 VS4ZeyPskbL+du/fXBpt9iZW1na6aXyBHyLKLgfYqpspp+WNgQExqLGFhRaZRK+PXD
 m3HvJujol3vGQFJEw99d5YDZCwWVdlSKCX9eQyIk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x08DVT5i120695
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Jan 2019 07:31:29 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 8
 Jan 2019 07:31:27 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 8 Jan 2019 07:31:27 -0600
Received: from gomoku.home (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x08DVMuf011668;
 Tue, 8 Jan 2019 07:31:25 -0600
From: Tero Kristo <t-kristo@ti.com>
To: <sboyd@kernel.org>, <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
 <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] dt-bindings: clock: ti,
 sci-clk: Add support for parsing clock info from DT
Date: Tue, 8 Jan 2019 15:30:21 +0200
Message-ID: <1546954223-9738-2-git-send-email-t-kristo@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546954223-9738-1-git-send-email-t-kristo@ti.com>
References: <1546954223-9738-1-git-send-email-t-kristo@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_053132_167595_17020B45 
X-CRM114-Status: GOOD (  13.55  )
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

By default, the available clock info is queried from firmware, which can
be quite a lengthy operation if there is a very large amount of clocks
available. Add option for parsing the used clocks from DT instead, and
only register these which can improve the boot time of the device quite
a lot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/devicetree/bindings/clock/ti,sci-clk.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
index 4e59dc6..c757ae1 100644
--- a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
+++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
@@ -18,6 +18,13 @@ Required properties:
   and clocks IDs for 66AK2G SoC are documented at
   http://processors.wiki.ti.com/index.php/TISCI#66AK2G02_Data
 
+Optional properties:
+-------------------
+- ti,scan-clocks-from-dt: Scan clock tree info from DT. By default,
+  clocks are queried from firmware, which can be rather slow operation,
+  especially if there is a really large number of clocks available out
+  of which only a handful are ever used by kernel.
+
 Examples:
 --------
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
