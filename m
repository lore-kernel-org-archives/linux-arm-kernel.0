Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A95C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:13:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EFA21906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AFZOe2I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EFA21906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BUVqD/FrMqOWJ24VhQZP7w2ii3QzIQLvMDBPJ1UZB1g=; b=AFZOe2I5MWI5e7
	h+r894kxtRXhNngzglopUgLaORA47MN/ix5VZvNHjJHpB2jUf5QOrbF895r9mM66IB5ygPHDFimD1
	r5lCwEdHSzPye0tcv+cIKbdjl3xdRjjbzoUEKr7qM37WiyFsbTTBReo6yg/6gDYH5Lj2235B5vnO+
	iqAX6FKnusud5HuQ5/sOOU2fMbdtdofHcjLGXBnwXOzXt9QrBo44mSlr6wS4WyV/FRj/8+eO/DTWO
	ZV8OOm2H6jXnu88VD1s33+kufAKAKXYhGV7al/Tr/RLz5dfUVxNEmOw2Dajpvgi+qI7z5BEYlKFqj
	8zNvFTQJdMhRw+1C0bXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaPIT-0006ed-76; Fri, 21 Dec 2018 18:13:17 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaPHj-0005xm-Dp
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 18:12:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 280CA1596;
 Fri, 21 Dec 2018 10:12:28 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDD653F575;
 Fri, 21 Dec 2018 10:12:26 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] ARM: dts: am437x: replace linux,
 wakeup with wakeup-source property
Date: Fri, 21 Dec 2018 18:12:20 +0000
Message-Id: <20181221181220.6877-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_101232_217571_F33F998C 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TW9zdCBvZiB0aGUgbGVnYWN5ICJsaW51eCx3YWtldXAiIGJvb2xlYW4gcHJvcGVydHkgaXMgYWxy
ZWFkeSByZXBsYWNlZAp3aXRoICJ3YWtldXAtc291cmNlIi4gSG93ZXZlciBmZXcgb2NjdXJyZW5j
ZXMgb2Ygb2xkIHByb3BlcnR5IGhhcyBwb3BwZWQKdXAgYWdhaW4sIHByb2JhYmx5IGZyb20gdGhl
IHJlbW5hbnRzIGluIGRvd25zdHJlYW0gdHJlZXMuCgpSZXBsYWNlIHRoZSBsZWdhY3kgcHJvcGVy
dGllcyB3aXRoIHRoZSB1bmlmaWVkICJ3YWtldXAtc291cmNlIiBwcm9wZXJ0eQppbnRyb2R1Y2Vk
IGluIHRoZSBjb21taXQgYWVkYTUwMDNkMGI5ICgiSW5wdXQ6IG1hdHJpeF9rZXlwYWQgLSBjaGFu
Z2UKbmFtZSBvZiB3YWtldXAgcHJvcGVydHkgdG8gIndha2V1cC1zb3VyY2UiIikKCkNjOiAiQmVu
b8OudCBDb3Vzc29uIiA8YmNvdXNzb25AYmF5bGlicmUuY29tPgpDYzogVG9ueSBMaW5kZ3JlbiA8
dG9ueUBhdG9taWRlLmNvbT4KQ2M6IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnClNpZ25lZC1v
ZmYtYnk6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+Ci0tLQogYXJjaC9hcm0v
Ym9vdC9kdHMvYW00Mzd4LWdwLWV2bS5kdHMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9h
bTQzN3gtZ3AtZXZtLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FtNDM3eC1ncC1ldm0uZHRzCmlu
ZGV4IGY0YTIwY2FkZTgwOC4uNGM2ZWUzN2VhNTczIDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290
L2R0cy9hbTQzN3gtZ3AtZXZtLmR0cworKysgYi9hcmNoL2FybS9ib290L2R0cy9hbTQzN3gtZ3At
ZXZtLmR0cwpAQCAtNzEsNyArNzEsNyBAQAogCQlwaW5jdHJsLTAgPSA8Jm1hdHJpeF9rZXlwYWRf
ZGVmYXVsdD47CiAJCXBpbmN0cmwtMSA9IDwmbWF0cml4X2tleXBhZF9zbGVlcD47CgotCQlsaW51
eCx3YWtldXA7CisJCXdha2V1cC1zb3VyY2U7CgogCQlyb3ctZ3Bpb3MgPSA8JmdwaW8wIDMgR1BJ
T19BQ1RJVkVfSElHSCAvKiBCYW5rMCwgcGluMyAqLwogCQkJCSZncGlvNCAzIEdQSU9fQUNUSVZF
X0hJR0ggLyogQmFuazQsIHBpbjMgKi8KLS0KMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
