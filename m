Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1876EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:06:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C328220869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kyDW+z4K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RhhdRumx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C328220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NDA6LqWJD3ActuHr0DUODqaP+B1W94OJ4625vuz1hVk=; b=kyDW+z4KZODW7s
	/YftprfE+9xyJIbaW7GDkbn+CZlsaekbbaYqETiI7uhwTJ/T/5uLLUUcAh4yYoaXCnVWn48dvNyMU
	cPOjsxax8eDNZxZLLRQFSYAYcjF9eHMmOKnOR3EGRCaqHHOyFXyX9Wsqav0fFB4Yh2h4Ya4sbLSsS
	4aJsdVWaQkxWpxmMkhk/3eI152VGwAyrAWOKiqNlrVRlyNp3WKvvmhCu9sKQ4cgp/cH4YagJ61k7V
	GJ09x6HvsyuzNK3ozu1owC9hcBtbJB0maFIjbM8BgzsFz3j9+W1qQ6Se1QYOEm57tt3XAWT7nGWC/
	je3g3CyEY666GBORkZOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1good7-0004BX-I7; Wed, 30 Jan 2019 12:06:09 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goocP-0003Ts-6i
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 12:05:30 +0000
Received: by mail-wm1-x344.google.com with SMTP id d15so21365782wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 04:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v7e5TjWs3HaH+dKoME3wIYzLGLqfjdUTh7Tqi9yEOJY=;
 b=RhhdRumxsYwf2tTT1iw3m79Up3YVEqYf7BIMltFzXSliCO48UrhOByk02MhxDYRUBr
 2hooSETf9Bgb3yaZiRZ725ePirZC6An5hkOvWyg/M06CueZrgOXHaxuDJlzEvMwLJ6Mc
 diuvmE0DZLT4OYY1rfVYp+Fphc5t4TaQPWp/7ShFubKbYsQBDBqdwZ1FCjBMiF6zYoGq
 5lOwBHxBRE0QPA3nvcGH85Za/6JQ6JHyw+vvDMGmCQDZHTlc0QrBwZUj5sZfI8snj7rl
 9VPm2ctlZvKfWNXH5pBZoAh6ZseOeH1iFUyn+NsWZDAJm3Nx1bFQII+vcHsZrECc/3Fd
 Wk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v7e5TjWs3HaH+dKoME3wIYzLGLqfjdUTh7Tqi9yEOJY=;
 b=tWDVdThUOo3MBi5Tw+UTeYtv3MKJzoPi+VWXVxQWUs8P7a1OYOLhqp57tvihNKTg/8
 TFWSF3NjtZCgvSY8IYaJB2NwJAoGmgMBFIL463I+lpXfAAmIb9kM7ja08Ka8357PsxSS
 8SfiuXu8EnZDTB+M1dSS9b6b8iKro7xwyRhXBazshVQoQ9aOLVcdXORUMy6rgyRLMl0S
 jmf+wkUuUitXXGr0OCpPJkbr835bmcXjoUZFLC/+xdmC6CnPPHhCUoEyHviXZN9E9u98
 BRy+IixPM8djKDiXkl8uI+wQlgyJ61VITpZcvRQpyZvOWt5GFaWvRbaHfNfPXgpHMpC4
 tvYA==
X-Gm-Message-State: AJcUukdrJwiPjvTQeqsPEaCGKjn4CklPxmDnXIMhdPN8xzPQWnhjbpFk
 LRxMkQh7ZHPl3USBLO0qRK9tbw==
X-Google-Smtp-Source: ALg8bN6u0Icdt1IT+oBI9rxYuRNNrhGtkyKV1X8Vbjv3Ma/A4msl+s5xPGr/ALK02v5MP5w1QUcKew==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr24735580wmf.59.1548849921784; 
 Wed, 30 Jan 2019 04:05:21 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id f15sm642954wrt.10.2019.01.30.04.05.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 04:05:20 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/3] dt-bindings: spi: Document imx8mq binding
Date: Wed, 30 Jan 2019 12:05:11 +0000
Message-Id: <20190130120511.11555-4-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130120511.11555-1-ccaione@baylibre.com>
References: <20190130120511.11555-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_040525_621181_F62DA1E9 
X-CRM114-Status: GOOD (  10.59  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the "fsl,imx8mq-qspi" binding to the spi-fsl-qspi documentation.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index e8f1d627d288..3fd1b8baf5ca 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -5,6 +5,8 @@ Required properties:
 		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
 		 "fsl,ls1021a-qspi"
 		 or
+		 "fsl,imx8mq-qspi" followed by "fsl,imx7d-qspi"
+		 or
 		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
 		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
   - reg : the first contains the register location and length,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
