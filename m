Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4843BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1870620856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cJ7kEjKu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcSrwqY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1870620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=O2KEGkssXM50X9xUYkgdoJdXOF7/lvyaPy7tLJxeeDw=; b=cJ7kEjKuW04l+j
	smmOo19X+MfD9bODGXBF1u1D4kyaWRiqstYMcep31e/YcrXcaVjSCe9wqW5SL/1ZbjqUSVwoOc2y7
	sY0CykGSwh3Cau5HIz/T5W8p/6lwi04+SCL7s2srQZQMD00sZiPmpBHmdZZRj2/ytFi0nO0WnAxCg
	TJQii7uRVsTQ/tDFgbDuYJKEgzkpU0RPcq0ctlNU7Bqwf1+Nq5vD3aypMVQYcOdtteBqltaNXkrDA
	ZHSdyYdEyopOwpSpvDYUacu/sWjz52E4CVhGPcvxBP+GDb0Vt9XFR8kMK0e/dekQx08ZlqMtSFUU5
	rUPNNXICUjCZKgao4njA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcuqT-0004GZ-UU; Fri, 28 Dec 2018 16:18:45 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuqQ-0004EO-Bb
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 16:18:43 +0000
Received: by mail-lj1-x242.google.com with SMTP id t18-v6so19071311ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 08:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C+leDKkBVfjRpoUE44MkXKt8HF9pvwnytOv/e4MMaU8=;
 b=WcSrwqY64z5Sb6TFyFSlJCQlUBLnDE+X8oeeAfM4tmamS4Lh9uQe1jQoWlW7U7R1AK
 vgVcNUyDu4KZ6FkIXLCu7FmfNrRQMD3Zk2NyH/GQT7iDpjxZDGZ2Z2UOAY7fpwx/ka7V
 yaaXr3UsKTFnrUemBUuhHdsA8opySn/Lq7xmYgZJdqYi33I8U4Gp8+PjQJxGc1vToR8B
 /GosPsVzPOC6Sy3fFptbGyYFymAfg0dfMyNbfWZT1U8R4KXjhyik54V0lLX3wbdAQ9ih
 gmlVaKH2khrWFyQImyAc8BSUmiwTonbuAVHhvOE6T7EYK1kUDNami48K1i7KER2ZZHdL
 VoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C+leDKkBVfjRpoUE44MkXKt8HF9pvwnytOv/e4MMaU8=;
 b=mRwZUgnXdAKrYwN71Ej6MoaWmwSKqKN1YUX/QND/mCxBspgJzZ9khJjNAL6M4bjrW/
 CpmLer/t1y0K/z1Y2PopQJ/p3tkWlatDUOd0lSPG4K3hQDBAkAiwopkK8WB0urNVNWyE
 Em5K3ZBvG7uq7Vq0aWDlv38uRkubC7LwNF0PE2F5FLjAuLBFbwpT9vm1aY6PmiOKn6bB
 /9s1YDaud4nAj+dTWOsJdfEXnv/cQEHFnW6YeBIK5Tfc5aQJbzveVQPsA2vihanGgpHY
 tbyb9xb5QtrTUad0a3Kfv6JJD3l7b368F0ychhS1X6Tjrj10BkyqetOHSeRjS0vhachH
 BOLw==
X-Gm-Message-State: AJcUukcMhR/Q2BFvdwi/X+ZF+9Ff/p96Xb8LPFZfYzctUHrqkbnYgPQa
 r898gtsbtsr5Xg7JqBSkkjU=
X-Google-Smtp-Source: ALg8bN7r4F+mBjki6kxhWO46pf+rJxzeohYOsNUr+Rcmz2Pga8Ms1bki4O3aO7GlE5ME1gPr2/XfXw==
X-Received: by 2002:a2e:92ca:: with SMTP id
 k10-v6mr16099242ljh.63.1546013910132; 
 Fri, 28 Dec 2018 08:18:30 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 08:18:29 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH 0/6] ARM: dts: s5pv210: aries: Enable more drivers present on
 Samsung Aries based devices
