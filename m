Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F91C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE719218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OZys85lG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="n2yeI7h8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE719218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YlcUKi6EkyPiRqh5166K1sFBACu/4OusV8SpV+PcGXk=; b=OZys85lGl7cdLb
	nZMQVY/H+aipvkbwt5HkJchPNtcpEkgJL2+Jn6APFc4NrwKJbV0dITxyclA3Z3HDSoSbFryM/wINK
	Fu1u/COtDevX6UiDzjPDUENTdVsCfFEAQCWVF0HSXlCfh6IKJBFaeSN2si68XcdrRplO8kWoqpRjJ
	+zJwiSeEQG4ibiXsfeTggAp29Dw57aPGpG8gsR8mcuQgzWxNBXvnFHLJgJSgxSWHVoHv8EUaEKD8z
	QrJdVT9sWhZ8Z/MxWlUB6LW48M6fQ1QG5AC/lN88qoihQTQQLf4TZWFnDzxGf0BeyW1bqZRYycy/O
	K/A5ZAtFhTbJcNd0yNeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcCJE-00045j-0u; Wed, 26 Dec 2018 16:45:28 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcCJA-00043H-G4
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 16:45:26 +0000
Received: by mail-qk1-x743.google.com with SMTP id n12so9560964qkh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=InwYWFVcgsNeL+HQcZ5vgHtIv1cvzFUFvu3UrzzVaBw=;
 b=n2yeI7h8aHMbPfRTciWj/doMgM6b2hrPX6d2Nj/RJqxw4rXomNTuaPW2Erzqdxudqj
 HNe4J7qjWuhAu+sr6kO2Cn9ZtG7nf3kjP2aoJHXeK3lK8Ps5PHigegMsS8th/kDj44RG
 2mFff9fAxK5Lhg7TT1GJ+S/ZVllpWgq26/9WsY+UpSgrZQxiaowZwLsfbGehuZbieptq
 +RKEDVN2NxOqxiU239+RxtiFJNFjTvJ5TDIv3+q7DUFMpMkha/70/Hj3FnN3EjHRMLai
 KTeD5ntD/a2Gl56CwuVqAuhsRChHnrdJGl+4yHROJecu0iOZFh265NPi+4ktGHw06pxr
 3qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=InwYWFVcgsNeL+HQcZ5vgHtIv1cvzFUFvu3UrzzVaBw=;
 b=HcT042ypwcnATg2a1dH4fH+P6NqOm1XXjIt4sUItcofzxo6T8WUk0F9/2e5+OjIjVZ
 hxMmV+36obwJZEJTK6mnvi4Velx5LGccy6+2yGHuZtX17q72hzJpwhm4e3xtOI9wTvqZ
 4/6VsjzYl8Gd7et5DYvclDymxpqcfLEMgeoZ3SizKma+W0zc8KxDY2Oo5gwCz3Jq72jh
 LCHMgWKMGVP+N60QvtQLfCoVmvQA6zz4faONJnpCWKGvEyAOXHzvzusTIP2mvGGUU23V
 REmPVtcbKfWEDvb6YqfbhpekpfdpjmmKAdZMpffwiLNm7fpO4mxVKqx7dXt3Eu67jTWt
 VrhA==
X-Gm-Message-State: AJcUuke1nIb3BRXX0UFW1ChqkhsnIhIsw8bAEswGZaXn6rBAsiLz8ULG
 0aA5UG0WT/v4M0mXPME6IX7kjQ==
X-Google-Smtp-Source: ALg8bN5hCYw0xiCyKIk/UBSJ8upSjDurDY60a3X/min2YuOsLsTeTR9K8nj0IoPeS3sKp4NPKWn6TQ==
X-Received: by 2002:ae9:ec02:: with SMTP id h2mr18855149qkg.84.1545842713028; 
 Wed, 26 Dec 2018 08:45:13 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id m41sm17874920qtc.58.2018.12.26.08.45.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Dec 2018 08:45:12 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org,
 rppt@linux.vnet.ibm.com, mhocko@suse.com, ard.biesheuvel@linaro.org,
 andrew.murray@arm.com, james.morse@arm.com, marc.zyngier@arm.com,
 sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com
Subject: [PATCH v3 1/3] arm_arch_timer: add macro for timer nbits
Date: Wed, 26 Dec 2018 11:45:07 -0500
Message-Id: <20181226164509.22916-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181226164509.22916-1-pasha.tatashin@soleen.com>
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_084524_577422_A72CC6B1 
X-CRM114-Status: GOOD (  12.66  )
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

The minimum value of bits arm defines for timer value is 56bits, add a new
macro ARCH_TIMER_NBITS to use it in code instead of hardcoding 56.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/clocksource/arm_arch_timer.c | 8 ++++----
 include/clocksource/arm_arch_timer.h | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..e4843ad48bd3 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -175,13 +175,13 @@ static struct clocksource clocksource_counter = {
 	.name	= "arch_sys_counter",
 	.rating	= 400,
 	.read	= arch_counter_read,
-	.mask	= CLOCKSOURCE_MASK(56),
+	.mask	= CLOCKSOURCE_MASK(ARCH_TIMER_NBITS),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static struct cyclecounter cyclecounter __ro_after_init = {
 	.read	= arch_counter_read_cc,
-	.mask	= CLOCKSOURCE_MASK(56),
+	.mask	= CLOCKSOURCE_MASK(ARCH_TIMER_NBITS),
 };
 
 struct ate_acpi_oem_info {
@@ -963,8 +963,8 @@ static void __init arch_counter_register(unsigned type)
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
 
-	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS,
+			     arch_timer_rate);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 349e5957c949..c485512e1d01 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -71,6 +71,9 @@ enum arch_timer_spi_nr {
 #define ARCH_TIMER_EVT_STREAM_FREQ				\
 	(USEC_PER_SEC / ARCH_TIMER_EVT_STREAM_PERIOD_US)
 
+/* 56 bits minimum, so we assume worst case rollover */
+#define	ARCH_TIMER_NBITS		56
+
 struct arch_timer_kvm_info {
 	struct timecounter timecounter;
 	int virtual_irq;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
