Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB10EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:46:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D8B2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r398kbp8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHh3A4fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D8B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PRxthxxTqhRMdTvB208I9AiWY4RzwXVcfGc1qALwyHY=; b=r398kbp8XfpfBp
	PbQmixKSJkoDzveve7gUvmD7CzIleI0/CPIYXbdlz9drp7D+gR3TDLoeT/nJ2Ta4nfts/bTv1OS4x
	8SsoYAulrOpnkjIeLm8ZI4JMoIPYLkyGjUlvNbpf6m/k3x/wLVubyOLxD50pDlsvQzTLPR0lrV2iI
	Hwtbos2/xwAyxKD3FtXEc+WMq4LGYqbuKLfhKYbjuAiZeclZnFrB9bVW5xrKgdEbAYP6VRTr1Yq80
	WJqJ3vcIFCq4NtdXmIAAQqMx/AxaIP0q7RfdDGUxbUdh4CWmTF+R1zAtWdrd1RMqLZVga4hX40wSr
	YlEyyVWSYI103KE+tPJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdGom-0007gy-Al; Sat, 29 Dec 2018 15:46:28 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdGoi-0007em-W1
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 15:46:26 +0000
Received: by mail-lf1-x144.google.com with SMTP id v5so16189790lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 29 Dec 2018 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HJ2D6S+BDoyT03ZFRm8ignD7WKbmeioqnKEpSljjok8=;
 b=FHh3A4frWZa9R5ZnhGNKmr+YDMPmuGTRRHei39/mQ11mNUSL3H0I0EE6w/ZIQAWcii
 Q0wAbv9SwgcHvnYBDORQ9xW7CYdKE6eSm1x0C2k6/EBgPw7OcjUwI2A520e0XK2NZSRg
 uk5Hy+/N8iJOCYa/Fw3br9EBCW8JSiT+0qgcI9HDt0DaOQfG5B+jXgTM+cSsC7/+obi4
 Xx+8vXEyZAQZEEe+yvq5WqhenrY5CdWBR4DgTZQPlB7iTBDcMJQg/a6mN8WXC0TTG1V9
 h3PTcdLSUOzfjr+Li/k5eJr97dxjFk0BH31rcw+Dq/Vh50xrCTu3pGdnB8kx6rwyJxz6
 ZWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HJ2D6S+BDoyT03ZFRm8ignD7WKbmeioqnKEpSljjok8=;
 b=WIEGTuCAQs/O9rJ6eEHlR3Qm440tfH+9jJRQu79HjwXDQLVKVdiB8yKfthkj9k88Yx
 bQxYGN7e8W0pXVCYgqZ2l2a6JKt22NDjPJNAWagpbekPWsdUKCzbJqqc+ag+evpxxLgu
 oPdwbF3nVz4qxQ4k3w/Rx8/8NHFgo7uk+qSNcuQ24RgUsK/eQJtkZsz0yCST5Q6AUCA1
 OCOXCbMvoLuQ2JEoJWL5lpyd04q7imLLvsNpsMh01AB8Sl/gsv+Wa326rAVGPFl9Klw7
 3G+QZfpWj4gJd6wCIoZhixJSvEvYQESsrwuRFgY4ySlfiAX8h334tbTterzXICONrqCz
 u2pw==
X-Gm-Message-State: AA+aEWZpJoEZDs/FG99FREmudqVkf15eIsrwhoEJgGPZb5/Bg6ClPXNX
 RV748+ikSlriaTrwfKJ4Vpc=
X-Google-Smtp-Source: AFSGD/WXaxorWkt/A8rmcraHPQ/UJpJ10nGCFUq8X/6Uvvj4axZdkmEjvuPZ6N8fDU5IkDOfVxOcaA==
X-Received: by 2002:a19:200b:: with SMTP id g11mr15577555lfg.58.1546098372092; 
 Sat, 29 Dec 2018 07:46:12 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:59d9:2ac4:8755:7a21])
 by smtp.googlemail.com with ESMTPSA id
 d19-v6sm9106105ljc.37.2018.12.29.07.46.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 07:46:11 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: andrzej.p@samsung.com
