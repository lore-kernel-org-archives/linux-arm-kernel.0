Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDBFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C07320823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lj6r3sWj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlrM1972"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C07320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1yyG7zikAnUGj3fAUurgIpfKRP6g9xeWENGYGrBh/iU=; b=Lj6r3sWjk/G0l4
	uC8VzW3cEbt13fnip8pPhWm1RlFVdgDRnwi7m/9MkIYn+QlQJ80TDZAybFcOfFi6uzl5JXaqGf4WP
	/UKmsyjOcVdGVaYQBB2QYuYxqrgXPpL4pQHf3JBeA/rLUf5HMr/wwoWXmHl+01nwj27A4HubKsLbq
	wzp0cfVgztvFwI/H7tEYglV07Pb3L0LwN1wqwwrALyI6slprQKB/FyYn/0GgHwJHDEzQroYZ3BF+p
	SbzwM0BykCbNjMU+XQKYZGemG++XaU5+Gd20Rd2FfkqCzSqrAuQkOFr2zBinDY7xPzr1AMBtSNP/c
	9UjSWi5HVfKpEljZDibA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkRrH-0008Gs-Iy; Fri, 18 Jan 2019 10:58:43 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkRqp-0007pr-IS
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:58:17 +0000
Received: by mail-wr1-x441.google.com with SMTP id p4so14497836wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 02:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4PBOByBDyORJotrQHfAdkrD3rgX1OelOnufeKqsU2dQ=;
 b=AlrM1972m+0wXMXOuZvU17EhloZ3TgU+0dIl+cd6pVPtOCjjKqwzIbZ3qrSe2qlVEW
 Hw9ggdG4YeVmAHafc5+n+akYNC0sXtYESZj6frJhFweaIHa/bj8H8YM6vI5nxTZSygcM
 9vR54EMAC2oeYRxIsG4Cmg43eJLzQ9buONYUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4PBOByBDyORJotrQHfAdkrD3rgX1OelOnufeKqsU2dQ=;
 b=E7T4hxD1tIDk81mMepJF7ZCY2ztw5DFjcfEgZFqgYHDrJUtesZxtXvsjWgfV+TGd5q
 ppdshdRRaHXllrluljwnEfd5VebNmlxqhaA/NAILQ6kEdrA0yWw3LVJOwKPLSIT3FZM7
 3hIGQ4z76vLT/PsGmh/3wYQQiIrU+gwqmhDYg/sE+du+A6ZdhijUwQn9lWGoJRiFfsr2
 Qoxkp677bBIry7Yur6+tqY0mSj0YG8nP7c6/m/STc365xuA5UBGrH08e4yPOJrypI+5o
 p1CeM8c6gMHzCnY+vDuDUMtbjGjJbrNJQtWCEojh9vrB2InexGtZKbxxjV8GqDaEOE0Q
 smYg==
X-Gm-Message-State: AJcUukcEJ87aRPrt5nxKTIWsWO3zMXLU7jG2MqBHnDBJIOXe+NQOcyVK
 I5Te9aC5y5xWXmg1TF/Ig19jUg==
X-Google-Smtp-Source: ALg8bN6XNctV/3mjt9tXUIVh909CcvPA7/B0iHznoaW1oLjZTDN2yXXDqL2opy2cpSGYg4eMK78sIQ==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr17072968wrp.59.1547809094054; 
 Fri, 18 Jan 2019 02:58:14 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-20-152.w90-86.abo.wanadoo.fr. [90.86.223.152])
 by smtp.gmail.com with ESMTPSA id y13sm65345467wrn.73.2019.01.18.02.58.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 02:58:13 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: keescook@chromium.org
Subject: [PATCH 2/2] gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+
Date: Fri, 18 Jan 2019 11:58:07 +0100
Message-Id: <20190118105807.26425-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
References: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_025815_729565_10DE7B01 
X-CRM114-Status: GOOD (  12.75  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, re.emese@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

GCC 9 reworks the way the references to the stack canary are
emitted, to prevent the value from being spilled to the stack
before the final comparison in the epilogue, defeating the
purpose, given that the spill slot is under control of the
attacker that we are protecting ourselves from.

Since our canary value address is obtained without accessing
memory (as opposed to pre-v7 code that will obtain it from a
literal pool), it is unlikely (although not guaranteed) that
the compiler will spill the canary value in the same way, so
let's just disable this improvement when building with GCC9+.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
index a65fbefb8501..89c47f57d1ce 100644
--- a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
+++ b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
@@ -53,6 +53,19 @@ static unsigned int arm_pertask_ssp_rtl_execute(void)
 #define NO_GATE
 #include "gcc-generate-rtl-pass.h"
 
+#if BUILDING_GCC_VERSION >= 9000
+static bool no(void)
+{
+	return false;
+}
+
+static void arm_pertask_ssp_start_unit(void *gcc_data, void *user_data)
+{
+	targetm.have_stack_protect_combined_set = no;
+	targetm.have_stack_protect_combined_test = no;
+}
+#endif
+
 __visible int plugin_init(struct plugin_name_args *plugin_info,
 			  struct plugin_gcc_version *version)
 {
@@ -100,5 +113,10 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
 	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
 			  NULL, &arm_pertask_ssp_rtl_pass_info);
 
+#if BUILDING_GCC_VERSION >= 9000
+	register_callback(plugin_info->base_name, PLUGIN_START_UNIT,
+			  arm_pertask_ssp_start_unit, NULL);
+#endif
+
 	return 0;
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
