Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3A6C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:57:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734CD218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j8t7+j4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734CD218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5R8tYB9hN3Wlphhxr6+5ZtFM7jH6PJJiKksyincf6ss=; b=j8t7+j4dY07V4W
	G2M62KKKZtj5S7h7Ipc5zy0L9HcqAuJVMU7kIqGUQ1oofTv2H5a7eU+QQ9TnJnp+rTPZGmgR5tH5g
	2mfDqtybPniuUPOtyf5PbMlhDp12cBa+iE42MUWa50C9zq0RWdE4NsAC6nBgruZanY/zEHyJuyKGS
	w8j5lc6h74qyJfKvOBf3XGM4fcnTkviGys8yQssENiD1TQPFGuasBLRKpax1bI19NiG0cr/AJALnp
	DZsue3vMkPsgNXX3mo36/+krj2sYpDgLIQQbVm/is5/sD3VbxFJZvU93zRxT412kiL2wF4vNWm6xD
	ardG7h90z/xGJjHH1K6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3r2-0008Eq-Kv; Fri, 25 Jan 2019 15:57:16 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3qy-0008ER-KL
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 15:57:14 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gn3qv-0001w3-QD; Fri, 25 Jan 2019 16:57:09 +0100
Message-ID: <1548431829.28802.50.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: Kconfig.platforms: fix warning unmet direct
 dependencies
From: Lucas Stach <l.stach@pengutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, Anders Roxell
 <anders.roxell@linaro.org>
Date: Fri, 25 Jan 2019 16:57:09 +0100
In-Reply-To: <20190125143215.GE25901@arrakis.emea.arm.com>
References: <20190115191839.13823-1-anders.roxell@linaro.org>
 <20190125143215.GE25901@arrakis.emea.arm.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_075712_817960_AA19F8F1 
X-CRM114-Status: GOOD (  19.40  )
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
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRnJlaXRhZywgZGVuIDI1LjAxLjIwMTksIDE0OjMyICswMDAwIHNjaHJpZWIgQ2F0YWxpbiBN
YXJpbmFzOgo+IE9uIFR1ZSwgSmFuIDE1LCAyMDE5IGF0IDA4OjE4OjM5UE0gKzAxMDAsIEFuZGVy
cyBSb3hlbGwgd3JvdGU6Cj4gPiBXaGVuIEFSQ0hfTVhDIGdldCBlbmFibGVkLCBBUk02NF9FUlJB
VFVNXzg0NTcxOSB3aWxsIGJlIHNlbGVjdGVkIGFuZAo+ID4gdGhpcyB3YXJuaW5nIHdpbGwgaGFw
cGVuIHdoZW4gQ09NUEFUIGlzbid0IHNldC4KPiA+IAo+ID4gV0FSTklORzogdW5tZXQgZGlyZWN0
IGRlcGVuZGVuY2llcyBkZXRlY3RlZCBmb3IgQVJNNjRfRVJSQVRVTV84NDU3MTkKPiA+IMKgIERl
cGVuZHMgb24gW25dOiBDT01QQVQgWz1uXQo+ID4gwqAgU2VsZWN0ZWQgYnkgW3ldOgo+ID4gwqAg
LSBBUkNIX01YQyBbPXldCj4gPiAKPiA+IFJld29yayB0byBhZGQgJ2lmIENPTVBBVCcgYmVmb3Jl
IEFSTTY0X0VSUkFUVU1fODQ1NzE5IGdldHMgc2VsZWN0ZWQsCj4gPiBzaW5jZSBBUk02NF9FUlJB
VFVNXzg0NTcxOSBkZXBlbmRzIG9uIENPTVBBVC4KPiA+IAo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEFuZGVycyBSb3hlbGwgPGFuZGVycy5yb3hlbGxAbGluYXJvLm9yZz4KPiA+IC0tLQo+ID4gwqBh
cmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zIHwgMiArLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMgYi9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zCj4g
PiBpbmRleCAyNTFlY2YzNGNiMDIuLmQ0ZmFjYTc3NWQ5YyAxMDA2NDQKPiA+IC0tLSBhL2FyY2gv
YXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMKPiA+ICsrKyBiL2FyY2gvYXJtNjQvS2NvbmZpZy5wbGF0
Zm9ybXMKPiA+IEBAIC0xNDUsNyArMTQ1LDcgQEAgY29uZmlnIEFSQ0hfTVZFQlUKPiA+IMKgY29u
ZmlnIEFSQ0hfTVhDCj4gPiA+ID4gwqAJYm9vbCAiQVJNdjggYmFzZWQgTlhQIGkuTVggU29DIGZh
bWlseSIKPiA+ID4gPiDCoAlzZWxlY3QgQVJNNjRfRVJSQVRVTV84NDM0MTkKPiA+ID4gPiAtCXNl
bGVjdCBBUk02NF9FUlJBVFVNXzg0NTcxOQo+ID4gPiA+ICsJc2VsZWN0IEFSTTY0X0VSUkFUVU1f
ODQ1NzE5IGlmIENPTVBBVAo+ID4gPiA+IMKgCWhlbHAKPiA+ID4gPiDCoAnCoMKgVGhpcyBlbmFi
bGVzIHN1cHBvcnQgZm9yIHRoZSBBUk12OCBiYXNlZCBTb0NzIGluIHRoZQo+ID4gwqAJwqDCoE5Y
UCBpLk1YIGZhbWlseS4KPiAKPiBBY3R1YWxseSwgZG8gd2UgbmVlZCB0byBzZWxlY3QgdGhlIGVy
cmF0YSB3b3JrYXJvdW5kcyBleHBsaWNpdGx5PyBUaGF0Cj4gc2VlbXMgdG8gYmUgdGhlIG9ubHkg
Y2FzZSB3aGVyZSB3ZSBkbyBpdCAoY29tbWl0IDkzMDUwN2MxODMwNCwgImFybTY0Ogo+IGFkZCBi
YXNpYyBLY29uZmlnIHN5bWJvbHMgZm9yIGkuTVg4IikuIFRoZXkgYXJlIGRlZmF1bHQgeSwgc28g
d2UKPiBzaG91bGRuJ3QgbmVlZCB0byBmb3JjZSB0aGVtIG9uLgoKVGhpcyBpcyBiYXNlZCBvbiBw
YXN0IGV4cGVyaWVuY2UuIFdlJ3ZlIGhhZCBhIGxvdCBvZiBjYXNlcyB3ZXJlIHBlb3BsZQpkaWQg
bm90IGVuYWJsZSB0aGUgbmVjZXNzYXJ5IENQVSBlcnJhdGEgd29ya2Fyb3VuZCwgd2hpY2ggdGhl
biB1c3VhbGx5CmxlYWQgdG8gdmVyeSBoYXJkIHRvIGRlYnVnIHN5c3RlbSBmYWlsdXJlcy4gSXQg
aXMgb24gb3VyIGxpc3Qgb2YgdGhpbmdzCnRvIGxvb2sgb3V0IGZvciBub3csIGJ1dCBJIHdvdWxk
IGZlZWwgbXVjaCBiZXR0ZXIgaWYgdGhlcmUgaXMganVzdCBubwpjaGFuY2UgZm9yIGEgdXNlciB0
byBtaXNjb25maWd1cmUgdGhlIGtlcm5lbCBpbiB0aGlzIHdheS4KClJlZ2FyZHMsCkx1Y2FzCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
