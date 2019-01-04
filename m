Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DF6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAEE21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GuZIlMfn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puOa+Oa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAEE21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jgnatUXscBnDEJP5Q21b9N6W+vBUjQuEUKsFe97QZpw=; b=GuZIlMfn7CGeTG
	W5J4r0ff0sCeyk7ob0KHdndkbaWMyk91bOjQFjfor5mrlhYITYuDcUIulkSYKdFsfr0RDMsBinRHU
	vN5pDxYidhZx6vlawtHMD3N8l0xlComVnv1pmw2WmZm2gkphzFdbm6BwOSc5DK1vg7mrLYlXQYZ+E
	rxCT5wW0FaC9c7i1luvDHLqsbYHlMu3J4DvQCmyM3T4oAATLXMc8tElny42kkpc6o2m/ZhF6RAqVo
	sgV0dHm+fV8vC3w5sAzdXR5apjxqlZIBAw+s4y0qUqriZjmXSCgh080tY6HqQGodj48KK/p3IhPeq
	qz/zPa7kWsLO1xX1UPdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTd5-00077z-R1; Fri, 04 Jan 2019 17:51:31 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbV-0004Ft-TV
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:09 +0000
Received: by mail-pf1-x441.google.com with SMTP id 64so18619611pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QhqhT8k9cRoxWOByjnw4+D3pr2bPAqv3RKgBmGiID7Y=;
 b=puOa+Oa5mf9v7e1IlYNfFflOsFbHuywQvz56JQu5xhuT1CWhPCFLj5SYPYM0yYmSxf
 /3ltIOT1DOuf/cpIxyBhUhuMcaU4KjjEeEw1v4Vp+uJ3/5Wswg9DE0gIpvZBEf4NTwgG
 g/Z+0G0NDf6OlV+Ajjkw/F4DhmocblP0TRHEL3hokf2GHWJ5twOYmMsVgsUhoPqohYz7
 zbbrvcYT13Eyp+txwqEY8zgTO1SEd+AEvdzWdSzcHuZwLdtEfyg5o2uw7tTj3v0ngKwP
 hQfOk4ZWVwOUb0AxvHfRCFHbgaChQbx7CK2zY/tDmCMQZNrW/4FH8cjdhfuUu68LEUd7
 YgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QhqhT8k9cRoxWOByjnw4+D3pr2bPAqv3RKgBmGiID7Y=;
 b=V2xEYeoRlGVdB+KxplPxJQIalsZb6ODAfgCxS1niOPfyu2zgVBo/P0Iw/msm+Jx4Xq
 /SI6BOVMHI3sVwlS3V4x+MzY0Ys6nunug/JUfXlyLSFTnlJtc+qWaWXvKCwF+Jp8i0C/
 ie4qH6049bhW7VlfXXB854/x0dCqU2ggUCj2b96+wGndKPjVFq24UrrdlA+xuPvD3Sp8
 Z+ijNQH/h3Xledt8Mvav69tGfHjAzjfkcusEhUb71/99Mc2LS9xM8NcXrGgyWZqf2oPD
 Rz6p8xF794g1sc9JwPWtneRVAZFPWlHXT4u6RMZHVKkR3VH9fWTB8sCTW7KFbc0VBRNV
 9tOw==
X-Gm-Message-State: AJcUukcEGyvZD+dTfNjtg80PpDcybRJudySMl8C8XjffHNWJ7AKnAsnm
 IyQ2+SvK+6yj+WQIPa9xhMsqW2KLE9I=
X-Google-Smtp-Source: ALg8bN4LPvul9EoVP+PUo/2OYcZzz1whMoTFA5PuuZ/nPLmsezd3LBKPNU19q/O3Rnl3lTb/V3kfzg==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr2485051pgg.429.1546624193159; 
 Fri, 04 Jan 2019 09:49:53 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:49:52 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 07/20] PCI: dwc: Make use of IS_ALIGNED()
Date: Fri,  4 Jan 2019 09:49:12 -0800
Message-Id: <20190104174925.17153-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_094954_700625_4FEA34FA 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Make the intent a bit more clear as well as get rid of explicit
arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
"size". No functional change intended.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 93ef8c31fb39..67236379c61a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -22,7 +22,7 @@
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
-	if ((uintptr_t)addr & (size - 1)) {
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
@@ -43,7 +43,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 
 int dw_pcie_write(void __iomem *addr, int size, u32 val)
 {
-	if ((uintptr_t)addr & (size - 1))
+	if (!IS_ALIGNED((uintptr_t)addr, size))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (size == 4)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
