Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6FAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:06:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D883220660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QPD0ePi0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKAEwXL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D883220660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lSP96ZhHhxyXasJDtJRizS0fvPJhjCmodn1BbqPo2qE=; b=QPD0ePi05zUB42
	oLCCK0XYWSR/5ma564zhD5+sEb+kHmlbmXoh8V3ARs72qDt0Blx4gRy1aN504KOeiue+mcn8Vjfot
	fX1YaRzpZ6EwIiEWWDKH9yN1b3wY9a3uT1ObApp48RbCDJpj7PGkG9JufJo7ZlgB4hVhPt/UgZ5NP
	Sj8jzHvDZGBuXo7TFCSlocHmUNInOQjy0Nm8veZYoDGi6qr0QQvTL7MLlYU2XrAEMAleaEJQs02Q4
	ws0tMxA+66hZFM7QHZlDORbYV2jVXyui4PhKK4ObVyCuZOnqBjlNTQK27g2GJmr2lKI/lSvOMW9qT
	765BxtCbPjOqNMCZZhng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggxdr-0001Oo-S5; Tue, 08 Jan 2019 20:06:27 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggxcu-0000Ov-Om
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 20:05:33 +0000
Received: by mail-lf1-x142.google.com with SMTP id i26so3913851lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nLRztxJAeC5B0+rbtnhFFtucRRJLwQz+ndZxADHnDTU=;
 b=UKAEwXL9hYyXEhhP0NaziiUWYqtM6BZnjtuY+YV4w3EzYgVDCGF3EV88PHcZqc+mdj
 kC1+FienrQZD3XyfAczMzbeAcbTJxyBsWlvBk4Vbve7llKXm/9t+zIy4BQi1m622tmCm
 25pwUNv1EFNO00GYU9IPFFQrPrcnBrZal6T0s2Rg/iUuKCX29JhDRvBrqLzBfDrKXVoo
 h81FLSoQEcCFH13fIo5ttsZ/7y8cob+nd8JLbaOQ8XGsiLmK04Y0Jd1HRIhlgtY9S2wl
 C26jgTV29SW98g1h2mBR9enBj0IY/cgyQgj7cU1frTbBatiPf9hZtfnXezqThHppiczR
 0yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nLRztxJAeC5B0+rbtnhFFtucRRJLwQz+ndZxADHnDTU=;
 b=GUA7VbCReb03NOIZvPd0XIJ1nzQYHzJH8hhNOZTxGf75k2IE1b9LVm7GeijwkaBgxJ
 s0fWloclGMbZ719IG4MfUU8rZPjDpa7Kc322ZAk8j4+lHcpZtPTa7HBEQKMJbIKAajhG
 N2KZeSHewgPKNx2o9VzQLj/kQw8m2UeHya4TaIxHQjkb8CZv6Bj6iRwntIYTdm2AytSI
 CNlh+S5XD7WnfeFEp6X6dzPQc1A51gC3heEtnaeS22UGF7Fy/kHW+A7oqlJJ9t0bW4Dt
 Y4jTzbM9ZfteiVqUePyCqLzp5qm9BXBTcOkFE25o+9RH1j9VIvFYP6BpYebxukXsM13b
 CyWg==
X-Gm-Message-State: AJcUukc247OAeg9V+ObHp1+/0AeWp4nC/f84sDLojMq/HKUH/+A9ATxz
 F/02H3BgIFROhC/2XNhu9bU=
X-Google-Smtp-Source: ALg8bN4IdbHawsPUgv2UefkEeNdV4W9bb30hNxa2Lb9Non7jT4OuwfzlsfKBZFvMSSdHmRw4GLI39g==
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr1752659lfk.78.1546977926750; 
 Tue, 08 Jan 2019 12:05:26 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id
 y23-v6sm14486768ljk.95.2019.01.08.12.05.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 12:05:26 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH 3/4] cpufreq: s5pv210: Defer probe if getting regulators fail
