Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B452C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:23:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AF320821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K/EJvAV+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iooce9HI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AF320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Du049S9bP8FptG5Gs/uDQUEIY+nJP6SejMjyZ3/p5Iw=; b=K/EJvAV+s87PmJ
	7FetgYeMXVBRHRpAKjVBpnLIpyBznaANTwW3o1jXaNL8qg+e2EFgQhyTzswqVDUdQtAZZbJTjcfvi
	FL1WoUNLPJkqG46Ticnt0O8/vGO9Ew5diE5XJ7P9LVi8sm3AvW3TIv9Wh/1LWkYF1oLLssB3mTRXz
	iDI2IEUp7Y4JmiT+W1egolb9CWDV29X6zloeh0QVzPoytQ0CbG5E8lGVRSk60DPvvpxykSqqhmxNW
	KxCyQ+ABgRT83N6JEdzrS16uXz2wZt0D+7JQvvaRPxTENaLcQDryqvwt/wIVyscYl01mjdbsnMi1u
	VBLRvSH82Kt9f2JgOLug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLWi-0005gw-3z; Mon, 10 Dec 2018 13:23:12 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLWF-0005Cv-MB
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:22:46 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so10438047wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wPFj6MLu/M8G4PTHe2LZz+FX5iaOvPF1UuFtv4gFdoM=;
 b=iooce9HIO/IlQvwj9SUjEVZnfs4JA8YOgJDRilfuZl6auKf8xTrYC9R5wRQ+C0bHxX
 ZoFdLXyU3el2I9dN9udnFGLs4UxW6Gg5ijO2IoI9UK+vPkV3zubFGZUNq3RRD7yR0si5
 66F9q1JZHKxsUODKLPhESXtIAOv+SDnoCVVfNIezW2czQtrLsbRQIs2xotIRdGhS1Wl1
 xdUkmfyWQD++JJNL9TQVCq08kwEK4ZRHGDCJ6oaYtwoRRXp3otKtUoEHPJBCX7gWrcSM
 Ewwf5pqG3wqhf9DckZw2fqS9rqIWcZ271KOBsQHQ/Y5GvgJdW2lwVzUWjy+zssTlFyef
 1TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wPFj6MLu/M8G4PTHe2LZz+FX5iaOvPF1UuFtv4gFdoM=;
 b=FWE6fPjZ0TLrgGUGGNkPkWwhW0j7AFKtyHtbnmAN4Y26V1vC+kKV3s2it+xjvT0ose
 FzuHxI1JAe6ecd+BiivJ8FTH59vYo1n66Wmeat+EPkXfgxGmH1gms9KqyktaI4WjnuMW
 HVnq4j/9EY8F/7q30Vom+p3o/koZZBNROaE8xq879phr0Y7aLGSmufGZILRRF3GQ0ULH
 VSWZV9Sz0ASIGfGpp4HJHum/exGOfoEmzU9Cea+eWxhXpMP3Q2fgASGEvUmAJImRiStN
 6oD3guugBSoBhux5eKhRZTP4TAMc8bXJ6MV9Am6zaBTStM8e64oHyGa2K9pR2E868EX4
 pLMA==
X-Gm-Message-State: AA+aEWaMpLBn2U7XLL4alijw0m3Z/y+VK85v+lxvjar+2cgWCIaN7RF1
 ir28wfhutMVnkSAjFn0xPTFwtA==
X-Google-Smtp-Source: AFSGD/VMEYq9rPP0ewBLKlh/rB6emjkoSuKndni9TE55hTZ/5s2L+oaavtKw/KDurpcOrw1X+emiDw==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr9607298wrn.11.1544448151513;
 Mon, 10 Dec 2018 05:22:31 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id l3sm11208424wru.36.2018.12.10.05.22.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 05:22:30 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: devicetree@vger.kernel.org,
	khilman@baylibre.com
Subject: [PATCH 1/2] dt-bindings: gpu: mali-midgard: Add resets property
Date: Mon, 10 Dec 2018 14:22:26 +0100
Message-Id: <20181210132227.29262-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210132227.29262-1-narmstrong@baylibre.com>
References: <20181210132227.29262-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_052243_751530_D5E02896 
X-CRM114-Status: GOOD (  11.83  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Amlogic ARM Mali Midgard requires reset controls to power on and
software reset the GPU, adds these as optional in the bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 18a2cde2e5f3..24d83ec952f1 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -37,6 +37,8 @@ Optional properties:
 - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
   for details.
 
+- resets : Phandle to the reset controls for the Mali Midgard device.
+
 
 Example for a Mali-T760:
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
