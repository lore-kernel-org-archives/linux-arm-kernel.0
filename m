Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7206C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:25:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B427F21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H8iIL/E0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiAfQAAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B427F21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5+SQYXqCpEQniRsbwKWyVWEvcMxXKLLkRBbiscJeT14=; b=H8iIL/E0v+OKI2
	mdapvHPguE3TdL48O3fcWlVxupwglltkkKMWyf5p8FA15nIYniHwgU+9j7Eyeyd8z0m7kJXdXLS95
	UtqGdz0P/ooIzv/008fBnbDYy+k8DPl1BqQXA3vFYmWHXM/eHUJ+S0zG9mnMwb3IPgkhA9g0cTJwv
	eYTtvk/xNxMBjSbZgCjQCv8YEhYiVn14XEhecw6GZ7lMVOsvRhhDjNOTUC8UmF/El0SO0PGdX2+xR
	lgSL3cL38kamhB+K96YfVUqJq7BM+Pv9w1cQcCYqEad9y975Ky1BPEMqFkby40IbwWpFDWPfX2JB7
	18ULqSq3PqVcsOF6FDPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQaD-00024f-07; Tue, 29 Jan 2019 10:25:33 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQa9-000244-N5; Tue, 29 Jan 2019 10:25:31 +0000
Received: by mail-pf1-x443.google.com with SMTP id i12so9456217pfo.7;
 Tue, 29 Jan 2019 02:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yCoqyS5sQXkP21/OTQAB1RFTdGLdq0rZC3i7yVDJ9jo=;
 b=EiAfQAAc2YRyybe4jf6fWxnef7ujdYUZyUuWjDL9/ScYNiLocvXK/DF5Uf6g9fXy9K
 FKaJ41fPoTxnTgMFbNdAdJ4fwEtwf1Vig6gfBh450RVgDQFyIITV2NP0tgLp00Hgz0rS
 e1MzkYIwFvWeZ3+AOjS829oufwJ2qsn8aBBn8i2Exk3/5ay3zSUyg4qcfkZwCq6Vrl4a
 1u8IPCkjuahV4vXvvMZezNU3faqXeZxaibz47G0bvbvc2bsOxTHtvGkKMvLyplj4Cc+C
 kqlHjkUWJGbBHZWdAw/Teq7SzCF8AqeuLp+USjAfPXQHkIF+kfMmPaUMd6sfdJtGTBO2
 LdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yCoqyS5sQXkP21/OTQAB1RFTdGLdq0rZC3i7yVDJ9jo=;
 b=PTnyKhS83dQUqgSRfulciuHDDI7jtdtZQW8JP9J3nFcWWroP3Mp+8pcNKCegn7DHI4
 Wlm3ZLwWl9XGfvTzGo1yhC27sD0n+cK155g/jxzAi1cKN7Eij4zCYsxC1HNnlNVzgSJE
 jMmB37IulvzEyRb43FqKlDL44E84xmhkFGuU/Ka/YmCbdJJUDsYuxXSBFyeVHsj0My1a
 76MJpqVHWlcdou6TwxBJtQnG3Chh7A4KVKqSpNPHIWWAojQA00zqKu5FEnyOBUWG/pU4
 5wkm5esBEOgneqYhqjANSJ2NVfZO5IscOD6e9Q0AaVm8yT2ECJdASG8PkbdoYOPjLozm
 4qyA==
X-Gm-Message-State: AJcUukdW1MYD6WrEwjnJkVlpoEe9/dhpiNAmQS5ABwwWP25d5CDx4DUi
 pEOvC/k0OjnY+DVKoqaXyW7sOCXa
X-Google-Smtp-Source: ALg8bN4caAyx6vY7J82t3dGW3QZWBS+SsIi+Bh/UXDRyRyXsNpJn7BWvm/SeXdPbvlV4dOkCfRcfqA==
X-Received: by 2002:a62:dbc2:: with SMTP id
 f185mr25389034pfg.235.1548757528738; 
 Tue, 29 Jan 2019 02:25:28 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.149])
 by smtp.gmail.com with ESMTPSA id d21sm47744462pfo.162.2019.01.29.02.25.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 02:25:27 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 0/2] Odroid c2 usb fixs
Date: Tue, 29 Jan 2019 10:25:19 +0000
Message-Id: <20190129102521.4141-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_022529_771194_4662C28F 
X-CRM114-Status: UNSURE (   9.25  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is follow up on my previous patches.
Changes rebase on mainline: 5.0-rc4

[0] https://lore.kernel.org/patchwork/patch/1031243/
[1] https://lore.kernel.org/patchwork/patch/1031243/

changes depend on phy patch

[2] https://patchwork.kernel.org/patch/10777359/

As per Martin's suggestion and input I have tried to fix below issue.

Fixed the phy power issue on the usb port.
# cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  5    4      0 unknown     0mV     0mA     0mV     0mV
    c9100000.usb                  1                                 0mA     0mV     0mV
    c9100000.usb                  1                                 0mA     0mV     0mV
    c9000000.usb                  1                                 0mA     0mV     0mV
    c9000000.usb                  1                                 0mA     0mV     0mV
 P5V0                             1    1      0 unknown  5000mV     0mA  5000mV  5000mV
    USB_OTG_PWR                   4    2      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c0000020.phy.1         2                                 0mA     0mV     0mV
       phy-c0000000.phy.0         2                                 0mA     0mV     0mV

#  lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 2, Class=Audio, Driver=, 480M
        |__ Port 3: Dev 3, If 3, Class=Audio, Driver=, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M

Now hotpluing of usb device is working on odroid c2 boards.
TODO: need to initialize the otg usb port to accept usb device.

Any input are welcome

Best Regards
-Anand

Anand Moon (2):
  ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
  ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator power failed
    warning

 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
