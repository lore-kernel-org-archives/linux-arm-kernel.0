Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B66DC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:13:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBD420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MRXMyknO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBD420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cba1mphr+a66RuSFsnM+H5jKKdrpRK3mDYDwyl+l6p0=; b=MRXMyknOCEeky8
	QPmKzNUY8SMdjw4zoEPpJQnKpX/QuLWhCC+s3AAwI9Q6e5zdFz5ZNfpgcG4PTSpeWSAQWoQPQ3pN7
	+hK0Bo6p2EqCJS35xMz5HL6py7HtT9qhHUsqrsF4Yv4oMNWWMpPOYY5x1PjFE4wGmx2X3Kift2/bq
	LGeHmKLCtCql8D8uGnOtqrFd0AjsOjO1AQpaDsUp++G3AMvAzSXDkjAC4Njxbb8jlCFvZ3954bK66
	yO6NWR5qSX8rsTXAfmGB3Bgvn0qsiz9amtZnRXYFSTVhcdatlmFoOUOHRhpP+QYRkCdFlHBOjQrq2
	EgXxU0Tk41EM+Vk1QxgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvLN-0005Cq-Fg; Thu, 06 Dec 2018 15:13:37 +0000
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvLH-0005Bz-Pu
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:13:35 +0000
Received: by mail-lf1-f67.google.com with SMTP id f23so583544lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=Fe3/yqBpf9nSMtaMboYSUItlGt6aYnnhkmOZpRL34kY=;
 b=J/b3sILuKujwtHPq54PFd0N5jrjPMkpG2wjkAJo0MQKX7vXqFnCe31Jwyvb1ExeK10
 6kPN0IrqXJL/7ps18hiwUjQi7hOYzUq/57ortwxPENvhyem0J4A+sv2w1kQ67c/bGt4M
 GOy2hrq7YM4lzD+5jKkX1Xtl9q69hdFZg1h3h2XObYd8PmCy6RiRJCCDF5/V0uUBy+5B
 AUtpTRNtbnSv7/z14MSX6uZ2uUSo7K50823gwr0YBw2bfYWMLbDA9AOXLkLmJNbsRR+u
 sRiIf++erbltRiMpS6QPj3qTPuGiC5GoveDLPfOX9j+yWBkInFFHJB9Aki5OfdE+ujUj
 8Q8g==
X-Gm-Message-State: AA+aEWYPM3BwTeg3FvN1H7miumMyXLvQpHYPdmmtml7QRPnmYPqybKOT
 Lxzj0sOPrrVxDLxYRVrUgMk=
X-Google-Smtp-Source: AFSGD/UKqwvqngJ4zSOCF6af7JvT8zoH8dIIShluX5oZq/1xPpdDhagFHSIvHngV7rawyO9gEl2mTQ==
X-Received: by 2002:a19:945b:: with SMTP id w88mr16333003lfd.15.1544109200176; 
 Thu, 06 Dec 2018 07:13:20 -0800 (PST)
Received: from localhost.localdomain ([213.87.131.37])
 by smtp.gmail.com with ESMTPSA id h3sm115222lfb.49.2018.12.06.07.13.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Dec 2018 07:13:19 -0800 (PST)
From: Alexander Popov <alex.popov@linux.com>
To: kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Florian Weimer <fweimer@redhat.com>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Alexander Monakov <amonakov@ispras.ru>, Tycho Andersen <tycho@tycho.ws>,
 Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Emese Revfy <re.emese@gmail.com>, Thomas Garnier <thgarnie@google.com>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, H Peter Anvin <hpa@zytor.com>,
 David S Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 gcc@gcc.gnu.org, alex.popov@linux.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] stackleak: Register the 'stackleak_cleanup' pass
 before the '*free_cfg' pass
Date: Thu,  6 Dec 2018 18:13:07 +0300
Message-Id: <1544109187-13805-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_071331_847799_5521BE0F 
X-CRM114-Status: GOOD (  14.15  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently the 'stackleak_cleanup' pass deleting a CALL insn is executed
after the 'reload' pass. That allows gcc to do some weird optimization in
function prologues and epilogues, which are generated later [1].

Let's avoid that by registering the 'stackleak_cleanup' pass before
the '*free_cfg' pass. It's the moment when the stack frame size is
already final, function prologues and epilogues are generated, and the
machine-dependent code transformations are not done.

[1] https://www.openwall.com/lists/kernel-hardening/2018/11/23/2

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 2f48da9..dbd3746 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
 						PASS_POS_INSERT_BEFORE);
 
 	/*
-	 * The stackleak_cleanup pass should be executed after the
-	 * "reload" pass, when the stack frame size is final.
+	 * The stackleak_cleanup pass should be executed before the "*free_cfg"
+	 * pass. It's the moment when the stack frame size is already final,
+	 * function prologues and epilogues are generated, and the
+	 * machine-dependent code transformations are not done.
 	 */
-	PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER);
+	PASS_INFO(stackleak_cleanup, "*free_cfg", 1, PASS_POS_INSERT_BEFORE);
 
 	if (!plugin_default_version_check(version, &gcc_version)) {
 		error(G_("incompatible gcc/plugin versions"));
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
