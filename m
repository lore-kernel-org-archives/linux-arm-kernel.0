Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C81C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9B521B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k087vWYV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGrnrRtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9B521B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Rr1rpp+waacA00wgLWtNxVMgIZ67bRe7svBcCoO2SG8=; b=k087vWYV0kYhGlaygmRuXKIviq
	CasBt2ShaeR7w9hlrOu37MdZkXu5qYv11U/dlt1+3N5z14LQgW5Z2o8B8j/cBh99rWkr1LYCI7+9n
	CswAdSnpKmbYN+0h2TaNTG/JO3GaaszTRVmLxICshXvk7kYEap6HsWndM65JhDcRMfQy2w4lIUCyX
	u7KBgSFrsYae0B13SNQYboIZjwPHC0lK1pQVcIWD0m97+zXIolAVaCgA4EjXjX+mN/IfPu+qet4FT
	6xzpzyHA0YcQiuNrXgwC+PeHP+Vj75ryETIzHu07Sm5TSNwfny/ftFBOc6IR20j2rKL7d+kAv1tMF
	H8Ht1hWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guWOH-000244-Ak; Fri, 15 Feb 2019 05:50:25 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guWO7-0001g3-A3
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:50:19 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so4254840pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FgP1Av6WIa2OwRHRskBEOGvJeOoMNE23SqACDKpO5GA=;
 b=vGrnrRtOh+CFwVIsf5zXdpm3NO6QemlAqrI3DdzPURVLojYlwn0pRxREBrdseVUL5I
 g0dvRPCEy6lrPrwNc9L8x8Dm7adEnKmhAThoeFaBPqAxSizh4ytLuAYPxFuYAr4/NwnN
 cdsEK0R06AkbfcR8fdfWvD77eK/88XkUr/GIUk0Wrz+fGWqlvoaO2w1oEGZjHbD9r1Ha
 zQ85PGidEd2Fdw/iuwQv/yrfzv7HLsxnIagEbfEak9xDt6gdwGhRGnHI8HTu0oAcd1Bh
 w2kwtl749r4KkQ9cBBKuK/v9a8G7O5gYiLEEBod9+EQz8KLLeYZZZYxPvl8ZO1goAiMQ
 +lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FgP1Av6WIa2OwRHRskBEOGvJeOoMNE23SqACDKpO5GA=;
 b=h0sOm/h3Fy2qUBl4Em4Y+fEf6jcze5c3XEkfDyI42AeP8Gt0fk5jRiljuu/5jd+CWR
 7DWuNQqsm9pJ6WKO1wzxrhrRMXLpMZrcr6d2A6r0/TQe67Gb0WnqbJaeTgG6pdBOtKAu
 t35COM84TZrJ8o04NeL8fIqHrkJJtNfsKAYM5lbU3gyvF5TK6F9XxcS6zkwPYhqSR9B2
 ZZHuFTsiM1tV+6ia9HbOfjr723ObqIyem0KQki7B6fnuPpMVci5QOfPHF89IkidwsRSf
 E/nDPJdK7qAmxGBAxVK+K6gxDwcqRpfs/uquz5w4lI/seRVu5fgM4rg0WsgsH4qbqTHw
 lyhQ==
X-Gm-Message-State: AHQUAuZNQvZsx9CTBMCPWbJuXa9EnhsEUR+JGc01dTMwfFSVGmN4gldn
 D+d4p7JmGrv+Y6bSRwqgWmMzhuVEiA==
X-Google-Smtp-Source: AHgI3IY1YLEQr63XAmBf0S/+piyK7nomI07zC/PaEqZz/zzepN1rt9s0hPp597nA8odFMTlFrKjDkg==
X-Received: by 2002:a63:e742:: with SMTP id j2mr3818961pgk.172.1550209814821; 
 Thu, 14 Feb 2019 21:50:14 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98a:c91:14c4:f458:9909:7fad])
 by smtp.gmail.com with ESMTPSA id
 c18sm6160810pfc.63.2019.02.14.21.50.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:50:13 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: p.zabel@pengutronix.de,
	xuwei5@hisilicon.com,
	robh+dt@kernel.org
Subject: [PATCH v2 1/2] dt-bindings: reset: Add HI3670 reset controller binding
Date: Fri, 15 Feb 2019 11:19:54 +0530
Message-Id: <20190215054955.788-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
References: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_215015_633659_CFC46BF1 
X-CRM114-Status: GOOD (  13.48  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, john.stultz@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
driver is reused for HI3670 SoC and the binding is documented here which
uses the fallback approach.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt   | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
index 2bf3344b2a02..2df4bddeb688 100644
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
@@ -5,11 +5,12 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 The reset controller registers are part of the system-ctl block on
-hi3660 SoC.
+hi3660 and hi3670 SoCs.
 
 Required properties:
-- compatible: should be
-		 "hisilicon,hi3660-reset"
+- compatible: should be one of the following:
+		 "hisilicon,hi3660-reset" for HI3660
+		 "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670
 - hisi,rst-syscon: phandle of the reset's syscon.
 - #reset-cells : Specifies the number of cells needed to encode a
   reset source.  The type shall be a <u32> and the value shall be 2.
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
