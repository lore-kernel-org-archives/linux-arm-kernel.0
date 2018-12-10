Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57546C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:27:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C7620821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FuZzN+kr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSbgr9om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C7620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=G/7yotnp4ZgqAupPXlY1QncSTStDEIrEA8jXu3cpOv8=; b=FuZ
	zN+kr2qwSHXGdBS9U2cCkXYjEwjDMEBeG1927ecuG43EOtvANf0wVYvywunMIZyeiFwz6UDhB6Pnf
	S580o/tdltvvY/UPcmAIL9xGVbeuuJfRIFO9klHrMKBFI/eiNJoP1Hz+nHEK1f50wgW/qjEOkWIC+
	J59pewJHRXGpS0PeV2cpHwEprRqUB/7pmdQWwTsTpqbLuxOw6/MAdtRr/G9MrW/J/jXw9yTEfUwkx
	UlODrSYS+Atz7OmZ6QpH8B5SQOwy//h6doZz3EiHWg21radBPdIHxb//wVIiBDMdF5WfbhqCo8hnH
	iyq5yEAafMUd5riG/ye9sQYFt7ErcWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOOY-0007kp-DO; Mon, 10 Dec 2018 16:26:58 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOOU-0007jR-QT
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:26:56 +0000
Received: by mail-pl1-x642.google.com with SMTP id gn14so5470700plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=zbmStDBNmYRujmWOzPMjCrtqy+G4MLvgr+sv4jD/SdA=;
 b=QSbgr9om9u5opOgTyTZhKtKqHSXcep7JiYFmz3zpcY4S2L/qGGhwXRxsel/D67ndVx
 OOumnuhs2kZho6BVTmN1eqm9xmqsJDDTiSwFInOdFL1Vd1/TMmISEqGg5D4Jj/iQ/cJW
 08Qp/BvedocA5i89Utit4K77JW6yC2XI+YNmyUrlMIqUKhynkEiC0cy9dqWEktSSnOfQ
 TriqCIYoNqUKH3jyS4y6pVWEb4RXoE5eGkFLQadDiNn8H+O0jqeXrF1mO65urbFnw+P4
 vXerdqqWZbrPCUKeKh5b6wZTAuNje+QqnZr7p3vUD56qpkfcU7fZzrcubwaF2DyQsyOS
 sgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=zbmStDBNmYRujmWOzPMjCrtqy+G4MLvgr+sv4jD/SdA=;
 b=HmZlw0Y5vwhATFzWcYT1mlm/L3U7bA/IldrrDLGCHuRkKRvct2WBdcxegpYp+HWUqz
 NXmbAXsc8K8WIiM52jCjgPpCW49T5QGSK7Di1NMd2DIR+X+GHZQyHeqkA/iLjdg1YYCB
 P3iUzeiBjwCNs7ZP913LdxT8T88KvBeoO70gBfy3sC9mi45PbuoX5SU6UjorFE1+QjcY
 k037nae7KqdyKl/dF1YHwQ7he0CBM/ks1Txx0r/4/ROLxe0YvdapeglebDOhTkIfQ4vs
 rvSVDp7Lz0M25fLl2t56GsVkg0GNoOtURl6B4HCS0g4qLWoLV1X/VzjvJREyul2PrQzs
 MdFg==
X-Gm-Message-State: AA+aEWbunB9Z8aD7bqrmfvMcRSHLVgNjIT8eWbI3uKekDHyOTBe7iBrh
 0cakk8PGztU26LShzB7rSl4=
X-Google-Smtp-Source: AFSGD/XPYD3BN+bTIY5M/hlctqELfsTaJAEUf1sroItPS9sBMTlo8kq1Ia6DRr0RAdeuFZcc1d2Ljg==
X-Received: by 2002:a17:902:9897:: with SMTP id
 s23mr12157224plp.69.1544459204050; 
 Mon, 10 Dec 2018 08:26:44 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id q199sm19875892pfc.97.2018.12.10.08.26.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 08:26:43 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: lorenzo.pieralisi@arm.com,
	daniel.lezcano@linaro.org,
	rjw@rjwysocki.net
Subject: [PATCH v4] cpuidle: big.LITTLE: fix refcount leak
Date: Mon, 10 Dec 2018 11:26:41 -0500
Message-Id: <20181210162641.21029-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_082654_855496_B7B3885D 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
changes in v4:
-update tile
-refactor code,suggested by Daniel
---
 drivers/cpuidle/cpuidle-big_little.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index db2ede565f1a..b44476a1b7ad 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -167,6 +167,7 @@ static int __init bl_idle_init(void)
 {
 	int ret;
 	struct device_node *root = of_find_node_by_path("/");
+	const struct of_device_id *match_id;
 
 	if (!root)
 		return -ENODEV;
@@ -174,7 +175,11 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
+	match_id = of_match_node(compatible_machine_match, root);
+
+	of_node_put(root);
+
+	if (!match_id)
 		return -ENODEV;
 
 	if (!mcpm_is_available())
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
