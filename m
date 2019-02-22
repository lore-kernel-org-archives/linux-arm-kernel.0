Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9835FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB5A2077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a+yNrKOc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4nl0W25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB5A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KYAncA5X0TZNWejT8eW5CMXOoTnH0ojy++olnxAOzsI=; b=a+yNrKOcMpQ4Jf
	umyjZVJhYujYXMu9MOfBcmGnoHZ7KClbPsLet1DQT3EBBbZRvfVwnxHi9ZHaOflj3Wt6JhFVD7ywv
	NgzuLkDNGNkw1IIB4Z8k34oDb2iq1+eIME5CK1NPX+6h4CKtY4duBu6Q7TCmKRYhv1zruG195gTpa
	Kq1xiaM1T3tVLQDv49nB+tGr9n72CynB/NfAyYmDETq78zqo0OTk5XT7eWwq8MyATEGSTgVANUlkF
	YkllnOgHuqHylPWp9JJUGmu1jIV7wPjYJI/QD+gph6yt2afRcc6kHCXm0daAtGNC/eRe7//rvW4gU
	17Z7PGY87PZqIJv8I6zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFBd-0006lO-HO; Fri, 22 Feb 2019 18:04:37 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFBX-0006j8-NL
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:04:35 +0000
Received: by mail-lj1-x242.google.com with SMTP id z20so2372851ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wJIfcNgdLwIOQgBq8MfHDWHd4OU+U5junDQOmjo7ne8=;
 b=U4nl0W25kjXAqzkYHIbSN0n/W8/x8GX5UgACZqpahcEb8Hak9t7bR/1iNs6lVzEWSo
 X5wWQ98QDBHwxKNofEUAovpjuToCDyiYDm3SKuuXvyGDGkHhAw9e7fhX1oY0lZriFkxh
 XyGc+I1pdkXebyadO6YkzQrNqSI8ghS3Q1OBfInl0qvaKI5dn+As6dw5vbeCy55pyvDs
 r8Zmrl1Zi/bCpbD58FBq6rWPIOEq7AygTloR5edQlKjNhSXie/FHBZ/QMUN0ISh7ip3k
 dnlEBWZ6ktpOqyUDPKW0NBCMKHtCec6jftG2YgDLqxne6ppf4uEop9uwIgnLb/Zp/SbF
 l2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wJIfcNgdLwIOQgBq8MfHDWHd4OU+U5junDQOmjo7ne8=;
 b=nXjwp0uuXCBqrglvV2HLwCGOSeUJKTU2cVWPfT5KXMF9gWKABiDs8EmBXEA2G+Bu1t
 vkYT4qN+3OrEVkKOBBTzx0uZHYVVH/5V6QYUwgzCkCE/ASZs6goR+m1rDWJaH7cXJTvZ
 vHG382wubkX2cYR3ZuWmj/vP1E8Cz13hfzHO19iAmptsgweZQZ9t3hhQiYncIGlrywxR
 3HSB6Z3h4ZRZhoQZKOABdR1B3musUFU9uK1d9vQkbys1hBZuwsL8HRdEDQPT+bC2293o
 dmnPYgLNQZFHLkegVxs877FjlAgrda7NqczvP1hF5P64hOZ6TYOYLrj1PfcmN8v9W7DW
 rQ4Q==
X-Gm-Message-State: AHQUAuZxxaO7aEZ/3AKPLROUfK4gG1quJOeuZZ97GqPLGdJGhwI1idOm
 RI2RJ01D23P8lH15SExmsAQ=
X-Google-Smtp-Source: AHgI3IZ7h0ngBjkJPtkp453YXg2cpHpft3qtKxSzFnOnhfwqVJHuR2K01nDXgpH/hGsO+ULFvak2dA==
X-Received: by 2002:a2e:9a95:: with SMTP id p21mr2835278lji.127.1550858669304; 
 Fri, 22 Feb 2019 10:04:29 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 10:04:28 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v5 0/8] Support Trusted Foundations firmware on Tegra30
