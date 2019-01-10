Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55360C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:54:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009D320685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iURo+ITY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htf7k0Ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009D320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yDwpZRNMo3f25v57MQFa0STy954w/ltDURgWn3ybj50=; b=iURo+ITYRua+pC
	00k1A3hYyfDhgrs0gL6BCIFtFyQAiUr3jylFBZFix82YDys2xHXW915SfNCkGFDw4YDhMtu8d715s
	4+77bQ2OAM6dDwCgSolva21FWQLO2NVt8iNPjpG2QtqxaSl1LnD8fpPlxsfaoj2qTBkOxdhElOuSf
	e4UP7+BdKDtKMyfyskaLCMA7s6FSfPOBzqewwYLfIQ+WVQxyut1ff3ipOJKExN7yAJ8uy3W2Cd1s8
	v5nAa1/5u1O1wmFH4Mrlr4SWysiwzlR9KRwKfvf2Sg1whmV/vASZzDik+Bo8SA3x6G5ZY+bZhmkCM
	UO2BEvyYSAIYPrQ0doVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhL3-0002YJ-R7; Thu, 10 Jan 2019 20:54:05 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhKI-0001nF-8x
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:53:21 +0000
Received: by mail-lf1-x142.google.com with SMTP id a16so9310932lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 12:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pV8kbDyRB/8qZ90lJTc0lEk+FaV2Ra/kqeVF/E8Hnfk=;
 b=Htf7k0ExehzCaF3zhHh1dRJbDHstaIkx5+nKHbbc/ILqAjuqaUwe3koIB3cNj44gz2
 ZwF0a1qw6466nImj6AWCNYVaJdU0eXFGt6hVW2tW/n6Db5HoOaqLFVTWnulK4rMHo6Q8
 saKPC9Pv/qlO+joFcR3ASl0LCqDVgoAWDWRhxz8JScyXXxDt5zQbW4LkHBbKBTfSRfam
 S2rH4mnhsuT5xDuyvYWeSvpj2VL23FZunTRa6t18CsuqH2gu/7q/Igb53u9n5Cqmrj0Y
 EP5sYVhOQ2c1w4Gwji6GfVl/y+MJwSuyCwubB7fzG44E5g3khbFVV9PhOr6Ab/gnxmvU
 aybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pV8kbDyRB/8qZ90lJTc0lEk+FaV2Ra/kqeVF/E8Hnfk=;
 b=eXsscKEPFB41p7FTPFG73fUbK+FbV/PeR7d74P/0ox/92D/PqGrmnrLO8+xDESyfFE
 eL5GHKwPLS6vJMJK3MwQ55w+9oACVnVEI7OcpkZrk2XSqZZ250TW7iZub0XMFPsk5INz
 IKhDR432PNhaFEwTsaNpiV4NubAFE4a36suf/l569YaF05xChm1dMo+pka500YODTutp
 PA26oGxzTOiXVQCQegtZX1wx71SuwBuEpl69AVFqQ1YCQkDM+nkddVyMYuj4Wdv2S0yP
 DVb3mdkRAMEBu5nclBCPACMbsos5hTRSQGC3rAvfK/H/MV9R4LTJIbzH4N4jA/QW4mXA
 fOlg==
X-Gm-Message-State: AJcUukennKvbADvg15JImdiBPuE2bxS5lfHEOSmW3d1Z7r8836QL5RkU
 cQJFm+0JBZD1URSY2j969Sw=
X-Google-Smtp-Source: ALg8bN5+qL67TTptupCRMWOWMH6hxida6ZissbV6ggdz+24+VlshN7ushnka9oUaZ9ltQc93hn1ACg==
X-Received: by 2002:a19:d5:: with SMTP id 204mr6311233lfa.116.1547153596596;
 Thu, 10 Jan 2019 12:53:16 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
 by smtp.googlemail.com with ESMTPSA id
 z7-v6sm15389690lji.42.2019.01.10.12.53.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 12:53:16 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH v2 3/4] cpufreq: s5pv210: Defer probe if getting regulators
 fail