Subject: [PATCH] media: s5p-jpeg: Check for fmt_ver_flag when doing fmt
 enumeration
Date: Sat, 29 Dec 2018 16:46:01 +0100
Message-Id: <20181229154602.25693-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_074625_036973_4AD71AFA 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: linux-samsung-soc@vger.kernel.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
 linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UHJldmlvdXNseSB3aGVuIGRvaW5nIGZvcm1hdCBlbnVtZXJhdGlvbiwgaXQgd2FzIHJldHVybmlu
ZyBhbGwKIGZvcm1hdHMgc3VwcG9ydGVkIGJ5IGRyaXZlciwgZXZlbiBpZiB0aGV5J3JlIG5vdCBz
dXBwb3J0ZWQgYnkgaHcuCkFkZCBtaXNzaW5nIGNoZWNrIGZvciBmbXRfdmVyX2ZsYWcsIHNvIGl0
J2xsIGJlIGZpeGVkIGFuZCBvbmx5IHRob3NlCiBzdXBwb3J0ZWQgYnkgaHcgd2lsbCBiZSByZXR1
cm5lZC4gU2ltaWxhciB0aGluZyBpcyBhbHJlYWR5IGRvbmUKIGluIHM1cF9qcGVnX2ZpbmRfZm9y
bWF0LgoKSXQgd2FzIGZvdW5kIGJ5IHVzaW5nIHY0bDItY29tcGxpYW5jZSB0b29sIGFuZCBjaGVj
a2luZyByZXN1bHQKIG9mIFZJRElPQ19FTlVNX0ZNVC9GUkFNRVNJWkVTL0ZSQU1FSU5URVJWQUxT
IHRlc3QKYW5kIHVzaW5nIHY0bDItY3RsIHRvIGdldCBsaXN0IG9mIGFsbCBzdXBwb3J0ZWQgZm9y
bWF0cy4KClRlc3RlZCBvbiBzNXB2MjEwLWdhbGF4eXMgKFNhbXN1bmcgaTkwMDAgcGhvbmUpLgoK
Rml4ZXM6IGJiNjc3ZjNhYzQzNCAoIlttZWRpYV0gRXh5bm9zNCBKUEVHIGNvZGVjIHY0bDIgZHJp
dmVyIikKU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxA
Z21haWwuY29tPgotLS0KIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vczVwLWpwZWcvanBlZy1jb3Jl
LmMgfCAxNSArKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zNXAt
anBlZy9qcGVnLWNvcmUuYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vczVwLWpwZWcvanBlZy1j
b3JlLmMKaW5kZXggM2Y5MDAwYjcwMzg1Li4yMzJiNzVjZjIwOWYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vczVwLWpwZWcvanBlZy1jb3JlLmMKKysrIGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9zNXAtanBlZy9qcGVnLWNvcmUuYwpAQCAtMTI5MywxMyArMTI5MywxNiBAQCBz
dGF0aWMgaW50IHM1cF9qcGVnX3F1ZXJ5Y2FwKHN0cnVjdCBmaWxlICpmaWxlLCB2b2lkICpwcml2
LAogCXJldHVybiAwOwogfQogCi1zdGF0aWMgaW50IGVudW1fZm10KHN0cnVjdCBzNXBfanBlZ19m
bXQgKnNqcGVnX2Zvcm1hdHMsIGludCBuLAorc3RhdGljIGludCBlbnVtX2ZtdChzdHJ1Y3QgczVw
X2pwZWdfY3R4ICpjdHgsCisJCSAgICBzdHJ1Y3QgczVwX2pwZWdfZm10ICpzanBlZ19mb3JtYXRz
LCBpbnQgbiwKIAkJICAgIHN0cnVjdCB2NGwyX2ZtdGRlc2MgKmYsIHUzMiB0eXBlKQogewogCWlu
dCBpLCBudW0gPSAwOworCXVuc2lnbmVkIGludCBmbXRfdmVyX2ZsYWcgPSBjdHgtPmpwZWctPnZh
cmlhbnQtPmZtdF92ZXJfZmxhZzsKIAogCWZvciAoaSA9IDA7IGkgPCBuOyArK2kpIHsKLQkJaWYg
KHNqcGVnX2Zvcm1hdHNbaV0uZmxhZ3MgJiB0eXBlKSB7CisJCWlmIChzanBlZ19mb3JtYXRzW2ld
LmZsYWdzICYgdHlwZSAmJgorCQkJc2pwZWdfZm9ybWF0c1tpXS5mbGFncyAmIGZtdF92ZXJfZmxh
ZykgewogCQkJLyogaW5kZXgtdGggZm9ybWF0IG9mIHR5cGUgdHlwZSBmb3VuZCA/ICovCiAJCQlp
ZiAobnVtID09IGYtPmluZGV4KQogCQkJCWJyZWFrOwpAQCAtMTMyNiwxMCArMTMyOSwxMCBAQCBz
dGF0aWMgaW50IHM1cF9qcGVnX2VudW1fZm10X3ZpZF9jYXAoc3RydWN0IGZpbGUgKmZpbGUsIHZv
aWQgKnByaXYsCiAJc3RydWN0IHM1cF9qcGVnX2N0eCAqY3R4ID0gZmhfdG9fY3R4KHByaXYpOwog
CiAJaWYgKGN0eC0+bW9kZSA9PSBTNVBfSlBFR19FTkNPREUpCi0JCXJldHVybiBlbnVtX2ZtdChz
anBlZ19mb3JtYXRzLCBTSlBFR19OVU1fRk9STUFUUywgZiwKKwkJcmV0dXJuIGVudW1fZm10KGN0
eCwgc2pwZWdfZm9ybWF0cywgU0pQRUdfTlVNX0ZPUk1BVFMsIGYsCiAJCQkJU0pQRUdfRk1UX0ZM
QUdfRU5DX0NBUFRVUkUpOwogCi0JcmV0dXJuIGVudW1fZm10KHNqcGVnX2Zvcm1hdHMsIFNKUEVH
X05VTV9GT1JNQVRTLCBmLAorCXJldHVybiBlbnVtX2ZtdChjdHgsIHNqcGVnX2Zvcm1hdHMsIFNK
UEVHX05VTV9GT1JNQVRTLCBmLAogCQkJCQlTSlBFR19GTVRfRkxBR19ERUNfQ0FQVFVSRSk7CiB9
CiAKQEAgLTEzMzksMTAgKzEzNDIsMTAgQEAgc3RhdGljIGludCBzNXBfanBlZ19lbnVtX2ZtdF92
aWRfb3V0KHN0cnVjdCBmaWxlICpmaWxlLCB2b2lkICpwcml2LAogCXN0cnVjdCBzNXBfanBlZ19j
dHggKmN0eCA9IGZoX3RvX2N0eChwcml2KTsKIAogCWlmIChjdHgtPm1vZGUgPT0gUzVQX0pQRUdf
RU5DT0RFKQotCQlyZXR1cm4gZW51bV9mbXQoc2pwZWdfZm9ybWF0cywgU0pQRUdfTlVNX0ZPUk1B
VFMsIGYsCisJCXJldHVybiBlbnVtX2ZtdChjdHgsIHNqcGVnX2Zvcm1hdHMsIFNKUEVHX05VTV9G
T1JNQVRTLCBmLAogCQkJCVNKUEVHX0ZNVF9GTEFHX0VOQ19PVVRQVVQpOwogCi0JcmV0dXJuIGVu
dW1fZm10KHNqcGVnX2Zvcm1hdHMsIFNKUEVHX05VTV9GT1JNQVRTLCBmLAorCXJldHVybiBlbnVt
X2ZtdChjdHgsIHNqcGVnX2Zvcm1hdHMsIFNKUEVHX05VTV9GT1JNQVRTLCBmLAogCQkJCQlTSlBF
R19GTVRfRkxBR19ERUNfT1VUUFVUKTsKIH0KIAotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
