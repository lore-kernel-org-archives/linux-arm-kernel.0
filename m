Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E01FC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAC2217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BW9Qu3ia";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTFmUd1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAC2217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5MAhwJyoih2LLCbL8I9lXCMyYARvfMnci/jb8u437lQ=; b=BW9Qu3iae26Cz+3gfiKk09DcSV
	TGOhdxBKv16WueiOM1gcbWnHLrNVQiwL0jABbS8qr78QE/7SYT8tJ1JZVdEkofYw5vyYSR28LL+RQ
	igiqvlqKcTDokAVpvsr0oKedmbW3t9i9/WFiu9VsOprcYxBrP+XhO3YlSQnfUnARgnO2Pl1kI480r
	+8P1V8pmXpoGPrre9tEZS8HaJs6kCsWoLcirxfzEnwHxSslhG0CPnxLYv/O909aUtZ0AYcMfOM7UR
	dbwvgm/P/raDjzaVv8UnahblWrWZoiJdysqripB0Ai62ZKG5/GB3hgzrtRN4TquOqdXz9sl7bFinn
	WdgtfS7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grA5i-0000GT-Jw; Tue, 05 Feb 2019 23:25:22 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grA5Q-0007Ub-4f
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 23:25:05 +0000
Received: by mail-pg1-x544.google.com with SMTP id d9so2100840pgl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 15:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WNp4gohR0kMr5GUi8PqSACf2MyhhTlb9SKT3Z79/9T4=;
 b=CTFmUd1NWnzQEmzeNv77ejYV6bDV+03HNubH5pp8Bf7ecdZAgok7sKxHz2RnIkroO2
 2zA6DcOTpsLNnZaIHkTy+LiaxO8Gl2n4bc8/s27NGj7Ac9rF+xQ14bfBukZZvczWQ82B
 lhUn+IHLnUD+u8DD3GjQNYCyQX+2VTarLjIAP7/vDCqo6N4blKsoIdqsU4qLG9iQdWr8
 d6yw5RwC92mX4gXb4q0zMTueXbTucESrUzFnPLW9SE1EVmWJoezdwdefP/Ff6HJK3C5p
 de+95AJGnt5eus9nQ+sAKvTFUkNnuYsXaqjVzu5BlzixyRX2vd1ww/8QRSmniA/pOBKK
 zP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WNp4gohR0kMr5GUi8PqSACf2MyhhTlb9SKT3Z79/9T4=;
 b=dPQLSkr9yz/DXG9ZG31psKgZBQyJeWxg+/QVsx+DxWkSOR4rYRzx9xSjzH+DaNZcAR
 YEATk84BGpvJCtU5EoNA9kzlzwI719QgkSVT72TwZp5JU6M7dvTRU64vZqCcqhRn5Kwl
 NMKAujKx8avwyQ6shxuj71Es4YvrcP5KiC8LXf0Sou9kQfYX5Iac7JXy6+Sn3IzF0J2Z
 82X6dEmMdAmEUB5m8jFv8VN93d6tjntroIqqBYluHtFJiy+GWj7ag1DKqoEwx59WoH0Y
 CZJhjvKf1wdVEl+bBB6zAd4bGbwx+iys/H6xBI5Wg9P3mr11CW4mcrYePr/GqdwRbuH6
 ts3w==
X-Gm-Message-State: AHQUAuaChzDn10rZ1sundkSPzAp+UF/ddopEXW9Imu+l8FSu8R90oDc9
 SwuaumH2Eq3f4hG44ehDy5YkOA==
X-Google-Smtp-Source: AHgI3IbjgKibiAxZFpQjJ7vzUVTR24eUAKYKE8dGLEXFleWiNZC6ihKqre2cwlTnbM25J7pUwxCXWw==
X-Received: by 2002:a63:3206:: with SMTP id y6mr6774105pgy.338.1549409103744; 
 Tue, 05 Feb 2019 15:25:03 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.25.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 15:25:03 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 3/6] coresight: Use of_node_name_eq for node name comparisons
Date: Tue,  5 Feb 2019 16:24:55 -0700
Message-Id: <20190205232458.7074-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205232458.7074-1-mathieu.poirier@linaro.org>
References: <20190205232458.7074-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_152504_216488_73052B06 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Rob Herring <robh@kernel.org>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 89092f83567e..7045930fc958 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -80,8 +80,8 @@ static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
 	 * Skip one-level up to the real device node, if we
 	 * are using the new bindings.
 	 */
-	if (!of_node_cmp(parent->name, "in-ports") ||
-	    !of_node_cmp(parent->name, "out-ports"))
+	if (of_node_name_eq(parent, "in-ports") ||
+	    of_node_name_eq(parent, "out-ports"))
 		parent = of_get_next_parent(parent);
 
 	return parent;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
