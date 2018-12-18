Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6588FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:58:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A4121871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qfQghI4x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3qM7PBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A4121871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KjSfO/XJs23VOazFt13FxxTeFfy2qJRomBe/pAk3wUw=; b=qfQghI4xv2gaNQ
	tFP6kD8SF35Izgun3biL5nTt1xXop9c5EvwqpeAtHToSNrp987mbykZrG+Z66olKyu4pMBLSN2u1w
	K498goyEbyXmBhRexn5NxQ9KSQsUcAtx4dgK/AVuXN/4Ss7NHh3b7CKVGrZ3dc5RZzq/zakQd8ADT
	lkFu0/DIcYb0q8bWHNKMjol9IVENjEzpilcZnYZkIorT/JIUfx1q6/JfeTxasVXXDh4Z4RYQbRft5
	RHq8Qj1BLdIdBBJOwnqXGKM22HePzV0D21VGDzg+x0uIoT8W4/k8sbP40l4M5ddkzplt5DJneIbFw
	qJB1A/ea3rQ+1IFk5aLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHlE-0003ks-QM; Tue, 18 Dec 2018 15:58:20 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHlA-0003jr-8m
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:58:18 +0000
Received: by mail-lf1-x142.google.com with SMTP id n18so12654334lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jf8b8vtTUhJJ5Ks//e7xldWM93d3ka8ldx+UbNKLFZs=;
 b=c3qM7PBdboDMxG33PXBfsFZNQcwjQgOHMJR+HFCRZ6U5UALSvkdn4V+IlGyNb6Mtey
 6l0Z6UvgCUEKnp4Pz0szT2f4WV9qAYhOUWA51HNpC1KMR/uPn0kKSW6nk1vZxro8ky8s
 OWsiG2WJr5aC3G/DjCB1RdhTmWPx+3twMfw1L1Q7wEEmanA5aE78Uafl0anjWoZQD7sy
 3TKBixJOMVyiQ8jekLy4hoqOpalxoFxDtGc1TdRJzzLEFcowZAFJWFUdCiLKBrW+W7Xx
 b6o1ojD28Ig5yYDazrTRHmNje6CjFtBKbrSH7qfPKrhPxBhDCGhA+dsVCkLAhepusV6G
 iKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jf8b8vtTUhJJ5Ks//e7xldWM93d3ka8ldx+UbNKLFZs=;
 b=J1G1/CMpG14TiTiBrmwP3PxSrBc3a2aYmObKYznXCYkPBuu2CVcTp66nnNsNZj30tf
 TzCtf3p/IARgVknt8Szv52Y3rzsTNNHOkizk/W96Yh7tR1SHb5QcHPAxRz+67FrHstj8
 Pnlw0Ffdgf1Bjt+NoDC3RdNVNQ4jIeoEelpYGEATMOeuUuO2/4eUTtWOnKcE+b28mEzc
 ZQ6r+I/PkCrFIs5QcMPjrAICgfy8GwvuiFY1p5ZNjz4xt8+Hg0fRIvEICOt3Urkfkzo5
 Q8t8yZMC/P0hFr+jQHbTIjqewZlahYAb6RzlRNRXAIQhCtuPfwM41r0rQg1b7ptOaDLK
 Xyvg==
X-Gm-Message-State: AA+aEWY2JXHGIL5b1nRgUu3HpW543YVNZoMeFnhnCO+aJepyfVQ30ONu
 JSJozhOBW8SjZR5LNiZR47c=
X-Google-Smtp-Source: AFSGD/VVeB7z9vq414UvtXJV4JLPFy7J6RYjn7tma8OebLcZ37jJgWJM5XQc3saJtXScwztxRri6zg==
X-Received: by 2002:a19:ae03:: with SMTP id f3mr10876716lfc.86.1545148683647; 
 Tue, 18 Dec 2018 07:58:03 -0800 (PST)
Received: from linux-veee.lan (ip-194-187-74-233.konfederacka.maverick.com.pl.
 [194.187.74.233])
 by smtp.gmail.com with ESMTPSA id r7-v6sm3085277ljc.10.2018.12.18.07.58.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 07:58:03 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH fixes 4.20] dt-bindings: pinctrl: bcm4708-pinmux: rework
 binding to use syscon
