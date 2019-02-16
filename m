Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E5DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:32:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0739C222E6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Egw6uZXv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaHX6me/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0739C222E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=upBpOwWtS0szMgn7Y1nJ3XaPeZWbJESrR3qCu9TbiII=; b=Egw
	6uZXvuyyTtbdLmfRJkvZvYnXHcEsgjve7iGljxgqHAy9Y0j2W7MhrUoCI5UKZaK4NEiyYY+9nQlLX
	jM7jScVVf/12AztC7p1NT11b0aZalFZ9GKZsjfdVwk13JwRklKbll3A1dq1ORWwLi270dKx7WoRdj
	4NXaTrYB3jamaXnLeTtpK32x5EBy/r9+tCgTTvQNp6baEYJHVCMeL0fJeg0MomRLARQcKOjAcIF9Q
	ilSxm/Y8sMPppH/HxGwrAmq+jOEeMDITM5FYOajub1R7ffM1tkG3M939uZ5hNNeOxv602hl6COQJG
	bHHZ2JRGBJ+ACHSS/lA/lxYTAWD20bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv2sk-00084V-Rt; Sat, 16 Feb 2019 16:32:02 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv2sg-00083M-VQ
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 16:32:00 +0000
Received: by mail-pg1-x541.google.com with SMTP id b2so537906pgl.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=LO3QrEf9owC5ZOEMrXxiFtSgd/NWCotfP8eeokdC2i8=;
 b=PaHX6me/h9dvQWxmJNZs39smveT2uy2UddFwRbuTcGq/9ARB9PsJt0pSJ10sloH9SE
 /8+G0FtEAB/xfzk9RJ9XiDegqWST7Gjhly2pAY2GkR0KpMfo56rf9OOq/YKV53KLQ4lU
 hmp+5KVM29VeOS5/j+etuOjOf0N1C/tHQt9/c2SAYZT9vWpv8uAf2OiWcw/RHQScAlNu
 +jVA5cRmFGRdWvc928IxlO1XIkUg2V5RVSEX/VW9/QlTlX1Zmz9pfW3p8FuGaSf4MprX
 PkF3tTwGBukjOGontQiOiW9nYqRS4gtj2ju94V593DGUYUE6TBMk8LJNYw33ffKIFdlF
 ouJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LO3QrEf9owC5ZOEMrXxiFtSgd/NWCotfP8eeokdC2i8=;
 b=FZPCiaS5b7aT3vAWoVGx97/HrhCB2RTNzQyuqQlYIXUA0phiBhYVhIWgzsnAYHHPqF
 D6vMK6SEUeq1U5FkEtAvpHM85luUhbeBlOCgLPj3MsAecgGerzmhTeNem6LbYR8z7NFL
 h/KN+A6FsVGoyjS8iW7/0AkG9AlIdmJRCzwcJXSgTuGwFUJl/OtGHXbzwgRl0Jy8XzoV
 g6pWqI+KAqv7UXf5Ntg6lJSEP0trXAhELBltiZVDVoND0StPFuSsjgNEJQ2cffgrJDqm
 FPgyORbnZizaAD1LlSZURWulPNtMge6g44B1lnjKyIIetFelEc641FvdlLPPUwxXlWFk
 Pb/g==
X-Gm-Message-State: AHQUAuZgMCUUyzvRP+/7cJaivCj4TFLNScv9WUtUQeEp5oQX+PgUGQxv
 hI9asUO57SL2tmlIBm0bdkg=
X-Google-Smtp-Source: AHgI3IZA8RrwU96a2b4ROhL2T4Xuw9ulV3+X8XQn3r4wK1JP1Szg2+fr5WaoBClngjdv4YK0LszfJg==
X-Received: by 2002:a63:f10c:: with SMTP id f12mr14667460pgi.374.1550334715958; 
 Sat, 16 Feb 2019 08:31:55 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id l22sm14763633pfj.179.2019.02.16.08.31.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 08:31:55 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: sudeep.holla@arm.com,
	rjw@rjwysocki.net,
	viresh.kumar@linaro.org
Subject: [PATCH] cpufreq: scmi: fix use-after-free in scmi_cpufreq_exit()
Date: Sat, 16 Feb 2019 11:31:48 -0500
Message-Id: <20190216163148.12375-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_083159_015536_8495FCF5 
X-CRM114-Status: GOOD (  12.30  )
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

This issue was detected with the help of Coccinelle. So
change the order of function calls to fix it.

Fixes: 1690d8bb91e37 (cpufreq: scpi/scmi: Fix freeing of dynamic OPPs)

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 242c3370544e..9ed46d188cb5 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -187,8 +187,8 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	kfree(priv);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	kfree(priv);
 
 	return 0;
 }
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