Date: Fri, 22 Feb 2019 20:59:18 +0300
Message-Id: <20190222175926.23366-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100431_782830_D250F4A8 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpUaGlzIHBhdGNoc2V0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIFRydXN0ZWQgRm91bmRh
dGlvbnMgZmlybXdhcmUgb24KTlZJRElBIFRlZ3JhMzAuIFByZXR0eSBtdWNoIGFsbCBvZiBUZWdy
YTMwIGNvbnN1bWVyIGRldmljZXMgaGF2ZSB0aGF0CmZpcm13YXJlIGFuZCB1cHN0cmVhbSBrZXJu
ZWwgY2FuJ3QgYm9vdCBvbiB0aG9zZSBkZXZpY2VzIHdpdGhvdXQgdGhlCmZpcm13YXJlIHN1cHBv
cnQuCgpDaGFuZ2Vsb2c6Cgp2NTogICAgIC0gRml4ZWQgbWFjaGluZSBoYW5naW5nIG9uIGRpc2Fi
bGluZyBELWNhY2hlIGR1cmluZyBzdXNwZW5kLAogICAgICAgICAgdHVybmVkIG91dCB0aGVyZSBh
cmUgc2xpZ2h0IHZhcmlhdGlvbnMgaW4gYmVoYXZpb3VyIGJldHdlZW4KICAgICAgICAgIGZpcm13
YXJlIHZlcnNpb24gaW4gcmVnYXJkcyB0byBjYWNoZS1tYW5hZ2VtZW50LiBUaGFua3MgdG8KICAg
ICAgICAgIFJvYmVydCBZYW5nIGZvciByZXBvcnRpbmcgdGhlIHByb2JsZW0gYW5kIGhlbHBpbmcg
d2l0aCB0aGUKICAgICAgICAgIHNvbHV0aW9uLgoKdjQ6ICAgICAtIEZpeGVkIFRodW1iMi1rZXJu
ZWwgaGFuZ2luZyBvbiBUZWdyYTIwLCB0dXJuZWQgb3V0IGl0IHdhcyBub3QgYQogICAgICAgICAg
Z29vZCBpZGVhIHRvIHN3aXRjaCBDUFUgaW50byBUaHVtYjIgbW9kZSByaWdodCBhZnRlciBqdW1w
aW5nIGludG8KICAgICAgICAgIHRoZSByZXNldCBoYW5kbGVyLgoKICAgICAgICAtIE1vdmVkIExQ
Mi1tb2RlLXNldCBmaXJtd2FyZSBjYWxsIGludm9jYXRpb24gdG8gYSBsYXRlciBzdGFnZSB0bwog
ICAgICAgICAgYmV0dGVyIHJlcGxpY2F0ZSB3aGF0IGRvd25zdHJlYW0ga2VybmVsIGRvZXMuIFRo
aXMgY2hhbmdlIHdhcwogICAgICAgICAgc3VnZ2VzdGVkIGJ5IFJvYmVydCBZYW5nIGFuZCBmaXhl
cyBzeXN0ZW0gaGFuZyBvbiBPdXlhIGdhbWUKICAgICAgICAgIGNvbnNvbGUuCgogICAgICAgIC0g
QWRkZWQgcmVmZXJlbmNlcyB0byB0aGUgb3JpZ2luYWwgd29yayBtYWRlIGJ5IE1pY2hhxYIgTWly
b3PFgmF3CiAgICAgICAgICBpbnRvIGNvbW1pdCBtZXNzYWdlcyBvZiB0aGUgcmVsZXZhbnQgcGF0
Y2hlcy4KCnYzOiAgICAgLSBJbXBsZW1lbnRlZCBzdXNwZW5kLXJlc3VtZSBzdXBwb3J0LgoKICAg
ICAgICAtIFJld29ya2VkIGFybS9maXJtd2FyZS90cnVzdGVkX2ZvdW5kYXRpb25zLmMgYSB0YWQu
IE5vdyBjYWNoZQogICAgICAgICAgaXMgZ2V0dGluZyBwcm9wZXJseSBpbml0aWFsaXplZCwgY2Fj
aGUgZW5hYmxpbmcgLyBkaXNhYmxpbmcgaXMKICAgICAgICAgIHN1cHBvcnRlZC4KCnYyOgogICAg
ICAgIC0gVGhlICJEb24ndCBhcHBseSBDUFUgZXJyYXRhcyBpbiBpbnNlY3VyZSBtb2RlIiBwYXRj
aCBnb3Qgc29tZQogICAgICAgICAgY2xlYW51cCwgaW4gcGFydGljdWxhciByZXNvbHZlZCB0aGUg
bWVzc2luZXNzIGluCiAgICAgICAgICBfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX2RhdGEuCgog
ICAgICAgIC0gQWRkZWQgYSBjb21tZW50IHRvIHRmX2NhY2hlX3dyaXRlX3NlYygpLCBqdXN0aWZ5
aW5nIHRoZSB3YXJuaW5nCiAgICAgICAgICBtZXNzYWdlLgoKRG1pdHJ5IE9zaXBlbmtvICg4KToK
ICBBUk06IHRydXN0ZWRfZm91bmRhdGlvbnM6IEltcGxlbWVudCBMMiBjYWNoZSBpbml0aWFsaXph
dGlvbiBjYWxsYmFjawogIEFSTTogdHJ1c3RlZF9mb3VuZGF0aW9uczogTWFrZSBwcmVwYXJlX2lk
bGUgY2FsbCB0byB0YWtlIG1vZGUgYXJndW1lbnQKICBBUk06IHRydXN0ZWRfZm91bmRhdGlvbnM6
IFByb3ZpZGUgaW5mb3JtYXRpb24gYWJvdXQgd2hldGhlciBmaXJtd2FyZQogICAgaXMgcmVnaXN0
ZXJlZAogIEFSTTogdGVncmE6IFNldCB1cCBMMiBjYWNoZSB1c2luZyBUcnVzdGVkIEZvdW5kYXRp
b25zIGZpcm13YXJlCiAgQVJNOiB0ZWdyYTogRG9uJ3QgYXBwbHkgQ1BVIGVycmF0YXMgaW4gaW5z
ZWN1cmUgbW9kZQogIEFSTTogdGVncmE6IEFsd2F5cyBib290IENQVSBpbiBBUk0tbW9kZQogIEFS
TTogdGVncmE6IFN1cHBvcnQgTDIgY2FjaGUgbWFpbnRlbmFuY2UgZG9uZSB2aWEgZmlybXdhcmUK
ICBBUk06IHRlZ3JhOiBBZGQgZmlybXdhcmUgY2FsbHMgcmVxdWlyZWQgZm9yIHN1c3BlbmQtcmVz
dW1lCgogYXJjaC9hcm0vZmlybXdhcmUvdHJ1c3RlZF9mb3VuZGF0aW9ucy5jICAgIHwgODAgKysr
KysrKysrKysrKysrKysrKysrLQogYXJjaC9hcm0vaW5jbHVkZS9hc20vZmlybXdhcmUuaCAgICAg
ICAgICAgIHwgIDIgKy0KIGFyY2gvYXJtL2luY2x1ZGUvYXNtL3RydXN0ZWRfZm91bmRhdGlvbnMu
aCB8IDEzICsrKysKIGFyY2gvYXJtL21hY2gtdGVncmEvY3B1aWRsZS10ZWdyYTExNC5jICAgICB8
ICAzICstCiBhcmNoL2FybS9tYWNoLXRlZ3JhL3BtLmMgICAgICAgICAgICAgICAgICAgfCA0OSAr
KysrKysrKysrKysrCiBhcmNoL2FybS9tYWNoLXRlZ3JhL3Jlc2V0LWhhbmRsZXIuUyAgICAgICAg
fCA1MCArKysrKysrKysrKy0tLQogYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC5jICAgICAgICAg
ICAgICAgIHwgIDMgKwogYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC5oICAgICAgICAgICAgICAg
IHwgIDkgKystCiBhcmNoL2FybS9tYWNoLXRlZ3JhL3NsZWVwLXRlZ3JhMjAuUyAgICAgICAgfCAg
NCArKwogYXJjaC9hcm0vbWFjaC10ZWdyYS9zbGVlcC5TICAgICAgICAgICAgICAgIHwgMTQgKyst
LQogYXJjaC9hcm0vbWFjaC10ZWdyYS90ZWdyYS5jICAgICAgICAgICAgICAgIHwgMTAgKysrCiAx
MSBmaWxlcyBjaGFuZ2VkLCAyMTUgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCgotLSAK
Mi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
