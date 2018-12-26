Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:32:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D97F218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JRBxtmQQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSif7DwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D97F218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fBrxIktLv1rydGtCj1IRTNFZCOHLkvOKArifIjjbjII=; b=JRB
	xtmQQ3FEPF1TaGdZpA2PF4Q7Dzy9Sx1IJ6CniRTqEBOYs70D/w60GOK1Q0I8qncgU12Kg4YcQV5C2
	0SgNuZ5p+nFuQqKbxvcXo4K6ACtLIpU8hdNyYQlcIs2PVm+hTD9v7uYG57iqxmdPgRSLXJG56XiG6
	QfOINM0xgTuHmjwAo/2OIbhj1k2XkG0wxDikQYHgRztoqnEo+0TUagANipHkLeRh5m0zxa9gttYJq
	mdBLW7kr9q1u3m+iyPPhLanzObT7dk75XBlzD+4AFBuqaWPkTsYc9kmzLcTx4RVZJwFSMceYWmyGJ
	NBsUyJeN8EjPhdWObBFtrKCbEiKXFuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc9IX-000643-0S; Wed, 26 Dec 2018 13:32:33 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc9IU-000630-Bn
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 13:32:31 +0000
Received: by mail-pf1-x443.google.com with SMTP id w73so7868990pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=oXiqN+RrYGdfkWEsu1YpPKuSwaRt/K9PJb7pt5kxUUk=;
 b=NSif7DwUlw5nSUGeOq/82phz7UDVUH/7HepPkT5w/8gSEv6+d6T8lNqYjMrYNUdcnp
 covR7MM2dNajHbu/rE4xnMY2QVKOfHOD+S49xLzhQNGtCidpejotzX4+t15nH4oforDr
 FqWpRSEiQN0u1mvbSGZy2n1ecBZrmfz6ljdXha4bMk8dnF9DuPGTARy4VJDtFe6mKEuq
 RmHijbKgexo8KtSQ2ceX21YjfNUiPEvpzUKwZnqb8XJPp4Hs+8xcfJWT/9um109tqS/K
 XpQvIAaQ5gV6DZFOAvDO/zwl7nkjQiFpg7X8S4auo2b+8S+b2WQ5pp1poby9RwTqX0pC
 2Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=oXiqN+RrYGdfkWEsu1YpPKuSwaRt/K9PJb7pt5kxUUk=;
 b=CK8NF3BR0kZw+NRnjXit/s40O0DXBs1e0ZkkGDcq1CkJOZJaGxZHVFkV2bIqJJzM02
 xXQbxE/jGRmxpruIy0wfnjZk+rbIYcPj9zsum0G/WlSYlemhcch0d25sny9TDET7VIpN
 Kk5zYAIhbyL4ri6JD6wG5u/i2greKqrW0x4NywcpZNGobmjTt1PjoR42m0VSN8TSDaJ0
 HGAdAJBIFqNDD7XhQ26XCP4ZdD5Xlo78jlQCxICTLMDwRIDsVDkVdO7OI0yCBr9J6/DX
 hTt2f1vSVYHgMO3+pDrTqd7hOJ+YkvaIX27kiE58mUvEv9qnZn/pA2B0UAb41RM+XkFQ
 cgHQ==
X-Gm-Message-State: AJcUukfEk+nrTKNKlWHPGlSpeJ/Sf8ged5ehn3ZMI6kci/T7iG5mzwmt
 eWCfvlyZeoYBFr71Oz7HZmw=
X-Google-Smtp-Source: ALg8bN78uGlG2vYyUhfFJAmY421lVnBEi97xot6zFgkG2FDfmJoi3aYMa3kjUpaMRSJ1EzkzZ2pO6g==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr18770862pgh.265.1545831138571; 
 Wed, 26 Dec 2018 05:32:18 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id 125sm67850226pfd.124.2018.12.26.05.32.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Dec 2018 05:32:17 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com,
 mturquette@baylibre.com, sboyd@kernel.org, kgene@kernel.org,
 krzk@kernel.org
Subject: [PATCH] clk: samsung: exynos4: fix refcount leak in exynos4_get_xom()
Date: Wed, 26 Dec 2018 08:32:15 -0500
Message-Id: <20181226133215.4939-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_053230_405955_E8D3D5E2 
X-CRM114-Status: GOOD (  10.75  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/samsung/clk-exynos4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 59d4d46667ce..54066e6508d3 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1028,6 +1028,7 @@ static unsigned long __init exynos4_get_xom(void)
 			xom = readl(chipid_base + 8);
 
 		iounmap(chipid_base);
+		of_node_put(np);
 	}
 
 	return xom;
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
