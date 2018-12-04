Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6D6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:15:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB842082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iT0d33Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB842082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=GtZbHxNE5ZJYhrq69THgJHPO5nuhj8MuHkeua2sr284=; b=iT0
	d33FpFc2JOJHI+gpFD8+sikIYJoQcGX1/1gz+2XfXm7fIHpWMLupXhEeCkdvdWilKLDYtyMi2NNFk
	oLMjhzwnlm6Ex+qkmuaRmxHKKXBZvSjTeGvUkgOXhe479fjCBG2IK6lKwlbBG+Y5gj75E5ipqAF8Y
	bJ3zJqA5c0G7a9+qBgCsovt8Q57ZA4af1oCvR3QZL/A5SGEcDy1IN/yX3Phzllo4MawAIMfin66SP
	5EmL8S1NeJ/S08LuefuUm6g+a1NNvha/2cCMqVf237+R5mrVIUQwwt+TxzX0LTIhkGY3+OtJLybUh
	/rhsap9oyjthxK/ehRTgwZavcZIeB7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBTs-0000Dt-JB; Tue, 04 Dec 2018 14:15:20 +0000
Received: from bastet.se.axis.com ([195.60.68.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBTl-0007Kd-2j
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:15:16 +0000
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 53EF31850C;
 Tue,  4 Dec 2018 15:14:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id B9KJkER89gtD; Tue,  4 Dec 2018 15:14:57 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bastet.se.axis.com (Postfix) with ESMTPS id 49AE818505;
 Tue,  4 Dec 2018 15:14:57 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A44B1E072;
 Tue,  4 Dec 2018 15:14:57 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2B0B1E06A;
 Tue,  4 Dec 2018 15:14:56 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder03.se.axis.com (Postfix) with ESMTP;
 Tue,  4 Dec 2018 15:14:56 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
 by seth.se.axis.com (Postfix) with ESMTP id E60E2201;
 Tue,  4 Dec 2018 15:14:56 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
 id E0FBA800D4; Tue,  4 Dec 2018 15:14:56 +0100 (CET)
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: linux@armlinux.org.uk,
	jeyu@kernel.org
Subject: [PATCH v5 1/2] module: Overwrite st_size instead of st_info
Date: Tue,  4 Dec 2018 15:14:14 +0100
Message-Id: <20181204141415.969-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_061513_403249_B1380724 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: Vincent Whitchurch <rabinv@axis.com>, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

st_info is currently overwritten after relocation and used to store the
elf_type().  However, we're going to need it fix kallsyms on ARM's
Thumb-2 kernels, so preserve st_info and overwrite the st_size field
instead.  st_size is neither used by the module core nor by any
architecture.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v5: Add Dave Martin's Reviewed-by
v4: Split out to separate patch.  Use st_size instead of st_other.
v1-v3: See PATCH 2/2

 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..3d86a38b580c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 
 	/* Set types up while we still have access to sections. */
 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
-		mod->kallsyms->symtab[i].st_info
+		mod->kallsyms->symtab[i].st_size
 			= elf_type(&mod->kallsyms->symtab[i], info);
 
 	/* Now populate the cut down core kallsyms for after init. */
@@ -4061,7 +4061,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
 			*value = kallsyms->symtab[symnum].st_value;
-			*type = kallsyms->symtab[symnum].st_info;
+			*type = kallsyms->symtab[symnum].st_size;
 			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
