Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE4C21901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U+RVjeZi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="kdHcXhxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE4C21901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PHfKbcjpuJPWWxFVrJvVay+paFDWbt++m/hLD12No3A=; b=U+RVjeZix6IGMCir1GjaiIObi9
	v3M18OmmQsfh/LqfrCjWYGKQgMV7zkBW8CYD8B9gA2t00pOecHLm+Gr/pnhIUKiXipyn29MmU1Ahs
	ThC3Jz+CmsXOQWFSBiPfyvKc49FagSyIPVggudUFPflKIcgiNuAJ7vKaMaL578oDYYxjuLTxnPiCO
	uJSsObYFyCgBrrnI0denx7ANTN0nUxQWy/Q2q5yXMXN3l4dh0s3ObQGmw3dcWc8rQcS9tNvjWjhD+
	hauJSJW/B1vHGZKniGth0fETj5Lcs7rORREelcVuIeunkFbGUVCEvmlrl/HwpkdNpeZi6axM7dZcP
	r7cszv1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjX2-00058f-CC; Mon, 18 Feb 2019 14:04:28 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjWT-0004XK-4x
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:03:56 +0000
Received: by mail-ed1-x542.google.com with SMTP id x7so13897160eds.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=I6Qr3PnJqhUErKNHRtGnpwGVLGbDm4vYaQedao4hHXI=;
 b=kdHcXhxCjuyfL/RsbUdI7m1L2Yqy6Ch6aOf/JLBNnD5HRcGRSlgFnLV7GDHT0+O/ZH
 WwhadtXZC4vVGNOZDuBn55xN7S4uRWX++KyhraFKHbfOfDIpV2BF2i1X1ZZmPSUG4VoF
 AkRhIRakB9igwGHCOjQRaHFAWn158WcLofcO9Bvujyxj6a9Q5/FR2tK/sXcaVtMFDepB
 mzDtU5X9T6XAokc0oVHVyJYLk6aWrjK7mlq7vIRYN+67ZQfflVjoZTlS3hBnJ8v3vCvY
 cUmqgkNmUgZCJM9+9LD/mdkYFxEuSclcXauFOzLsjW1gmke/0ca5/PZRLVfeL0qwR77Y
 7kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=I6Qr3PnJqhUErKNHRtGnpwGVLGbDm4vYaQedao4hHXI=;
 b=lLrze6WCzk6AM4c2tsQIn5i8IScBd/ALFMB9NmddtwFkjumD5bwYH3moouN5MM4hVn
 uc7f1S5MbeGct4QuT3LMhPiFgpwAGQdNBmvcLMnAVR7E/BKHZPIkcSUprbRzc56AX/x0
 oezq8ubHBIKakci5JlrXNk4Q9MkLwii7rra/i+eibfBc+v7arjko6jfuzInUcN9+aiUt
 of+v1S2j+1dLx2A8w7VbCf78JkY+Y9mZQQ5Iw9V5w7ffD2d5gK8QuF9cjKxz1L+4/k5i
 bkXI66UZLPTNKSlEB0DeoiRrRMKDkzId6xe7X2+AifGse1Tr7+pR1/Q7/aZIqMQWHxFQ
 TOKA==
X-Gm-Message-State: AHQUAuar7Tdb+7e8c2G+zVMVh2xPvEkkAj+1+8eEWrIur3LLumzZyKZB
 jJeF/niP+uBpctvRooADf+8fyA==
X-Google-Smtp-Source: AHgI3IZi9n1v6BYfISfADbqQLufHezmPHIqiJiJUI3/6IPWV+cI2byGpqq/pa18Sn/cvn8B5knGS2w==
X-Received: by 2002:a17:906:ee2:: with SMTP id
 x2mr16832980eji.202.1550498631380; 
 Mon, 18 Feb 2019 06:03:51 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:50 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/8] dt-bindings: iio/counter: ftm-quaddec
Date: Mon, 18 Feb 2019 15:03:17 +0100
Message-Id: <20190218140321.19166-4-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_060353_184172_3450651E 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: Patrick Havelange <patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

FlexTimer quadrature decoder driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 .../bindings/iio/counter/ftm-quaddec.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
new file mode 100644
index 000000000000..4d18cd722074
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
@@ -0,0 +1,18 @@
+FlexTimer Quadrature decoder counter
+
+This driver exposes a simple counter for the quadrature decoder mode.
+
+Required properties:
+- compatible:		Must be "fsl,ftm-quaddec".
+- reg:			Must be set to the memory region of the flextimer.
+
+Optional property:
+- big-endian:		Access the device registers in big-endian mode.
+
+Example:
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
