Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:55:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BC3214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jn1lKAN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BC3214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B+nz4VpTMcklFFLTMc5PTGhTspIbjXZ6rZDJs8ZAD0c=; b=Jn1lKAN72091bR
	M0ReSvFvHJv1MY38BmSM7ZJaUSivk8V4XDOy+LfiilCHveKtXTlwYQZfEtJUVQzqqfYyykNl7q8sa
	8gZDp7ftmgaqq7T3UxRNJuqfNPNaH0BJ8GIKDq5VAhd3/0hsofngNlmwQETtBBwqcqm9A5GYbCxbc
	Sr6xY0DlpBK2a9mNB+6aMmcM4w4k7JbnL5iJHRCvVj45zV/4zpbLBDGoVN2B6m67zU2Z3ySIul9z8
	uHEiQSNlB43lkyHmtITTGxQzT4cu72P4JjkIukIHXEFaiWUYpihy7KbAH+7bASB6mGoctXuYutenO
	WPl7X9OOZxBEwRAFGWvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvzm-0001yH-JI; Thu, 06 Dec 2018 15:55:22 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvzj-0000zg-7x
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:55:20 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9B418207A8; Thu,  6 Dec 2018 16:55:06 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4BA9520745;
 Thu,  6 Dec 2018 16:55:06 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] arm64: dts: clearfog-gt-8k: describe mini-PCIe CON2 USB
References: <634478cc2f11ea3ee3b89393ae6d82f39d3c8531.1544095149.git.baruch@tkos.co.il>
Date: Thu, 06 Dec 2018 16:55:05 +0100
In-Reply-To: <634478cc2f11ea3ee3b89393ae6d82f39d3c8531.1544095149.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Thu, 6 Dec 2018 13:19:09 +0200")
Message-ID: <87tvjqveee.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075519_413496_D6BA048A 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmFydWNoLAogCiBPbiBqZXUuLCBkw6ljLiAwNiAyMDE4LCBCYXJ1Y2ggU2lhY2ggPGJhcnVj
aEB0a29zLmNvLmlsPiB3cm90ZToKCj4gRW5hYmxlIHRoZSBVU0IzIHBlcmlwaGVyYWwgdGhhdCBp
cyB3aXJlZCB0byBDT04yIG9uIHRoZSBDbGVhcmZvZyBHVC04Swo+IGJvYXJkLgo+Cj4gU2lnbmVk
LW9mZi1ieTogQmFydWNoIFNpYWNoIDxiYXJ1Y2hAdGtvcy5jby5pbD4KPiAtLS0KPiAgYXJjaC9h
cm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWNsZWFyZm9nLWd0LThrLmR0cyB8IDQg
KysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWNsZWFyZm9nLWd0LThrLmR0
cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC1jbGVhcmZvZy1ndC04
ay5kdHMKPiBpbmRleCBkZmIyNjY2MWE4OGUuLjViNGE5NjA5ZTMxZiAxMDA2NDQKPiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAtY2xlYXJmb2ctZ3QtOGsuZHRz
Cj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWNsZWFyZm9n
LWd0LThrLmR0cwo+IEBAIC0yODIsNiArMjgyLDEwIEBACj4gIAl2cW1tYy1zdXBwbHkgPSA8JnZf
M18zPjsKPiAgfTsKPiAgCj4gKyZjcDBfdXNiM18xIHsKCkRvbid0IHlvdSBoYXZlIGFueSBwaHkg
Zm9yIHRoaXMgVVNCMyBwb3J0PwoKR3JlZ29yeQoKPiArCXN0YXR1cyA9ICJva2F5IjsKPiArfTsK
PiArCj4gICZjcDFfcGluY3RybCB7Cj4gIAkvKgo+ICAJICogTVBQIEJ1czoKPiAtLSAKPiAyLjE5
LjIKPgoKLS0gCkdyZWdvcnkgQ2xlbWVudCwgQm9vdGxpbgpFbWJlZGRlZCBMaW51eCBhbmQgS2Vy
bmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9ib290bGluLmNvbQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
