Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D21C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:54:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5915720857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hl6Nnmaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5915720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qEpvOWhBe6WI50wrYqNx7awBGLP4H+TxTQ52QCl5vQY=; b=Hl6NnmajFgbLcp
	2tloFX8DBZVyJCReShu3IXuNuMLY9rvvgUgco0doXzp5y/E6mTgvNs225XhUv/XqpwLlKxd+Vh0Q4
	tFyKA7t7HASr3DP0wzSXdxate+qebu9RPkT6YlGjT/bL7QxDKy41Yx3IHgVcP/f68IytwN62cMyHa
	zZrrYrHMl5vF8QUAKd/SApxGKfx29TRFwR/D61TtH8987knSWyevIU6VxLIhhlI0kCyn9GIEX2fj0
	D+uEv+z5it85WlLUNP0HTvt7HyNO17Z2eR/VkI4Zjhz0DLJisQEx0MZw8lqTweGW/9ot5BdEOQ+M2
	+PyTC8iCJG8faqkBcbTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4k2-0000ab-BE; Fri, 08 Feb 2019 11:54:46 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4jo-0000Lt-8U
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:54:34 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id CC97CFB03;
 Fri,  8 Feb 2019 12:54:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M288rw8xnDf3; Fri,  8 Feb 2019 12:54:28 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 8181A43F22; Fri,  8 Feb 2019 12:54:27 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Sam Ravnborg <sam@ravnborg.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 0/3] Mixel DPHY support for i.MX8
