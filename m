Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C3DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:17:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA62620881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BeCjUVBr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G5AA114r";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fCDokJqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA62620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kwnet9vRp3dOqXk+gEgDwkiUGmmNXzFA/6vsLwiNcDk=; b=BeCjUVBrFNRNKK
	lLlnXqK6EDqfdxgHVcNK2QKFkEAm1POO2m5HhXBcbIqQfSXhaf66G7hgdAhKDzRCaE5QXnGAoY0zT
	XgO5jQmGyb4hSzXudKfxjkNAQc5uuK53mUFjGK6DugbpxXJCC05Dos7YIoZqF4dk+hXpKgV0H7nTl
	BOhmJ2uAzAsthgEzrpOzwOZ1un1pUKj8C8VBbv1Uuv93LDYJ/SxyUF9bo/6bbmA+N8HdgLhM7lRzM
	CL1OQMgEpk+LvRDr+ERHBsssx0UBw4+bPaR87FgVdUUcd+ORv1c+nKbWa5sBi0gf8LqL6mkJftBSx
	paqufn8d7mueG5Ba8yqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCOx-0001Nz-Ko; Mon, 28 Jan 2019 19:16:59 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCNq-0000ge-Ti
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:15:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id E5FC660F40; Mon, 28 Jan 2019 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548702950;
 bh=JpF7V+JuY+CgwGKWsywfk4F8hvetL4pl7KsYcYF/Ivc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G5AA114rMvohkJaqR4iGYTcXYIbzVqVQuA9NEWIHYSh3h6VzbeTJmQGi0oTtTQDNl
 Bw4UhjKEa5RhzRGG9sgjhwi624PPi2EweGjGuKd2YdOtSHp5Hm0UD4L8FeMM5xmZM6
 7Kj2xwmxhpPwmTxuhpj+a49G4mHATtVmWYAjrbKQ=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4097160ECC;
 Mon, 28 Jan 2019 19:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548702920;
 bh=JpF7V+JuY+CgwGKWsywfk4F8hvetL4pl7KsYcYF/Ivc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fCDokJqcv4s6XUkktjlpY277buqghs3B5ipc5EjF1CAO3GoY0MMI5TPaMXUtpZ8/5
 90IGDIbiy1CKE2aatImRM4hAtrCyUJOu4D/uvAJd6PYiG112xDQSznQyvhm6a8psKp
 BuJO8hF+nQD40wxEVnchIX/UiXberYkzm1hLY6k0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4097160ECC
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
Subject: [PATCHv5 5/7] coresight: etm4x: Add ETM PIDs for SDM845 and MSM8996
Date: Tue, 29 Jan 2019 00:44:02 +0530
Message-Id: <cb7d3e715f154942fba1597b91d5b13c25f607e7.1548419933.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_111551_696206_77B7BFA7 
X-CRM114-Status: GOOD (  11.34  )
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

Instead of overriding the peripheral id(PID) check in AMBA
by hardcoding them in DT, add the PIDs to the ETM4x driver.
Here we use Unique Component Identifier(UCI) for MSM8996
since the ETM and CPU debug module shares the same PIDs.
SDM845 does not support CPU debug module.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---
This patch depends on UCI support by Mike Leach in below link:
 https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index fe76b176974a..17731a8ae787 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1080,6 +1080,10 @@ static const struct amba_id etm4_ids[] = {
 	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
 	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
 	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	ETM4x_AMBA_UCI_ID(0x000f0205),		/* Qualcomm Kryo */
+	ETM4x_AMBA_UCI_ID(0x000f0211),		/* Qualcomm Kryo */
+	ETM4x_AMBA_ID(0x000bb802),		/* Qualcomm Kryo 385 Cortex-A55 */
+	ETM4x_AMBA_ID(0x000bb803),		/* Qualcomm Kryo 385 Cortex-A75 */
 	{},
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
