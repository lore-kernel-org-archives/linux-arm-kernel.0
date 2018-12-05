Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2DEC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:08:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB592081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e6nrTVE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB592081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1EbGa4QGQKj24UUiIsVFaZjcoOjTBm0vXCBU4vK6YYk=; b=e6nrTVE+Wr5Ve2
	TcEWwUQDmDmpF0HePyCTxLkdTURNK6gZQhWT2dvz2tgsQdXh0u1Ayr0yAXSogo3sMLTvGCdrRsGVk
	b9QXR1nKG9SymDdEwyE5xSSyO2VpSjU0KBe4qbeRkTnsOf+NrY+M82DyXNTWIJJG029c5GQP7MZeQ
	2tv9g00PDpMxoZI9QTy1sEBdHCamnwAbQtEBvVXj6IHkV/NS7RBSuC/yfeOz9Eg9rJk3yBsKQUwM/
	vvUcUCDk0WozaPxxJyM3C0y1L0TzNKXrKBdZm/xXNHJ4V3m1+vZGTmqEgZu5p0RdVF0dJ7SO3Y1AZ
	Ko5GernGit2183/d8B6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYmt-0001db-FO; Wed, 05 Dec 2018 15:08:31 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYmq-0001cd-48
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:08:29 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Dec 2018 07:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; d="scan'208";a="96339107"
Received: from jinbaowa-mobl1.ccr.corp.intel.com ([10.249.170.100])
 by orsmga007.jf.intel.com with ESMTP; 05 Dec 2018 07:08:13 -0800
Message-ID: <1544022486.2841.42.camel@intel.com>
Subject: Re: [PATCH v2 00/11] thermal: add new flag irq-mode for trip point
From: Zhang Rui <rui.zhang@intel.com>
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Wed, 05 Dec 2018 23:08:06 +0800
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94@eucas1p1.samsung.com>
 <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_070828_175692_8D8AD3F3 
X-CRM114-Status: GOOD (  23.94  )
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
Cc: mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
 daniel.lezcano@linaro.org, krzk@kernel.org, edubezval@gmail.com,
 robh+dt@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24g5LiJLCAyMDE4LTExLTA3IGF0IDE4OjA5ICswMTAwLCBMdWthc3ogTHViYSB3cm90ZToKPiBI
