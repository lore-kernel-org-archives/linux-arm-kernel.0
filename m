Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55E4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:32:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B571218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PXqD6sjw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EyD/2NgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B571218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eSo1+j41yyW3UOuIc2zh4kv7MjiMHesBNZIp0C6AUAk=; b=PXqD6sjwsfx9t/
	v/NSRkmtpSSoerpkFWJGsXXKZ8yYMp1tPHAGf2LAbvtcoMJGZhOVWHiXK0ymTQC9gOTcaNNTqOoj/
	CsVNmQgPzqX1/s6tuYhF4bWqUbmdh40veG8PA05GaVCOWqiGlo6Offv3eZTa6Yi9qawkiBvsQMuRA
	vuIJ5g6auEIrEioOd1YMygH70bAiU98oT6E/ykx8R24EKQQmZ2BstklW/ryA0oEgsVAEp7JvHy/9V
	cTtfCz5p6lfEpmxkPN/NigeM9KHs6TgMf7sI9eHoVziBkAsW3/5i7VaqZrkM9HuAShO4MbftxL61o
	X13G7FIFr2P4lUbQ+8TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8hb-0001k9-Nq; Thu, 31 Jan 2019 09:32:07 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8hB-0001M2-7u
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:31:44 +0000
Received: by mail-pl1-x643.google.com with SMTP id y1so1217876plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XwV5NceIy8SJWO3Dn5rgCTKNVRtgdNg201S3RdP6Xfs=;
 b=EyD/2NgIXL7x73pg8ki6VPw4vEUFhE6XVUvYefF3PQPqJME7sUlp2njdPxo71N/OHe
 jWXcD22DZyUuHxaYMpPg3qZzPDrh3PesE2SxdIK93OHtWWdONgKnBMKClBKMAvfdfnZO
 wXq7m1o6FXoGsjeCfnMzxMdKdf9GKMYGE6bpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XwV5NceIy8SJWO3Dn5rgCTKNVRtgdNg201S3RdP6Xfs=;
 b=WXRL45N66sriUb7BScpXIFpyoC2h1s3h4fCJs20OiiF84HXZTLOZfm6QibyEk9wFiW
 k/u/OSO/mHhs71uFBUXeyHNHo5Wleqd7HkCLd4mV2QHA8g4F+p7x10Hn7SAwmEBP8AH/
 +ganJHxt8fDfZg7P72GeeRSxMlD2kSHh8NpVBfrXwxvk84bCWciPTL1IgPS6RBP2jJvC
 qJ9VHdHsBzBbmStNP0B/2gXPbHdgT5Eo/M05Mp5RqiRrd3EqLP93gEsP52sV/68EQUcJ
 3mEN2wQNQCT3cbHT7Bp/g1LPajZCbJFuA/GqHTUQfeWFqNDUIetlkFiqNnTb7aBjbRAF
 kl1w==
X-Gm-Message-State: AJcUukdafaqqy5k1uXF5EHUY4W+gyk7RzcAEyvvNBRMJCvM4Dct7SkdM
 QLG8sCtToQURZkcL4T7SkbbcRg==
X-Google-Smtp-Source: ALg8bN7bnuOCF1AxOQGwk6uupYKVfweajlM1oD/fg3GZG2MGvCwoK9Gl2zQZOTAHduE5E5kpVijwJw==
X-Received: by 2002:a17:902:584:: with SMTP id
 f4mr34986569plf.28.1548927100583; 
 Thu, 31 Jan 2019 01:31:40 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id w184sm4531197pgd.34.2019.01.31.01.31.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 01:31:39 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [PATCH v4 1/6] dt-bindings: Add a binding for Mediatek SCP
Date: Thu, 31 Jan 2019 17:31:26 +0800
Message-Id: <20190131093131.245531-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
In-Reply-To: <20190131093131.245531-1-pihsun@chromium.org>
References: <20190131093131.245531-1-pihsun@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_013141_295103_AEAA4FE1 
X-CRM114-Status: GOOD (  14.55  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Pi-Hsun Shih <pihsun@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Erin Lo <erin.lo@mediatek.com>

Add a DT binding documentation of SCP for the
MT8183 SoC from Mediatek.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v3:
 - No change.

Changes from v2:
 - No change. I realized that for this patch series, there's no need to
   add anything under the mt8183-scp node (neither the mt8183-rpmsg or
   the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
   directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
   created by SCP name service.

Changes from v1:
 - No change.
---
 .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
new file mode 100644
index 00000000000000..b07e5c4ca9af1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
@@ -0,0 +1,10 @@
+Mediatek SCP Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+Mediatek SoCs.
+
+Required properties:
+- compatible		Should be "mediatek,mt8183-scp"
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+
-- 
2.20.1.611.gfbb209baf1-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
