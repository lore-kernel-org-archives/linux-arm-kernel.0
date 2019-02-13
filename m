Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF0AC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:10:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE11222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lPSwcJA1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1p64dTsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE11222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5JYHw3LqhoNGvOC7wMHzQDlUERM45dkSS2gSOgDrGLE=; b=lPSwcJA1vrK9n8nZPAbZOvDiWr
	K66tx2mc8knC04jDVu16niEJP6Bu9sBxPoVU4RBS5HtVlaY2hIvHQ5qWkm1DUBeqhY/dIT4XKh8MZ
	Qr5bk1WnltuOSnvKgGl+fXrs4t523uwV2RJL/9Iu6vWVlh2micxHc0IZG5JTqLZkVuBN8mKjyiSQa
	abOgH2EfjLMNDulmh793O4YX+jaAsiPhHnl9AGiRzlH3jOQ4zAMkwWygO55hF1FDq4onHwYGP6Eps
	juENIKOlRw2w3osai+wVSjXCEHZriuhtQD4o+YSgmlvDHg5Ej9rS/qrGff3nzvjOu9uN2dIgnaMXE
	20Nz13tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwBK-0007rt-Ah; Wed, 13 Feb 2019 15:10:38 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwAU-0005hx-He
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:09:55 +0000
Received: by mail-ed1-x541.google.com with SMTP id h58so2218421edb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Nl2exdiih+VjHG/ozKpTxSpUwLVI9022jYFyfu0Qz18=;
 b=1p64dTsvl5SVUsGHL3FLt1+nD8NmQocR3FhCscUxik7dkqyvYZe9zLqoAObZrNGuXM
 /vdO1YZnjzEwQPUtC8hKELtdhfce4nKivab6kodqWOrgaDLv8Rgj32i7rvz05mCS4+8v
 fcD0GaTXet39ium9YtMFesNYNBkTcBYr5ZsvReQTVJ3T2S1xB5q+lDXh5pPumzz/ApR2
 7hSB3HTEOK9Xld8MWQIDZrMNmphOkRUDvD1VZuvE7gTTDmVn/DwgKjKBZzhVCYUB3auI
 lHejL2e6gA0siuSse9ZExSf8k/E00GjSz4Hef/Rv2qttqxuL5XPkIaGSX4enPRBfmvqU
 v9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Nl2exdiih+VjHG/ozKpTxSpUwLVI9022jYFyfu0Qz18=;
 b=nPVNX/XimH+YNbt2yYFMyP6hneCIpvejKMO/1+VTeepaZ16wweIGI/rW5J0JVdxQ8E
 mCibQOEowhqzberuu199vCd2ACA7KvfSJTmt3PIKGXA5nKU58WLYYnQfi+rxbtQAEcAL
 zoLnvD1XUNrihUg1MqP6h2X+wgchxMtxeykSAtzvjV7uAyjsYHDCDvx/A39yKFkw9ae9
 02dEe39E+asORybitIxLiJVbR5d2o4ucOjpZLtBpa3yq4EpB0QLSP+WlPuDlAPWUKX8s
 Kx5sLufgm49yv/U9Z+HK2hHlMjEXIUbdN+BDbGKeoQbVZ/zGU/zvX2wCHJDlBY987uiB
 Odcg==
X-Gm-Message-State: AHQUAuaBLbrH3P/hNdT8DcX4Pp0xCUVPhotB0AQFs0DTNc7hOEcZi6RA
 CTJD85lYJp8laED7r3lwUivm6Q==
X-Google-Smtp-Source: AHgI3IamSPBWkpmVDICq57ehjEwNPLY2zEI4b9JBPG8jq5i5XYnNhIuRNGkhmx8cKd1Whz5KZ3ufZQ==
X-Received: by 2002:a50:ad57:: with SMTP id z23mr727379edc.223.1550070585131; 
 Wed, 13 Feb 2019 07:09:45 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 ([2620:10d:c092:180::1:4505])
 by smtp.googlemail.com with ESMTPSA id k26sm1903941ejv.63.2019.02.13.07.09.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 07:09:44 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 3/4] gnss: add mtk receiver type support
Date: Wed, 13 Feb 2019 16:09:28 +0100
Message-Id: <1550070569-18588-4-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_070946_929001_2404DE24 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add an MTK (Mediatek) type to the "GNSS_TYPE" attribute.

Note that MTK receivers support a subset of NMEA 0183 with vendor
extensions.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
v4:
No changes

v3:
Moved the gnss_type_names string addition to this patch.
Edited the commit message to remove the reference to a vendor protocol.

v2:
Renamed from GTOP to MTK.

 drivers/gnss/core.c  | 1 +
 include/linux/gnss.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 4291a0dd22aa..320cfca80d5f 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -334,6 +334,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
 	[GNSS_TYPE_NMEA]	= "NMEA",
 	[GNSS_TYPE_SIRF]	= "SiRF",
 	[GNSS_TYPE_UBX]		= "UBX",
+	[GNSS_TYPE_MTK]		= "MTK",
 };
 
 static const char *gnss_type_name(struct gnss_device *gdev)
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 43546977098c..36968a0f33e8 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -22,6 +22,7 @@ enum gnss_type {
 	GNSS_TYPE_NMEA = 0,
 	GNSS_TYPE_SIRF,
 	GNSS_TYPE_UBX,
+	GNSS_TYPE_MTK,
 
 	GNSS_TYPE_COUNT
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
