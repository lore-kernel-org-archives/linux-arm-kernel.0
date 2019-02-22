Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548D0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205952077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I9nxBcIe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EfnqGPOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205952077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=THAiiZVeW5MVe1t0EbuLcM4XWp14DX8gGKAE5Ej0jyo=; b=I9nxBcIe1oMyF1
	ku471zV9TwhamkE0d7yWhOLwdVwlHIg1kbgJqymPAB4cU2s2BwS5GWvtoaQ+DStko9Dft/oybuI83
	fMccgeztDMi7sVByOhd/zSH0cKFsD+bSloxrIO4RWyFiR82UNEn42UBLocX4nt1RA89a0k+RBXOwe
	03+c/I4p05ccyGGwjiiWbniG27/aBjU0++SWGSGEuFCQjOWG6iAAW5jjw/jt5dH8ckJETpegjyGIx
	lWqp9kc91GiDxHOb2P40D0WOjweQRDmbJMvppWcIoqWLy0vyTFzrWoByadNEbfndbdNVDcKqNmQhG
	tOM4vH562fqUEcfmjlmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwynS-0007Q6-0i; Fri, 22 Feb 2019 00:34:34 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwyn9-00075e-Ue
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 00:34:18 +0000
Received: by mail-pf1-x441.google.com with SMTP id g6so219386pfh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OBVnoqXuO6HFOZ085kg+BDnfHXIhy9OmFMZxP4tCxpw=;
 b=EfnqGPOXB+Uhq1/DNgFMPxIVt3T3GMCie9YVOIrnCRIlVx3XOSiSvyj2HCPFtVOlQP
 1mh9XqgjQnMQTy3kMk4IR4CbmdabuKi3QUub2B4kB9rowmtLAYzKjXJLn8Oqx7b0AYyE
 yMntsAzKhhAdRDaEuFyxnJQ8w8oN/QDj0rXqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OBVnoqXuO6HFOZ085kg+BDnfHXIhy9OmFMZxP4tCxpw=;
 b=GyOhhnkS/XUj8xMzKjpqd9RmyYgRq/NudM9t5OJbCxN1i7pLW9PKPUEiPTRxTl4ngA
 EMaZ40Ln6wKu08zsigNgoKeWmRFnrmQxslv33N3sF4TeFv1ruEVUC0sQE3rs29JLZtVj
 QCJUhKPALDjKoNdhtPTS/u6RwCKFxsHevQjtVvPts1F/cZWOl//UMmM1hcQoa66y1tdn
 7WCJ3bEp3dK1+gQnHsHj8q9hsIBQp2iH74zbzuyDPs7qBzDX1V5NxfKlV/tG/0TAuGeO
 mCZAjE/vVU8WDkc0zG5OF5eziFVY7J0QZs43B10TTu3f1T7Z+VpToPpuwFlN/kexHkuZ
 7sIA==
X-Gm-Message-State: AHQUAuag6I1SAwUVA78KjVLgrIX1VXmHaKb3pfmbBLwePiTU/e8mHEhs
 VBm0mMlU4w88YyoN5m6moBx9wA==
X-Google-Smtp-Source: AHgI3IbGOJeo1tMct7+tFWXD7jLSXbSNtxVZdnkGfxrjSW81ok1QIOiXQPjcBYhWfdhBjDo0Ual3WA==
X-Received: by 2002:a62:7086:: with SMTP id l128mr1333899pfc.68.1550795652021; 
 Thu, 21 Feb 2019 16:34:12 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id c3sm269830pfg.53.2019.02.21.16.34.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 16:34:11 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
Date: Thu, 21 Feb 2019 16:34:02 -0800
Message-Id: <20190222003403.128243-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190222003403.128243-1-briannorris@chromium.org>
References: <20190222003403.128243-1-briannorris@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_163416_136118_F9315E73 
X-CRM114-Status: GOOD (  10.05  )
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

There are two USB PID/VID variations I've seen for this chip, and I want
to utilize the 'interrupts' property defined here already.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 Documentation/devicetree/bindings/net/btusb.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
index 37d67926dd6d..43c96c3380a6 100644
--- a/Documentation/devicetree/bindings/net/btusb.txt
+++ b/Documentation/devicetree/bindings/net/btusb.txt
@@ -9,6 +9,9 @@ Required properties:
 		 (more may be added later) are:
 
 		  "usb1286,204e" (Marvell 8997)
+		  "usb0cf3,e300" (Qualcomm QCA6174A)
+		  "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))
+
 
 Also, vendors that use btusb may have device additional properties, e.g:
 Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
