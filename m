Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76B3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:56:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71501218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W56Ln6Tv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzIJ9lSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71501218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tkcU36Fs3TT8O80BIATlDzk6ST8YHXYxrCakVNlG9pE=; b=W56Ln6TvLDunfw
	dQEyrYrnN5LSKcDQ62B9vSIYNEFD/Rz2qgUkc2TjwtgOBZdDzf6pTIuHKIyrr8s9Oqb+u92rZoPCU
	/LQJnuJpBtBjojCEm746mwH1jMtInUGw1Uq+qZ9mdUjo0Ce5j86Y+HvdZSvNh1Two5pu/IPUZtX7p
	5PVsWm2D4Gl1UVCrRqqz6TAZ9CzXHs979Gnf2z0L4uvjn7J3MKFiYtf62R3a0FQJp9+RW6HSk25hM
	1TYG6jZrkMU0lrPnBuxAOAK5YS07shVfAV/PyFwla4zl/PTjzUvUglBYp+IU0dsdg7KtzPwMmbOp7
	9oVHot0SRAoqteu9b7uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZMPI-0006Jh-KG; Tue, 18 Dec 2018 20:56:00 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZMPF-0006IL-JL
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 20:55:58 +0000
Received: by mail-wm1-x344.google.com with SMTP id y139so3975563wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 12:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tOi0WSQxEvc0Rs6AL8W3qRpEySU4z9T/xkS/tyIoq4E=;
 b=dzIJ9lSQKAzcFaRuPKc/KxO1XskoBFjWSsdmf6udXt8vC6qBzXVQvMi7mYYFOa/6WA
 1YYoHO9bQcHtUCDOG7+BgtM5mZG0K9G9DjhTWtZcMye3R5TANT9Yo/7SdLTj0c/KeQvp
 mFfDoi+mL8q7DZMtR0jnkN8pceftYqro1pUKOjCEgswX88SPbwwsqZAX6vy95nC/Ag16
 at/NWkueCUI8nEjJYXIIlKK+0udVYB9PgNooNta43/AOBHTX0iDqxY67R3cg9oMCY/rZ
 WysCWeqq+gkRMyXXuCwz+GTiZyTXhplKUDncKtOVN2/0O+O8D+Ol8px+PRFPbbuODh8F
 Hspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=tOi0WSQxEvc0Rs6AL8W3qRpEySU4z9T/xkS/tyIoq4E=;
 b=KW9WfQ6GUkgLGpe7tTjOyZ1vbRgqkANXqpiyk56v8oa3XD+a4pIgE5Uln4idXP2x2V
 cmh27qLxxgOtOwUC+1M3MKuCT9RuypNT/+epfz4yvfPZLRNO+WKL9MWSm2aJ3oq+oVVY
 5mGUFqM6tKfdByAOnr/y2r4YuyRFa7442SknONmFAGaSCtIOE15NiM5EoVC0eRSZp2CD
 9DNkTtKu+ufhuhqiQKecxA5lbFN2QgGwGIOq7FQy+WskwwTsN1BlCDIQx1KmYOILNwlF
 Cm3g2bA40GWvB/7tf06H2ipX1pmKjtDytpoFOuw2S9U8ZFdbZkcn1klKhQGCKQZmpEPJ
 pL5g==
X-Gm-Message-State: AA+aEWa1LVF0HLw4ubUa42hoXYU6qKdTPA0IE4MWYV/Z6JWVVOgsQKDZ
 mftz2ab2tpnH7L7Vei1ENp8=
X-Google-Smtp-Source: AFSGD/XsEYvnEZVRcYrcw2ooP69qvHF9+UsQHUmhr8GHTf8HOvjUL68D/8/C48BC3Fxx0I++wcXA2Q==
X-Received: by 2002:a1c:709:: with SMTP id 9mr4593373wmh.39.1545166545485;
 Tue, 18 Dec 2018 12:55:45 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id h13sm5572416wrp.61.2018.12.18.12.55.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 12:55:44 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 2CE59114106E; Tue, 18 Dec 2018 21:55:43 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH] clk: Use __printf markup to silence compiler
Date: Tue, 18 Dec 2018 21:55:41 +0100
Message-Id: <20181218205541.26783-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_125557_634035_B6678A37 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

