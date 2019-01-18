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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F8C61CE3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:54:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1692084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TivJI8wz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HL+pGmWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1692084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XG4BPJ/TDKHCU490Qip9PKOwSu/cFURKE83v5gJcyzs=; b=TivJI8wzDhnptY
	FhATooEZUYa/+3IWlrykvq/1UTu4tlOHHgnIjUcz5Jj7Pxjev2v9G5YE3/BJ+tbUNeZBrYsCtMoPI
	ghl5EPZ0+SwJiUPXheYAOD1+tHHXlO3gUJcXiw3NYIlxaGwJyQoZy1xbKARAeLPelFDsGpKHn//tX
	afzhQNnnO0BWqOid0HQlzD9RczpliPmk7QX+2f/rhHBVRWPqpAX2D1U1D505lZGAGASmbs3z0h1EW
	URaUNIiQArq6fsmCuqMwZs0BpoOVdZ9i5Z/TW9sbuARFqXIzr6fOkchqnypBRVK4KscUp+7QkF/Gv
	UBU3kU9SzQpuEaKT4l2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkd1d-0001nt-8h; Fri, 18 Jan 2019 22:54:09 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkd0b-0000pt-Cy; Fri, 18 Jan 2019 22:53:10 +0000
Received: by mail-wm1-x344.google.com with SMTP id y8so5916185wmi.4;
 Fri, 18 Jan 2019 14:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6l6WolcewijNZ7C3qoRDiIawTtYi7pkKh2E+h6KjBjU=;
 b=HL+pGmWDAVhAT1PB2aUZ8XgfmbJHy70tti9LHkfD4OsKNxWEOiN3jLbw5z8txIZH6Z
 DV9IvPL+1MfzcsMyTMejp4MydpgoNQKHMZd4+Ad26AtCJNNTBOzI2lRd/nczVwyp40Db
 g2jqFz9VAbEj9z6Pp5xdWRsIMjXG9xC66zycUK1BPLX1PP3qalJDhXjl2hyitEpJAF0h
 RcNqjAp5/e0Z77p/Otg6XRN1F21kCsRAgLf00jl2BMiLgBTGdJAMheoQV3zKZ2j0Of5a
 SRyDa4qkiDKXm0T9tNZTogEI8YMLlCVFwZsNbCqMyQ773zIuZC03XLivgQmp0LGOGSJD
 cqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6l6WolcewijNZ7C3qoRDiIawTtYi7pkKh2E+h6KjBjU=;
 b=Fa+ibocNJWp6IHMOKXDtqymThnjIWk5FHmLNJinaDgSRjMWAJFVSz/A1XtpQDr5nEz
 C5y49alSeKEIUXNxjzkayPaLRAkC7TvgWXBQHw/DrfHk4U+WMJyhwlRhW9aEoSS9MIHd
 TfKDeGIk4xbRjYpksJ50sDZ6kXANshZ2K7nrqbZW/pexZIYNtSAcdGUCshqOatyClRJi
 SFrOsegUGhoOEpmz3YqlvJ4fuvVRslL1yABRXB8Unod/UxpZBO6XDK4GU8Z0R/PNCa4A
 H5mGsU6IyWioBSzzUQHJ/96i/02xG4f5LLLRVR+eqfggaNFnNEHFVgcvss1xLZR2zdVZ
 9GDw==
X-Gm-Message-State: AJcUukftDhwuzR2p6ej9t3A/tJLRs76QKtzhWJ5kY4nC7UTwEDuLK6ir
 iz6PpBqyzMbMIAc8S/HpAKAYx/0V
X-Google-Smtp-Source: ALg8bN77H2e9JWrslAM3lXtLXmX98Pb1y2gXqef1vDYVPhEZ/qIQTlZCbnUdKnhtyy242R4P5cHKgg==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr17324158wma.109.1547851983053; 
 Fri, 18 Jan 2019 14:53:03 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id
 x186sm51197352wmg.41.2019.01.18.14.53.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 14:53:02 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 6/7] ARM: dts: meson8b: odroidc1: add iio-hwmon for the
 chip temperature
Date: Fri, 18 Jan 2019 23:52:26 +0100
Message-Id: <20190118225227.6516-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
References: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_145306_014513_371B8124 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SAR ADC enabled channel 8 can be used to measure the chip temperature.
This can be made available to the hwmon subsystem by using iio-hwmon.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 0f0a46ddf3ff..8c83590810a8 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -118,6 +118,11 @@
 			  1800000 1>;
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&saradc 8>;
+	};
+
 	vcc_1v8: regulator-vcc-1v8 {
 		/*
 		 * RICHTEK RT9179 configured for a fixed output voltage of
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