aSBhbGwsCj4gCj4gVGhpcyBwYXRjaCBzZXQgYWRkcyBhIG5ldyBmbGFnIGFuZCBtZWNoYW5pc20g
aW4gdGhlcm1hbCB0cmlwIHBvaW50cwo+IGluCj4gRFQuwqDCoFRoZSBvbGQgaW1wbGVtZW50YXRp
b24gaW4gdGhlcm1hbCB6b25lIGluIERUIHNldHMgdGhlIHNhbWUKPiBjb25maWd1cmF0aW9uIGZv
ciBhbGwgaW50ZXJuYWwgdHJpcCBwb2ludHMuIEl0IGRvZXMgbm90IHdvcmsgZm9yIGFsbAo+IEhX
LsKgwqBUaGVyZSBhcmUgU29DcyB3aGljaCBzdXBwb3J0IElSUXMgZm9yIHNvbWUgdHJpcCBwb2lu
dHMgKGkuZS4KPiBFeHlub3MgNCBoYXMgNCB0cmlwIHBvaW50cyB3aXRoIElSUXMpLiBGb3IgYWRk
aXRpb25hbCBvbmUgZGVmaW5lZAo+IGluc2lkZSB0aGUgdGhlcm1hbCB6b25lIHRoZXJlIGlzIGEg
bmVlZCBvZiAncG9sbGluZycuIFdoZW4gZGV2ZWxvcGVyCj4gYWRkcyBwb2xsaW5nIG1vZGUgc2V0
dGluZ3MgaW5zaWRlIHRoZSB0aGVybWFsIHpvbmUsIGFsbCB0aGUgdHJpcAo+IHBvaW50cyB3aWxs
IGJlIHJlZ2lzdGVyZWQgZm9yIHBvbGxpbmcsIGV2ZW4gdGhvc2Ugc3VwcG9ydGluZyBJUlFzLAo+
IHdoaWNoIGRvZXMgbm90IG1ha2Ugc2Vuc2UuCgp3ZSBoYXZlIHR3byB0aW1lcnMsIG9uZSBmb3Ig
cG9sbGluZywgYW5kIG9uZSBmb3IgcGFzc2l2ZSBjb29saW5nLgpJIHRoaW5rIHdlIGFyZSB0YWxr
aW5nIGFib3V0IHBhc3NpdmUgY29vbGluZyB0aW1lciBvbmx5LCByaWdodD8KQW5kIHRoZSByZWFs
IHByb2JsZW0gaXMgdGhhdCB3ZSBoYXZlIG11bHRpcGxlIHBhc3NpdmUgdHJpcCBwb2ludHMgYW5k
Cm9ubHkgcGFydCBvZiB0aGVtIHN1cHBvcnQgaXJxX21vZGUsIGFuZCB3ZSBkb24ndCB3YW50IHRv
IHN0YXJ0IHRoZQpwYXNzaXZlIHBvbGxpbmcgdGltZXIgZm9yIGFsbCBvZiB0aGUgcGFzc2l2ZSB0
cmlwIHBvaW50cy4KCnRoYW5rcywKcnVpCgo+ICBUaHVzLCBkZXZlbG9wZXJzIGNyZWF0ZSB3b3Jr
YXJvdW5kcywgd2hpY2gKPiBhcmUgY29uZnVzaW5nIGZvciBzb21lIG90aGVyIGRldmVsb3BlcnMu
wqDCoFRvIHdvcmthcm91bmQswqAKPiBwZW9wbGUgZGVjbGFyZSBzb21lIHRyaXAgcG9pbnRzIGFz
ICdhY3RpdmUnICh0aG9zZSB3aXRoIElSUSBzdXBwb3J0KS4KPiBJdCBhbGxvd3MgdG8gYnlwYXNz
IHBvbGxpbmcgbW9kZSBpbiB0aGVybWFsIGZyYW1ld29yayBhcHBsaWVkIGZvcsKgCj4gYWxsIHRo
ZXJtYWwgem9uZSdzIHRyaXAgcG9pbnRzLgo+IAo+IFRoZXJtYWwgZnJhbWV3b3JrIGRlZmluZXMg
NCB0eXBlcyBvZiB0cmlwIHBvaW50cy4gVGhlICdwYXNzaXZlJyBtZWFucwo+IHBhc3NpdmUgY29v
bGluZyB1c2luZyBEVkZTLCAnYWN0aXZlJyBpcyBkZXNpZ25lZCBmb3IgZmFuIGFuZCBvdGhlcgo+
IGRldmljZXMgYWN0aXZlbHkgY2hhbmdpbmcgdGhlIG91dHNpZGUgY29uZGl0aW9ucy4gVGhlcmVm
b3JlLCBhCj4gd29ya2Fyb3VuZAo+IG1lbnRpb25lZCBlYXJsaWVyIGlzIGNvbmZ1c2luZyB3aGVu
IHNvbWVvbmUgZG9lcyBub3Qga25vdyBhYm91dCB0aGUKPiBmcmFtZXdvcmsgbGltaXRhdGlvbnMu
Cj4gCj4gVGhpcyBwYXRjaCBzZXQgdHJpZXMgdG8gc29sdmUgdGhlIGlzc3VlIGJ5IGFkZGluZyBv
bmUgZmxhZyBpbnNpZGUgdGhlCj4gdHJpcCBwb2ludDogJ2lycS1tb2RlOycuwqDCoFRoZSB0cmlw
IHBvaW50ICdwYXNzaXZlJyBkZWNsYXJlZCBpbiBEVAo+IHdpdGgKPiBleHBsaWNpdCBmbGFnICdp
cnEtbW9kZTsnIHdpbGwgbm90IHJlZ2lzdGVyIGl0c2VsZiBhcyBwb2xsaW5nIG1vZGUuCj4gVGhl
cm1hbCBmcmFtZXdvcmsgd2lsbCBza2lwIGl0IGR1cmluZyBzY2hlZHVsaW5nIG5leHQgcmVhZCBv
dXQgd29yay4KPiBUaGUgb2xkIGdsb2JhbC1wb2xsaW5nLW1vZGUtY29uZmlndXJhdGlvbi1pbnNp
ZGUtdGhlcm1hbC16b25lIGlzCj4gc3RpbGwKPiB2YWxpZC7CoMKgUGF0Y2ggc2V0IGRvZXMgbm90
IGJyZWFrIGV4aXN0aW5nIGRlc2lnbiBmb3IgdHJpcCBwb2ludHMKPiB3aGljaAo+IGRvIG5vdCBo
YXZlICdpcnEtbW9kZScgZmxhZyAtIHRoZXkgd2lsbCB1c2UgcG9sbGluZy4KPiAKPiBBcyBhbiBl
eGFtcGxlIHBsZWFzZSBjaGVjayBwYXRjaCAjMTAgZm9yIEV4eW5vczQgU29DIGZhbWlseSwgd2hl
cmUKPiB0aGVyZQo+IGlzIDQgSFcgc3VwcG9ydGVkIHRyaXAgcG9pbnRzIGFuZCB0aGVyZSBpcyBh
IG5lZWQgb2YgNi4gVGhlIHJlc3QgMgo+IGFyZQo+IGRlY2xhcmVkIGFzICdwYXNzaXZlJyB3aXRo
b3V0ICdpcnEtbW9kZTsnIGZsYWcsIHdoaWNoIG1lYW5zIHBvbGxpbmcKPiBtb2RlIG5lZWRlZCBm
b3IgdGhlbS4KPiAKPiBQYXRjaCAjMSBpcyBhIHNtYWxsIGNsZWFudXAgaW4gdGhlcm1hbCBmcmFt
ZXdvcmsuCj4gCj4gQ2hhbmdlIGxvZzoKPiB2Mgo+IC0gY2hhbmdlZCBkZXNjcmlwdGlvbiBpbiBj
b3ZlciBsZXR0ZXIKPiAtIGNoYW5nZSBjb21taXQgbWVzc2FnZXMgYWNjb3JkaW5nIHRvIEtyenlz
enRvZiBjb21tZW50cwo+IC0gcmViYXNlIG9uIHRvcCBvZiBjdXJyZW50IG1haW5saW5lICh2NC4y
MC1yYzEpCj4gCj4gUmVnYXJkcywKPiBMdWthc3ogTHViYQo+IAo+IEx1a2FzeiBMdWJhICgxMSk6
Cj4gwqAgdGhlcm1hbDogcmVtb3ZlIHVudXNlZCBmdW5jdGlvbiBwYXJhbWV0ZXIKPiDCoCB0aGVy
bWFsOiBhZGQgaXJxLW1vZGUgY29uZmlndXJhdGlvbiBmb3IgdHJpcCBwb2ludAo+IMKgIHRoZXJt
YWw6IGFkZCBuZXcgc3lzZnMgZmlsZSBmb3IgaXJxLW1vZGUKPiDCoCBEb2M6IHRoZXJtYWw6IG5l
dyBpcnEtbW9kZSBmb3IgdHJpcCBwb2ludAo+IMKgIERvYzogRFQ6IHRoZXJtYWw6IG5ldyBpcnEt
bW9kZSBmb3IgdHJpcCBwb2ludAo+IMKgIGFybTY0OiBkdHM6IGV4eW5vczU0MzM6IGFkZCBzdXBw
b3J0IGZvciB0aGVybWFsIHRyaXAgaXJxLW1vZGUKPiDCoCBhcm02NDogZHRzOiBleHlub3M3OiBh
ZGQgc3VwcG9ydCBmb3IgdGhlcm1hbCB0cmlwIGlycS1tb2RlCj4gwqAgYXJtOiBkdHM6IGV4eW5v
czQ6IGFkZCBzdXBwb3J0IGZvciB0aGVybWFsIHRyaXAgaXJxLW1vZGUKPiDCoCBhcm06IGR0czog
ZXh5bm9zNTQyMDogYWRkIHN1cHBvcnQgZm9yIHRoZXJtYWwgdHJpcCBpcnEtbW9kZQo+IMKgIGFy
bTogZHRzOiBleHlub3M1NDIyOiBhZGQgc3VwcG9ydCBmb3IgdGhlcm1hbCB0cmlwIGlycS1tb2Rl
Cj4gwqAgYXJtOiBkdHM6IGV4eW5vczU0MTA6IGFkZCBzdXBwb3J0IGZvciB0aGVybWFsIHRyaXAg
aXJxLW1vZGUKPiAKPiDCoC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC50
eHTCoMKgwqDCoMKgwqDCoMKgfMKgwqDCoDcgKysKPiDCoERvY3VtZW50YXRpb24vdGhlcm1hbC9z
eXNmcy1hcGkudHh0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgOSArKwo+
IMKgYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNC1jcHUtdGhlcm1hbC5kdHNpwqDCoMKgwqDCoMKg
wqDCoMKgfMKgwqAxMCArLQo+IMKgYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTQxMC1vZHJvaWR4
dS5kdHPCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgMTAgKy0KPiDCoGFyY2gvYXJtL2Jvb3QvZHRz
L2V4eW5vczU0MjAtdHJpcC1wb2ludHMuZHRzacKgwqDCoMKgwqDCoHzCoMKgMTAgKy0KPiDCoGFy
Y2gvYXJtL2Jvb3QvZHRzL2V4eW5vczU0MjItb2Ryb2lkeHUzLWNvbW1vbi5kdHNpIHzCoMKgNDAg
KysrKystLS0KPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZXh5bm9zL2V4eW5vczU0MzMtdG11LmR0
c2nCoMKgwqDCoMKgfCAxMDUKPiArKysrKysrKysrKysrKy0tLS0tLS0KPiDCoC4uLi9hcm02NC9i
b290L2R0cy9leHlub3MvZXh5bm9zNy10cmlwLXBvaW50cy5kdHNpIHzCoMKgwqA4ICsrCj4gwqBk
cml2ZXJzL3RoZXJtYWwvb2YtdGhlcm1hbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHzCoMKgMTcgKysrKwo+IMKgZHJpdmVycy90aGVybWFsL3RoZXJtYWxf
Y29yZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqAxNiAr
Ky0tCj4gwqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9zeXNmcy5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgNTMgKysrKysrKysrKy0KPiDCoGluY2x1ZGUvbGlu
dXgvdGhlcm1hbC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB8wqDCoMKgNSArCj4gwqAxMiBmaWxlcyBjaGFuZ2VkLCAyMjYgaW5zZXJ0aW9u
cygrKSwgNjQgZGVsZXRpb25zKC0pCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
