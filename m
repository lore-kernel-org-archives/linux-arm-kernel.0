Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92850C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DCA20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O7yW3Vm+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzylELZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DCA20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=c83wDkiKYD4KUuvkwK6aqHJMmczB0GLJPLO6fUvd/Cc=; b=O7yW3Vm+LYqyzv
	xm9Y2ZfD7+Eui6Oo4CGQPpyXZi9nBGpvQ77FWRSFqgbe9+bSAxabJmme+HbEhZ83pDV0VtUa+an6X
	hCeqmXfqbUn1CpQcT9fUKJlIBHpjvzCvPuNukvrl5rhgsme5U3WXCabsLJ9SCJMVrqf6Sif8u7x15
	HjO8vjd2Jw6IsxwORbyNLRfXzhZZ6mCbPTtZ9I3O/+QCmPShYABvlxk5qP7jw8txwcBA2RDobYkG0
	Ohu47PTOlsPle8KPFN9Ap3cQQ1VrxVEjkgUsdSlbDbXrCnaPtdvIW9FMFApd367izVKa0NYOZK7WS
	gm768P1Ms3Br7JUnp+sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVH81-0007Wn-IG; Fri, 07 Dec 2018 14:29:17 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVH7x-0007Ve-R4
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:29:15 +0000
Received: by mail-lj1-x243.google.com with SMTP id v15-v6so3679699ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sF0pCHT7D1F2NOjqJwt6ksiA4U85wwi9Q90+TSNTC9s=;
 b=rzylELZ+EaX3sCY/9gbV+UlMtq9pMzIL6/l3zhtPrt2X8c1OwvretUdvx2GNdlH5+W
 d42GBNkdkq5YNJwJubIsFFV+YECLTYPCnzd/kPZifg+bjsEhEqd5RSU94pvdNW8sv2V1
 7biz2NHi1OIcG4nTSXMnewds5r3Qe8hwjQAIQjArgyrc/5nNYh7L7WZa26P1Q8DWM2/D
 lMu9rOXAJyvUb7D0HsQ9I8LTknFoLY03AisY9/p36yCBznTbZocvUjJr2ya4MT+Yns5O
 kA2ble84SCREjUWO4ogY9jmsTivpZ2DO/ctX0+THUHfe/PoHte+5aaoZyX0cgOc9PfIK
 QoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sF0pCHT7D1F2NOjqJwt6ksiA4U85wwi9Q90+TSNTC9s=;
 b=qBtmG+PPdxQCMdUEHml8d1ewkI/vpn4QzrFdvIxl18kq4dbZtc6I5JssbDQdwnmpuM
 oTgL14cmn0h7sqdDXmOqFrvutkmIHBNqnWShpf4kq9UqdZ7NjyjHmJTQIFgMtPZ9AT7K
 NqdEY5AjB0naOm+dFlmcQUSN4gReNtE0JRBv5Y3hzfabQZ1chDCI0sTZVWxR0UP0n8Nv
 bc6AF8enyttymGujkMNlpEr5H2XtOZsyqnqKsW8E/RqcFqpfm3IneTqi5gcnu6XBQDf2
 amp39MKGSTOFOKGDEfepwsDTSo7V02aTKqPDJQXMFLMHHWxjDG/a3WjFJM24YAU1w+wD
 q7OQ==
X-Gm-Message-State: AA+aEWYlyznqmZdm3f08g226r17JLvqqyHh4Gec6YuY/VRugaglGAJ7x
 NeapWFTMkDA/t0KBo+IHUCA=
X-Google-Smtp-Source: AFSGD/UB6LFrnIqC0oafrWYff6XsukLwntM2AiDS5RqUneHgtitpZgg3O4yijeEypsTs9NsoSkzsNg==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr1438248ljd.137.1544192941567; 
 Fri, 07 Dec 2018 06:29:01 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
 by smtp.googlemail.com with ESMTPSA id v64sm630504lfa.48.2018.12.07.06.29.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 06:29:00 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: nick@shmanahar.org
Subject: [PATCH v4 0/3] Input: atmel_mxt_ts: Add support for optional
 regulators
Date: Fri,  7 Dec 2018 15:28:54 +0100
Message-Id: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_062913_876252_9E1DC6B9 
X-CRM114-Status: GOOD (  12.67  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBvcHRpb25hbCByZWd1bGF0b3Igc3VwcG9ydCB0byBhdG1l
bF9teHRfdHMuCkZpcnN0IHBhdGNoIGFkZHMgcmVndWxhdG9ycyB0byBkcml2ZXIuClNlY29uZCBw
YXRjaCBlbnN1cmVzIHRoYXQgZGV2aWNlIGlzIHJlYWR5IGZvciBjb21tdW5pY2F0aW9uLgpUaGly
ZCBwYXRjaCB1cGRhdGVzIGRvY3VtZW50YXRpb24uCgpDaGFuZ2VzIGZyb20gdjM6CiAgLSBDaGVj
a3BhdGNoIGZpeGVzCiAgLSBEcm9wIHB1bmN0dWF0aW9uIGZyb20gc3ViamVjdCBvZiBvbmUgb2Yg
cGF0Y2hlcwoKQ2hhbmdlcyBmcm9tIHYyOgogIC0gQWRkIHJldmlld2VkLWJ5IHRvIG9uZSBwYXRj
aAogIC0gTW92ZSBjb2RlIGZvciBlbmFibGluZyByZWd1bGF0b3JzIGludG8gc2VwYXJhdGUgbWV0
aG9kLAogICAgdG8gbWFrZSBjb2RlIG1vcmUgcmVhZGFibGUuCiAgLSBBZGQgd2FpdCBjb2RlLCB0
byBlbnN1cmUgdGhhdCBkZXZpY2UgaXMgcmVhZHkgZm9yIGNvbW11bmljYXRpb24uCgpDaGFuZ2Vz
IGZyb20gdjE6CiAgLSBFbmFibGUgcmVndWxhdG9ycyBvbmx5IGlmIHJlc2V0X2dwaW8gaXMgcHJl
c2VudC4KICAtIFN3aXRjaCBmcm9tIGRldm1fcmVndWxhdG9yX2dldF9vcHRpb25hbCB0byBkZXZt
X3JlZ3VsYXRvcl9nZXQuCgpQYXdlxYIgQ2htaWVsICgzKToKICBJbnB1dDogYXRtZWxfbXh0X3Rz
OiBBZGQgc3VwcG9ydCBmb3IgIG9wdGlvbmFsIHJlZ3VsYXRvcnMKICBJbnB1dDogYXRtZWxfbXh0
X3RzOiBXYWl0IGZvciBkZXZpY2UgYmUgcmVhZHkgZm9yIGNvbW11bmljYXRpb24KICBJbnB1dDog
YXRtZWxfbXh0X3RzOiBEb2N1bWVudCBvcHRpb25hbCB2b2x0YWdlIHJlZ3VsYXRvcnMKCiAuLi4v
YmluZGluZ3MvaW5wdXQvYXRtZWwsbWF4dG91Y2gudHh0ICAgICAgICAgfCAgOCArKwogZHJpdmVy
cy9pbnB1dC90b3VjaHNjcmVlbi9hdG1lbF9teHRfdHMuYyAgICAgIHwgNzYgKysrKysrKysrKysr
KysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQoKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
