Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81624C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:55:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EEF20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jmOgnfQm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kj4NZ+uH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RVGTCvMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EEF20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A301ag13OUQWef+eiVixcpGVVTZ1Uxy222cnEOBr5Sk=; b=jmOgnfQmDt+6pv
	VZcA5FhAMQePKMfOaysT3xr/AS5tqULiQ+Hn9UIORbWuFIq/+fCUJRcmTTfFAtdCyZ6c7whyNTk3t
	JSxux2RK6UW+hvrYTywTFOlsxi0Rhzi/ob6NBPsXRf6UwG1bMpr35wxfwjC3xl7UqMH0a3sv7ZlsY
	IVDiR+VxNexHokK+VN78N58SnqXC1ZTaEXPAXJ1gaEc3PovJQKIuXtiWpEu0QkzBkMpLCU/bOXecI
	3WdMQLJZqDlQQq9WpyZoERgl5t5Ck3R20ifNvfHnHHqwnel0ReDFL+iVT8f+slnNsxMu5FdVcBMB+
	48/BBt+6GBUHy/Uhg/rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpN73-0007cv-Tt; Fri, 01 Feb 2019 00:55:21 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpN61-0005U2-3Y
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 00:54:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 7578D60A75; Fri,  1 Feb 2019 00:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548982456;
 bh=XRws+PX9K+dRZofUcw1/8OWV2YXiS1PN5N6cB98Ksng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kj4NZ+uHtjHnYIQcn2h2nQlga8zx6ilX3Aa7qVYfnLeBKE76WvHJBoLEyRNErynl6
 hOn9lc7xFGUeo6yhObwNoRMjMObIWraLqocIskSN0L41ExpdoxHUcn7sRHJjN7N7Dw
 VreNzj+/THkFIRJIR2NdFPixOBPpnHVCrS39pCwQ=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C650C60A75;
 Fri,  1 Feb 2019 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548982440;
 bh=XRws+PX9K+dRZofUcw1/8OWV2YXiS1PN5N6cB98Ksng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RVGTCvMaW8rl7KSOhP5fVvMG3aBiWzuHbw9ClQ1uXIF38Btrb2OCm+WE8ePwShSzu
 o2OEF8dzlvlavcqZWoad2HgX5qLHO8YJ2Jmq0dhZK6oXilSVY77Azbdu0PJhOeTJty
 0HnxyoUPhG358+t+00lAOLRzsCcmwLoe6T4X2tBE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C650C60A75
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Rob Herring <robh+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>, Doug Anderson <dianders@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, devicetree@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCHv7 4/6] coresight: etm4x: Add support to enable ETMv4.2
Date: Fri,  1 Feb 2019 06:23:12 +0530
Message-Id: <f5712a48f499d3b2e89f58a43eb30d3dff8b1103.1548981329.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_165417_547709_A8C9ECCE 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
 Tingwei Zhang <tingwei@codeaurora.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SDM845 has ETMv4.2 and can use the existing etm4x driver.
But the current etm driver checks only for ETMv4.0 and
errors out for other etm4x versions. This patch adds this
missing support to enable SoC's with ETMv4x to use same
driver by checking only the ETM architecture major version
number.

Without this change, we get below error during etm probe:

/ # dmesg | grep etm
[    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
[    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
[    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
[    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
[    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
[    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
[    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
[    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22

With this change, etm probe is successful:

/ # dmesg | grep etm
[    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
[    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
[    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
[    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
[    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
[    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
[    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
[    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index dd9b9b5ebb84..08ce37c9475d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -55,7 +55,8 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 
 static bool etm4_arch_supported(u8 arch)
 {
-	switch (arch) {
+	/* Mask out the minor version number */
+	switch (arch & 0xf0) {
 	case ETM_ARCH_V4:
 		break;
 	default:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