Date: Thu, 10 Jan 2019 21:52:14 +0100
Message-Id: <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_125318_641293_13C70B2C 
X-CRM114-Status: GOOD (  15.38  )
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
ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KQ2hhbmdlcyBm
cm9tIHYxOgogIC0gRml4IGNvbXBpbGF0aW9uIGVycm9yCiAgLSBSZW9yZ2FuaXplIGNvZGUgc28g
aXQncyBzbWFsbGVyCi0tLQogZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jIHwgMzIg
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9z
NXB2MjEwLWNwdWZyZXEuYyBiL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYwppbmRl
eCBmNTE2OTdmMWUwYjMuLjZkZjk1OTQxYmE5NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jcHVmcmVx
L3M1cHYyMTAtY3B1ZnJlcS5jCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEu
YwpAQCAtNTk0LDYgKzU5NCwyNSBAQCBzdGF0aWMgaW50IHM1cHYyMTBfY3B1ZnJlcV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCSAqIHRoaXMgd2hvbGUgZHJpdmVyIGFzIHNv
b24gYXMgUzVQVjIxMCBnZXRzIG1pZ3JhdGVkIHRvIHVzZQogCSAqIGNwdWZyZXEtZHQgZHJpdmVy
LgogCSAqLworCWFybV9yZWd1bGF0b3IgPSByZWd1bGF0b3JfZ2V0KE5VTEwsICJ2ZGRhcm0iKTsK
KwlpZiAoSVNfRVJSKGFybV9yZWd1bGF0b3IpKSB7CisJCWlmIChQVFJfRVJSKGFybV9yZWd1bGF0
b3IpID09IC1FUFJPQkVfREVGRVIpCisJCQlwcl9kZWJ1ZygidmRkYXJtIHJlZ3VsYXRvciBub3Qg
cmVhZHksIGRlZmVyXG4iKTsKKwkJZWxzZQorCQkJcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IHJlZ3Vs
YXRvciB2ZGRhcm1cbiIpOworCQlyZXR1cm4gUFRSX0VSUihhcm1fcmVndWxhdG9yKTsKKwl9CisK
KwlpbnRfcmVndWxhdG9yID0gcmVndWxhdG9yX2dldChOVUxMLCAidmRkaW50Iik7CisJaWYgKElT
X0VSUihpbnRfcmVndWxhdG9yKSkgeworCQlpZiAoUFRSX0VSUihpbnRfcmVndWxhdG9yKSA9PSAt
RVBST0JFX0RFRkVSKQorCQkJcHJfZGVidWcoInZkZGludCByZWd1bGF0b3Igbm90IHJlYWR5LCBk
ZWZlclxuIik7CisJCWVsc2UKKwkJCXByX2VycigiZmFpbGVkIHRvIGdldCByZWd1bGF0b3IgdmRk
aW50XG4iKTsKKwkJcmVndWxhdG9yX3B1dChhcm1fcmVndWxhdG9yKTsKKwkJcmV0dXJuIFBUUl9F
UlIoaW50X3JlZ3VsYXRvcik7CisJfQorCiAJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShO
VUxMLCBOVUxMLCAic2Ftc3VuZyxzNXB2MjEwLWNsb2NrIik7CiAJaWYgKCFucCkgewogCQlwcl9l
cnIoIiVzOiBmYWlsZWQgdG8gZmluZCBjbG9jayBjb250cm9sbGVyIERUIG5vZGVcbiIsCkBAIC02
MzMsMTkgKzY1Miw2IEBAIHN0YXRpYyBpbnQgczVwdjIxMF9jcHVmcmVxX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCX0KIAl9CiAKLQlhcm1fcmVndWxhdG9yID0gcmVndWxh
dG9yX2dldChOVUxMLCAidmRkYXJtIik7Ci0JaWYgKElTX0VSUihhcm1fcmVndWxhdG9yKSkgewot
CQlwcl9lcnIoImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZkZGFybVxuIik7Ci0JCXJldHVybiBQ
VFJfRVJSKGFybV9yZWd1bGF0b3IpOwotCX0KLQotCWludF9yZWd1bGF0b3IgPSByZWd1bGF0b3Jf
Z2V0KE5VTEwsICJ2ZGRpbnQiKTsKLQlpZiAoSVNfRVJSKGludF9yZWd1bGF0b3IpKSB7Ci0JCXBy
X2VycigiZmFpbGVkIHRvIGdldCByZWd1bGF0b3IgdmRkaW50XG4iKTsKLQkJcmVndWxhdG9yX3B1
dChhcm1fcmVndWxhdG9yKTsKLQkJcmV0dXJuIFBUUl9FUlIoaW50X3JlZ3VsYXRvcik7Ci0JfQot
CiAJcmVnaXN0ZXJfcmVib290X25vdGlmaWVyKCZzNXB2MjEwX2NwdWZyZXFfcmVib290X25vdGlm
aWVyKTsKIAogCXJldHVybiBjcHVmcmVxX3JlZ2lzdGVyX2RyaXZlcigmczVwdjIxMF9kcml2ZXIp
OwotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
