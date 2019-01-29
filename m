Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14757C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:47:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF10920882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e8ef02jj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KQ0uLPYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF10920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vn5yiHY5WEdloMUKw8Nk64EZkKti7o19kwUTbWAfjOs=; b=e8ef02jj6UMKgi
	SD3kOO2v9EodZHPhQI+ZL0v2SHP7/Ow1MwiI5hYZ9XM0j22JyckxOuECtv6Zxq4kzzj0JcoHULX2l
	jItVjTzDzp+DlckVS1Sf3RsLopyoX6j2rJVcjqkB65Nebt9ill7Sz51nuHR/g9cvFkrXXgv2RUqTA
	xujQuDG/9pmFnIYeT2vWj++lLrJn/D2mM9YnbZi2+8P12dmRQpRK1TAQ7AjtBGiQL8b/pEx+v55kz
	GUR2DDe9r/wqq4jPGGpewSs+GVoVeuW8PPSf+EGSfXaDBTh9axLIFfUqtwX2DXogMb54Pid4yf+p0
	SvJ0U+SevtZCnQJvyL6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gobES-000127-Cd; Tue, 29 Jan 2019 21:47:48 +0000
Received: from mail-qk1-x74a.google.com ([2607:f8b0:4864:20::74a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gobDo-0000OF-Gn
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 21:47:09 +0000
Received: by mail-qk1-x74a.google.com with SMTP id r145so23445779qke.20
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 13:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=VfTmoNMPlJmohGl2Jrgx4BeuNBOVF9EMtA7Kyykgjb0=;
 b=KQ0uLPYfWNlH3/RpDZBUHajDNDRAuSm6tqYQOe8N/2DwozsycLvyteBAnkzDczWWXx
 kY5Qp4Uxr7jN6gUftrYAP8Rfoi7/JFDmaZhxSxrId1h05gxLLSsz9RptaeRJ0wOfvFZ+
 uyVnGu3KH2xkqSnK8QVE5sUkYeYIM8aBpDe11CK1P6QCHM5E/wiZGiUfUAWhq0bBViAu
 ypV5qEYqhwi0+Bgvk8JWpyO6JowsORJaf5HArhBRYQPWr0mtjZR4lcIp4l0kvLaMH+Ab
 uoWc4wyWo0STQbaXTQ1x0LuVgVxwjZjZF5U6h5ps1GMnaQWQzOMPRWVnDrhmS4ggEh9l
 Jfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=VfTmoNMPlJmohGl2Jrgx4BeuNBOVF9EMtA7Kyykgjb0=;
 b=RqiCTDV3cFL0H4VKTZ/SejGMdfFZsJF3YpAPfrRRv7iNPH/gBE2Z4bO7r88V2+yi0G
 sOcPhGSVoL3lQQh64ZA0Ym4byGGcHiNRdJe7+T8PEBi7U9VfoyI6P1fYwwCkz+Ug7B2N
 yHs9TTJ8GEgLqQtQKxsKGkGN1pdcgnh7dSkRS8UYErtZ51YQZj5KFEX8HageTIvH4kHf
 MVu0+RuJ2IBBbwqstntySdOjuTxFOnNo2uPi1QvT13Nl8ql2GQiyo2zm4HMDtYUTj3SG
 9iNQQTxIm++zStH4mQ1vsW+7qW+99evq9mfoDnMbsKiz540FQiQtT33FN0g0GZ/1DcS7
 UB4g==
X-Gm-Message-State: AJcUukeGsNWFDp+PpaFfgrqyk5pAyyJAKqiqmbZQGzFwZOgMQzUKmwJj
 6bkhV2kIPBlFLpt5J9q49ht3mhsG1zh7
X-Google-Smtp-Source: AHgI3IYndzSP3ThzJ3+zOZEdR7qNg7UVYBWhioP7GkG3xlWXwI1jT9aFqPjSpoqFkbN6u/lNBum9it3WqlZM
X-Received: by 2002:aed:3a25:: with SMTP id n34mr4385651qte.17.1548798427022; 
 Tue, 29 Jan 2019 13:47:07 -0800 (PST)
Date: Tue, 29 Jan 2019 13:47:02 -0800
Message-Id: <20190129214703.119694-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH] ARM: dts: aspeed: quanta-q71l: enable uart1
From: Patrick Venture <venture@google.com>
To: venture@google.com, joel@jms.id.au, robh+dt@kernel.org, andrew@aj.id.au, 
 mark.rutland@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_134708_559862_BB267731 
X-CRM114-Status: UNSURE (   7.88  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable the uart1 node such that the clock will be enabled.

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
index 999679b5ef55..0d7c6339da46 100644
--- a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
@@ -138,6 +138,10 @@
 	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
 };
 
+&uart1 {
+	status = "okay";
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.20.1.495.gaa96b0ce6b-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
