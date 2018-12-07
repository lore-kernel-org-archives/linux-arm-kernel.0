Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE21DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:29:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E51D20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hk3qlXsP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oiml8qol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E51D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vrHTDH9cuGO/fGGlqUVk4AimloFmOoag9vYIyQGLjD4=; b=hk3
	qlXsPzmh6FV+gRf4Xc7g0N6uFU5+qNwnhjQmUUqrY02Kz3CqFdJt8DsV57f0IT2GWrd26iz+kPkwO
	t2BO/mEYfynjFErJRV+8VhusRDeH+CaliIAV+dSouVbI37Fy2KtyqKNCgyW75Fs4hPzi98M9/6Z17
	LhmMJww3RE31YaG37p0es2KabAFqerRl/g95DGZjxY2/hRAKig+/uI8rMUsMPYJwHj1tZBJ2nTbVj
	sz5+hEBBnjNmQXkr3lbAiljpWRnZ4Zfu8NMGMKqnR6Ph8N6iFpi7cVALA3JTHRtPp7dZRVrZfMmeG
	JE4uEiUVi5SDSyGi/BXM9fEHxjh09iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVMkR-00026u-Cl; Fri, 07 Dec 2018 20:29:19 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVMkO-000262-8F
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 20:29:17 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so4965284wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 12:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=WDVG6voduasP42cwv2/jCe1Drp8mfo4Vn8e2dcve1V4=;
 b=Oiml8qolI0resv+O8MKOatC6brBLUyWWj+J/5EZaYgE/diQMUzlaGoAnw/4E4wpXjf
 vN1aQtFqLVNNlk74eJmfG12EzYXr3fQRaKh2YFDQYk960vbEH2YwZbYzfoi+2lY/NJ+Z
 zMQqHSBZlwKlZN2WtJQ2NzvY/D9+Vml0Q+B24fi8u5qxmufeCwXvdimZHBGj32TeCUrl
 3CaiOEfh1g+t4Mfsms5yNevyLKZdlmlOX1kjfazkzbUl7yEI0Eil8LEQAZ/re4bRYN6j
 nwng2F5kEF7HIfU7NWW/ENGeZg7C/WvQp0advnVYKDU5CeBg/8XxPgCPn01gsGTCAK5w
 kt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WDVG6voduasP42cwv2/jCe1Drp8mfo4Vn8e2dcve1V4=;
 b=SvRIRqNsMew06iswRNBOhv5Llxldx1Fk+aSnJTILQTfMimJSKlYOrw/iwNt61vq0hf
 A2IvjNN5OGgFFPy8AcBfGJiuGYeqRPwiNs36D5OqswhFdjRh6a372dfHx/ogF6kYfcKs
 1l8cgQnsvqZBKBfPp166ZZ3rSKr5GweOFb+w4HLtAeri8AMwg9Ph1vmIctpCWq1cmqhX
 ccjWOBZrYKtw7pvxDHjYaAIqoABAY+sSwT2Fe1HI9WLIPwnmgkDtJKkV3K3MjTQDzNrP
 DxKUQW66rgDACsy9hOMNmeKuUO7uCvVRcc2peeWRJb/cysw6K3qKFYFZ3NAQTgIVJV8p
 iS/w==
X-Gm-Message-State: AA+aEWYpwGVs/Men8CPsQUcibYosaNszZK91Mqxt6MSnED+sMxo/Dsv9
 ZQuPhapzQUQA/vCIulCxR7ehrsBi
X-Google-Smtp-Source: AFSGD/VSkMkKvpfeiFs3dy3xjSAboYYR4ZmEVNcog9CPdTUFggRPqrJ/cNbJ0bG18f1V+Zw5jARO2Q==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr3125635wrn.27.1544214543649; 
 Fri, 07 Dec 2018 12:29:03 -0800 (PST)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz.
 [86.49.110.70])
 by smtp.gmail.com with ESMTPSA id v1sm5683409wrw.90.2018.12.07.12.29.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 12:29:02 -0800 (PST)
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: shmobile: Fix R-Car Gen2 regulator quirk
Date: Fri,  7 Dec 2018 21:28:58 +0100
Message-Id: <20181207202858.17129-1-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_122916_299372_7552B5A1 
X-CRM114-Status: GOOD (  14.91  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The quirk code currently detects all compatible I2C chips with a shared
IRQ line on all I2C busses, adds them into a list, and registers a bus
notifier. For every chip for which the bus notifier triggers, the quirk
code performs I2C transfer on that I2C bus for all addresses in the list.
The problem is that this may generate transfers to non-existing chips on
systems with multiple I2C busses.

This patch adds a check to verify that the I2C bus to which the chip with
shared IRQ is attached to matches the I2C bus of the chip which triggered
the bus notifier and only starts the I2C transfer if they match.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index d4774d8ff997..f78e5348bd4c 100644
--- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -40,6 +40,7 @@
 struct regulator_quirk {
 	struct list_head		list;
 	const struct of_device_id	*id;
+	struct device_node		*np;
 	struct of_phandle_args		irq_args;
 	struct i2c_msg			i2c_msg;
 	bool				shared;	/* IRQ line is shared */
@@ -102,6 +103,9 @@ static int regulator_quirk_notify(struct notifier_block *nb,
 		if (!pos->shared)
 			continue;
 
+		if (pos->np->parent != client->dev.parent->of_node)
+			continue;
+
 		dev_info(&client->dev, "clearing %s@0x%02x interrupts\n",
 			 pos->id->compatible, pos->i2c_msg.addr);
 
@@ -167,6 +171,7 @@ static int __init rcar_gen2_regulator_quirk(void)
 		memcpy(&quirk->i2c_msg, id->data, sizeof(quirk->i2c_msg));
 
 		quirk->id = id;
+		quirk->np = np;
 		quirk->i2c_msg.addr = addr;
 
 		ret = of_irq_parse_one(np, 0, argsa);
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
