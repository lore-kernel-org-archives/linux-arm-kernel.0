Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CA4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3CB20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P6ka2bAX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Roh39Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3CB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IKPzXE7bq6YjB6cc6dhuWfvjyzGhA5aYeNdGWkptiZ4=; b=P6ka2bAXRMiF5M
	8BRZWM8HKs9g+X6zBgWec2bmnY61RiL6NGBx5Nlt+MHQ7zXhGXtmYHAV5mx8odw8+NzNvRse6K4mO
	bU8Gu23MOFhvJGxS7/0VSbiTXJ65Ubr6h5FmFDmk0+zRspw1h+G/QMED9hRprsxiSRvga+6P57Gmg
	lxWHZ7R/Kco5aw7Ev76XuIY4NA0cM2lyGPVKB/BUy4aQ7ajSeHbiS34Cf+fg6q2im2bWkJJyr9i7q
	DtYPC9XzmCM5qETYmUeuX76VjZ4/bLx6LOX5Dx71Xu0MoK/UsGt4FKuBdi8vDKlAVpWZJrh1o2E/1
	+z21HA2b7sYmjUppOs7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giltU-0006Gp-0U; Sun, 13 Jan 2019 19:58:04 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giltQ-0006GR-UQ
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 19:58:02 +0000
Received: by mail-lf1-x142.google.com with SMTP id c16so14165095lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 13 Jan 2019 11:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bFXW5esP1qyBjm7dno9fSDhMNRBkGYcMnaFJwnRT22g=;
 b=i/Roh39YbMiqa1az+3XQH5GBrXp8Vqh+6ewCUAWo+UHSjvXIi2yUlFXdY9YNBgWYhW
 eiO6mYgkvpswKpd9Gs1Jai4VLsX51zNLqRmvjIADXxyvL8I6zOthzjau2g8iX86J7bl2
 0jsQeWHc4dnHpBq6xVcr3UI0MVLLhgblbUH9MnMOoG3fc5QhViIEQUKvJER/HWZMSu+Y
 LEfzd6/F4V6SUxAzQ05bZxIjsS0LCazZRBEY20WnqBPOKToEc627sIhugXLm2J3BjmWl
 8PnAwa821urEs0K/XNVGtQCb5H2L2QjyewheFgHgDQWdyBX7JQ2UgqZ1/IqGDf9DY1Ay
 FHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bFXW5esP1qyBjm7dno9fSDhMNRBkGYcMnaFJwnRT22g=;
 b=fyQt4+0Du/5jbCcggDCoCaiBJtMJfzON5rOjBcUkPYDdZawdFyzi92wqju/dMW2XiI
 Ohz48kaEzSePcG6+Ba9dZv82fEj8WieJyMb0bL8t9/I78OrlTjM1x7vF9nIgopY2mTSF
 AAAXh1pjYVKXg8vQUhQjXF8CzvrMTNAv8eTzcS3skx1ujlcGh35Ek8Jn+cAfiaIpcROo
 wOsY1wHaSuZO7bYygCPrGfsPBVp3yMIgOeYC/0QdZEGcoFChsEIPD7C5c/PvAQBOO89e
 cjnumaqFUJ5ypLZtp0K+2ijR5EuOrKpujXrsbmnWtGIonfJiYbc13Nb2p+FlxnVCSQEL
 f/Vw==
X-Gm-Message-State: AJcUukdn8QqZa2pcsB5EpX7d1KSmwbLysjIXdoLpEDRp26jTfuwSxMVG
 jqqZkPSEwCYY7OS0KVb8Xk8=
X-Google-Smtp-Source: ALg8bN5U+PN5/aIg1CEXUH+saRACDLlkJv34dKzI8/1IPsGyTPGNSXjpdKtSpHna2biSnNDjNe/sJw==
X-Received: by 2002:a19:7d42:: with SMTP id y63mr11329886lfc.47.1547409478957; 
 Sun, 13 Jan 2019 11:57:58 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:607a:1b80:a32f:5413])
 by smtp.googlemail.com with ESMTPSA id q67sm15988569lfe.19.2019.01.13.11.57.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Jan 2019 11:57:58 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH v4] cpufreq: s5pv210: Defer probe if getting regulators fail
