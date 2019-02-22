Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D32C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0602083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J5wBVhlB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CZMR79TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0602083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ubR9sIHwZtdm4J/yh3Hl9Hqzb1bcnAzO9Ll2eqeamEs=; b=J5wBVhlBpN1I/M
	g0oyiErfaQwo0qt09tOvFly+NiKGWMkEjN2esqHggCdZfAUR11VM0HsVkfxC81Ty8EhDzMVSYDTb6
	He51KYRMtEkREUEhP+Oe9pZ4wwkqhkOY/0VWdz7Xxk7rhQ8EZfDRfcwKvEfLFojVRKG96hpYKWEoZ
	/R4B+E5GrLKGw4oxRFRSGa/Es43K7xqayEUlgPuNw/yw5F112uONjf+u1KE67veVqamEMs+Dgsj1P
	VNYjuP5b/HiAAMCYYlB27NfITWFo2eJ/N94au7iVZuuTxEg0FmYvDzwgqdwxCBvf0ZwxQecuydVBF
	UGMBS57NsznIGaOUYFvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwynD-00077k-3C; Fri, 22 Feb 2019 00:34:19 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwyn9-00075Z-FP
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 00:34:17 +0000
Received: by mail-pl1-x641.google.com with SMTP id s1so225245plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 16:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zY2jb25QAq1g/TE6DFipzC1VS/FPvRjbhYIqEGjdavA=;
 b=CZMR79TEp6okgbitRKUrx/zE6k1bvOTpS/MJdf4JgULsf7t8svMY7HCb5syEO4GOEw
 B/zo7Iztup8iB5CN2rh/IeFUIjF94xXCHiJVPZ7+6sLxqxhqVkbWUE/bEz6fM2aU+ZSv
 UuOkwX3OYX5UmrWRhNAdIBt1Zuq2nko3J0gts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zY2jb25QAq1g/TE6DFipzC1VS/FPvRjbhYIqEGjdavA=;
 b=XVivRk7rbQOThGi4Hroe1xBhM2CfTjRI2e8l7jD2CvoASR7ve7Lro+ecuQ8j5L6TzP
 8l+4lFi0wojljWFzl8pByOdNjlwCrFhnX5XniQ6GqXmUc1Hxn94iOREpB7lwmsMzkaJX
 rf0cZPa485YHYavcK1jo64PB3eGQ8V0hlGPPHS5iYtJZW3LxhVFt77iaueNtWKah4kiG
 B8rwnv0VJSISDPOWKEruCYA2nwe+vKajs3uFWupsYbBxym9SMWFRhY6VzVnfk3Bf1Oh0
 cjEZfj5okpVj1aFfiXdtsMlQWA95T3QK2ytR0Me5k1aSYnixUqcUoSacdXaCZeM67wpl
 rh3g==
X-Gm-Message-State: AHQUAuaJ6tEe6Jj2JQ28WCPr8cIksO0Pvo07hxYaqeQeg7GyeoSQGFW6
 J25Mn8jLwUcYhLhyrkE+aeYjvQ==
X-Google-Smtp-Source: AHgI3Ib0CD3XpdWcv9QpJUjgdjW+aFVX0c54CH4gaJNQ02kxILdUJXAW0fFC8DTGWsMsGfuPCO2ylg==
X-Received: by 2002:a17:902:33c1:: with SMTP id
 b59mr1345131plc.220.1550795650564; 
 Thu, 21 Feb 2019 16:34:10 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id c3sm269830pfg.53.2019.02.21.16.34.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 16:34:09 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH 1/3] Bluetooth: btusb: add QCA6174A compatible properties
Date: Thu, 21 Feb 2019 16:34:01 -0800
Message-Id: <20190222003403.128243-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_163415_519475_D0621B3C 
X-CRM114-Status: UNSURE (   9.44  )
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
 Rajat Jain <rajatja@google.com>, Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We may need to specify a GPIO wake pin for this device, so add a
compatible property for it.

There are at least to USB PID/VID variations of this chip: one with a
Lite-On ID and one with an Atheros ID.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 470ee68555d9..380e6f38c607 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
 
 static const struct of_device_id btusb_match_table[] = {
 	{ .compatible = "usb1286,204e" },
+	{ .compatible = "usb0cf3,e300" }, /* QCA6174A */
+	{ .compatible = "usb04ca,301a" }, /* QCA6174A (Lite-On) */
 	{ }
 };
 MODULE_DEVICE_TABLE(of, btusb_match_table);
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
