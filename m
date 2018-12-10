Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FABC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:52:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6222086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pSr7qjzz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mQ0IrP52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6222086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zSIIyqPA+u0VJaFG+1m3j3isf7b1ziBvsIdumkWnnYg=; b=pSr7qjzzUai98DtkEBClPXsvxD
	MRlRYa0IUHlrIY0d5rKob1U/7moqAFqPoUIIidWn9b5nrrArQdnCQXx5tN8vejJVSW1y/2+dchY7L
	6YfsKPmpWK8aEMQh4dt5+zDnmetO3W/dc/S1gv6CIMEglusW0RvvQC2ofSQzt/ixa6AZtdWz3nBu+
	ba3NUA3FrjPtKWrgu+++M3EWc2E7CmcItp0jhmyTkMm5IuUa82oaaNxgly1j/Q4h5ODPq3TOGUAk+
	ienW43TWvrraydf5P0wwngSIX557b7hwWtOiZ1T+s0MD2/+73XsW5/8zBfHo1qifbMhE6u1dcPK6t
	6MVzSmmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLzS-0002PA-2A; Mon, 10 Dec 2018 13:52:54 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLzI-0002Az-GW
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:52:48 +0000
Received: by mail-qk1-x742.google.com with SMTP id y16so6476846qki.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8RbBHMlHC4MBAxHJ/VKYOqUPgKWsUsgjDHJ/6QsaCV4=;
 b=mQ0IrP52cV3hOoqcWLeYg1PX6fs9QsNDlX6cQlAXGsO4doPFW969At55QsnHgFaGDA
 u+ddBCkDjiqLEwyD5rX28kEIZJkQtb1+c+8IIhK8a8222JRMc6P/YQUmqgvL6ar1PGiq
 fvByncSn08DCn06qSPc7wZXNqWGYzTHgMz+Cbe+eL4PPUm1UTS0z6bX56QiO76fY68Aj
 6wb9gcVpX1KRQPgJdWuKbr11jG88BaMSt9qEZ88zw4HsZhaFuM54ASuRjorwYrHgImLx
 KKLfOlReA81HL3hXlipz7/gIq4O/ucKawGYEHTFDdh199eAgaYAmwmW9iftqTUfAFmZ3
 mSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8RbBHMlHC4MBAxHJ/VKYOqUPgKWsUsgjDHJ/6QsaCV4=;
 b=a2N9U7HHfUPRaQk6pP2jyWn8KP+RAXD22Jd7qGZ2CY+4qAwGgu5pEoU4ja40/ObP1r
 yd9Xr+Rzd5pnawVRzcoz2Uy92+EseBp43za7CkEUuMY2sUcJxZwCFaDQrIYDCrgDaQwk
 ab62+jcuT4J44qfbooUHaqkmt5ApFCJT9vBmtdjvDdjkl5SbGJCMNXX1Fb/Ny+SUcZso
 Wyn5MvX4wP+cLzgQIOjolEZaHAOraLehsGX+DAAeNd2bHoDSlr/ZYJigXsrweb0+n5cW
 2lp2sTXzYg2zH/oeyrK7R3HDAwDiXj/LFWFuNSQl7hQrQi9aeKTo2VJlK8zgzlu1mL7F
 d5zw==
X-Gm-Message-State: AA+aEWb+x/Cy7BaUPcrliu7LJBxc4sncwYE5qeFRdAhThPAJ6lN5dQ7J
 UHfm1rO946U/w9YH+aJvwolWVA==
X-Google-Smtp-Source: AFSGD/U3hLsfUNTIL9SOo9dVZOP6/1WAjGlUmNPzoyhYTIIpXgqBrKN9XyeX5Rl+OJCvGospEWwsnQ==
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr11141349qkg.147.1544449952499; 
 Mon, 10 Dec 2018 05:52:32 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id j33sm7104854qte.38.2018.12.10.05.52.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 05:52:31 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: akpm@linux-foundation.org
Subject: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep warning
Date: Mon, 10 Dec 2018 08:52:28 -0500
Message-Id: <20181210135228.49751-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <1543877121-4098-1-git-send-email-cai@gmx.us>
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_055244_906461_4B60353E 
X-CRM114-Status: GOOD (  13.81  )
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
Cc: mark.rutland@arm.com, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org, Qian Cai <cai@lca.pw>,
 longman@redhat.com, tglx@linutronix.de, mingo@kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
warning.

[    0.000000]  lockdep_assert_cpus_held+0x50/0x60
[    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
[    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
[    0.000000]  arch_timer_acpi_init+0x274/0x6ac
[    0.000000]  acpi_table_parse+0x1ac/0x218
[    0.000000]  __acpi_probe_device_table+0x164/0x1ec
[    0.000000]  timer_probe+0x1bc/0x254
[    0.000000]  time_init+0x44/0x98
[    0.000000]  start_kernel+0x4ec/0x7d4

This is due to the commit cb538267ea1e ("jump_label/lockdep: Assert we hold
the hotplug lock for _cpuslocked() operations").

Since it is applying a global workaround to all CPUs here, it did not hold
any CPU locks in this path.

arch_timer_acpi_init
  arch_timer_check_ool_workaround(ate_match_acpi_oem_info, table)
    arch_timer_enable_workaround(wa, local = false)
      for_each_possible_cpu()
	per_cpu()

There is also another path did not have any CPU lock.

time_init
  clocksource_probe
    arch_timer_of_init
      arch_timer_check_ool_workaround(ate_match_dt, np)
        arch_timer_enable_workaround(wa, local = false)

When hot-adding a CPU, it will go with a slightly different route.

arch_timer_starting_cpu
  __arch_timer_setup
    arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL)
      arch_timer_enable_workaround(wa, local = true)
        __this_cpu_write()

Hence, deal with them differently.

Fixes: 450f9689f294 (clocksource/arm_arch_timer: Use
static_branch_enable_cpuslocked())
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: fix the root cause instead of a workaround.

 drivers/clocksource/arm_arch_timer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..81dca7d31d13 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -492,17 +492,20 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 
 	if (local) {
 		__this_cpu_write(timer_unstable_counter_workaround, wa);
+
+		/*
+		 * Use the locked version, as we're called from the CPU
+		 * hotplug framework. Otherwise, we end-up in
+		 * deadlock-land.
+		 */
+		static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
 	} else {
 		for_each_possible_cpu(i)
 			per_cpu(timer_unstable_counter_workaround, i) = wa;
+		/* A global workaround is not on the CPU hotplug path. */
+		static_branch_enable(&arch_timer_read_ool_enabled);
 	}
 
-	/*
-	 * Use the locked version, as we're called from the CPU
-	 * hotplug framework. Otherwise, we end-up in deadlock-land.
-	 */
-	static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
-
 	/*
 	 * Don't use the vdso fastpath if errata require using the
 	 * out-of-line counter accessor. We may change our mind pretty
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
