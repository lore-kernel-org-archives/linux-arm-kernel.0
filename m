Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425EEC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A2D208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YuM0HSZI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCYKFkpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A2D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d6kVVI5S0LYfibS2q2GMpatVA6yZaljcL/GuPBI1zZk=; b=YuM0HSZIRVQrtd
	b9mi/QoOa9NhgP8DzQ6z4uKUfBSDcmhcWsYbAqubVdqlKMj6+ENe/100p3G0MVDQUxICNuss6bF2H
	gFW6qEqJ/lIxsVikBRbLV3/+X53s8MfSr7PWixVrru+oo9QxSTRMe8U2lKEXCbbJon0+T5ASEctRE
	8CAtd8wGU4t16dzCIn1X3691RC26I1SIJJBFwsEEWor1IeOmH6Hzv6UnMeLJJpS72RwAIZAGhKWl1
	vExd2Wq6+OYBv0x71CevInN6UR6TTZl5M+F+WgIuxH5zTWtX6A8Ip4rCqo73drVqhWuQHzV0+G5au
	41axmT7amMjUIafb88Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXXp-0008Kt-I0; Fri, 18 Jan 2019 17:03:01 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXXZ-00087o-Sb
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:02:47 +0000
Received: by mail-pl1-x644.google.com with SMTP id a14so6589775plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3GYPwFAfOQ2PBwuTZDsLKhTieI3hmQzYqkGxR2OgQSM=;
 b=jCYKFkpjXqGzDObfujVjSF4j6c6ARgIt8wreJEFYkmR/9xZsRwyxTyO00TYXkd0qza
 DYOgUwlzeUHGBXlgyET6F7DsZpjSphFI3O/88XjoMOxJ/NiLXDLONXJB5evqKMxIYRxh
 KukpdkTAn43/bBzOzGozLnSBakoLfKM4DU3ynL3RrQuSdPLfgPnQbyo/zBYdI7X02mT1
 0eDtpaxD7DwfvC7ETKqHcyEIVCm3cmwr89aIl2JWRK7Ofly6k35jCuD79eWWvoMXAcch
 S99l4Dwg1lk1H5SDQ/+CkSZ5PbH2KhU4AcaXq19BB8MdCvLCW7iEYiaKPCzPSWahnFuW
 Oqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3GYPwFAfOQ2PBwuTZDsLKhTieI3hmQzYqkGxR2OgQSM=;
 b=exmXPHQzKgRdRQvPAAQGrTaDEgWkTmqzICYM77ejgSO2OpZ/asKoHqvvNFxWsAIItm
 m/QPBqlL95AcQ2l54ZlAT7WBHuPvFz9CeF9KnOzOpBWm3BbuVzLNedgfgiB5YH8EaSkd
 GHEbBJ3b/Bt0Bzgjb/JFgp44Xg4T76Eb+WvrEGFe3CDSGab/q+a25wN2VibOTyWzyDeX
 vux8005TyhxL2clMah0Tf4aO6nMqDI0Av8HMY0HjZTzXUB2xvlNc49/U9Rlj1I8Z7jTa
 tD6lEoeP6g+1GldfsXfrVUW96DG6akKCjPUT1QoMbzj5GK8i8QMlA6qt9Aa7Tqjj5e/p
 tl9A==
X-Gm-Message-State: AJcUukfSWCk19kV7nxJE0W2IaegFR76VS88mHIQD9slqWwvV/9y8nOBx
 7GZ8+HRvDWHKlScnt6ObbSM=
X-Google-Smtp-Source: ALg8bN5GYqC1evbJwdjXhHBNVtpkDQAi7VzvvBJXjFG03Ue4K5yK643MPMID0mliToQZas5hMgNhXA==
X-Received: by 2002:a17:902:7791:: with SMTP id
 o17mr19716381pll.60.1547830964956; 
 Fri, 18 Jan 2019 09:02:44 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net.
 [216.71.193.140])
 by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:02:44 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Add new quirk for broken local ext features
 max_page
Date: Fri, 18 Jan 2019 09:02:25 -0800
Message-Id: <20190118170232.16142-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_090245_920485_1D16D0A9 
X-CRM114-Status: GOOD (  14.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some adapters (e.g. RTL8723CS) advertise that they have more than
2 pages for local ext features, but they don't support any features
declared in these pages. RTL8723CS reports max_page = 2 and declares
support for sync train and secure connection, but it responds with
either garbage or with error in status on corresponding commands.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 include/net/bluetooth/hci.h | 7 +++++++
 net/bluetooth/hci_event.c   | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e20556..d7849f128d58 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -192,6 +192,13 @@ enum {
 	 *
 	 */
 	HCI_QUIRK_NON_PERSISTENT_SETUP,
+
+	/* When this quirk is set, max_page for local extended features
+	 * is set to 1, even if controller reports higher number. Some
+	 * controllers (e.g. RTL8723CS) report more pages, but they
+	 * don't actually support features declared there.
+	 */
+	HCI_QUIRK_BROKEN_LOCAL_EXT_FTR_MAX_PAGE,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2826ce162b..9c59af7de197 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -639,7 +639,9 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	if (rp->status)
 		return;
 
-	if (hdev->max_page < rp->max_page)
+	if (!test_bit(HCI_QUIRK_BROKEN_LOCAL_EXT_FTR_MAX_PAGE,
+		      &hdev->quirks) &&
+	    hdev->max_page < rp->max_page)
 		hdev->max_page = rp->max_page;
 
 	if (rp->page < HCI_MAX_PAGES)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