Date: Tue,  8 Jan 2019 21:05:08 +0100
Message-Id: <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_120529_065160_A2B062E6 
X-CRM114-Status: GOOD (  14.44  )
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
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk,
 krzk@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
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
ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KIGRyaXZlcnMv
Y3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYyB8IDMzICsrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVmcmVxLmMgYi9kcml2ZXJz
L2NwdWZyZXEvczVwdjIxMC1jcHVmcmVxLmMKaW5kZXggZjUxNjk3ZjFlMGIzLi4yZDBlNGRjN2Vk
ZTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYworKysgYi9k
cml2ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVmcmVxLmMKQEAgLTU5NCw2ICs1OTQsMjYgQEAgc3Rh
dGljIGludCBzNXB2MjEwX2NwdWZyZXFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKIAkgKiB0aGlzIHdob2xlIGRyaXZlciBhcyBzb29uIGFzIFM1UFYyMTAgZ2V0cyBtaWdyYXRl
ZCB0byB1c2UKIAkgKiBjcHVmcmVxLWR0IGRyaXZlci4KIAkgKi8KKwlhcm1fcmVndWxhdG9yID0g
cmVndWxhdG9yX2dldChOVUxMLCAidmRkYXJtIik7CisJaWYgKFBUUl9FUlIoYXJtX3JlZ3VsYXRv
cikgPT0gLUVQUk9CRV9ERUZFUikgeworCQlwcl9kYmcoInZkZGFybSByZWd1bGF0b3Igbm90IHJl
YWR5LCBkZWZlclxuIik7CisJCXJldHVybiAtRVBST0JFX0RFRkVSOworCX0gZWxzZSBpZiAoSVNf
RVJSKGFybV9yZWd1bGF0b3IpKSB7CisJCXByX2VycigiZmFpbGVkIHRvIGdldCByZWd1bGF0b3Ig
dmRkYXJtXG4iKTsKKwkJcmV0dXJuIFBUUl9FUlIoYXJtX3JlZ3VsYXRvcik7CisJfQorCisJaW50
X3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwgInZkZGludCIpOworCWlmIChQVFJfRVJS
KGludF9yZWd1bGF0b3IgPT0gLUVQUk9CRV9ERUZFUikgeworCQlyZWd1bGF0b3JfcHV0KGFybV9y
ZWd1bGF0b3IpOworCQlwcl9kYmcoInZkZGludCByZWd1bGF0b3Igbm90IHJlYWR5LCBkZWZlclxu
Iik7CisJCXJldHVybiAtRVBST0JFX0RFRkVSOworCX0gZWxzZSBpZiAoSVNfRVJSKGludF9yZWd1
bGF0b3IpKSB7CisJCXJlZ3VsYXRvcl9wdXQoYXJtX3JlZ3VsYXRvcik7CisJCXByX2VycigiZmFp
bGVkIHRvIGdldCByZWd1bGF0b3IgdmRkaW50XG4iKTsKKwkJcmV0dXJuIFBUUl9FUlIoaW50X3Jl
Z3VsYXRvcik7CisJfQorCiAJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxM
LCAic2Ftc3VuZyxzNXB2MjEwLWNsb2NrIik7CiAJaWYgKCFucCkgewogCQlwcl9lcnIoIiVzOiBm
YWlsZWQgdG8gZmluZCBjbG9jayBjb250cm9sbGVyIERUIG5vZGVcbiIsCkBAIC02MzMsMTkgKzY1
Myw2IEBAIHN0YXRpYyBpbnQgczVwdjIxMF9jcHVmcmVxX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCiAJCX0KIAl9CiAKLQlhcm1fcmVndWxhdG9yID0gcmVndWxhdG9yX2dldChO
VUxMLCAidmRkYXJtIik7Ci0JaWYgKElTX0VSUihhcm1fcmVndWxhdG9yKSkgewotCQlwcl9lcnIo
ImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZkZGFybVxuIik7Ci0JCXJldHVybiBQVFJfRVJSKGFy
bV9yZWd1bGF0b3IpOwotCX0KLQotCWludF9yZWd1bGF0b3IgPSByZWd1bGF0b3JfZ2V0KE5VTEws
ICJ2ZGRpbnQiKTsKLQlpZiAoSVNfRVJSKGludF9yZWd1bGF0b3IpKSB7Ci0JCXByX2VycigiZmFp
bGVkIHRvIGdldCByZWd1bGF0b3IgdmRkaW50XG4iKTsKLQkJcmVndWxhdG9yX3B1dChhcm1fcmVn
dWxhdG9yKTsKLQkJcmV0dXJuIFBUUl9FUlIoaW50X3JlZ3VsYXRvcik7Ci0JfQotCiAJcmVnaXN0
ZXJfcmVib290X25vdGlmaWVyKCZzNXB2MjEwX2NwdWZyZXFfcmVib290X25vdGlmaWVyKTsKIAog
CXJldHVybiBjcHVmcmVxX3JlZ2lzdGVyX2RyaXZlcigmczVwdjIxMF9kcml2ZXIpOwotLSAKMi4x
Ny4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
