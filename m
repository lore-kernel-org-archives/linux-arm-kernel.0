Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C34C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:56:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077D820869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QneM7I3q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="aQdtwq9r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="U7QxeHps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077D820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XAgU4cweAGUTLlMTuaU7ws9P0nhELRLraegvwAxK3Mo=; b=QneM7I3qt8GUcz
	OJKs43LeVjHN6bnjEdVwsXQEJvVvm8OsQaLEgas+nrAg63EXkzR33I6RVN6/1/r2Ozk8yWOzQplbJ
	MqE0BVSBD+TMzagm1AE6VCmblnB19NLOQ0r2aiUnA3/+3Yp07GT5jY71FXC/72ooTNFaCz1+qRRK5
	Zy/99bmq6UkzUDUgLwNoZH7HmPc6TCguppIu2dXolwKFWyooz59uflpi+YVe4BkuSoCrsA9VFu9Pw
	0NmYRnE5yKSEb6Tj5vaCgrWgMLpRDdTQBD/f/7MjDV7Gd03fAHexQi2OeBIUehZ37oNDmS9SOlGf4
	bZh/L140YAr8wLlTdO+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQ7k-0005Vs-RU; Tue, 29 Jan 2019 09:56:08 +0000
Received: from mx08-00252a01.pphosted.com ([91.207.212.211])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQ7g-0005UL-4I
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:56:06 +0000
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
 by mx08-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0T9sILi030742
 for <linux-arm-kernel@lists.infradead.org>; Tue, 29 Jan 2019 09:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org;
 h=from : to : subject : date : message-id; s=pp;
 bh=k+E40Tzc8px8cxD6PUEgzTs1U0d15EV2t5awtuJLmnk=;
 b=aQdtwq9rBPZ/IWQi3fWgltcLA2PaTKVp3eYkd77TfLFU+wml9JoJlgC61u4tnx0UbbtF
 6tYvwcO0JxVF95+ZnfcCOMgCR7At+hPcHeoQCyE3yHSoQaJZBi6s4DJXeU80ACeNb90J
 8AIFjDKqjMg4vaDaEDdr6H66/8kjpUAcuv+s1/DSunIYWKzkdAw2IWf57xrE+GcMQt4p
 CUQVbmC/fubcxP8nCQyprsPbMgFKOMjN6fr4nt+b5zr2Fyz+jpzkQXMMj4LhYzyeZOE1
 yEi+rsCjokrQ0LYL1pwsB5bHBfPkLQ7XdnOdkVz+cTrlLV2Lk4/gEk35WHoKu/dc+XRI uw== 
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by mx08-00252a01.pphosted.com with ESMTP id 2q8cwk9f8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <linux-arm-kernel@lists.infradead.org>; Tue, 29 Jan 2019 09:56:02 +0000
Received: by mail-wm1-f69.google.com with SMTP id f198so5634918wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 01:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.org; s=google; h=from:to:subject:date:message-id;
 bh=k+E40Tzc8px8cxD6PUEgzTs1U0d15EV2t5awtuJLmnk=;
 b=U7QxeHpsZ0MgSR8wEehTzPKpMPChsHCI3WuB40S+LYyRoUdtfaYQiq8ZorqWEKvp9p
 Yb2+b2yP4UBY3MS0+VUkdR1lnbMhH4mefpvBOZR7xwQu0HhISS7rF4dXB2qb6qR++MS3
 GI4tfOUKGauxcBvYIifGRYO8aEHN7HP4i4zFmfTetXXATPA87WFm3MH3s4drp9SmEQM8
 fSMY1udzRP/jvLkdia+WLb7MBqGuhxRVOzWyvjQIYDYkd+n/BtDzX0pw9ibjLk507+zS
 RSxlqInkZxtGSWC5H6okWfCmjoapyJcJ+S2TuxC1aRBTdsY7Ieh21GDGS2c/9pK18AdW
 pymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=k+E40Tzc8px8cxD6PUEgzTs1U0d15EV2t5awtuJLmnk=;
 b=Sjo4LZzKfISpdDSEaq27lm/bB+YthtH10rdAwOp14PKHmFiBm/uOXQ9xm7QzVYF7Rx
 myI8AXSyAW7ANZuPgO/EdHsFtLPQOvvrPfKNPuvrI4ueNolpntuMTde7IIGO3ufSBnr1
 V+PpQxygVeuWUhsm8lnafXuuuMxbdBEIrc2ZEjTIV4ys+Ud+Kv9rzCTOaN9iu2qTqskH
 7TXsS3XaiM6QOdN3JnfVYBNUDgID6cjgTrL9XAksr4LIXSyd+u8T+jn4onfJLDrqaO0s
 6/Y8FQroMlxBhn0Ek+ETuhSWRNBh8OcpazjAK11T02tjZp286j8w5w1ShurwV8GLUrj/
 U/Cg==
X-Gm-Message-State: AJcUukffEyLmHliLSgED1c13GUXa+EMHd/9E2loRNIAuLrXp+8oTgy7L
 ciCxwW9rIyszp6dkEdagCoxUVCSiOWivLMvG9N/RD6CgY+6aj9/brxV/9coVH4r8+VE7oZeCS6S
 8ijGqdUISgkRL4hwYm/VXgET+h9gt2Wx5wf8=
X-Received: by 2002:a05:6000:108d:: with SMTP id
 y13mr24199318wrw.135.1548755761630; 
 Tue, 29 Jan 2019 01:56:01 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5U9ylZum2D6Wh7giVvVEQFjPMHrJTEm/hXb39NLipI3jQ2EJGiMhmgfsuEX7105kxhos18kA==
X-Received: by 2002:a05:6000:108d:: with SMTP id
 y13mr24199301wrw.135.1548755761417; 
 Tue, 29 Jan 2019 01:56:01 -0800 (PST)
Received: from localhost.localdomain (cust51-dsl50.idnet.net. [212.69.50.51])
 by smtp.gmail.com with ESMTPSA id
 h131sm2775062wmd.17.2019.01.29.01.56.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Jan 2019 01:56:00 -0800 (PST)
From: Phil Elwell <phil@raspberrypi.org>
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Phil Elwell <phil@raspberrypi.org>, linux-pm@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date: Tue, 29 Jan 2019 09:55:57 +0000
Message-Id: <1548755757-79270-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-29_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_015604_454949_0BF13DB9 
X-CRM114-Status: GOOD (  16.30  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

"cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
dereference in bcm2835_thermal_debugfs. The driver makes use of the
implementation details of the thermal framework to retrieve a pointer
to its private data from a struct thermal_zone_device, and gets it
wrong - leading to the crash. Instead, store its private data as the
drvdata and retrieve the thermal_zone_device pointer from it.

Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 720760c..ba39647 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -119,8 +119,7 @@ static const struct debugfs_reg32 bcm2835_thermal_regs[] = {
 
 static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 {
-	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
-	struct bcm2835_thermal_data *data = tz->devdata;
+	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
 	struct debugfs_regset32 *regset;
 
 	data->debugfsdir = debugfs_create_dir("bcm2835_thermal", NULL);
@@ -266,7 +265,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	data->tz = tz;
 
-	platform_set_drvdata(pdev, tz);
+	platform_set_drvdata(pdev, data);
 
 	/*
 	 * Thermal_zone doesn't enable hwmon as default,
@@ -290,8 +289,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 static int bcm2835_thermal_remove(struct platform_device *pdev)
 {
-	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
-	struct bcm2835_thermal_data *data = tz->devdata;
+	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
+	struct thermal_zone_device *tz = data->tz;
 
 	debugfs_remove_recursive(data->debugfsdir);
 	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
