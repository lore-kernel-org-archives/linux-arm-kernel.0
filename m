Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2E12184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cPp75AT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2E12184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C9LKwa9iE99O+/hkLCQh99/QN8tv5mdCNXed64DRa6o=; b=cPp75AT3KGN9Do
	rUIkASEY2xz7VQg6jTGkjXaeROjTkjdfRDF09450vPphJZQL8ctFlzKJHagYSy9hgmcFkb21kETGa
	wwq/AchhWolOmZDwsmxgJjpYEmBXcmWpw6qDohuu/vG1xxmEEtxT4/WryXodT1fdKoXKn8SRXHDZu
	oQypHoa9bIqKPYCfZ7/+as1UDb0/Nit+SfhUy6mkO9jjD9GKwbHraK/3T+jd5WvD0G3ygTDU4e32D
	2gvZqaL6YBwRlvNl/10JbgrAg9UzkAifENd67k9wckf6ntRHyk8QSkrYxAtbND9bvvJqSee0yR019
	ixweP1LmdOObh2vW11mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfEUB-0002fr-2M; Fri, 04 Jan 2019 01:41:19 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfETw-0002NY-Ql
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 01:41:10 +0000
Received: by mail-qt1-f195.google.com with SMTP id d19so38952207qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 17:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=HHhbR5UARcBdfKhvEAPMhhHPIp3au6k3s9rssxoZ9to=;
 b=RF3GBw74bVSeoQVHqWpBXkVsUU1mlIMrJhCtF3h2QBdv9F7X+c0hRukgwiTxj+EzYi
 zfrENptl8i1ULupGRhmuG2vlWvXGHY2khWoyB3PQxuX69Sxw/LHv9d7jwajN/ucgq0+G
 trJXq3SJNXuS4bnhY91WQGdt26r2D+fXc6XuQLZ7o09257LyCYGImeVnaZGoZQM3DDmt
 2N/B5lBqpCiEpCu+hmo3R7zLg37BkYFMkWhNf5b+63a/uZq/LBXYsT6/irzxQ5dAW/2x
 td5p8vf3VMhOgfbWymgHl5ceVNbnyJuapLqLtQj3MVA34tXQHWPqNCzU2jD/g0fNuKYo
 0Glg==
X-Gm-Message-State: AJcUukdZxeFit2fOfkYpN0ZXFDcLc8oHAMJmgOddugAu66I5latlo0B+
 blq3EPahrWKupzoljtaikJd3djr9
X-Google-Smtp-Source: ALg8bN4YKFnO2BIypTRVe7fgo+ncLx3xkY2gdJVGuqep2jzBlktOQJ+0yMgFzoftayZLi5MXhfl6hQ==
X-Received: by 2002:ac8:468f:: with SMTP id g15mr48038697qto.363.1546566061726; 
 Thu, 03 Jan 2019 17:41:01 -0800 (PST)
Received: from localhost.localdomain ([181.220.84.254])
 by smtp.gmail.com with ESMTPSA id l73sm30882443qkl.16.2019.01.03.17.40.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 17:41:00 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 03 Jan 2019 23:40:54 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] dt-bindings: Add vendor prefix for elgin
Date: Thu,  3 Jan 2019 23:40:22 -0200
Message-Id: <20190104014023.17973-3-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104014023.17973-1-otavio@ossystems.com.br>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_174105_511312_5F8A7B74 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, devicetree@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Otavio Salvador <otavio@ossystems.com.br>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Vicent Chi <vicent.chi@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add elgin vendor definition as 'Elgin S/A.'

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3bbe3b87a1ff..b2c3d7ca1722 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -113,6 +113,7 @@ eckelmann	Eckelmann AG
 edt	Emerging Display Technologies
 eeti	eGalax_eMPIA Technology Inc
 elan	Elan Microelectronic Corp.
+elgin	Elgin S/A.
 embest	Shenzhen Embest Technology Co., Ltd.
 emlid	Emlid, Ltd.
 emmicro	EM Microelectronic
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
