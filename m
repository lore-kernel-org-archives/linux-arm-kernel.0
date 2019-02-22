Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E8AC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741C720645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nLdcGdqw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FonEQvjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741C720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=L8xWfjQHqzQUfL2iThYwAbw6nf4bv9M1jYfWs/aJKDk=; b=nLdcGdqwUSOqkr
	Vrefszw3kj8qxKbxz+HLREsadRh/UVSCKevf6RTF0uhQKbBP+jXVVZ7lkpOKdUjJONZM7KjnS18/E
	bwzu1W9oJyaQYgJsykcJBetxQw3AkSlBwuQJ203TD9ZXiJuELJKYp8n9v+hEf2OEYD/t6K4sVVSu4
	mZl81+The1EiKacTxnBAIov70EXd4tcYqo8JZjwG5hMtnWi5qy/US2gFxD0rCi/M5hMG8AnZcZaYY
	iH31kvpmK3naBXephHtfeAUqqPCOBQMEreq5U/yDLGVf3rBmYi7CK6et6GjTEb5UeOJgoyB/NgxuX
	PmJy9XHRB0PBaAKNxaXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxJhj-0000LI-9s; Fri, 22 Feb 2019 22:54:03 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxJhf-0000JM-Rv
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 22:54:01 +0000
Received: by mail-pg1-x542.google.com with SMTP id s198so1766952pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 14:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nOmkR54mk1YiaV2P4+fXimG34BV3NNX5X3QQIlvQVZg=;
 b=FonEQvjFE8rinSdK0+YhsK7NSIKGCnlG0bsqQ8t7MJflKAQnIFi7Bzwkh0rYge72WM
 zgb/8P2VCLv4otyxW9sV36wHKm9BUynifaYI2f04CljuU+ExEsK+ON7RwyP3JlbWQkB7
 P5ccE83/ZjI3ZXxk17E7ff9sISh959aqZuu7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nOmkR54mk1YiaV2P4+fXimG34BV3NNX5X3QQIlvQVZg=;
 b=PWgjdGicpBgsr1NSF/XEXptBZZSlGf3Tgw897LU1Dhbt2cZQ9svKHuUGXkGqzw9sv9
 W9eFL4lyxIpI0FgGWeRCZuRrllX2L+Y4Eit+Ai+1LOlHUS4HG/4UIYXeKmu/fni1PnFl
 ejWoOeKBOSRWGogXAHVYLyJ9TIKe5TabgHf2pcFkszFeHdGCDyPxfS/ulb3Ih/yobp4o
 IVqpfYtIonQaAdUis2Qg8TThfgQ/0fTX6ZlTG5Xvvv5jgBsKUSVMlb1fNQEQQzs7cCSC
 FG/ZZZx8N7o6+PYxhskTgHnaM+THkooMmOeRQMaCz6zLMPniF1pt8eUjZZUAWLwfvxha
 5UFA==
X-Gm-Message-State: AHQUAuYbXf/WlvPNCd9dKPjKIkkdwcg84+adH02iTmE8WAYmd0EANlgv
 hn9ayuNHF/+XKNXf9QXXDdmtqw==
X-Google-Smtp-Source: AHgI3IbX30eBxxMnWiJnPiqgNTaN6UZxyKS5qylYNv4mkQAyTqVyKBdygA2Woo5vLcKqD2q0qeQRaQ==
X-Received: by 2002:a62:d448:: with SMTP id u8mr6554991pfl.105.1550876039259; 
 Fri, 22 Feb 2019 14:53:59 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id g185sm3994995pfc.174.2019.02.22.14.53.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 14:53:58 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible properties
Date: Fri, 22 Feb 2019 14:53:43 -0800
Message-Id: <20190222225345.69084-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_145359_937704_966081AD 
X-CRM114-Status: UNSURE (   9.46  )
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

We may need to specify a GPIO wake pin for this device, so add a
compatible property for it.

There are at least to USB PID/VID variations of this chip: one with a
Lite-On ID and one with an Atheros ID.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
v2:
 * drop leading zeroes from VID, per documented binding
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 470ee68555d9..54cb5f583b1d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
 
 static const struct of_device_id btusb_match_table[] = {
 	{ .compatible = "usb1286,204e" },
+	{ .compatible = "usbcf3,e300" }, /* QCA6174A */
+	{ .compatible = "usb4ca,301a" }, /* QCA6174A (Lite-On) */
 	{ }
 };
 MODULE_DEVICE_TABLE(of, btusb_match_table);
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
