Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F77C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:50:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2221720811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NhUFrLmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2221720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iLL6xQK91ko6lnF6xZq4JqqBomlC1/aSMSMiP9eSU9w=; b=NhUFrLmHbE0pWx
	Z658Eim5487tlAgLBFa060V3NtOvG5pMbKV84s9XqV7Ry0zC84gVg+Ht1NZLijfPZrTrQsRdD/pR7
	VJbVMdnCCXGE5vKRI/ZChr6d5Be5LxZSmE0G4K20pqh6+gSKe3QF1iGJ0Pim+UftPkhMfQcRpZ3/B
	bwjqEE6rXkP4Iu43UE3zULz9tbCJgDXZNNaPvi034ytzR723ulUwYUIXH68/ZulHeoOkNP9Q1A7C3
	ls6JIdgfinRgaryJQO7ndNcpjI3k5PRtXqqybDKs/g8Cu7H/dlyyRgGJRFLICN3VyMTyjWddVxM2x
	1URs2rCLFy+qgZpm8NGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUX0-0003bM-UX; Fri, 01 Feb 2019 08:50:38 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUWP-0001rR-Rr
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:50:09 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id BB28EFB04;
 Fri,  1 Feb 2019 09:49:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BUkYdQNW3bmw; Fri,  1 Feb 2019 09:49:55 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 77417461BC; Fri,  1 Feb 2019 09:49:55 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Sam Ravnborg <sam@ravnborg.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 0/3] Mixel DPHY support for i.MX8
