Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFEAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:43:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391FE206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="shfqvI73";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoF+RxuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391FE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6F1St5KGgBYEvpGGGJ0ugi+Oy8jumZRUsJJYf0sQ79U=; b=shfqvI73knvvSI
	5ISY6tXwHIhT2hV3Klkdm8WFpnkB1PP7jVTJiywXXxQcSwXrOzuK3dCjaYghb6iZIvOO6ux/LIQjw
	/y5t5sXcxv5TXvJxBf2njW0RJC/D/mn+rBvh4DPXB3YeYyysy5Iixwfle7QkOW+EJiMpZeqyPrNhs
	AODIDW61HzND5DfR/9Fj6FoIwsYvVGBiKBs20uVPB6rY5wLuld3sGFMTGAH2iR+tyythjf6PgOa8s
	Dyp9d3CqB26YlR1/cGIOsMuCqPR9OnNWOj9xOv5wmsKi5ql0bV1AMfyeNwVJ9ni+kzuqm3Ffko0b0
	pd5G0MDkJRU/badvqsYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2ht-0004jP-2y; Fri, 11 Jan 2019 19:43:05 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2hp-0004in-UM
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:43:03 +0000
Received: by mail-lj1-x244.google.com with SMTP id v15-v6so13931978ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 11:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WZRVS57tv9I9ffMetpNGaYITV4nVk628qDxZw36pJwY=;
 b=JoF+RxuWc2U9ZqruqdjMEi3EjCHt0bgwXRIwuZppsWf8QH8qSge61SMBsSilfSj6Tg
 pw4ZUIBNDO0tUwDtPKfgMFMBK3XFn5y6Qhgg03Iv0VNDuh+hLNhYUWZNGbf93yeK+5UM
 ZrxVROqyBcFhWrMElADODgOAENuuFx7t/ep+ZIddLBvvZHeBERqmkejK0mmu5JPXntBN
 Fcssi9buJrfJm0RUg/J5vDecw9WzoxkI7N/uh73NzFpO2vuo5F++6j2aH60pdxGSesrf
 Wv1wq15hteaG+z4NtC/OGLH9byfsjaNSasr3UprXgwDP5DxlpSAOpW86ViMmBBk9e+uq
 KZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WZRVS57tv9I9ffMetpNGaYITV4nVk628qDxZw36pJwY=;
 b=mK58KAXB9eypR1uvjRUWyi3Rei8ggdqnZZEIpFLuzT5cqwfRb5Qa5dtz/JZ3+XuTwG
 FgQN7BGztnnhgZKPkuiojmSpu6gepVt47ZpnGnpiUGuYnooCEZ5L4/4SCwjZfErK2y3J
 G4QqkHcFI8Cg0VErEL3xtU/BkLA0pzf5IhhjbgEx4QByGl2OAVfC9PPZKWFE+bWNSYY5
 DLILNpXgHDe6lpv738MDIoQpDUKhVXxYCtRLHg8b0MtKDPE+xDeT+e0l3PfFIJM5X3dt
 voftdEdqaPtghlMlY9hSRlkzc8T6QAWCyHXIt4DuchetKDpi3VnwX6YiRGYml8t/liAl
 3h8g==
X-Gm-Message-State: AJcUukc2avw3wE9iQj1gjeM8VHkbwjB/gYUXIQgxxKIoGujixHrto2sr
 jaqQX7AsHFGexR26jHdxY2LBkuxOSX8h3w==
X-Google-Smtp-Source: ALg8bN5G1D/gYawrOZ1LXdLsVI9Ryj4UGQP1xBGAR8D5E9SYUt9eLCKuZEmQortAT8+vnWDeCbTIgw==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr6808353ljo.10.1547235778733; 
 Fri, 11 Jan 2019 11:42:58 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:1c33:9053:5344:9f1f])
 by smtp.googlemail.com with ESMTPSA id h3sm14602964lfj.25.2019.01.11.11.42.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 11:42:57 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH v3] cpufreq: s5pv210: Defer probe if getting regulators fail
