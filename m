Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19719C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94BF20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DyOFqhwz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQgguxkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94BF20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GBBzPK8+zhM0WpL7k8/+vmb2i6rehb+ycPmTtZZG+4c=; b=DyOFqhwze/eCnjCZNZJT2mpvTa
	5nVkELE0cMRsK7clc5iKriNV3otWtK93Re7/Q4jwtunGdPjPwYFYI2SRAXBG0Njaij44evd/xVRcj
	AH4QtCBho8I4YJ6J8IOfhMwPVf6JOFPuoUNqZxZcLymFhX4DRskZtih9QtpN9tqlg3uFksNMXEY8B
	fA+nuLlW3cmnGksYo50ce+6e730/j38EyCBXXsObqCi+u6rXhKp/ceq7JTvGWNcczB6l0jei8v0qV
	7s812gz0WjltrLbuEuaHnfeAblSw255D1Z56UoOOMAtDpkyH39kyWjAqU8/zvKfLpusbCXUdJDO5Y
	czb4uw+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPRw-0000Yl-Dw; Tue, 15 Jan 2019 14:12:16 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPRf-0008R5-8X
 for linux-arm-kernel@bombadil.infradead.org; Tue, 15 Jan 2019 14:11:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lu4RqA501aHKb+usE6bct2I7yXo7qzf+jN73gQirhB8=; b=eQgguxkIxKWPXP4l86+HtFnBc
 TWnrqC+Az204fa0VXVslXQP8zL5IJyGEtIgSikVCkmvphxvnJo3eIWQDuJToouGhbwiXhS6VGrJwd
 fTiKeqwVDGdE7Ro/rwrke1Jyd0yoa1EAfNJ2pRM/mfddc/enU7MATcUEozcgRB7hld6goRSg6Y3yx
 car2eFXNMwZlgjAXQDFewRVwwBuEU5Wy3RMb2LsrBX+Am8/ihVdu9lNL6qEKxyXnEg8wsyLsz7v0Y
 SCOEyYvy0Yl75iptC1HJtO6PpHTICl0tU6tJYo5eHLTrXHHaRvc17LNFe3vgOlBydbZFKznhmerLY
 gCoM6VEqw==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPEs-0006H1-IQ
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:58:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA758A78;
 Tue, 15 Jan 2019 05:58:45 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D50F33F70D;
 Tue, 15 Jan 2019 05:58:43 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/4] arm64: uaccess: Implement user_access_region_active
Date: Tue, 15 Jan 2019 13:58:29 +0000
Message-Id: <1547560709-56207-5-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_135846_754906_07495440 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Provide arm64 implementation of user_access_region_active.

Check the status of PAN or SW PAN if needed.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h  |  2 ++
 arch/arm64/include/asm/uaccess.h | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 72dc4c0..f0b2f32 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -114,6 +114,8 @@
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)

+#define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)
+
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
 #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 6a70c75..1a8acc9 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -225,6 +225,18 @@ static inline void uaccess_enable_not_uao(void)
 	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
 }

+#define unsafe_user_region_active	uaccess_region_active
+static inline bool uaccess_region_active(void)
+{
+	if (system_uses_ttbr0_pan()) {
+		return read_sysreg(ttbr1_el1) & TTBR_ASID_MASK;
+	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO) &&
+		   alternatives_applied) {
+		return !read_sysreg_s(SYS_PSTATE_PAN);
+	}
+	return false;
+}
+
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
  * current addr_limit.
--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