Date: Fri,  1 Feb 2019 09:49:52 +0100
Message-Id: <cover.1549010639.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_005002_268377_7FF79378 
X-CRM114-Status: GOOD (  11.42  )
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
ZSBuZWNlc3NhcnkgcGFydHMgYXJlIGluIC0gdmlhIHRoZSBwcm92aWRlZCBkZXZkYXRhLgpUaGUg
ZHJpdmVyIGlzIHNvbWV3aGF0IGJhc2VkIG9uIHdoYXQncyBmb3VuZCBpbiBOWFBzIEJTUC4KCkRv
Y3VtZW50YXRpb24gb24gdGhlIERQSFkncyByZWdpc3RlcnMgaXMgY3VycmVudGx5IHRoaW4gaW4g
dGhlIGkuTVg4IHJlZmVyZW5jZQptYW51YWxzIChldmVuIG9uIHRoZSBpLk1YOFFYUCBmb3JtIDEx
LzE4KSBzbyBtb3N0IG9mIHRoZSB2YWx1ZXMgd2VyZSB0YWtlbiBmcm9tCmV4aXN0aW5nIGRyaXZl
cnMuIE5ld2VyIE5YUCBkcml2ZXJzIGhhdmUgYSBiaXQgbW9yZSBkZXRhaWxzIHNvIHdoZXJlIHBv
c3NpYmxlCnRoZSB0aW1pbmdzIGFyZSBjYWxjdWxhdGVkIGFuZCB2YWxpZGF0ZWQuCgpUaGlzIGlz
IGJhc2VkIG9uIGxpbnV4LW5leHQgYXMgb2YgMjAxOS0wMS0yNSBhbmQgTWF4aW1lIFJpcGFyZCdz
IGRwaHkKY29uZmlndXJhdGlvbiBoZWxwZXIgcGF0Y2hlcyB3aGljaCB3b3VsZCBuZWVkIHRvIGdv
IGluIGZpcnN0LgoKVG8gZ2V0IERTSSB3b3JraW5nIG9uIHRoZSBpbXg4TVEgdGhlcmUncyBhIGRy
aXZlciBmb3IgdGhlIG53bCBkc2kgaG9zdApjb250cm9sbGVyIG1pc3Npbmcgd2hpY2ggSSBpbnRl
bmQgdG8gbG9vayBhdCB0b28uCgpDaGFuZ2VzIGZyb20gdjEKKiBBcyBwZXIgcmV2aWV3IGNvbW1l
bnRzIGZyb20gRmFiaW8gRXN0ZXZhbQogICogS2NvbmZpZzogdHJpc3RhdGUgbWl4ZWwgZHBoeSBz
dXBwb3J0LgogICogRHJvcCB1bnVzZWQgJ3JldCcgaW4gbWl4ZWxfZHBoeV9yZWZfcG93ZXJfb2Zm
LgogICogTWF0Y2ggdmFsdWVzIG9mIERQSFlfUlhMe1BSUCxEUlB9IHRvIHRob3NlIG9mCiAgICBo
dHRwczovL3NvdXJjZS5jb2RlYXVyb3JhLm9yZy9leHRlcm5hbC9pbXgvbGludXgtaW14L2xvZy8/
aD1pbXhfNC4xNC43OF8xLjAuMF9nYQogICAgVGhlIHByZXZpb3VzIHZhbHVlcyB3ZXJlIGJhc2Vk
IG9uIDQuOS4KICAqIFVzZSByZXNvdXJjZSBzaXplIG9uIGRldm1faW9yZW1hcCwgd2UgaGF2ZSB0
aGF0IGluIGR0IGFscmVhZHkuCiAgKiBVc2UgcmVnbWFwIHNvIGl0J3Mgc2ltcGxlIHRvIGR1bXAg
dGhlIHJlZ2lzdGVycy4KICAqIFVzZSByZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQgaW5zdGVhZCBv
ZiBvcGVuIGNvZGVkIGxvb3AuCiAgKiBBZGQgdW5kb2N1bWVudGVkIHJ4aHNfc2V0dGxlIHJlZ2lz
dGVyCiogQXMgcGVyIHJldmlldyBjb21tZW50cyBmcm9tIFNhbSBSYXZuYm9yZwogICogTW92ZSBk
cml2ZXIgdG8gZC9waHkvZnJlZXNjYWxlLwogICogTW92ZSBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
ciB0byB0b3Agb2YgZmlsZS4KICAqIERyb3AgJy8qICNkZWZpbmUgREVCVUcgMSAqLycuCiAgKiBV
c2UgR1BMLTIuMCsgc2luY2UgdGhlIHZlbmRvciBkcml2ZXIgdXNlcyB0aGF0IGFzIHdlbGwuCiAg
KiBEcm9wIHRoZSBtdXRleCwgcmVnaXN0ZXIgYWNjZXNzIGlzIG5vdyBwcm90ZWN0ZWQgYnkgcmVn
bWFwLgogICogRml4IHZhcmlvdXMgc3R5bGUgLyBpbmRlbnRhdGlvbiBpc3N1ZXMuCiogQ2hlY2sg
Zm9yIHJlZ2lzdGVyIHJlYWQsIHdyaXRlIGFuZCBpb3JlbWFwIGVycm9ycwoqIEltcHJvdmUgcGh5
IHRpbWluZyBjYWxjdWxhdGlvbnMKICAqIFVzZSBMUCBjbG9jayByYXRlIHdoZXJlIHNlbnNpYmxl
LCBjaGVjayBmb3IgZXJyb3JzCiAgKiBVc2UgYWQgaG9jIGZvcnVtdWxhcyBmb3IgdGltaW5ncyBp
bnZvbHZpbmcgaHMgY2xvY2sKKiBTd2l0Y2ggZnJvbSBkcGh5X29wcyB0byBkZXZkYXRhLiBPdGhl
ciBpLk1YOCB2YXJpYW50cwogIGRpZmZlciBpbiByZWdpc3RlciBsYXlvdXQgdG9vCiogQWRkIE1p
eGVsIEluYyB0byB2ZW5kb3ItcHJlZml4ZXMudHh0CgpHdWlkbyBHw7xudGhlciAoMyk6CiAgZHQt
YmluZGluZ3M6IEFkZCB2ZW5kb3IgcHJlZml4IGZvciBNaXhlbCBJbmMKICBkdC1iaW5kaW5nczog
cGh5OiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgbWl4ZWwgZHBoeQogIHBoeTogQWRkIGRyaXZlciBm
b3IgbWl4ZWwgZHBoeSBmb3VuZCBvbiBpbXg4CgogLi4uL2JpbmRpbmdzL3BoeS9taXhlbCxtaXBp
LWRzaS1waHkudHh0ICAgICAgIHwgIDI5ICsKIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRv
ci1wcmVmaXhlcy50eHQgICB8ICAgMSArCiBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgfCAgIDkgKwogZHJpdmVycy9waHkvZnJlZXNjYWxlL01ha2VmaWxlICAg
ICAgICAgICAgICAgIHwgICAxICsKIC4uLi9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OC1taXBp
LWRwaHkuYyAgICB8IDQ5NCArKysrKysrKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNTM0
IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGh5L21peGVsLG1pcGktZHNpLXBoeS50eHQKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4LW1pcGktZHBoeS5jCgotLSAKMi4y
MC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
