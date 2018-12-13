Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ECDC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:27:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A3320811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sg3cPgQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A3320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LmK5E8gHRa8+/ayHylU0XUKIyF0shJ9tyBIVT//fOJ4=; b=sg3cPgQB7TDe8n
	D/kMcvv9KU0iKzXL19mKg8AiywUxZATMcfkA9liOwv7mmdJ3/FevGfG8fZNqJykeMql0kgk8liCJ2
	EFase9Pf9oXfQg48xmr2gcbzb31TcNhTiwkbqPb7EqWy3jxm4bZFyMFviNjndrSbXwUWkn/6SpyVM
	3uBRb7IFJJtUlq4vzvF4v4z13XedqHRRVNCJxiYANkDYxMLSIX7bIUangiZS906oi97yAOM9TTPzM
	JXKM9Y70uZhyutOiWmJ07KRQHqVvORK5Mll93820SiUTzuaMqHfaQgTaUqPfrrJETBGUii7ch9o/Y
	LAdxVpUew8cjlYzhpGFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOCw-0000Tn-Ok; Thu, 13 Dec 2018 10:27:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOCr-0000MQ-Si
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:27:05 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 273C83002081;
 Thu, 13 Dec 2018 10:26:51 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 152851001F59;
 Thu, 13 Dec 2018 10:26:51 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id CA3441808855;
 Thu, 13 Dec 2018 10:26:50 +0000 (UTC)
Date: Thu, 13 Dec 2018 05:26:50 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
To: John Garry <john.garry@huawei.com>
Message-ID: <837880744.86933950.1544696810428.JavaMail.zimbra@redhat.com>
In-Reply-To: <9291e284-7b9b-3d93-1e79-f01c174d9979@huawei.com>
References: <1125108393.85764095.1544629302243.JavaMail.zimbra@redhat.com>
 <9291e284-7b9b-3d93-1e79-f01c174d9979@huawei.com>
Subject: Re: [bug?] poor migrate_pages() performance on arm64
MIME-Version: 1.0
X-Originating-IP: [10.43.17.9, 10.4.195.12]
Thread-Topic: poor migrate_pages() performance on arm64
Thread-Index: qi/aZVZcWKXtBEFxN6kaqxHgNv0cYQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 13 Dec 2018 10:26:51 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_022702_087490_A4E6E727 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: linux-mm@kvack.org, Tan Xiaojun <tanxiaojun@huawei.com>, ltp@lists.linux.it,
 linux-arm-kernel@lists.infradead.org, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gKyBjYydpbmcgbGludXhhcm1AaHVhd2Vp
