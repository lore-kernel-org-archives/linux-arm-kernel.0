Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A56C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A19C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eKX/O0Xt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBHQqcBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A19C20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=28rhSTpe9/lI0TpCNBQgkvDy3KE9Q/mwH+HFAKMKQW0=; b=eKX/O0XtbN4hBC
	myxnEt5P+4uSqugsNOkl5+RHyQDOKLf4W448kk0kldYkrj5tLM+eYQiBDLLeNB4gmcawwp6mQT0DB
	GU08ak+dX5nKArHqUwAh7GWiqpZzccCXGhrUSw4uKLcGlcyEWDCZQjYeLcnUoGm4mWI4+zgNQlOem
	8mQzvsvWus50wMU/A7CRdjCWTu/Pfrj/OwyVEOFMOvAL7U6nGpOOyIB/sNRfYFsHel4eTrb9LagX4
	rQUZ+EB1MFyRzo2vr/R6HY148TjD2AQt50wZ56l8AFZjksDTmy3VAYf59+iBcGuRAEpWRlreRL5H5
	ix7140hsvn2uyOy+40vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkRqq-0007qr-LI; Fri, 18 Jan 2019 10:58:16 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkRqn-0007oZ-Os
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:58:15 +0000
Received: by mail-wr1-x42b.google.com with SMTP id j2so14575274wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 02:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hqW5bTVxkyVuhKIuJPQ4C2gt3hYjohFMEMSFlFTILDw=;
 b=FBHQqcBVe9XWvqjl7p0lAbyelhPo4Wjc+flSeDUNBh1yBYsC7PFqrIlTApVzAG8GlX
 S3cWyjqFO0KmRL4b+zpRfqksGic4JQ9J1ut7hR8kIH1igg48FN8TMou1irQPjvh8jqTp
 dOP3KQAtl0Cg47pppSHKiH5KWSypx2IXMQAhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hqW5bTVxkyVuhKIuJPQ4C2gt3hYjohFMEMSFlFTILDw=;
 b=CYQOm/CBAQzKlmoGhh/zg5T5LNkEkptBOXq8Xbi4SCNzgqatlW0Tny5m/mTihPIXLY
 k5N5TauoLsbeOfNTzD82jbRh+faTeSuyoY/BYcm3NkuhUJTUmzjqL99hdV2V567STzWl
 SQmY897J3uct0yrGA0Om3kfNpHw9FE8tTm1WL8HBXfbJwaqRq/uiLUK3oNGifaYC1kWe
 B1YthLmqjwwLqsT/5vrjCK8iIkGbUcdK5jKtln3HBKjMmTTUgaltS272tMlwmXeUUjsN
 O5xJ09EX1RXV6jLxdRY5mcVXj28T9bS471MGZQ9Ucu2T424ExvsvvltrED5I0lP7X+8q
 P8ng==
X-Gm-Message-State: AJcUukeS1plYksYK0W/SQ/AhkY0Jw705oMbnW0PgE//e2rIhyk7Q6jZB
 BwM9364av6HrmzIo565grWCRwQ==
X-Google-Smtp-Source: ALg8bN673NWhROkhM1FbMUMUTAyInYEvWlgIhuba1o6HieQgJ8Wac6e7YuABjrz6fHf0NBSAwnvZpg==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr16590868wrm.218.1547809091644; 
 Fri, 18 Jan 2019 02:58:11 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-20-152.w90-86.abo.wanadoo.fr. [90.86.223.152])
 by smtp.gmail.com with ESMTPSA id y13sm65345467wrn.73.2019.01.18.02.58.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 02:58:10 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: keescook@chromium.org
Subject: [PATCH 0/2] gcc-plugins: fixes for arm_ssp_per_task_plugin
Date: Fri, 18 Jan 2019 11:58:05 +0100
Message-Id: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_025813_803431_D77996E6 
X-CRM114-Status: UNSURE (   7.87  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, re.emese@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A couple of fixes to permit newer versions of GCC to use the stack
protector plugin for ARM.

Ard Biesheuvel (2):
  gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP mask
  gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+

 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
