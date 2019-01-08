Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD11C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2CA20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dWesV7/c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an2949Sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2CA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRShPn6KwnDqXlijSlckUikzPb1UsSOrex8NLqeIODw=; b=dWesV7/cjeVxOv
	1NwHc2Tt/RUbBnYprDp73OLTVTLgVPKUPvBhgOpw1TGWaBj+xnNEu9YGahS+e6EcHsuXtuSRU++Cx
	lDeLM49Xk16G/gWQSzod6By1dSp5ZMjoaR17Rm5TyHUaxudUeOipFSuZ9MBU+/yFkr99C7DWqQOv+
	wNcWWIG9nLYxZdoCWy+cSV7/Gl82WfV/fruvMu6XAgJYvrlfcgRiZKsogcJnN4rNalhdJKsT0P5mG
	ldHGI5cCHTZ5gEiuInu5HXxjBP4hCw20ujCTcDhcqwo+f4czQ/TWmn50aDQhRxr8Sv6cM/4qdKeWN
	zGCJr9DsKGmUek4lvfGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggxd3-0000Yj-KF; Tue, 08 Jan 2019 20:05:37 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggxcr-0000NC-5A
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 20:05:26 +0000
Received: by mail-lf1-x143.google.com with SMTP id b20so3870810lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CKLSuDSiUbomGh4I8Fz1drCWaMjb7DVbiuB6C0KO3NA=;
 b=an2949SnqLLfU9Rs8eDpBYidaG72QIHQzb2Ogy6sXdZ+kOrIYpD8CNdBAwAd6sdQIJ
 4t4Xnw8T56Y5w03EzA4iuaOYaLQ65QgHyIw3gKOmeifjc9XwchaEqtTbumVGgMyy/jr4
 H3Vm8UPEV3QxdwS3LnsWHD8lmbOd2TMuFbXtFyha3N2aVXCKBtLJhPIgNSdZy69uret6
 VMzD24DhRQUgua0SNZ6Esruu2ykCyI0OlupqV0jqC6I2Gp4rNeeZuqQDI44Uc1lqZ6CG
 Fl4xIWU+Y0ESq6R+TaQTZwUwuUJH2ZZTNO2hG6JQt+12KA/SUjX0zyhxC0vfWAT/OXV+
 AKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CKLSuDSiUbomGh4I8Fz1drCWaMjb7DVbiuB6C0KO3NA=;
 b=imiVM1CDQdC+WAH+UFxtHzW+209jhEmiLrNew1hPgh3BCfDaQiC25WOlHPrT8XZhNH
 tfnEw5b+EiDElUhORdvyYsc9jR134Ex+xKKvj116v3M9zfGsZkmEfeZR4fvyKeA5FN47
 G54TIjYkNFs1jBZ8O3A6l+z2hVShmxd2UvSKs35lKP9aZy2v5AfRIQvGM0M2KcOriycz
 f/N09s0rSIretpMTzdmIzMJd7uCS5r1kizu+d8jki19YKsQxocwHRKYayjfsEwaYeLgg
 n2yL5tedBRL9PFbWRO+ZvzOtPeLhx6RnAbPV4sDgTXI/Qx5Z/qoLW0iNY3retAejsg4H
 sPKw==
X-Gm-Message-State: AJcUukf+k3OP7FgXEUwGTjNTvpFNBGxcv/OsAFJBQUxpNmE/mNyFqjOo
 WBW0nWYe7VUQ9WP2eoXOYXk=
X-Google-Smtp-Source: ALg8bN46YCS0ZU8VbXtL9n20S6AqiEI4hOlXxP6D+RREGvAHL54MhaFThRMF+As/6EnUqsBWpGg7AQ==
X-Received: by 2002:a19:c70a:: with SMTP id x10mr1823599lff.88.1546977923517; 
 Tue, 08 Jan 2019 12:05:23 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id
 y23-v6sm14486768ljk.95.2019.01.08.12.05.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 12:05:22 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH 1/4] ARM: dts: s5pv210: Add dmc nodes
Date: Tue,  8 Jan 2019 21:05:06 +0100
Message-Id: <20190108200509.30494-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_120525_194526_A7B4B8F1 
X-CRM114-Status: GOOD (  12.21  )
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

VGhpcyBjb21taXQgYWRkcyBkbWMgbm9kZXMsIHdoaWNoIGFyZSBuZWVkZWQgYnkgczVwdjIxMCBj
cHVmcmVxIGRyaXZlcgp0byB3b3JrLgoKU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3
ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYy
MTAuZHRzaSB8IDEyICsrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0c2kgYi9hcmNoL2Fy
bS9ib290L2R0cy9zNXB2MjEwLmR0c2kKaW5kZXggZTk2MTM0MTgyMjhkLi4yZDU1YTNhNmU3OWUg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaQorKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9zNXB2MjEwLmR0c2kKQEAgLTI1LDYgKzI1LDggQEAKIAogCWFsaWFzZXMgewog
CQljc2lzMCA9ICZjc2lzMDsKKwkJZG1jMCA9ICZkbWMwOworCQlkbWMxID0gJmRtYzE7CiAJCWZp
bWMwID0gJmZpbWMwOwogCQlmaW1jMSA9ICZmaW1jMTsKIAkJZmltYzIgPSAmZmltYzI7CkBAIC01
MjEsNiArNTIzLDE2IEBACiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwogCQl9OwogCisJCWRtYzA6
IGRtY0BmMDAwMDAwMCB7CisJCQljb21wYXRpYmxlID0gInNhbXN1bmcsczVwdjIxMC1kbWMiOwor
CQkJcmVnID0gPDB4ZjAwMDAwMDAgMHgxMDAwPjsKKwkJfTsKKworCQlkbWMxOiBkbWNAZjE0MDAw
MDAgeworCQkJY29tcGF0aWJsZSA9ICJzYW1zdW5nLHM1cHYyMTAtZG1jIjsKKwkJCXJlZyA9IDww
eGYxNDAwMDAwIDB4MTAwMD47CisJCX07CisKIAkJZzJkOiBnMmRAZmEwMDAwMDAgewogCQkJY29t
cGF0aWJsZSA9ICJzYW1zdW5nLHM1cHYyMTAtZzJkIjsKIAkJCXJlZyA9IDwweGZhMDAwMDAwIDB4
MTAwMD47Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