Date: Sun, 13 Jan 2019 20:57:54 +0100
Message-Id: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_115800_983559_9AEF0489 
X-CRM114-Status: GOOD (  16.82  )
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
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlcmUgaXMgcG9zc2liaWxpdHksIHRoYXQgd2hlbiBwcm9iaW5nIGRyaXZlciwgcmVndWxhdG9y
cyBhcmUgbm90IHlldAppbml0aWFsaXplZC4gSW4gdGhpcyBjYXNlIHdlIHNob3VsZCByZXR1cm4g
RVBST0JFX0RFRkVSIGFuZCB3YWl0IHRpbGwKdGhleSdyZSBpbml0aWFsaXplZCwgc2luY2UgdGhl
eSdyZSByZXF1aXJlZCBjdXJyZW50bHkgZm9yIGNwdWZyZXEgZHJpdmVyCnRvIHdvcmsuIEFsc28g
bW92ZSByZWd1bGF0b3IgaW5pdGlhbGl6YXRpb24gY29kZSBhdCBiZWdpbm5pbmcgb2YgcHJvYmUs
CnNvIHdlIGNhbiBkZWZlciBhcyBmYXN0IGFzIHBvc2liYmxlLgoKU2lnbmVkLW9mZi1ieTogUGF3
ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KQ2hhbmdlcyBm
cm9tIHYzOgogIC0gWmVybyBkbWNfYmFzZSBwb2ludGVycyBhZnRlciB1bm1hcHBpbmcgdGhlbQog
IC0gSWYgZ2V0dGluZyB2ZGRhcm0gcmVndWxhdG9yIGZhaWxzIGp1c3QgcmV0dXJuLCBubyBuZWVk
IHRvIGRvIGdvdG8KICAgIGp1bXAgd2hpY2ggd291bGQgZG8gdGhlIHNhbWUKCkNoYW5nZXMgZnJv
bSB2MjoKICAtIEhhbmRsZSBhbGwgZXJyb3IgcGF0aHMgaW4gcHJvYmUKCkNoYW5nZXMgZnJvbSB2
MToKICAtIEZpeCBjb21waWxhdGlvbiBlcnJvcgogIC0gUmVvcmdhbml6ZSBjb2RlIHNvIGl0J3Mg
c21hbGxlcgotLS0KIGRyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYyB8IDY3ICsrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25z
KCspLCAxOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvczVwdjIx
MC1jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVmcmVxLmMKaW5kZXggZjUx
Njk3ZjFlMGIzLi5jN2I3ZDFlNjViMDggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9zNXB2
MjEwLWNwdWZyZXEuYworKysgYi9kcml2ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVmcmVxLmMKQEAg
LTU4NCw3ICs1ODQsNyBAQCBzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIHM1cHYyMTBfY3B1
ZnJlcV9yZWJvb3Rfbm90aWZpZXIgPSB7CiBzdGF0aWMgaW50IHM1cHYyMTBfY3B1ZnJlcV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewogCXN0cnVjdCBkZXZpY2Vfbm9kZSAq
bnA7Ci0JaW50IGlkOworCWludCBpZCwgcmVzdWx0ID0gMDsKIAogCS8qCiAJICogSEFDSzogVGhp
cyBpcyBhIHRlbXBvcmFyeSB3b3JrYXJvdW5kIHRvIGdldCBhY2Nlc3MgdG8gY2xvY2sKQEAgLTU5
NCwxOCArNTk0LDM5IEBAIHN0YXRpYyBpbnQgczVwdjIxMF9jcHVmcmVxX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJICogdGhpcyB3aG9sZSBkcml2ZXIgYXMgc29vbiBhcyBT
NVBWMjEwIGdldHMgbWlncmF0ZWQgdG8gdXNlCiAJICogY3B1ZnJlcS1kdCBkcml2ZXIuCiAJICov
CisJYXJtX3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwgInZkZGFybSIpOworCWlmIChJ
U19FUlIoYXJtX3JlZ3VsYXRvcikpIHsKKwkJaWYgKFBUUl9FUlIoYXJtX3JlZ3VsYXRvcikgPT0g
LUVQUk9CRV9ERUZFUikKKwkJCXByX2RlYnVnKCJ2ZGRhcm0gcmVndWxhdG9yIG5vdCByZWFkeSwg
ZGVmZXJcbiIpOworCQllbHNlCisJCQlwcl9lcnIoImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZk
ZGFybVxuIik7CisJCXJldHVybiBQVFJfRVJSKGFybV9yZWd1bGF0b3IpOworCX0KKworCWludF9y
ZWd1bGF0b3IgPSByZWd1bGF0b3JfZ2V0KE5VTEwsICJ2ZGRpbnQiKTsKKwlpZiAoSVNfRVJSKGlu
dF9yZWd1bGF0b3IpKSB7CisJCWlmIChQVFJfRVJSKGludF9yZWd1bGF0b3IpID09IC1FUFJPQkVf
REVGRVIpCisJCQlwcl9kZWJ1ZygidmRkaW50IHJlZ3VsYXRvciBub3QgcmVhZHksIGRlZmVyXG4i
KTsKKwkJZWxzZQorCQkJcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IHJlZ3VsYXRvciB2ZGRpbnRcbiIp
OworCQlyZXN1bHQgPSBQVFJfRVJSKGludF9yZWd1bGF0b3IpOworCQlnb3RvIGVycl9pbnRfcmVn
dWxhdG9yOworCX0KKwogCW5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwg
InNhbXN1bmcsczVwdjIxMC1jbG9jayIpOwogCWlmICghbnApIHsKIAkJcHJfZXJyKCIlczogZmFp
bGVkIHRvIGZpbmQgY2xvY2sgY29udHJvbGxlciBEVCBub2RlXG4iLAogCQkJX19mdW5jX18pOwot
CQlyZXR1cm4gLUVOT0RFVjsKKwkJcmVzdWx0ID0gLUVOT0RFVjsKKwkJZ290byBlcnJfY2xvY2s7
CiAJfQogCiAJY2xrX2Jhc2UgPSBvZl9pb21hcChucCwgMCk7CiAJb2Zfbm9kZV9wdXQobnApOwog
CWlmICghY2xrX2Jhc2UpIHsKIAkJcHJfZXJyKCIlczogZmFpbGVkIHRvIG1hcCBjbG9jayByZWdp
c3RlcnNcbiIsIF9fZnVuY19fKTsKLQkJcmV0dXJuIC1FRkFVTFQ7CisJCXJlc3VsdCA9IC1FRkFV
TFQ7CisJCWdvdG8gZXJyX2Nsb2NrOwogCX0KIAogCWZvcl9lYWNoX2NvbXBhdGlibGVfbm9kZShu
cCwgTlVMTCwgInNhbXN1bmcsczVwdjIxMC1kbWMiKSB7CkBAIC02MTQsNyArNjM1LDggQEAgc3Rh
dGljIGludCBzNXB2MjEwX2NwdWZyZXFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKIAkJCXByX2VycigiJXM6IGZhaWxlZCB0byBnZXQgYWxpYXMgb2YgZG1jIG5vZGUgJyVwT0Zu
J1xuIiwKIAkJCQlfX2Z1bmNfXywgbnApOwogCQkJb2Zfbm9kZV9wdXQobnApOwotCQkJcmV0dXJu
IGlkOworCQkJcmVzdWx0ID0gaWQ7CisJCQlnb3RvIGVycl9jbGtfYmFzZTsKIAkJfQogCiAJCWRt
Y19iYXNlW2lkXSA9IG9mX2lvbWFwKG5wLCAwKTsKQEAgLTYyMiwzMyArNjQ0LDQwIEBAIHN0YXRp
YyBpbnQgczVwdjIxMF9jcHVmcmVxX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
CiAJCQlwcl9lcnIoIiVzOiBmYWlsZWQgdG8gbWFwIGRtYyVkIHJlZ2lzdGVyc1xuIiwKIAkJCQlf
X2Z1bmNfXywgaWQpOwogCQkJb2Zfbm9kZV9wdXQobnApOwotCQkJcmV0dXJuIC1FRkFVTFQ7CisJ
CQlyZXN1bHQgPSAtRUZBVUxUOworCQkJZ290byBlcnJfZG1jOwogCQl9CiAJfQogCiAJZm9yIChp
ZCA9IDA7IGlkIDwgQVJSQVlfU0laRShkbWNfYmFzZSk7ICsraWQpIHsKIAkJaWYgKCFkbWNfYmFz
ZVtpZF0pIHsKIAkJCXByX2VycigiJXM6IGZhaWxlZCB0byBmaW5kIGRtYyVkIG5vZGVcbiIsIF9f
ZnVuY19fLCBpZCk7Ci0JCQlyZXR1cm4gLUVOT0RFVjsKKwkJCXJlc3VsdCA9IC1FTk9ERVY7CisJ
CQlnb3RvIGVycl9kbWM7CiAJCX0KIAl9CiAKLQlhcm1fcmVndWxhdG9yID0gcmVndWxhdG9yX2dl
dChOVUxMLCAidmRkYXJtIik7Ci0JaWYgKElTX0VSUihhcm1fcmVndWxhdG9yKSkgewotCQlwcl9l
cnIoImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZkZGFybVxuIik7Ci0JCXJldHVybiBQVFJfRVJS
KGFybV9yZWd1bGF0b3IpOwotCX0KLQotCWludF9yZWd1bGF0b3IgPSByZWd1bGF0b3JfZ2V0KE5V
TEwsICJ2ZGRpbnQiKTsKLQlpZiAoSVNfRVJSKGludF9yZWd1bGF0b3IpKSB7Ci0JCXByX2Vycigi
ZmFpbGVkIHRvIGdldCByZWd1bGF0b3IgdmRkaW50XG4iKTsKLQkJcmVndWxhdG9yX3B1dChhcm1f
cmVndWxhdG9yKTsKLQkJcmV0dXJuIFBUUl9FUlIoaW50X3JlZ3VsYXRvcik7Ci0JfQotCiAJcmVn
aXN0ZXJfcmVib290X25vdGlmaWVyKCZzNXB2MjEwX2NwdWZyZXFfcmVib290X25vdGlmaWVyKTsK
IAogCXJldHVybiBjcHVmcmVxX3JlZ2lzdGVyX2RyaXZlcigmczVwdjIxMF9kcml2ZXIpOworCitl
cnJfZG1jOgorCWZvciAoaWQgPSAwOyBpZCA8IEFSUkFZX1NJWkUoZG1jX2Jhc2UpOyArK2lkKQor
CQlpZiAoZG1jX2Jhc2VbaWRdKSB7CisJCQlpb3VubWFwKGRtY19iYXNlW2lkXSk7CisJCQlkbWNf
YmFzZVtpZF0gPSBOVUxMOworCQl9CisKK2Vycl9jbGtfYmFzZToKKwlpb3VubWFwKGNsa19iYXNl
KTsKKworZXJyX2Nsb2NrOgorCXJlZ3VsYXRvcl9wdXQoaW50X3JlZ3VsYXRvcik7CisKK2Vycl9p
bnRfcmVndWxhdG9yOgorCXJlZ3VsYXRvcl9wdXQoYXJtX3JlZ3VsYXRvcik7CisKKwlyZXR1cm4g
cmVzdWx0OwogfQogCiBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBzNXB2MjEwX2NwdWZy
ZXFfcGxhdGRydiA9IHsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
