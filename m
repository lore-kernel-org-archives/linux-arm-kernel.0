Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA79C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DD2206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PZ3UsuyW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7njIuch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DD2206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LPFYKboIdUGRdkNezzJG61T0zyd5nycIZYn2VC+NVLM=; b=PZ3UsuyWCRVrqR
	NCAwHzXdzKLrOd2qegKYv7mKm3VttyuvnCLXbMmcN9T0ffzhD/oA8rvE8M1XVu49WnNrJZVqk3VL8
	usnhvhcRfiWY4L5ibolbfMbAyLtks/VoA02mJFMRpFAnXnUv16vXWIgdHHzXrLBVv9CxGShT7Jxpt
	mjKDIgEWfMqybAByenC82oLK0zykbQUbpvwVoVcmQZShz+NSEzFcBwiaCT6psyhB1vgk+LL341sNy
	4aJ6VNrWRB/U6YwcGTmv2VxudKaF12x0BhJNXjwbViYFpXXlhgLR/KJ5yAapf7vhgrmANI41QLS63
	F+Gjvx7rkXJUUMPoXOsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXyMa-0001vo-MH; Sat, 15 Dec 2018 01:03:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXyMX-0001ij-Sc
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 01:03:27 +0000
Received: from
 sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown
 [23.96.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD340208CB;
 Sat, 15 Dec 2018 01:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544835795;
 bh=1GRqsbYVwLz59qJD38TH6xczEZFBWO9wSJvd2hbyTvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m7njIuchjJb8KNuuMNOfAx+jxHgLaPUZOUnb/Y3KnJ3EY6bl25C3Fh/snlJSgWASS
 M5eeX4pHr2Nhbxar2RXejm4IcpQLhuPQwYNY/l10uKiS9l+oPKbqWuasKcmYKUKVM6
 hHD/0UgdtcqpbGGitoqfho6S9hu7yNhHakWxmbz8=
From: Sinan Kaya <okaya@kernel.org>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v10 5/6] arm64: select ACPI PCI code only both features are
 enabled
Date: Sat, 15 Dec 2018 01:02:46 +0000
Message-Id: <20181215010247.26101-6-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181215010247.26101-1-okaya@kernel.org>
References: <20181215010247.26101-1-okaya@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_170325_941992_AE70B868 
X-CRM114-Status: UNSURE (   9.35  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Sinan Kaya <okaya@kernel.org>,
 "moderated list:ARM64 PORT AARCH64 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ACPI and PCI are no longer coupled to each other. Specify requirements
for both when pulling in code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..bcb6262044d8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,7 +5,7 @@ config ARM64
 	select ACPI_GTDT if ACPI
 	select ACPI_IORT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
-	select ACPI_MCFG if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
@@ -163,7 +163,7 @@ config ARM64
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
-	select PCI_ECAM if ACPI
+	select PCI_ECAM if (ACPI && PCI)
 	select POWER_RESET
 	select POWER_SUPPLY
 	select REFCOUNT_FULL
-- 
2.19.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