Date: Fri, 11 Jan 2019 20:42:44 +0100
Message-Id: <20190111194244.2439-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_114302_007205_2D635ABC 
X-CRM114-Status: GOOD (  16.14  )
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
cm9tIHYyOgogIC0gSGFuZGxlIGFsbCBlcnJvciBwYXRocyBpbiBwcm9iZQoKQ2hhbmdlcyBmcm9t
IHYxOgogIC0gRml4IGNvbXBpbGF0aW9uIGVycm9yCiAgLSBSZW9yZ2FuaXplIGNvZGUgc28gaXQn
cyBzbWFsbGVyCi0tLQogZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jIHwgNjggKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlv
bnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9zNXB2
MjEwLWNwdWZyZXEuYyBiL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYwppbmRleCBm
NTE2OTdmMWUwYjMuLjYyN2IxMzJlM2U2MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jcHVmcmVxL3M1
cHYyMTAtY3B1ZnJlcS5jCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYwpA
QCAtNTg0LDcgKzU4NCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgczVwdjIxMF9j
cHVmcmVxX3JlYm9vdF9ub3RpZmllciA9IHsKIHN0YXRpYyBpbnQgczVwdjIxMF9jcHVmcmVxX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CiAJc3RydWN0IGRldmljZV9ub2Rl
ICpucDsKLQlpbnQgaWQ7CisJaW50IGlkLCByZXN1bHQgPSAwOwogCiAJLyoKIAkgKiBIQUNLOiBU
aGlzIGlzIGEgdGVtcG9yYXJ5IHdvcmthcm91bmQgdG8gZ2V0IGFjY2VzcyB0byBjbG9jawpAQCAt
NTk0LDE4ICs1OTQsNDAgQEAgc3RhdGljIGludCBzNXB2MjEwX2NwdWZyZXFfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkgKiB0aGlzIHdob2xlIGRyaXZlciBhcyBzb29uIGFz
IFM1UFYyMTAgZ2V0cyBtaWdyYXRlZCB0byB1c2UKIAkgKiBjcHVmcmVxLWR0IGRyaXZlci4KIAkg
Ki8KKwlhcm1fcmVndWxhdG9yID0gcmVndWxhdG9yX2dldChOVUxMLCAidmRkYXJtIik7CisJaWYg
KElTX0VSUihhcm1fcmVndWxhdG9yKSkgeworCQlpZiAoUFRSX0VSUihhcm1fcmVndWxhdG9yKSA9
PSAtRVBST0JFX0RFRkVSKQorCQkJcHJfZGVidWcoInZkZGFybSByZWd1bGF0b3Igbm90IHJlYWR5
LCBkZWZlclxuIik7CisJCWVsc2UKKwkJCXByX2VycigiZmFpbGVkIHRvIGdldCByZWd1bGF0b3Ig
dmRkYXJtXG4iKTsKKwkJcmVzdWx0ID0gUFRSX0VSUihhcm1fcmVndWxhdG9yKTsKKwkJZ290byBl
cnJfYXJtX3JlZ3VsYXRvcjsKKwl9CisKKwlpbnRfcmVndWxhdG9yID0gcmVndWxhdG9yX2dldChO
VUxMLCAidmRkaW50Iik7CisJaWYgKElTX0VSUihpbnRfcmVndWxhdG9yKSkgeworCQlpZiAoUFRS
X0VSUihpbnRfcmVndWxhdG9yKSA9PSAtRVBST0JFX0RFRkVSKQorCQkJcHJfZGVidWcoInZkZGlu
dCByZWd1bGF0b3Igbm90IHJlYWR5LCBkZWZlclxuIik7CisJCWVsc2UKKwkJCXByX2VycigiZmFp
bGVkIHRvIGdldCByZWd1bGF0b3IgdmRkaW50XG4iKTsKKwkJcmVzdWx0ID0gUFRSX0VSUihpbnRf
cmVndWxhdG9yKTsKKwkJZ290byBlcnJfaW50X3JlZ3VsYXRvcjsKKwl9CisKIAlucCA9IG9mX2Zp
bmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJzYW1zdW5nLHM1cHYyMTAtY2xvY2siKTsK
IAlpZiAoIW5wKSB7CiAJCXByX2VycigiJXM6IGZhaWxlZCB0byBmaW5kIGNsb2NrIGNvbnRyb2xs
ZXIgRFQgbm9kZVxuIiwKIAkJCV9fZnVuY19fKTsKLQkJcmV0dXJuIC1FTk9ERVY7CisJCXJlc3Vs
dCA9IC1FTk9ERVY7CisJCWdvdG8gZXJyX2Nsb2NrOwogCX0KIAogCWNsa19iYXNlID0gb2ZfaW9t
YXAobnAsIDApOwogCW9mX25vZGVfcHV0KG5wKTsKIAlpZiAoIWNsa19iYXNlKSB7CiAJCXByX2Vy
cigiJXM6IGZhaWxlZCB0byBtYXAgY2xvY2sgcmVnaXN0ZXJzXG4iLCBfX2Z1bmNfXyk7Ci0JCXJl
dHVybiAtRUZBVUxUOworCQlyZXN1bHQgPSAtRUZBVUxUOworCQlnb3RvIGVycl9jbG9jazsKIAl9
CiAKIAlmb3JfZWFjaF9jb21wYXRpYmxlX25vZGUobnAsIE5VTEwsICJzYW1zdW5nLHM1cHYyMTAt
ZG1jIikgewpAQCAtNjE0LDcgKzYzNiw4IEBAIHN0YXRpYyBpbnQgczVwdjIxMF9jcHVmcmVxX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCQlwcl9lcnIoIiVzOiBmYWlsZWQg
dG8gZ2V0IGFsaWFzIG9mIGRtYyBub2RlICclcE9GbidcbiIsCiAJCQkJX19mdW5jX18sIG5wKTsK
IAkJCW9mX25vZGVfcHV0KG5wKTsKLQkJCXJldHVybiBpZDsKKwkJCXJlc3VsdCA9IGlkOworCQkJ
Z290byBlcnJfY2xrX2Jhc2U7CiAJCX0KIAogCQlkbWNfYmFzZVtpZF0gPSBvZl9pb21hcChucCwg
MCk7CkBAIC02MjIsMzMgKzY0NSw0MCBAQCBzdGF0aWMgaW50IHM1cHYyMTBfY3B1ZnJlcV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQkJcHJfZXJyKCIlczogZmFpbGVkIHRv
IG1hcCBkbWMlZCByZWdpc3RlcnNcbiIsCiAJCQkJX19mdW5jX18sIGlkKTsKIAkJCW9mX25vZGVf
cHV0KG5wKTsKLQkJCXJldHVybiAtRUZBVUxUOworCQkJcmVzdWx0ID0gLUVGQVVMVDsKKwkJCWdv
dG8gZXJyX2RtYzsKIAkJfQogCX0KIAogCWZvciAoaWQgPSAwOyBpZCA8IEFSUkFZX1NJWkUoZG1j
X2Jhc2UpOyArK2lkKSB7CiAJCWlmICghZG1jX2Jhc2VbaWRdKSB7CiAJCQlwcl9lcnIoIiVzOiBm
YWlsZWQgdG8gZmluZCBkbWMlZCBub2RlXG4iLCBfX2Z1bmNfXywgaWQpOwotCQkJcmV0dXJuIC1F
Tk9ERVY7CisJCQlyZXN1bHQgPSAtRU5PREVWOworCQkJZ290byBlcnJfZG1jOwogCQl9CiAJfQog
Ci0JYXJtX3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwgInZkZGFybSIpOwotCWlmIChJ
U19FUlIoYXJtX3JlZ3VsYXRvcikpIHsKLQkJcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IHJlZ3VsYXRv
ciB2ZGRhcm1cbiIpOwotCQlyZXR1cm4gUFRSX0VSUihhcm1fcmVndWxhdG9yKTsKLQl9Ci0KLQlp
bnRfcmVndWxhdG9yID0gcmVndWxhdG9yX2dldChOVUxMLCAidmRkaW50Iik7Ci0JaWYgKElTX0VS
UihpbnRfcmVndWxhdG9yKSkgewotCQlwcl9lcnIoImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZk
ZGludFxuIik7Ci0JCXJlZ3VsYXRvcl9wdXQoYXJtX3JlZ3VsYXRvcik7Ci0JCXJldHVybiBQVFJf
RVJSKGludF9yZWd1bGF0b3IpOwotCX0KLQogCXJlZ2lzdGVyX3JlYm9vdF9ub3RpZmllcigmczVw
djIxMF9jcHVmcmVxX3JlYm9vdF9ub3RpZmllcik7CiAKIAlyZXR1cm4gY3B1ZnJlcV9yZWdpc3Rl
cl9kcml2ZXIoJnM1cHYyMTBfZHJpdmVyKTsKKworZXJyX2RtYzoKKwlmb3IgKGlkID0gMDsgaWQg
PCBBUlJBWV9TSVpFKGRtY19iYXNlKTsgKytpZCkKKwkJaWYgKGRtY19iYXNlW2lkXSkKKwkJCWlv
dW5tYXAoZG1jX2Jhc2VbaWRdKTsKKworZXJyX2Nsa19iYXNlOgorCWlvdW5tYXAoY2xrX2Jhc2Up
OworCitlcnJfY2xvY2s6CisJcmVndWxhdG9yX3B1dChpbnRfcmVndWxhdG9yKTsKKworZXJyX2lu
dF9yZWd1bGF0b3I6CisJcmVndWxhdG9yX3B1dChhcm1fcmVndWxhdG9yKTsKKworZXJyX2FybV9y
ZWd1bGF0b3I6CisKKwlyZXR1cm4gcmVzdWx0OwogfQogCiBzdGF0aWMgc3RydWN0IHBsYXRmb3Jt
X2RyaXZlciBzNXB2MjEwX2NwdWZyZXFfcGxhdGRydiA9IHsKLS0gCjIuMTcuMQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
