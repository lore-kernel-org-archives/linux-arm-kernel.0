Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B7BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:34:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112BC2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QW22Qy/n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpP7A1Es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112BC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QnZc8l6I/HG1Yqoix+SW9oCf3YecEtbDUYTYaRAd/WQ=; b=QW22Qy/nh5kJf8
	BZA5tXKoUet8r3qJIGJEzTB2VWOvxXJ5JMY/B2TRRdDy8ABYErm3ll42NcCyIkD597umOOUF0ciTt
	3zwVv0bnK5IivhNO1pdu8SsnTlz1TfwfWorwLLal7gxrQTMBpWo9OBvoa5EBcPoRhPAPen5eUPR1c
	URtS12MrmgxhRATCBF0MAWapVwX8UlDkufGsfThMVTJpcmeBmU4mxQWiI6eHzVbkjR6rIcecyXXeG
	2rIet7RC1nMmoi2D12xhEpgyLYM3Lr2FkLp63sY6JEgpIgYotSQy2nPeRQIGUNQBDTH9RHG35S0Ju
	Y9rj6hc8j0O+fEIBnD0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt34-0005sT-GF; Mon, 03 Dec 2018 18:34:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt0U-0003LE-3h
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gXCbx7FLYJYLoHWmTibUsDbopZnSEkoIoNBLX6Xu06g=; b=ZpP7A1EsS1f38bo6uifNap3hlz
 iGxUdj2oeT8S5yyfSMR5vJd96HvmKnH/yNvQRQg13A5i3qVI05JeOoUNrh/ibL0KhaaXWG44J84yT
 7ydPxGOMxQcYaNwRT1Vwdp6LL11DyFzFhWZSCCIS4JO51sy9N99hgEjz2p34Qc8XGHQQ03/Z09s+w
 w3LVYk9Qhe++MCFZLw1Fthwc766PmDGXWjSqR+3LgYudaiRi0wsdc1WMc9EJ8Di9WnNWfeXTcFsVG
 gwsK1Bg1K/MpKhZhNhnwN0a0+y5tNEeCRKVkMVfAhHH4XxL34yWFaFn10U7juJ0K/eOZvIE0ENxX5
 JBkk7RWw==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTscx-0001bk-3A
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F15271713;
 Mon,  3 Dec 2018 10:07:11 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D90F3F59C;
 Mon,  3 Dec 2018 10:07:09 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
Date: Mon,  3 Dec 2018 18:05:58 +0000
Message-Id: <20181203180613.228133-11-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_130727_269404_A6435B80 
X-CRM114-Status: GOOD (  12.82  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ACPI has a GHESv2 which is used on hardware reduced platforms to
explicitly acknowledge that the memory for CPER records has been
consumed. This lets an external agent know it can re-use this
memory for something else.

Previously notify_nmi and the estatus queue didn't do this as
they were never used on hardware reduced platforms. Once we move
notify_sea over to use the estatus queue, it may become necessary.

Add the call. This is safe for use in NMI context as the
read_ack_register is pre-mapped by ghes_new() before the
ghes can be added to an RCU list, and then found by the
notification handler.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 366dbdd41ef3..15d94373ba72 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -926,6 +926,10 @@ static int _in_nmi_notify_one(struct ghes *ghes)
 	__process_error(ghes);
 	ghes_clear_estatus(ghes, buf_paddr);
 
+	if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+				    "Failed to ack error status block!\n");
+
 	return 0;
 }
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