U2lsZW5jZSB3YXJuaW5ncyAodHJpZ2dlcmVkIGF0IFc9MSkgYnkgYWRkaW5nIHJlbGV2YW50IF9f
cHJpbnRmIGF0dHJpYnV0ZXMuCgogIGRyaXZlcnMvY2xrL2Nsa2Rldi5jOjI2NzozOiB3YXJuaW5n
OiBmdW5jdGlvbiBtaWdodCBiZSBwb3NzaWJsZSBjYW5kaWRhdGUgZm9yIOKAmGdudV9wcmludGbi
gJkgZm9ybWF0IGF0dHJpYnV0ZSBbLVdzdWdnZXN0LWF0dHJpYnV0ZT1mb3JtYXRdCiAgZHJpdmVy
cy9jbGsvY2xrZGV2LmM6MjgwOjI6IHdhcm5pbmc6IGZ1bmN0aW9uIG1pZ2h0IGJlIHBvc3NpYmxl
IGNhbmRpZGF0ZSBmb3Ig4oCYZ251X3ByaW50ZuKAmSBmb3JtYXQgYXR0cmlidXRlIFstV3N1Z2dl
c3QtYXR0cmlidXRlPWZvcm1hdF0KICBkcml2ZXJzL2Nsay9jbGtkZXYuYzozOTg6Mjogd2Fybmlu
ZzogZnVuY3Rpb24gbWlnaHQgYmUgcG9zc2libGUgY2FuZGlkYXRlIGZvciDigJhnbnVfcHJpbnRm
4oCZIGZvcm1hdCBhdHRyaWJ1dGUgWy1Xc3VnZ2VzdC1hdHRyaWJ1dGU9Zm9ybWF0XQoKU2lnbmVk
LW9mZi1ieTogTWF0aGlldSBNYWxhdGVycmUgPG1hbGF0QGRlYmlhbi5vcmc+Ci0tLQogZHJpdmVy
cy9jbGsvY2xrZGV2LmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsa2Rldi5jIGIvZHJp
dmVycy9jbGsvY2xrZGV2LmMKaW5kZXggOWFiM2RiOGIzOTg4Li4yZmIwMzU5NWRjMjYgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvY2xrL2Nsa2Rldi5jCisrKyBiL2RyaXZlcnMvY2xrL2Nsa2Rldi5jCkBA
IC0yNDcsNyArMjQ3LDcgQEAgc3RydWN0IGNsa19sb29rdXBfYWxsb2MgewogCWNoYXIJY29uX2lk
W01BWF9DT05fSURdOwogfTsKIAotc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwICogX19yZWYKK19f
cHJpbnRmKDMsIDApIHN0YXRpYyBzdHJ1Y3QgY2xrX2xvb2t1cCAqIF9fcmVmCiB2Y2xrZGV2X2Fs
bG9jKHN0cnVjdCBjbGtfaHcgKmh3LCBjb25zdCBjaGFyICpjb25faWQsIGNvbnN0IGNoYXIgKmRl
dl9mbXQsCiAJdmFfbGlzdCBhcCkKIHsKQEAgLTI3MSw3ICsyNzEsNyBAQCB2Y2xrZGV2X2FsbG9j
KHN0cnVjdCBjbGtfaHcgKmh3LCBjb25zdCBjaGFyICpjb25faWQsIGNvbnN0IGNoYXIgKmRldl9m
bXQsCiAJcmV0dXJuICZjbGEtPmNsOwogfQogCi1zdGF0aWMgc3RydWN0IGNsa19sb29rdXAgKgor
X19wcmludGYoMywgMCkgc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwICoKIHZjbGtkZXZfY3JlYXRl
KHN0cnVjdCBjbGtfaHcgKmh3LCBjb25zdCBjaGFyICpjb25faWQsIGNvbnN0IGNoYXIgKmRldl9m
bXQsCiAJdmFfbGlzdCBhcCkKIHsKQEAgLTM4Nyw2ICszODcsNyBAQCB2b2lkIGNsa2Rldl9kcm9w
KHN0cnVjdCBjbGtfbG9va3VwICpjbCkKIH0KIEVYUE9SVF9TWU1CT0woY2xrZGV2X2Ryb3ApOwog
CitfX3ByaW50ZigzLCA0KQogc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwICpfX2Nsa19yZWdpc3Rl
cl9jbGtkZXYoc3RydWN0IGNsa19odyAqaHcsCiAJCQkJCQljb25zdCBjaGFyICpjb25faWQsCiAJ
CQkJCQljb25zdCBjaGFyICpkZXZfaWQsIC4uLikKLS0gCjIuMTkuMgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