Date: Tue, 18 Dec 2018 16:57:44 +0100
Message-Id: <20181218155744.19409-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.7
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_075816_335435_E3EF9EE1 
X-CRM114-Status: GOOD (  16.16  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogUmFmYcWCIE1pxYJlY2tpIDxyYWZhbEBtaWxlY2tpLnBsPgoKQXMgcG9pbnRlZCBieSBS
b2IsIENSVSBpcyBhIGtpbmQgb2YgYmxvY2sgdGhhdCBjYW4ndCBiZSBndWFyYW50ZWVkIHRvCmhh
dmUgZXZlcnl0aGluZyBleHBvc2VkIGFzIHN1Ym5vZGVzLiBJdCdzIGEgc2V0IG9mIHZhcmlvdXMg
cmVnaXN0ZXJzCnRoYXQgYXJlbid0IHRpZWQgdG8gYW55IHNpbmdsZSBkZXZpY2UuIEl0IGNvdWxk
IGJlIGRlc2NyaWJlZCBtdWNoIG1vcmUKYWNjdXJhdGVseSBhcyBNRkQgKE11bHRpLUZ1bmN0aW9u
IERldmljZSkuCgpTb21lIGhhcmR3YXJlIGJsb2NrcyBtYXkgaW5kZWVkIHdhbnQgdG8gYWNjZXNz
IGEgcmVnaXN0ZXIgb3IgdHdvIG9mIHRoZQpDUlUgd2hpY2ggcmVxdWlyZXMgZGVzY3JpYmluZyBp
dCBhcyB0aGUgInN5c2NvbiIuCgpXaGlsZSBhdCBpdCByZXBsYWNlIGV4bXBsZSBub2RlIG5hbWUg
d2l0aCB0aGUgc3RhbmRhcmQgInBpbmN0cmwiIChhbHNvCnBvaW50ZWQgb3V0IGJ5IFJvYikuCgpT
aWduZWQtb2ZmLWJ5OiBSYWZhxYIgTWnFgmVja2kgPHJhZmFsQG1pbGVja2kucGw+Ci0tLQpIaSBM
aW51cywKCkFmdGVyIGJlaW5nIHBpbmdlZCBhYm91dCB0aGUgcGluY3RybCBkcml2ZXIgSSByZWFs
aXplZCBJIG5ldmVyIGFkZHJlc3NlZApSb2IncyBjb21tZW50cyBmcm9tIHRoZSBlLW1haWwgdGhy
ZWFkOgoKW1BBVENIXSBkdC1iaW5kaW5nczogcGluY3RybDogYmNtNDcwOC1waW5tdXg6IGltcHJv
dmUgZXhhbXBsZSBiaW5kaW5nCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2FybS1rZXJu
ZWwvbXNnNjgyODM4Lmh0bWwKaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC85ODQw
MjQvCgpSb2IgaGFzIHBvaW50ZWQgY29ycmVjdGx5IChhcyBhbHdheXMpIHRoYXQgZGVzY3JpYmlu
ZyBDUlUgdXNpbmcKInNpbXBsZS1idXMiIGhhcyBpdHMgaW1wbGljYXRpb25zIGFuZCBtYXkgaHVu
dCB1cyBiYWNrIGlmIHdlIGV2ZXIKcmVhbGl6ZSB3ZSB3aWxsIHdhbnQgdG8gcmVmZXJlbmNlIGl0
IGFzICJzeXNjb24iLiBUaGF0IGlzIHByZXR0eSBsaWtlbHkKYWN0dWFsbHkuCgpUbyBmaXggdGhh
dCB3aGlsZSBzdGlsbCBwb3NzaWJsZSAoYmVmb3JlIGhhdmluZyB0aGF0IERvY3VtZW50YXRpb24g
aW4KYW55IHN0YWJsZSByZWxlYXNlKSBJJ2QgbGlrZSB5b3UgdG8gY29uc2lkZXIgdGFraW5nIHRo
aXMgcGF0Y2ggZm9yIHRoZQo0LjIwIHJlbGVhc2UgaWYgeW91IGZpbmQgaXQgcG9zc2libGUuCgpJ
J20gd2VsbCBhd2FyZSBpdCdzIGRhbW4gbGF0ZS4gSSdtIGF3YXJlIEkndmUgc2NyZXdlZCB1cC4g
SSdtIHNvcnJ5LgoKSSdtIGFmcmFpZCBJIGNhbm5vdCBmaXggaXQgYW55aG93LiBKdXN0IHRha2Ug
YSBsb29rIGF0IHRoYXQgcGF0Y2ggYW5kCmZlZWwgZnJlZSB0byBzYXkgSSdtIGNyYXp5IGNvbWlu
ZyB3aXRoIGl0IHNvIGxhdGUuCi0tLQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9i
cmNtLGJjbTQ3MDgtcGlubXV4LnR4dCAgfCAxNiArKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL2JyY20sYmNtNDcwOC1waW5tdXgu
dHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvYnJjbSxiY200
NzA4LXBpbm11eC50eHQKaW5kZXggNGZhOTUzOTA3MGNiLi44YWIyZDQ2OGRiZGIgMTAwNjQ0Ci0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL2JyY20sYmNtNDcw
OC1waW5tdXgudHh0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5j
dHJsL2JyY20sYmNtNDcwOC1waW5tdXgudHh0CkBAIC03LDEzICs3LDE1IEBAIGNvbmZpZ3VyZSBj
b250cm9sbGVyIGNvcnJlY3RseS4KIAogQSBsaXN0IG9mIHBpbnMgdmFyaWVzIGFjcm9zcyBjaGlw
c2V0cyBzbyBmZXcgYmluZGluZ3MgYXJlIGF2YWlsYWJsZS4KIAorTm9kZSBvZiB0aGUgcGlubXV4
IG11c3QgYmUgbmVzdGVkIGluIHRoZSBDUlUgKENlbnRyYWwgUmVzb3VyY2UgVW5pdCkgInN5c2Nv
biIKK25vY2UuCisKIFJlcXVpcmVkIHByb3BlcnRpZXM6CiAtIGNvbXBhdGlibGU6IG11c3QgYmUg
b25lIG9mOgogCSJicmNtLGJjbTQ3MDgtcGlubXV4IgogCSJicmNtLGJjbTQ3MDktcGlubXV4Igog
CSJicmNtLGJjbTUzMDEyLXBpbm11eCIKLS0gcmVnOiBpb21lbSBhZGRyZXNzIHJhbmdlIG9mIENS
VSAoQ2VudHJhbCBSZXNvdXJjZSBVbml0KSBwaW4gcmVnaXN0ZXJzCi0tIHJlZy1uYW1lczogImNy
dV9ncGlvX2NvbnRyb2wiIC0gdGhlIG9ubHkgbmVlZGVkICYgc3VwcG9ydGVkIHJlZyByaWdodCBu
b3cKKy0gb2Zmc2V0OiBvZmZzZXQgb2YgcGluIHJlZ2lzdGVycyBpbiB0aGUgQ1JVIGJsb2NrCiAK
IEZ1bmN0aW9ucyBhbmQgdGhlaXIgZ3JvdXBzIGF2YWlsYWJsZSBmb3IgYWxsIGNoaXBzZXRzOgog
LSAic3BpIjogInNwaV9ncnAiCkBAIC0zNywxNiArMzksMTIgQEAgRXhhbXBsZToKIAkJI3NpemUt
Y2VsbHMgPSA8MT47CiAKIAkJY3J1QDEwMCB7Ci0JCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMi
OworCQkJY29tcGF0aWJsZSA9ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7CiAJCQlyZWcgPSA8MHgx
MDAgMHgxYTQ+OwotCQkJcmFuZ2VzOwotCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47Ci0JCQkjc2l6
ZS1jZWxscyA9IDwxPjsKIAotCQkJcGluLWNvbnRyb2xsZXJAMWMwIHsKKwkJCXBpbmN0cmwgewog
CQkJCWNvbXBhdGlibGUgPSAiYnJjbSxiY200NzA4LXBpbm11eCI7Ci0JCQkJcmVnID0gPDB4MWMw
IDB4MjQ+OwotCQkJCXJlZy1uYW1lcyA9ICJjcnVfZ3Bpb19jb250cm9sIjsKKwkJCQlvZmZzZXQg
PSA8MHhjMD47CiAKIAkJCQlzcGktcGlucyB7CiAJCQkJCWZ1bmN0aW9uID0gInNwaSI7Ci0tIAoy
LjEzLjcKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