Date: Fri, 28 Dec 2018 17:18:13 +0100
Message-Id: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_081842_404842_EA6DB000 
X-CRM114-Status: GOOD (  10.04  )
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
 linux-samsung-soc@vger.kernel.org, xc-racer2@live.ca, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org, pawel.mikolaj.chmiel@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaHNldCBlbmFibGVzIG1vcmUgZHJpdmVycyBmb3IgZGV2aWNlcyBwcmVzZW50IG9u
CiBTYW1zdW5nIEFyaWVzIGJhc2VkIGRldmljZXMuCgpGaXJzdCBwYXRjaCBzd2l0Y2hlcyBmaW1k
IHRvIGNvcnJlY3QgdmFyaWFudCwgd2hpY2ggd2Fzbid0CiBwcmVzZW50IGF0IG1vbWVudCBvZiBh
ZGRpbmcgYXJpZXMgZHRzLgoKTmV4dCB0d28gcGF0Y2hlcyByZW1vdmVzIGhhcmRjb2RlZCBib290
YXJncyBmcm9tIGR0cyBmaWxlcwogZm9yIGdhbGF4eXMgYW5kIGZhc2NpbmF0ZTRnLCBiZWNhdXNl
IG5vdyB3ZSBoYXZlIHdvcmtpbmcgYm9vdGxvYWRlcgogd2hpY2ggY2FuIHBhc3MgdGhvc2UgdmFs
dWVzLgoKT25lIG9mIHRoZSBwYXRjaGVzIGFsc28gcmVzZXJ2ZXMgbWVtb3J5IGZvciBTYW1zdW5n
IFM1UCBNRkMKIHZpZGVvIGNvZGVjLCBzbyBpdCdzIHBvc3NpYmxlIHRvIHVzZSBpdC4KCkxhc3Qg
dHdvIHBhdGNoZXMgYWRkcyBhbmQgZW5hYmxlcyBtb3JlIGRyaXZlcnMuCgpKb25hdGhhbiBCYWtr
ZXIgKDEpOgogIEFSTTogZHRzOiBzNXB2MjEwOiBhcmllczogU3VwcG9ydCBmb3IgbW9yZSBkZXZp
Y2VzIHByZXNlbnQgb24gQXJpZXMKClBhd2XFgiBDaG1pZWwgKDUpOgogIEFSTTogZHRzOiBzNXB2
MjEwOiBVc2UgY29ycmVjdCBmaW1kIHZhcmlhbnQKICBBUk06IGR0czogczVwdjIxMDogZ2FsYXh5
czogUmVtb3ZlIGhhcmRjb2RlZCBib290YXJncwogIEFSTTogZHRzOiBzNXB2MjEwOiBmYXNjaW5h
dGU0ZzogUmVtb3ZlIGhhcmRjb2RlZCBib290YXJncwogIEFSTTogZHRzOiBzNXB2MjEwOiBhcmll
czogQWRkIHJlc2VydmVkIG1lbW9yeSBmb3IgbWZjCiAgQVJNOiBkZWZjb25maWc6IHM1cHYyMTA6
IEVuYWJsZSBtb3JlIGRyaXZlcnMgcHJlc2VudCBvbiBTYW1zdW5nIEFyaWVzCgogYXJjaC9hcm0v
Ym9vdC9kdHMvczVwdjIxMC1hcmllcy5kdHNpICAgICAgfCA5MCArKysrKysrKysrKysrKysrKysr
KysrKwogYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1mYXNjaW5hdGU0Zy5kdHMgfCAgNyAtLQog
YXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1nYWxheHlzLmR0cyAgICAgfCAgNyAtLQogYXJjaC9h
cm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpICAgICAgICAgICAgfCAgMiArLQogYXJjaC9hcm0vY29u
Zmlncy9zNXB2MjEwX2RlZmNvbmZpZyAgICAgICAgfCA0MSArKysrKysrKy0tLQogNSBmaWxlcyBj
aGFuZ2VkLCAxMjEgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCgotLSAKMi4xNy4xCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
