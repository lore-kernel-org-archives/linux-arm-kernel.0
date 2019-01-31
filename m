Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8A5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:24:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBA5218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="szeoC0aQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c+hKm0rs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LUs5s5N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBA5218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SlFFXr5Rv2dORAR5fZC+Jva92NTk9M6kV4D6VMRlZrI=; b=szeoC0aQuP6QFB
	GABlqEjwhN7oLQGskErH5dvb0aKe63wqcJnzUSYBmymAaEOGoJ0r3/rnQdEcEHnzs7fUVdaB9NrLX
	5tVZdFzk+Qyo6cxKXL1NwWDo1nDWol8PI6L1ZH68c/m+/wJpDM4ApqQm16PlweniqLlVMTzxU32bD
	RQox7ostcMeXR9sCuuiVK5obsjmIcO3eDfF+DHM0cmxrkjOwIAAmCOOCh8anqWIHoux5mA8Toz9FS
	FS2j9wKbcoNx7msZHv8gxWBPymd/gGheS1BalUWp/sJAjpPrKxwhQed7O6MpN/2BNMf7KKmHvxbKI
	7UgmXkBriyCW+my5FFhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpDGx-000793-ES; Thu, 31 Jan 2019 14:24:55 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpDG9-0006ZM-H5
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 14:24:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 8AAA660DD4; Thu, 31 Jan 2019 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548944644;
 bh=YVfU0vvHyXFYOipNj0PgiEFupDcA967znBrdf6Y3SD0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c+hKm0rs/e1B+fnZxup2aZc1jLTtwMs0GfIZSuwHdZMXw03xoNqogXsI1Hypaiuz2
 ZS2LnpVKrQN0Filvoyi/sGnp5GSuz7472ZnyoXxfMoylpWJJRpcAAQ4ZL6A5nVxjQI
 VLYOVGfxQMXgWf3fj5WJM8vl/L9KQ78dzdsjI5Dw=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B45660FB4;
 Thu, 31 Jan 2019 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548944614;
 bh=YVfU0vvHyXFYOipNj0PgiEFupDcA967znBrdf6Y3SD0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LUs5s5N1Nfyuo93pAjroQHMWPumA6en1KvY0xL94SAC78MP7Gmka/3JtKi2lwxQ2+
 8xXgNBhqYjNI70juR4JpNtKLRGv0zPDpkf9ysQ7thWddMxwG2KkCIogim8+5dGceM2
 ICre931IR4qdEw4cxY6QJVOe04FDcyzpZGj5Vceo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B45660FB4
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
Subject: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier (UCI)
 table
Date: Thu, 31 Jan 2019 19:52:24 +0530
Message-Id: <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_062406_129246_1703193F 
X-CRM114-Status: GOOD (  14.89  )
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

Add UCI table for coresight CPU debug module. This patch adds
the UCI entries for Kryo CPUs found on MSM8996 which shares
the same PIDs as ETMs.

Without this, below error is observed on MSM8996:

[    5.429867] OF: graph: no port node found in /soc/debug@3810000
[    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
[    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
[    5.446474] OF: graph: no port node found in /soc/debug@3910000
[    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
[    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
[    5.487765] OF: graph: no port node found in /soc/debug@3a10000
[    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
[    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
[    5.501802] OF: graph: no port node found in /soc/debug@3b10000
[    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
[    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---
For testing, all dependent patches are in below tree:
 * https://github.com/saiprakash-ranjan/linux/tree/coresight-next

This patch depends on UCI support by Mike Leach in below link:
 * https://lore.kernel.org/lkml/20190130234051.2294-1-mike.leach@linaro.org/
---
 .../hwtracing/coresight/coresight-cpu-debug.c | 33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index e8819d750938..915d86a39cee 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
 	return 0;
 }
 
+static struct amba_cs_uci_id uci_id_debug[] = {
+	{
+		/*  CPU Debug UCI data */
+		.devarch	= 0x47706a15,
+		.devarch_mask	= 0xfff0ffff,
+		.devtype	= 0x00000015,
+	}
+};
+
 static const struct amba_id debug_ids[] = {
-	{       /* Debug for Cortex-A53 */
-		.id	= 0x000bbd03,
-		.mask	= 0x000fffff,
-	},
-	{       /* Debug for Cortex-A57 */
-		.id	= 0x000bbd07,
-		.mask	= 0x000fffff,
-	},
-	{       /* Debug for Cortex-A72 */
-		.id	= 0x000bbd08,
-		.mask	= 0x000fffff,
-	},
-	{       /* Debug for Cortex-A73 */
-		.id	= 0x000bbd09,
-		.mask	= 0x000fffff,
-	},
-	{ 0, 0 },
+	CS_AMBA_ID(0x000bbd03),				/* Cortex-A53 */
+	CS_AMBA_ID(0x000bbd07),				/* Cortex-A57 */
+	CS_AMBA_ID(0x000bbd08),				/* Cortex-A72 */
+	CS_AMBA_ID(0x000bbd09),				/* Cortex-A73 */
+	CS_AMBA_UCI_ID(0x000f0205, uci_id_debug),	/* Qualcomm Kryo */
+	CS_AMBA_UCI_ID(0x000f0211, uci_id_debug),	/* Qualcomm Kryo */
+	{},
 };
 
 static struct amba_driver debug_driver = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