Date: Fri,  8 Feb 2019 12:54:24 +0100
Message-Id: <cover.1549626136.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_035432_459602_637EE44C 
X-CRM114-Status: GOOD (  11.24  )
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
IGRwaHkKY29uZmlndXJhdGlvbiBoZWxwZXIgd2hpY2ggaGF2ZSBub3cgYmVlbiBtZXJnZWQuCgpU
byBnZXQgRFNJIHdvcmtpbmcgb24gdGhlIGlteDhNUSB0aGVyZSdzIGEgZHJpdmVyIGZvciB0aGUg
bndsIGRzaSBob3N0CmNvbnRyb2xsZXIgbWlzc2luZyB3aGljaCBJIGludGVuZCB0byBsb29rIGF0
IHRvby4KCkNoYW5nZXMgZnJvbSB2MgoqIEFzIHBlciByZXZpZXcgY29tbWVudHMgZnJvbSBGYWJp
byBFc3RldmFtCiAgKiBLQ29uZmlnOiBzZWxlY3QgUkVHTUFQX01NSU8KICAqIERyb3AgcGh5X3Jl
YWQKICAqIERvbid0IG1ha2UgcGh5X3dyaXRlIGlubGluZQogICogUmVtb3ZlIGR1cGxpY2F0ZSBk
ZWJ1Z2dpbmcgb3V0cHV0CiAgKiBDb21tZW50IHN0eWxlIGFuZCB0eXBvIGZpeGVzCiAgKiBBZGQg
I2RlZmluZXMncyBmb3IgUExMIGxvY2sgdGltaW5nIHZhbHVlcwogICogUmV0dXJuIGNvcnJlY3Qg
ZXJyb3IgdmFsdWUgd2hlbiBQTEwgZmFpbHMgdG8gbG9jawogICogQ2hlY2sgZXJyb3Igd2hlbiBl
bmFibGluZyBjbG9jawogICogVXNlIGRldm1faW9yZW1hcF9yZXNvdXJjZQoqIEFzIHBlciByZXZp
ZXcgY29tbWVudHMgZnJvbSBSb2JlcnQgQ2hpcmFzCiAgKiBEZWFzc2VydCBQRF9EUEhZIGFmdGVy
IFBMTCBsb2NrIChhcyBwZXIgbWl4ZWwgcmVmIG1hbnVhbCkKICAqIEFzc2VydCBQRF97RFBIWSxQ
TEx9IGJlZm9yZSBwb3dlciBvbiAoYXMgcGVyIG1peGVsIHJlZiBtYW51YWwpbWFudWFsCiogQWRk
IGV4aXQgcGh5X29wIHRvIHJlc2V0IENOL0NNL0NPCgpDaGFuZ2VzIGZyb20gdjEKKiBBcyBwZXIg
cmV2aWV3IGNvbW1lbnRzIGZyb20gRmFiaW8gRXN0ZXZhbQogICogS2NvbmZpZzogdHJpc3RhdGUg
bWl4ZWwgZHBoeSBzdXBwb3J0LgogICogRHJvcCB1bnVzZWQgJ3JldCcgaW4gbWl4ZWxfZHBoeV9y
ZWZfcG93ZXJfb2ZmLgogICogTWF0Y2ggdmFsdWVzIG9mIERQSFlfUlhMe1BSUCxEUlB9IHRvIHRo
b3NlIG9mCiAgICBodHRwczovL3NvdXJjZS5jb2RlYXVyb3JhLm9yZy9leHRlcm5hbC9pbXgvbGlu
dXgtaW14L2xvZy8/aD1pbXhfNC4xNC43OF8xLjAuMF9nYQogICAgVGhlIHByZXZpb3VzIHZhbHVl
cyB3ZXJlIGJhc2VkIG9uIDQuOS4KICAqIFVzZSByZXNvdXJjZSBzaXplIG9uIGRldm1faW9yZW1h
cCwgd2UgaGF2ZSB0aGF0IGluIGR0IGFscmVhZHkuCiAgKiBVc2UgcmVnbWFwIHNvIGl0J3Mgc2lt
cGxlIHRvIGR1bXAgdGhlIHJlZ2lzdGVycy4KICAqIFVzZSByZWdtYXBfcmVhZF9wb2xsX3RpbWVv
dXQgaW5zdGVhZCBvZiBvcGVuIGNvZGVkIGxvb3AuCiAgKiBBZGQgdW5kb2N1bWVudGVkIHJ4aHNf
c2V0dGxlIHJlZ2lzdGVyCiogQXMgcGVyIHJldmlldyBjb21tZW50cyBmcm9tIFNhbSBSYXZuYm9y
ZwogICogTW92ZSBkcml2ZXIgdG8gZC9waHkvZnJlZXNjYWxlLwogICogTW92ZSBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllciB0byB0b3Agb2YgZmlsZS4KICAqIERyb3AgJy8qICNkZWZpbmUgREVCVUcg
MSAqLycuCiAgKiBVc2UgR1BMLTIuMCsgc2luY2UgdGhlIHZlbmRvciBkcml2ZXIgdXNlcyB0aGF0
IGFzIHdlbGwuCiAgKiBEcm9wIHRoZSBtdXRleCwgcmVnaXN0ZXIgYWNjZXNzIGlzIG5vdyBwcm90
ZWN0ZWQgYnkgcmVnbWFwLgogICogRml4IHZhcmlvdXMgc3R5bGUgLyBpbmRlbnRhdGlvbiBpc3N1
ZXMuCiogQ2hlY2sgZm9yIHJlZ2lzdGVyIHJlYWQsIHdyaXRlIGFuZCBpb3JlbWFwIGVycm9ycwoq
IEltcHJvdmUgcGh5IHRpbWluZyBjYWxjdWxhdGlvbnMKICAqIFVzZSBMUCBjbG9jayByYXRlIHdo
ZXJlIHNlbnNpYmxlLCBjaGVjayBmb3IgZXJyb3JzCiAgKiBVc2UgYWQgaG9jIGZvcnVtdWxhcyBm
b3IgdGltaW5ncyBpbnZvbHZpbmcgaHMgY2xvY2sKKiBTd2l0Y2ggZnJvbSBkcGh5X29wcyB0byBk
ZXZkYXRhLiBPdGhlciBpLk1YOCB2YXJpYW50cwogIGRpZmZlciBpbiByZWdpc3RlciBsYXlvdXQg
dG9vCiogQWRkIE1peGVsIEluYyB0byB2ZW5kb3ItcHJlZml4ZXMudHh0CgpHdWlkbyBHw7xudGhl
ciAoMyk6CiAgZHQtYmluZGluZ3M6IEFkZCB2ZW5kb3IgcHJlZml4IGZvciBNaXhlbCBJbmMKICBk
dC1iaW5kaW5nczogcGh5OiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgbWl4ZWwgZHBoeQogIHBoeTog
QWRkIGRyaXZlciBmb3IgbWl4ZWwgZHBoeSBmb3VuZCBvbiBpbXg4CgogLi4uL2JpbmRpbmdzL3Bo
eS9taXhlbCxtaXBpLWRzaS1waHkudHh0ICAgICAgIHwgIDI5ICsKIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3ZlbmRvci1wcmVmaXhlcy50eHQgICB8ICAgMSArCiBkcml2ZXJzL3BoeS9mcmVlc2Nh
bGUvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgMTAgKwogZHJpdmVycy9waHkvZnJlZXNjYWxl
L01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAxICsKIC4uLi9waHkvZnJlZXNjYWxlL3BoeS1m
c2wtaW14OC1taXBpLWRwaHkuYyAgICB8IDQ5OSArKysrKysrKysrKysrKysrKysKIDUgZmlsZXMg
Y2hhbmdlZCwgNTQwIGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21peGVsLG1pcGktZHNpLXBoeS50eHQKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4LW1pcGktZHBo
eS5jCgotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
