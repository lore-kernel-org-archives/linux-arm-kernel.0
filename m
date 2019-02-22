Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23B1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF65C20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b75gNE9T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kdgcnXo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF65C20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DCh4lUsSlO6SZxOx2NRwnkB145OU784mxomDztzqOEU=; b=b75gNE9Th1bmIn
	h9wQqFdHTbqVoN+lW0zgyvsHyBJE501Z2laP1ijU+0Ugr47aaV1LTQjT6cpZ4iqiTzbSH7IX1XXNG
	lF9TPkCmm/LxI/Nf+DcluirFI6Tpmtkw84mFeb5jn5g40gGdKFmmHny3BMTJu6xj2fLRphU4xnK4T
	D6vlRP6EDsVRxcNNyVmHw/QGpkAmJEsIsqtbb/v9z+ATYIDhhRhwnFYT6nAIR6UDY9GMbXfeyFWmI
	B7D9hix70heFejFW/ILR7sIog3jeKS+bqqUMwecRdazJuhRp7KomCiiDwQhs6OXxdhV/KvJ0lUqV8
	EBk6vUkRAGSzllUAh7Ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxJhy-0000fB-N0; Fri, 22 Feb 2019 22:54:18 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxJhh-0000KC-EM
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 22:54:02 +0000
Received: by mail-pf1-x442.google.com with SMTP id d25so1738602pfn.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 14:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2jlndPxQUS25hD9X2O4zRB1zQ3dpXmFXtGTcX4KnwLs=;
 b=kdgcnXo+2UIcDSAXEEH4ZIov+JUKtDmDozAF9KDySDlmZXkQTluivbn8LWt8MXA4xh
 zfxxg0Li/vmlGvvQL78B02EII9ZA5UlpanaSR5QS5xqGpDCqI33gOk9Rm+weQdrxyqN1
 MTce9RIG1Et5FSOp/Sa4Vsgw/UDw/BWmM9lMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2jlndPxQUS25hD9X2O4zRB1zQ3dpXmFXtGTcX4KnwLs=;
 b=fEDg7MJ89c0TugI82a5oqXEpP0ybJ8iOALuANjJmm3S5VFXE0q1Wus0c6otG6g7c2e
 695n69XXp3bLoYPWNPGisfmXT5jTRkvYq0IZsQXl9VU/kB0nfx3yo64+cXp9FZO0qoXj
 T1EqWxX1C96ympNpt0/Xa4BY0I8fr+9SsW2KMhhZsSVd9G+iLV+bdYPZjaJBwbqUVXbS
 6mHzCADJNA/p/hd4tKItW0avahp0liJOFtmvrRMr8nx0zQJtQqU/9NkqR7u3bRYEEobL
 aYCuffyYpU88APBeVijBPVQYC5Z7bhW4hbBZiJ3gfggZ0fRLe3iNxo9veFZvIs5HUqII
 QRDg==
X-Gm-Message-State: AHQUAua8AHoXw8sgDUmPgxh7e1pAm9bMYxLcv1NzDLvePaiXNBfLzH5p
 MDZbP9beA4k68RW3O8EFhh/yHA==
X-Google-Smtp-Source: AHgI3IYmtjOMl5JYGgzo3C3QvB9fgUiwrmYezKxFimhE/1NEAza4tKyF1EFKbnwYIKl3Ue9Ox73niw==
X-Received: by 2002:a63:4a0a:: with SMTP id x10mr6211511pga.325.1550876040944; 
 Fri, 22 Feb 2019 14:54:00 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id g185sm3994995pfc.174.2019.02.22.14.53.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 14:54:00 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: net: btusb: add QCA6174A IDs
Date: Fri, 22 Feb 2019 14:53:44 -0800
Message-Id: <20190222225345.69084-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190222225345.69084-1-briannorris@chromium.org>
References: <20190222225345.69084-1-briannorris@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_145401_484392_24352957 
X-CRM114-Status: UNSURE (   9.97  )
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
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Brian Norris <briannorris@chromium.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are two USB PID/VID variations I've seen for this chip, and I want
to utilize the 'interrupts' property defined here already.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
v2:
 * drop leading zeroes from VID
---
 Documentation/devicetree/bindings/net/btusb.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
index 37d67926dd6d..b1ad6ee68e90 100644
--- a/Documentation/devicetree/bindings/net/btusb.txt
+++ b/Documentation/devicetree/bindings/net/btusb.txt
@@ -9,6 +9,9 @@ Required properties:
 		 (more may be added later) are:
 
 		  "usb1286,204e" (Marvell 8997)
+		  "usbcf3,e300" (Qualcomm QCA6174A)
+		  "usb4ca,301a" (Qualcomm QCA6174A (Lite-On))
+
 
 Also, vendors that use btusb may have device additional properties, e.g:
 Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
