Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FAFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829062086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6wDmAIU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOTdJMoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829062086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uXG8JJF7ZLt0RKi3cUS/xh6/rB2acj0tVatVM19cQCk=; b=O6wDmAIUcAFtSS
	txIssan31UntfJ8N/PEOZgEoOj7P0grP4ji/THnjxEAkg0qHOl3VYE3crDk9jeyr+/C60jq9JKfy6
	Ka/YT6GmuDjPNNEfRC51uv3iwvW6LUVXs2klqs2tMRXmd5w6urqjMRB/S5ydndUjAveK/7ZRcTZzy
	DPtxzJvdmhSazkTReQXWUjTKGvZnmVX2D1a5e9dnU4bC5MmrdFuQ2F02P5WdpZ8s8KDUSeSbN1Rk9
	b7SvVUsNIkX+gf05TuBvX7eIMOwahleyM4rFLRP7AxOP7oZIVyEFpp6jm+dmJ1dELaM4oC8PCvuFi
	enZiUB8J84xObIEab9Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPTt-00086K-SW; Mon, 10 Dec 2018 17:36:33 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPTj-0007rE-B0
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:36:27 +0000
Received: by mail-pl1-x644.google.com with SMTP id k8so5552776pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
 b=OOTdJMoV28QZwKWig2beKcjaiyzW73Jrx6asTLjc3u2QteieCIsaKh6NfWFd62n5OH
 yqZiwkKmuZQImMFk4aJ1wCiwmGvUcl90vDFqhepLwmubv2sdJLrbpU8MmcF4NOgTzdre
 0XpAVEptPwRU4K+RO/n8lLKNjsmYAgxlvfs5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
 b=sMIw1eTgUTFjNUZu9V/dp4++3bKnGTCTX/0seN9AxZCzBWHCIZLeZsYUU9XXt1abSm
 I7Lju06VdUwZt21DMDIkv2eldhsYoFXgluIm3C3UI58zrj89Rbdv3guzGjrviqlJ+A+K
 aMAYOzG73ezfOGxEJkIpt6s3RuraWoKRXzEMcgf2vrOiwB5WtVbrePKtjJC340UUSLzc
 SuS410M/TilU8KBmkOJizbJ4kBBj4DlrHYyBXJRgZfgrvPW/HmKqJUrqeect1ByGnsOU
 4wTM9s8FCAht2geI5pCNSiKNsrpl8vCuZK9KicCRDrRaY6gslY0zTOmPGbEW1Ntj9M9N
 +9xg==
X-Gm-Message-State: AA+aEWZ7Z/NSRijIVyb5e7AfKQbzRF6douR8kVESkYjRbMshMiWvkSdD
 mEXY8D7F0caGG9iq/LC6A7yE
X-Google-Smtp-Source: AFSGD/VlQQbhivcoy3gWxuETmz8E5m2MnAiSp/sBTcGGLnX7DhUXiIwhB7Xgrg7o88ZwLSXJH+Wb3Q==
X-Received: by 2002:a17:902:a9c4:: with SMTP id
 b4mr12922734plr.298.1544463372718; 
 Mon, 10 Dec 2018 09:36:12 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:36:12 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 01/15] dt-bindings: Add RDA Micro vendor prefix
Date: Mon, 10 Dec 2018 23:05:36 +0530
Message-Id: <20181210173550.29643-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_093624_098076_6FD1664B 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKQWRkIHZlbmRvciBwcmVm
aXggZm9yIFJEQSBNaWNybyB3aGljaCBub3cgbWVyZ2VkIGludG8gVW5pc29jCkNvbW11bmljYXRp
b25zIEluYy4KClNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5k
ZT4KU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhh
c2l2YW1AbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+Ci0tLQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhl
cy50eHQgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy50eHQKaW5k
ZXggNGIxYTJhOGZjYzE2Li4zNzgyNmZhYzc2ODQgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0CisrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0CkBAIC0zMjAsNiArMzIw
LDcgQEAgcmFsaW5rCU1lZGlhdGVrL1JhbGluayBUZWNobm9sb2d5IENvcnAuCiByYW10cm9uCVJh
bXRyb24gSW50ZXJuYXRpb25hbAogcmFzcGJlcnJ5cGkJUmFzcGJlcnJ5IFBpIEZvdW5kYXRpb24K
IHJheWRpdW0JUmF5ZGl1bSBTZW1pY29uZHVjdG9yIENvcnAuCityZGEJVW5pc29jIENvbW11bmlj
YXRpb25zLCBJbmMuCiByZWFsdGVrIFJlYWx0ZWsgU2VtaWNvbmR1Y3RvciBDb3JwLgogcmVuZXNh
cwlSZW5lc2FzIEVsZWN0cm9uaWNzIENvcnBvcmF0aW9uCiByaWNodGVrCVJpY2h0ZWsgVGVjaG5v
bG9neSBDb3Jwb3JhdGlvbgotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
