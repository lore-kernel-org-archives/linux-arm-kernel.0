Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE3DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:56:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1472081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oDWzGBwb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U+oBnd0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1472081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3rvDsYfygNrwjRDxqAS7z84fTyu5TpoRm5GBQm4KDTU=; b=oDWzGBwbiipMbw
	Md3XncvLOlqWvH1xG5hvPz1kflIJTQGtw32LHXHnf+44maZfTr2yKFI7BJsobW+QG0znyuAkakcV3
	0lHFCG7VejwrC8/SiX3gua5AtdQ7dFyv/QX7rFIX9yM5Xyqzp7c4mVVjD2bVlu7N2tLFONUYFzE53
	R1+TmnxE+tMJs2ZeDNsta/sryThpAua1sOFPW0QU2+snfunh9SpPj9DyvDQ+tSKsd2jztagT064bE
	HaP15PP+b2qGT+OMGgacbDNOj1DE7+VWdk1jrwlD+C5EsPSFyn0o6IZ8y1qT1E6GwoFlQMsH2Fpli
	33uqS1FuJkz7GiwUAxOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVftm-0004Xo-UF; Sat, 08 Dec 2018 16:56:14 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfkx-0006vM-RN; Sat, 08 Dec 2018 16:47:10 +0000
Received: by mail-wr1-x443.google.com with SMTP id t27so6532465wra.6;
 Sat, 08 Dec 2018 08:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4QoWFYdjwYMC8tWsTDBT1tQNmYukVHcS0fTvruwJ7zY=;
 b=U+oBnd0CrhKfSQMnfdw2hd4TW5z4VvZ8OGRW/GCG+BMTqTHElrff+8v/R4BqmzcLAd
 /nxh22SekA4SKafSWuxH/fXR/dNzxc3kFjmegT1OQmR+dlw50ndgWcIDaMUQcBkFLyz5
 O2TOcsKFa5oMAWSXhn4JLSW9tWrjvh/dipNVJeqlWJNoCpSm9NOERsJf14SMfzxgC3vf
 Apz3DvIBWeYKHGJCPa3nc5Vq/LVr0K/M4EDcewiFdpJYWPndWxV6c1QgCDx4sbui6Zuj
 fXIp/MjqbLSAqYx0DMDSkbp22SK3iacgREnAwRexFeR9aXIepRAn/gUH+x1aE3yM33GI
 Cd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4QoWFYdjwYMC8tWsTDBT1tQNmYukVHcS0fTvruwJ7zY=;
 b=qnG64qo78IOm8RiNvkzAQbwsNyyb7C+wClZCpN2IhBSpBFGW3xZiq/vybWeWeTdxef
 TxlLicpZ8DR/BgMMVwrBQZOJBvPRW2gNaS6UHmYd/Aqm28kfl/K/5GALOAOMLnWV0TT4
 FVVH1nC2XTFjEPMfMAXXzIXy0DGLRi14i9ZhkR3Mkk2yezIuRVD8rgDCsfohYPgghYZa
 dXyDPP8D5yFPQWNrvRoCJY1mvJA8iicHKvBpTNvGkOrY1OrQZYHenOfIQP+WW7t/0MbR
 lGp1SeupqiJcxLSIWNduBDdXknCf/lLNqCikIXAH/X3EegeBAhinKoxhchexbLMLJMNE
 Z+4Q==
X-Gm-Message-State: AA+aEWbKTZOOsnuvIO9hx3kfhrHvhh6nVI9+95S7wA0lKxzjm8LLqa2z
 Ua66GMZ9sK14LWeUgALsDkTSKJz+
X-Google-Smtp-Source: AFSGD/Xnfu5LTM5cPck9zzFRHTAxDzOMOgTVmfs6xzi0HozgAbm/PTKvsHLD5yeN1UBT4If70ODGug==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr5257378wrw.34.1544287615561;
 Sat, 08 Dec 2018 08:46:55 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:46:55 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 1/3] ARM: dts: meson6: add the ABP2 bus
Date: Sat,  8 Dec 2018 17:45:50 +0100
Message-Id: <20181208164555.26527-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_084707_887460_C88B3B4E 
X-CRM114-Status: GOOD (  10.55  )
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Mali GPU and the DVB demulator are located in the ABP2 bus. Describe
this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index ca978ab952cd..65585255910a 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -70,6 +70,14 @@
 		};
 	};
 
+	apb2: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x40000>;
+	};
+
 	xtal: xtal-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
