Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F36C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:41:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0D820838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NoEDI13o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnRExS/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0D820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vk/0v38ub7BW/laUWrkGZfffltDq94dC7NSuXPeQE78=; b=NoEDI13oqzY0Vu
	bYTY3KXLdVkYFQR229M3Zu9/mvVgmt0IjKp2z2ZP6uAVQsO/Q43Xfrec/kOkzCkMbATtCMbh8yWMw
	CmHU47lLOo3LFDu03ezIcEZhoRqIF+8o831J19+rh6t0VVm+7PdTKplksOtmmFRadWJ7mOAQhqUwD
	5n8Geyrvf/QyvpgTi9UovpYH7s4FHaKNMrmfCt4SE7v9Bz5J1m0daVPPivEI2eeR2PlW646Mz+uah
	Tu08u8m8tSG86w8OMQGlqc9k0Wco6kBYqGKbhlFtvtkma7/lRbmKBEBH1bInYb/TxVB0Idgq5BLOu
	Oh5X9v6qCVQy213AZnTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHJQ-0005mX-2O; Fri, 07 Dec 2018 14:41:04 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVH81-0007Vm-T5
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:29:21 +0000
Received: by mail-lf1-x143.google.com with SMTP id b20so3135866lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XFPTtMJpSFiF4PFAqSj6g1FCx0iqQrUaJq/0mQ1Us/I=;
 b=rnRExS/ioqXRd7pl9X9/WxnSDOkSz5BlvCsll1C0iOnrGjkL+YxDK5AG/ixFIJwLnj
 uBHkR/0kUmi2Vs3Gm3RSwug2RKF3WqLC0Z7P+4IJk4FsG4C+wD+M22uk3m9+G6fBWPjN
 y0v/Pmc+6RX9W7VLoifWD1QgiUtol9TfYdYDwd2d8gfrGngaWdq+6KEzhDbvEKCrkJZs
 jsOty8TBA9RGkBI0wEGUMB/zie8GdzJQWbpWSUP3UWXtVA2IEO0CrfGjKrmYxQokmk1E
 6xsSukU69ObfUN02s9DCMgGqfi9FKRY7YtAp8JUvw9TWjb+aNzazjNFGGQOIwlWxG7MV
 IoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XFPTtMJpSFiF4PFAqSj6g1FCx0iqQrUaJq/0mQ1Us/I=;
 b=KJEUDM/JZF2CxMPwrEuGxPO1V858DjGtBwF1SRgin23cEU2NVZnBb6jS18xjx81QoX
 P9XVyX80b19KGz66eT+cX0AhmHLNMTwd5lzlZKNZ7uXaBD9oxS6J2ib/dPALoreEhoGr
 TBoBfmDy9BYyImExPxxane+qyJJWuAvwYDg3EWZf28CBJiJyH+7aWJUdOCtn/DrNvB+Q
 HdUjb7hKHj4nm65AuK9znfn6ntXdcOzNyB0VoHd/dyJwNmxFHKbkeP5FRpUMqUeeunkC
 RsgDI/jb2fb7WnaSNRAUSfaSkWjrBWQSHMGYBMmZLnoqxJiLo3fsBowxPV8PvgIh8FiH
 Dtqw==
X-Gm-Message-State: AA+aEWbpDslISk7cwZiVUNtD/OnXUyIDwGt+8VkLLLQRJyvUEyf/lGsr
 79GuuSZUT+6gEUsNJAWXRoE=
X-Google-Smtp-Source: AFSGD/UJGLWQZxgX4zc/qOv5w0brAukTjLL/vMZ7TccXHJhOgYWzodEmqX/Piod2kwFhkAi+/CaztQ==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr1430771lfd.74.1544192945963; 
 Fri, 07 Dec 2018 06:29:05 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
 by smtp.googlemail.com with ESMTPSA id v64sm630504lfa.48.2018.12.07.06.29.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 06:29:05 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: nick@shmanahar.org
Subject: [PATCH v4 3/3] Input: atmel_mxt_ts: Document optional voltage
 regulators
Date: Fri,  7 Dec 2018 15:28:57 +0100
Message-Id: <20181207142857.15818-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_062918_196429_65E8CAF1 
X-CRM114-Status: GOOD (  12.27  )
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

RG9jdW1lbnQgbmV3IG9wdGlvbmFsIHZvbHRhZ2UgcmVndWxhdG9ycywgd2hpY2ggY2FuIGJlIHVz
ZWQKdG8gcG93ZXIgZG93bi91cCB0b3VjaHNjcmVlbi4KClNpZ25lZC1vZmYtYnk6IFBhd2XFgiBD
aG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIGZyb20gdjE6CiAgLSBBZGRlZCBy
ZXZpZXdlZC1ieQotLS0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2F0bWVsLG1heHRv
dWNoLnR4dCAgICAgICAgICB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5w
dXQvYXRtZWwsbWF4dG91Y2gudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lucHV0L2F0bWVsLG1heHRvdWNoLnR4dAppbmRleCBjODg5MTk0ODBkMzcuLjE3OTMwZWNhZGFk
MyAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2F0
bWVsLG1heHRvdWNoLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aW5wdXQvYXRtZWwsbWF4dG91Y2gudHh0CkBAIC0zMSw2ICszMSwxMiBAQCBPcHRpb25hbCBwcm9w
ZXJ0aWVzIGZvciBtYWluIHRvdWNocGFkIGRldmljZToKIAogLSByZXNldC1ncGlvczogR1BJTyBz
cGVjaWZpZXIgZm9yIHRoZSB0b3VjaHNjcmVlbidzIHJlc2V0IHBpbiAoYWN0aXZlIGxvdykKIAor
LSBhdmRkLXN1cHBseTogQW5hbG9nIHBvd2VyIHN1cHBseS4gSXQgcG93ZXJzIHVwIHRoZSBhbmFs
b2cgY2hhbm5lbCBibG9jaworICAgIG9mIHRoZSBjb250cm9sbGVyIHRvIGRldGVjdCB0aGUgdG91
Y2hlcy4KKworLSB2ZGQtc3VwcGx5OiBEaWdpdGFsIHBvd2VyIHN1cHBseS4gSXQgcG93ZXJzIHVw
IHRoZSBkaWdpdGFsIGJsb2NrCisgICAgb2YgdGhlIGNvbnRyb2xsZXIgdG8gZW5hYmxlIGkyYyBj
b21tdW5pY2F0aW9uLgorCiBFeGFtcGxlOgogCiAJdG91Y2hANGIgewpAQCAtMzgsNCArNDQsNiBA
QCBFeGFtcGxlOgogCQlyZWcgPSA8MHg0Yj47CiAJCWludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8+
OwogCQlpbnRlcnJ1cHRzID0gPFRFR1JBX0dQSU8oVywgMykgSVJRX1RZUEVfTEVWRUxfTE9XPjsK
KwkJYXZkZC1zdXBwbHkgPSA8JmF0c3BfcmVnPjsKKwkJdmRkLXN1cHBseSA9IDwmdHNwX3JlZz47
CiAJfTsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
