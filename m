Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF99C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:20:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703C620867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aPJrH0GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703C620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EDPnclLHWHbx9E5IWA84REQUH5IGY2BeISBtDiolp3I=; b=aPJrH0GCQyMnnM
	iSX3yDZ4fPnhwOqecNSu71GVpg6kh6Wb6tJWNPVAoNv8kUNtfhlu0DHSLa+7dN3++jRS7qgVT25oY
	vTwDDFCNZI7uKlf/rRCvK33mcbJ/Q6vjZebVtYiK3D4edhHz6Z4FmfLGYf8EGw7KrpUGKVHAZH79f
	fDAgpxR2hcaHVX/2UfkoxfIVy8lxlvRTEq9L6oELp0C6WcelmtqMYdQaIxcYS1wveUbUaObSgyF5h
	a8KeiwWYh2NjLLvxIP/7kcXiaOlofG9n22BpmN5Kay6k0zfjh6bUP7rW1xan7obMhBwITebVCupw+
	5jIYBNt0XQXgrEoZc4qQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSiiQ-0002Lu-8T; Fri, 30 Nov 2018 13:20:18 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSiiK-00015r-1U
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:20:15 +0000
Received: by mail-lj1-f194.google.com with SMTP id z80-v6so4951041ljb.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 05:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=MYK1Fe1SMo3XkBqdmK20b/a6CPuB50O2uKZhV3bkitM=;
 b=k3gSTMWls0uj5hNGTJRwZtpV74UNkOQJ238HcCvreJ/hOxBtkK/rn08oEPwjygTEOA
 pLt7qUJnvQ5ymUc5Q4eCMqtMt9ZQS18OTZFfTveAg83Prn4RQfXgqiyVz8OGlGzd1MGX
 uBmlZEpLrMGOXMCOUWroBjimPRZ6sdv2aXTYHB8KWHnTj2v6AS2w1ojfAQUarKVD3J+/
 JQjTpIIWyB2cBVY6Tp8H4yna++nfTOgbw8WlR0W6sgwteLg4B5Rxt2Z29q7kKjqLdeWQ
 MYZXYslKOynFBcmYcVNvX4F0v48rHBh+ms//c1wN/bnw3jnRUDi/8vPf4Ok5LFW3rRZb
 x2gA==
X-Gm-Message-State: AA+aEWZF4cLWguTv+vdmN4u0yJb7SC67ZJIFUqZlat019J5/7qoJcRQw
 kjbO5Ns0Fv+Dl/0bq39HsCs=
X-Google-Smtp-Source: AFSGD/Ug4nwyFB+Fak6D+Ks51fspieVWWH94yQHG7jlNyW+kdC2/h8GHEEwPZjRnekNlGWcNwd21YQ==
X-Received: by 2002:a2e:91d1:: with SMTP id
 u17-v6mr3846732ljg.160.1543583999439; 
 Fri, 30 Nov 2018 05:19:59 -0800 (PST)
Received: from localhost.localdomain ([213.87.138.170])
 by smtp.gmail.com with ESMTPSA id c22sm802455lfd.88.2018.11.30.05.19.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 05:19:58 -0800 (PST)
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
Subject: [PATCH 1/1] stackleak: Register the 'stackleak_cleanup' pass before
 the 'mach' pass
Date: Fri, 30 Nov 2018 16:19:47 +0300
Message-Id: <1543583987-27948-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_052012_544067_0B135232 
X-CRM114-Status: GOOD (  13.79  )
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
the 'mach' pass, which performs the machine dependent code transformations.
It's the moment when the stack frame size is final and function prologues
and epilogues are already generated.

[1] https://www.openwall.com/lists/kernel-hardening/2018/11/23/2

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 2f48da9..6f41b32 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
 						PASS_POS_INSERT_BEFORE);
 
 	/*
-	 * The stackleak_cleanup pass should be executed after the
-	 * "reload" pass, when the stack frame size is final.
+	 * The stackleak_cleanup pass should be executed before the "mach"
+	 * pass, which performs the machine dependent code transformations.
+	 * It's the moment when the stack frame size is already final and
+	 * function prologues and epilogues are generated.
 	 */
-	PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER);
+	PASS_INFO(stackleak_cleanup, "mach", 1, PASS_POS_INSERT_BEFORE);
 
 	if (!plugin_default_version_check(version, &gcc_version)) {
 		error(G_("incompatible gcc/plugin versions"));
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
