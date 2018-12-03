Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:50:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CB520850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B0D0Yz11";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UgDOnigX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CB520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xfmlWKqVOWObanVB99V/MvVL6XeJizYbtZhP0Ld/6u4=; b=B0D0Yz11d8EeKc
	6FqxN+AYWjZyXkLRuTQhWf02V7VpfltpMaecbcgO/JWrh8GnwjhiyPdno/144vxsLdz1eYYmTlfN6
	BMchgluRMnBvloeV8atjdwSC6QD33m4OoX+JnBFxP8iW7/oq7NFOcqQjrXr9bmgxmETkU9idne+0S
	YBFQJMLOJLduj28+ZsUwDb8Zyiy8ttcBOdbLp5npAh/06D5fxQtnqTkxzh7jEbZjBLxf5dDb/89jX
	DrPqgp+sgldq2rGHCKKE4kWjNkpZhV4pqs4OVelYmnsVU8q3twQP4Q3dkCsPRzhwqmR8RakYxEt++
	y7c3O3t+F7mD7hPPtxOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTw6z-0007Dw-OL; Mon, 03 Dec 2018 21:50:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTw6a-0006eH-T8
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 21:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RoLiDVuqvYANZ1flcAwjENqg+ADf2CNBEHOQ2CuYDWM=; b=UgDOnigXd8VnoUs9GL1VBCUVxx
 f/vNM7AJhd8kE4V/zKIpcYvDFX4Tp4FtXI9dzyzXOsLbORkUuycqI7l5PSN6sKHPHlbqQt4aUgQnG
 EJw10AJBsQeXd6eTBA+5pboPigDKtqkIbzJFC+kB13j/6gRd7wwa175JIH03MiTPZvPnr5l7l4PlF
 /8IivN8xyltQU9jbjLomg01WME3x6MExUQNueM54MkMjGsoSgAnzSJXkr118Lsb8e3ZHyCEVFvRe0
 jYstbckvyu0cuuDo0KI+T3uze03TzmjSGQkdqECXDrP/cDd/Ras0iUfT3R3IlbEDd8TyFBxz9YhwW
 KoMnbz6g==;
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvpx-000167-Lg
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:07 +0000
Received: by mail-oi1-f195.google.com with SMTP id t204so12343543oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RoLiDVuqvYANZ1flcAwjENqg+ADf2CNBEHOQ2CuYDWM=;
 b=VF9bkUderJyTU7PlT2BYotSoAh0fpF11ZKaxcsvks+YdveZ1BZ7/WQc64Kx9w26pfU
 Xl2e5mDgcV9islg+RMO3Gmcla46khd1ByYtTQ/8PtZJMhAtC0wD+lrPmbShq6P6Z+cdu
 L75IJmsVIcgQFs1Te+cPKFvu7MgtHTwUzmVX8GUBZb8eSJCk9j778bSbttoo/2LfL88Q
 Rak/JRa2rGLTxZCRjXDxJknRIsbHuZK0uuHQKPOUJCu+CKb1C1GrVreT5Z0KXi7GPEPc
 iFrbTOxwSlNR/v1gAsJvK/4+G0t1hC8LpJSbhV3GtOR6yUBliTWQu6hcqAqRMIkGjthx
 +6dw==
X-Gm-Message-State: AA+aEWbwmYKm6rJgnUDgWXrAb1snpnZqRCLJgkwqeul1zVj8H/Ml0Et4
 PapTyVkSzUDVmbuggFPSCg==
X-Google-Smtp-Source: AFSGD/VJlx1PDBZmcmB/SGQ6RsJ+otqbwoIYa3j7R2bskbvkocxhm0ynECKqW7DVQTmQOycr/0tgTQ==
X-Received: by 2002:aca:5bc3:: with SMTP id
 p186mr10568213oib.130.1543872776478; 
 Mon, 03 Dec 2018 13:32:56 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:55 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/34] dt-bindings: arm: renesas: Move 'renesas,
 prr' binding to its own doc
Date: Mon,  3 Dec 2018 15:32:14 -0600
Message-Id: <20181203213223.16986-26-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_213305_709750_2B9FE327 
X-CRM114-Status: GOOD (  16.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/renesas,prr.txt   | 20 +++++++++++++++++++
 .../devicetree/bindings/arm/shmobile.txt      | 18 -----------------
 2 files changed, 20 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt

diff --git a/Documentation/devicetree/bindings/arm/renesas,prr.txt b/Documentation/devicetree/bindings/arm/renesas,prr.txt
new file mode 100644
index 000000000000..08e482e953ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/renesas,prr.txt
@@ -0,0 +1,20 @@
+Renesas Product Register
+
+Most Renesas ARM SoCs have a Product Register or Boundary Scan ID Register that
+allows to retrieve SoC product and revision information.  If present, a device
+node for this register should be added.
+
+Required properties:
+  - compatible: Must be one of:
+    "renesas,prr"
+    "renesas,bsid"
+  - reg: Base address and length of the register block.
+
+
+Examples
+--------
+
+	prr: chipid@ff000044 {
+		compatible = "renesas,prr";
+		reg = <0 0xff000044 0 4>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 58c4256d37a3..5f18ce9cdbb8 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -149,21 +149,3 @@ Boards:
     compatible = "renesas,v3msk", "renesas,r8a77970"
   - Wheat (RTP0RC7792ASKB0000JE)
     compatible = "renesas,wheat", "renesas,r8a7792"
-
-
-Most Renesas ARM SoCs have a Product Register or Boundary Scan ID Register that
-allows to retrieve SoC product and revision information.  If present, a device
-node for this register should be added.
-
-Required properties:
-  - compatible: Must be "renesas,prr" or "renesas,bsid"
-  - reg: Base address and length of the register block.
-
-
-Examples
---------
-
-	prr: chipid@ff000044 {
-		compatible = "renesas,prr";
-		reg = <0 0xff000044 0 4>;
-	};
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
