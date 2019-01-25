Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63310C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:15:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C4A2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DOhYbEUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C4A2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5EdLiLUnRVIOOja90IQqO84JEznnsbWH3bllzBaPyJk=; b=DOhYbEUZA9bi5q
	zC/w5jivJVOI4Ae1yAlorZX4fGyGqlPu7mHbMYQtqwZhH1DqeCq1PUIK5MEZ0sFbawWB01gfyNaOW
	f7kZjtFOLQ4Yh2EHeNcR6o0LKkFyJG9G7qYTvS8X32fatDxjSxDFYSLgyCEnkXGDXczyR1LQBAYYD
	2ImQnfn0VevHazyZLFemjofa2wq6fXB2r/QJbnn6BWqy/obI8gDS4Esb1YPEpSpXW6RTEuRAico1V
	EW1njdU+/oAyYKcbEE6Pq2NyTJFpV3ezuAFijmtQplJW5AKXmM+4+0/2IkVtCSOtGm1Lt2XKZCDs1
	+UJFhu9UivNV3GWO/gZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyVk-0000YE-9e; Fri, 25 Jan 2019 10:14:56 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmyVg-0000XL-Pw
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:14:54 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 63FE5FB05;
 Fri, 25 Jan 2019 11:14:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lvhEzASPiFPx; Fri, 25 Jan 2019 11:14:47 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id DE2A448FC4; Fri, 25 Jan 2019 11:14:46 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH 0/2] RFC: Mixel DPHY support for i.MX8
Date: Fri, 25 Jan 2019 11:14:44 +0100
Message-Id: <cover.1548410989.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_021453_000515_141E4C4D 
X-CRM114-Status: UNSURE (   9.53  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBhZGRzIGluaXRpYWwgc3VwcG9ydCBmb3IgdGhlIE1peGVsIElQIGJhc2VkIG1pcGkgZHBo
eSBhcyBmb3VuZCBvbiBpLk1YOApwcm9jZXNzb3JzLiAgSXQgaGFzIHN1cHBvcnQgZm9yIHRoZSBp
Lk1YOE1RLCBzdXBwb3J0IGZvciBvdGhlciB2YXJpYW50cyBjYW4gYmUKYWRkZWQgLSBvbmNlIHRo
ZSBuZWNlc3NhcnkgcGFydHMgYXJlIGluIC0gdmlhIHRoZSBwcm92aWRlZCBob29rcy4KVGhlIGRy
aXZlciBpcyBzb21ld2hhdCBiYXNlZCBvbiB3aGF0J3MgZm91bmQgaW4gTlhQcyBCU1AuCgpEb2N1
bWVudGF0aW9uIG9uIHRoZSBEUEhZJ3MgcmVnaXN0ZXJzIGlzIGN1cnJlbnRseSB0aGluIGluIHRo
ZSBpLk1YOCByZWZlcmVuY2UKbWFudWFscyAoZXZlbiBvbiB0aGUgaS5NWDhRWFAgZm9ybSAxMS8x
OCkgc28gbW9zdCBvZiB0aGUgdmFsdWVzIHdlcmUgdGFrZW4gZnJvbQpleGlzdGluZyBkcml2ZXJz
LgoKVGhpcyBpcyBiYXNlZCBvbiBsaW51eC1uZXh0IGFzIG9mIDIwMTktMDEtMjEgYW5kIE1heGlt
ZSBSaXBhcmQncyBkcGh5CmNvbmZpZ3VyYXRpb24gaGVscGVyIHBhdGNoZXMgd2hpY2ggd291bGQg
bmVlZCB0byBnbyBpbiBmaXJzdC4KClRvIGdldCBEU0kgd29ya2luZyBvbiB0aGUgaW14OE1RIHRo
ZXJlJ3MgYSBkcml2ZXIgZm9yIHRoZSBud2wgZHNpIGhvc3QKY29udHJvbGxlciBtaXNzaW5nIHdo
aWNoIEkgaW50ZW5kIHRvIGxvb2tpbmcgYXQgdG9vLgoKR3VpZG8gR8O8bnRoZXIgKDIpOgogIGR0
LWJpbmRpbmdzOiBwaHk6IEFkZCBkb2N1bWVudGF0aW9uIGZvciBtaXhlbCBkcGh5CiAgcGh5OiBB
ZGQgZHJpdmVyIGZvciBtaXhlbCBkcGh5CgogLi4uL2JpbmRpbmdzL3BoeS9taXhlbCxtaXBpLWRz
aS1waHkudHh0ICAgICAgIHwgIDI5ICsrCiBkcml2ZXJzL3BoeS9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDcgKwogZHJpdmVycy9waHkvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMvcGh5L3BoeS1taXhlbC1taXBpLWRwaHkuYyAg
ICAgICAgICAgICB8IDQ0OSArKysrKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgNDg2
IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGh5L21peGVsLG1pcGktZHNpLXBoeS50eHQKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL3BoeS9waHktbWl4ZWwtbWlwaS1kcGh5LmMKCi0tIAoyLjIwLjEKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