LmNvbQo+IAo+IEl0IHNlZW1zIHRoYXQgd2UncmUgc3BlbmRpbmcgbXVjaCB0aW1lIGluIGNhY2hl
IGludmFsaWRhdGUuCj4gCj4gV2hlbiB5b3Ugc2F5IDQgbm9kZXMsIGRvZXMgdGhhdCBtZWFuIG1l
bW9yeSBvbiBhbGwgNCBub2Rlcz8KCkNvcnJlY3Q6CgojIG51bWFjdGwgLUgKYXZhaWxhYmxlOiA0
IG5vZGVzICgwLTMpCm5vZGUgMCBjcHVzOiAwIDEgMiAzIDQgNSA2IDcgOCA5IDEwIDExIDEyIDEz
IDE0IDE1Cm5vZGUgMCBzaXplOiA2NTMwNCBNQgpub2RlIDAgZnJlZTogNTk5MzkgTUIKbm9kZSAx
IGNwdXM6IDE2IDE3IDE4IDE5IDIwIDIxIDIyIDIzIDI0IDI1IDI2IDI3IDI4IDI5IDMwIDMxCm5v
ZGUgMSBzaXplOiA2NTQwNCBNQgpub2RlIDEgZnJlZTogNjQ0MTkgTUIKbm9kZSAyIGNwdXM6IDMy
IDMzIDM0IDM1IDM2IDM3IDM4IDM5IDQwIDQxIDQyIDQzIDQ0IDQ1IDQ2IDQ3Cm5vZGUgMiBzaXpl
OiA2NTQwNCBNQgpub2RlIDIgZnJlZTogNjQ4MzIgTUIKbm9kZSAzIGNwdXM6IDQ4IDQ5IDUwIDUx
IDUyIDUzIDU0IDU1IDU2IDU3IDU4IDU5IDYwIDYxIDYyIDYzCm5vZGUgMyBzaXplOiA2NTQwMyBN
Qgpub2RlIDMgZnJlZTogNjQ4MDUgTUIKbm9kZSBkaXN0YW5jZXM6Cm5vZGUgICAwICAgMSAgIDIg
ICAzIAogIDA6ICAxMCAgMTUgIDIwICAyMCAKICAxOiAgMTUgIDEwICAyMCAgMjAgCiAgMjogIDIw
ICAyMCAgMTAgIDE1IAogIDM6ICAyMCAgMjAgIDE1ICAxMAoKPiAKPiBUaGFua3MsCj4gSm9obgo+
IAo+IE9uIDEyLzEyLzIwMTggMTU6NDEsIEphbiBTdGFuY2VrIHdyb3RlOgo+ID4gSGksCj4gPgo+
ID4gSSdtIG9ic2VydmluZyBtaWdyYXRlX3BhZ2VzKCkgdGFraW5nIHF1aXRlIGxvbmcgdGltZSBv
biBhcm02NAo+ID4gc3lzdGVtIChIdWF3ZWkgVGFpU2hhbiAyMjgwLCA0IG5vZGVzLCA2NCBDUFVz
KS4gSSdtIHVzaW5nIDQuMjAuMC1yYzYsCj4gPiBidXQgaXQncyByZXByb2R1Y2libGUgd2l0aCBv
bGRlciBrZXJuZWxzICg0LjE0KSBhcyB3ZWxsLgo+ID4KPiA+IFRoZSB0ZXN0IChzZWUgWzFdIGJl
bG93KSwgaXMgYSB0cml2aWFsIEMgYXBwbGljYXRpb24sIHRoYXQgbWlncmF0ZXMKPiA+IGN1cnJl
bnQgcHJvY2VzcyBmcm9tIG9uZSBub2RlIHRvIGFub3RoZXIuIE1vcmUgY29tcGxpY2F0ZWQgZXhh
bXBsZQo+ID4gaXMgYWxzbyBMVFAncyBtaWdyYXRlX3BhZ2VzMDMsIHdoZXJlIHRoaXMgaGFzIGJl
ZW4gb3JpZ2luYWxseSByZXBvcnRlZC4KPiA+Cj4gPiBJdCB0YWtlcyAyKyBzZWNvbmRzIHRvIG1p
Z3JhdGUgcHJvY2VzcyBmcm9tIG9uZSBub2RlIHRvIGFub3RoZXI6Cj4gPiAgICMgc3RyYWNlIC1m
IC10IC1UIC4vYS5vdXQKPiA+ICAgLi4uCj4gPiAgIFtwaWQgMTM3NTRdIDEwOjE3OjEzIG1pZ3Jh
dGVfcGFnZXMoMCwgOCwgWzB4MDAwMDAwMDAwMDAwMDAwMl0sCj4gPiAgIFsweDAwMDAwMDAwMDAw
MDAwMDFdKSA9IDEgPDAuMDU4MTE1Pgo+ID4gICBbcGlkIDEzNzU0XSAxMDoxNzoxMyBtaWdyYXRl
X3BhZ2VzKDAsIDgsIFsweDAwMDAwMDAwMDAwMDAwMDFdLAo+ID4gICBbMHgwMDAwMDAwMDAwMDAw
MDAyXSkgPSAxMiA8Mi4zNDgxODY+Cj4gPiAgIFtwaWQgMTM3NTRdIDEwOjE3OjE2IG1pZ3JhdGVf
cGFnZXMoMCwgOCwgWzB4MDAwMDAwMDAwMDAwMDAwMl0sCj4gPiAgIFsweDAwMDAwMDAwMDAwMDAw
MDFdKSA9IDEgPDAuMDU3ODg5Pgo+ID4gICBbcGlkIDEzNzU0XSAxMDoxNzoxNiBtaWdyYXRlX3Bh
Z2VzKDAsIDgsIFsweDAwMDAwMDAwMDAwMDAwMDFdLAo+ID4gICBbMHgwMDAwMDAwMDAwMDAwMDAy
XSkgPSAxMCA8Mi4xOTQ4OTA+Cj4gPiAgIC4uLgo+ID4KPiA+IFRoaXMgc2NhbGVzIHdpdGggbnVt
YmVyIG9mIGNoaWxkcmVuLiBGb3IgZXhhbXBsZSB3aXRoIE1BWENISUxEIDEwMDAsCj4gPiBpdCB0
YWtlcyB+MzMgc2Vjb25kczoKPiA+ICAgIyBzdHJhY2UgLWYgLXQgLVQgLi9hLm91dAo+ID4gICAu
Li4KPiA+ICAgW3BpZCAxMzc3M10gMTA6MTc6NTUgbWlncmF0ZV9wYWdlcygwLCA4LCBbMHgwMDAw
MDAwMDAwMDAwMDAxXSwKPiA+ICAgWzB4MDAwMDAwMDAwMDAwMDAwMl0pID0gMTEgPDMzLjYxNTU1
MD4KPiA+ICAgW3BpZCAxMzc3M10gMTA6MTg6MjkgbWlncmF0ZV9wYWdlcygwLCA4LCBbMHgwMDAw
MDAwMDAwMDAwMDAyXSwKPiA+ICAgWzB4MDAwMDAwMDAwMDAwMDAwMV0pID0gMiA8NS40NjAyNzA+
Cj4gPiAgIC4uLgo+ID4KPiA+IEl0IGFwcGVhcnMgdG8gYmUgcmVsYXRlZCB0byBtaWdyYXRpb24g
b2Ygc2hhcmVkIHBhZ2VzLCBwcmVzdW1hYmx5Cj4gPiBleGVjdXRhYmxlIGNvZGUgb2YgZ2xpYmMu
Cj4gPgo+ID4gSWYgSSBydW4gWzFdIHdpdGhvdXQgQ0FQX1NZU19OSUNFLCBpdCBjb21wbGV0ZXMg
dmVyeSBxdWlja2x5Ogo+ID4gICAjIHN1ZG8gLXUgbm9ib2R5IHN0cmFjZSAtZiAtdCAtVCAuL2Eu
b3V0Cj4gPiAgIC4uLgo+ID4gICBbcGlkIDE0ODQ3XSAxMDoyNDo1NyBtaWdyYXRlX3BhZ2VzKDAs
IDgsIFsweDAwMDAwMDAwMDAwMDAwMDFdLAo+ID4gICBbMHgwMDAwMDAwMDAwMDAwMDAyXSkgPSAw
IDwwLjAwMDE3Mj4KPiA+ICAgW3BpZCAxNDg0N10gMTA6MjQ6NTcgbWlncmF0ZV9wYWdlcygwLCA4
LCBbMHgwMDAwMDAwMDAwMDAwMDAyXSwKPiA+ICAgWzB4MDAwMDAwMDAwMDAwMDAwMV0pID0gMCA8
MC4wMDAwOTE+Cj4gPiAgIFtwaWQgMTQ4NDddIDEwOjI0OjU3IG1pZ3JhdGVfcGFnZXMoMCwgOCwg
WzB4MDAwMDAwMDAwMDAwMDAwMV0sCj4gPiAgIFsweDAwMDAwMDAwMDAwMDAwMDJdKSA9IDAgPDAu
MDAwMDc0Pgo+ID4gICBbcGlkIDE0ODQ3XSAxMDoyNDo1NyBtaWdyYXRlX3BhZ2VzKDAsIDgsIFsw
eDAwMDAwMDAwMDAwMDAwMDJdLAo+ID4gICBbMHgwMDAwMDAwMDAwMDAwMDAxXSkgPSAwIDwwLjAw
MDA2OT4KPiA+ICAgLi4uCj4gPgo+ID4KPiA+IExvb2tpbmcgYXQgcGVyZiwgbW9zdCBvZiB0aW1l
IGlzIHNwZW50IGludmFsaWRhdGluZyBpY2FjaGUuCj4gPgo+ID4gLSAgMTAwLjAwJSAgICAgMC4w
MCUgIGEub3V0ICAgIFtrZXJuZWwua2FsbHN5bXNdICBba10gX19zeXNfdHJhY2VfcmV0dXJuCj4g
PiAgICAtIF9fc3lzX3RyYWNlX3JldHVybgo+ID4gICAgICAgLSAxMDAuMDAlIF9fc2Vfc3lzX21p
Z3JhdGVfcGFnZXMKPiA+ICAgICAgICAgICAgZG9fbWlncmF0ZV9wYWdlcy5wYXJ0LjkKPiA+ICAg
ICAgICAgIC0gbWlncmF0ZV9wYWdlcwo+ID4gICAgICAgICAgICAgLSA5OS45MiUgcm1hcF93YWxr
Cj4gPiAgICAgICAgICAgICAgICAtIDk5LjkyJSBybWFwX3dhbGtfZmlsZQo+ID4gICAgICAgICAg
ICAgICAgICAgLSA5OS45MCUgcmVtb3ZlX21pZ3JhdGlvbl9wdGUKPiA+ICAgICAgICAgICAgICAg
ICAgICAgIC0gOTkuODUlIF9fc3luY19pY2FjaGVfZGNhY2hlCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZmx1c2hfY2FjaGVfdXNlcl9yYW5nZQo+ID4KPiA+IFBlcmNlbnTilIIgICAg
ICBub3AKPiA+ICAgICAgICDilIIgICAgICB1YmZ4ICAgeDMsIHgzLCAjMTYsICM0Cj4gPiAgICAg
ICAg4pSCICAgICAgbW92ICAgIHgyLCAjMHg0ICAgICAgICAgICAgICAgICAgICAgICAgLy8gIzQK
PiA+ICAgICAgICDilIIgICAgICBsc2wgICAgeDIsIHgyLCB4Mwo+ID4gICAgICAgIOKUgiAgICAg
IHN1YiAgICB4MywgeDIsICMweDEKPiA+ICAgICAgICDilIIgICAgICBiaWMgICAgeDQsIHgwLCB4
Mwo+ID4gICAxLjgyIOKUgiAgICAgIGRjICAgICBjdmF1LCB4NAo+ID4gICAgICAgIOKUgiAgICAg
IGFkZCAgICB4NCwgeDQsIHgyCj4gPiAgICAgICAg4pSCICAgICAgY21wICAgIHg0LCB4MQo+ID4g
ICAgICAgIOKUgiAgICDihpIgYi5jYyAgIDB4ZmZmZjAwMDAwODA5ZWZjOCAgLy8gYi5sbywgYi51
bCwgZmZmZmY3ZjYxMDY3Cj4gPiAgICAgICAg4pSCICAgICAgZHNiICAgIGlzaAo+ID4gICAgICAg
IOKUgiAgICAgIG5vcAo+ID4gICAwLjA3IOKUgiAgICAgIG5vcAo+ID4gICAgICAgIOKUgiAgICAg
IG1ycyAgICB4MywgY3RyX2VsMAo+ID4gICAgICAgIOKUgiAgICAgIG5vcAo+ID4gICAgICAgIOKU
giAgICAgIGFuZCAgICB4MywgeDMsICMweGYKPiA+ICAgICAgICDilIIgICAgICBtb3YgICAgeDIs
ICMweDQgICAgICAgICAgICAgICAgICAgICAgICAvLyAjNAo+ID4gICAgICAgIOKUgiAgICAgIGxz
bCAgICB4MiwgeDIsIHgzCj4gPiAgICAgICAg4pSCICAgICAgc3ViICAgIHgzLCB4MiwgIzB4MQo+
ID4gICAgICAgIOKUgiAgICAgIGJpYyAgICB4MywgeDAsIHgzCj4gPiAgOTYuMTcg4pSCICAgICAg
aWMgICAgIGl2YXUsIHgzCj4gPiAgICAgICAg4pSCICAgICAgYWRkICAgIHgzLCB4MywgeDIKPiA+
ICAgICAgICDilIIgICAgICBjbXAgICAgeDMsIHgxCj4gPiAgICAgICAg4pSCICAgIOKGkiBiLmNj
ICAgMHhmZmZmMDAwMDA4MDlmMDAwICAvLyBiLmxvLCBiLnVsLCBmZmZmZjdmNjEwNjcKPiA+ICAg
MC4xMCDilIIgICAgICBkc2IgICAgaXNoCj4gPiAgICAgICAg4pSCICAgICAgaXNiCj4gPiAgIDEu
ODUg4pSCICAgICAgbW92ICAgIHgwLCAjMHgwICAgICAgICAgICAgICAgICAgICAgICAgLy8gIzAK
PiA+ICAgICAgICDilII3ODog4oaQIHJldAo+ID4gICAgICAgIOKUgiAgICAgIG1vdiAgICB4MCwg
IzB4ZmZmZmZmZmZmZmZmZmZmMiAgICAgICAgIC8vICMtMTQKPiA+ICAgICAgICDilIIgICAg4oaR
IGIgICAgICA3OAo+ID4KPiA+IFJlZ2FyZHMsCj4gPiBKYW4KPiA+Cj4gPiBbMV0KPiA+IC0tLS0t
IDg8IC0tLS0tCj4gPiAjaW5jbHVkZSA8c2lnbmFsLmg+Cj4gPiAjaW5jbHVkZSA8c3RkaW8uaD4K
PiA+ICNpbmNsdWRlIDxzdGRsaWIuaD4KPiA+ICNpbmNsdWRlIDx1bmlzdGQuaD4KPiA+ICNpbmNs
dWRlIDxzeXMvc3lzY2FsbC5oPgo+ID4KPiA+ICNkZWZpbmUgTUFYQ0hJTEQgMTAKPiA+Cj4gPiBp
bnQgbWFpbih2b2lkKQo+ID4gewo+ID4gCWxvbmcgbm9kZTEgPSAxLCBub2RlMiA9IDI7Cj4gPiAJ
aW50IGksIGNoaWxkOwo+ID4gCWludCBwaWRzW01BWENISUxEXTsKPiA+Cj4gPiAJZm9yIChpID0g
MDsgaSA8IE1BWENISUxEOyBpKyspIHsKPiA+IAkJY2hpbGQgPSBmb3JrKCk7Cj4gPiAJCWlmIChj
aGlsZCA9PSAwKSB7Cj4gPiAJCQlzbGVlcCg2MDApOwo+ID4gCQkJZXhpdCgwKTsKPiA+IAkJfQo+
ID4gCQlwaWRzW2ldID0gY2hpbGQ7Cj4gPiAJfQo+ID4KPiA+IAlmb3IgKGkgPSAwOyBpIDwgNTsg
aSsrKSB7Cj4gPiAJCXN5c2NhbGwoX19OUl9taWdyYXRlX3BhZ2VzLCAwLCA4LCAmbm9kZTEsICZu
b2RlMik7Cj4gPiAJCXN5c2NhbGwoX19OUl9taWdyYXRlX3BhZ2VzLCAwLCA4LCAmbm9kZTIsICZu
b2RlMSk7Cj4gPiAJfQo+ID4KPiA+IAlmb3IgKGkgPSAwOyBpIDwgTUFYQ0hJTEQ7IGkrKykgewo+
ID4gCQlraWxsKHBpZHNbaV0sIFNJR0tJTEwpOwo+ID4gCX0KPiA+Cj4gPiAJcmV0dXJuIDA7Cj4g
PiB9Cj4gPiAtLS0tLSA+OCAtLS0tLQo+ID4KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+
ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKPiA+Cj4gCj4g
Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
