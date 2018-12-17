Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9BFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:50:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA272133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MNFXt6GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA272133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PIE/R0ssSIjrho+PWoGCRrMGh2+XJq+fKY+UkuBy8fI=; b=MNFXt6GKKDKS+wXNoW8quPlp2
	AmdiXWHMkTNLe2agVx0MxDdTu2Ai7V9g7MDBte8Mjx/Ra8j27AYydDnQbc3d0996tZgUM/Snfx0K0
	CII+rW3Cgd9JtWfKJq9sMMPTs1kioJbyGf8JMph703N4Ol+qtloLxPnQ91BF42Xa4KZfffqUCLSlr
	fqYZ0VMvnGUx9fYJXWM66GVJeHCugWrmoKFgA9K3lJWqkY4jlrhVwLaSknfcnT4lBqdKBD7F/MdvC
	hXvAQpz89tr4HRQtS3sWKwi0JdLQoxS/yVoLN2OINnxQpaV+hDGs1Oa8I9Okr6VqD4SDGRG1Gr5UZ
	ijnmahTew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYyu8-0003QA-Dy; Mon, 17 Dec 2018 19:50:16 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYyu4-0002B3-Rl
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 19:50:14 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2018 11:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; d="scan'208";a="101389927"
Received: from skyhawk.jf.intel.com (HELO [10.54.51.81]) ([10.54.51.81])
 by orsmga006.jf.intel.com with ESMTP; 17 Dec 2018 11:50:00 -0800
Subject: Re: [Potential Spoof] Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors
 devices for Facebook
To: Vijay Khemka <vijaykhemka@fb.com>,
 Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>
References: <E3F1FFD7-1C5A-43DE-BCA6-5B50EEEF577F@fb.com>
From: James Feist <james.feist@linux.intel.com>
Message-ID: <024aee07-0444-cdaf-d274-b07244aec7b2@linux.intel.com>
Date: Mon, 17 Dec 2018 11:50:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <E3F1FFD7-1C5A-43DE-BCA6-5B50EEEF577F@fb.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_115012_948138_8D984311 
X-CRM114-Status: GOOD (  23.61  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMTcvMTggMTE6MzkgQU0sIFZpamF5IEtoZW1rYSB3cm90ZToKPiAKPiAKPiDvu79PbiAx
Mi8xNC8xOCwgMTI6NDIgUE0sICJMaW51eC1hc3BlZWQgb24gYmVoYWxmIG9mIFZpamF5IEtoZW1r
YSIgPGxpbnV4LWFzcGVlZC1ib3VuY2VzK3ZpamF5a2hlbWthPWZiLmNvbUBsaXN0cy5vemxhYnMu
b3JnIG9uIGJlaGFsZiBvZiB2aWpheWtoZW1rYUBmYi5jb20+IHdyb3RlOgo+IAo+ICAgICAgCj4g
ICAgICAKPiAgICAgIE9uIDEyLzE0LzE4LCAxMToyMiBBTSwgIm9wZW5ibWMgb24gYmVoYWxmIG9m
IEphZSBIeXVuIFlvbyIgPG9wZW5ibWMtYm91bmNlcyt2aWpheWtoZW1rYT1mYi5jb21AbGlzdHMu
b3psYWJzLm9yZyBvbiBiZWhhbGYgb2YgamFlLmh5dW4ueW9vQGxpbnV4LmludGVsLmNvbT4gd3Jv
dGU6Cj4gICAgICAKPiAgICAgICAgICBIaSBWaWpheSwKPiAgICAgICAgICAKPiAgICAgICAgICBP
biAxMi8xNC8yMDE4IDEwOjExIEFNLCBWaWpheSBLaGVta2Egd3JvdGU6Cj4gICAgICAgICAgPiBP
biAxMi8xMy8xOCwgMjo1NiBQTSwgIkpvZWwgU3RhbmxleSIgPGpvZWxAam1zLmlkLmF1PiB3cm90
ZToKPiAgICAgICAgICAKPiAgICAgICAgICA8c25pcD4KPiAgICAgICAgICAKPiAgICAgICAgICA+
ICAgICAgPiArICAgICAgICAgICAgICAgb2VtbmFtZTAgPSAiTUJfUDNWMyI7Cj4gICAgICAgICAg
PiAgICAgID4gKyAgICAgICAgICAgICAgIG9lbW5hbWUxID0gIk1CX1A1ViI7Cj4gICAgICAgICAg
PiAgICAgID4gKyAgICAgICAgICAgICAgIG9lbW5hbWUyID0gIk1CX1AxMlYiOwo+ICAgICAgICAg
ID4gICAgICA+ICsgICAgICAgICAgICAgICBvZW1uYW1lMyA9ICJNQl9QMVYwNSI7Cj4gICAgICAg
ICAgPiAgICAgID4gKyAgICAgICAgICAgICAgIG9lbW5hbWU0ID0gIk1CX1BWTk5fUENIX1NUQlki
Owo+ICAgICAgICAgID4gICAgICA+ICsgICAgICAgICAgICAgICBvZW1uYW1lNSA9ICJNQl9QM1Yz
X1NUQlkiOwo+ICAgICAgICAgID4gICAgICA+ICsgICAgICAgICAgICAgICBvZW1uYW1lNiA9ICJN
Ql9QNVZfU1RCWSI7Cj4gICAgICAgICAgPgo+ICAgICAgICAgID4gICAgICAib2VtbmFtZSIgaXNu
J3QgcGFydCBvZiB0aGUgdXBzdHJlYW0gYmluZGluZ3MuIElzIHRoaXMgc29tZXRoaW5nIHlvdQo+
ICAgICAgICAgID4gICAgICBoYXZlIHBhdGNoZXMgZm9yPwo+ICAgICAgICAgID4gVGhpcyBpcyBh
IHdvcmthcm91bmQgZmllbGQgdXNlZCBieSBkYnVzLXNlbnNvcnMgYXBwbGljYXRpb24gdG8gYXZv
aWQgb3ZlcmxheSBmb3IgZHluYW1pYyBkZXRlY3Rpb24gb2YgZGV2aWNlcyBiYXNlZCBvbiBqc29u
IGZpbGUgZGVmaW5pdGlvbi4KPiAgICAgICAgICA+Cj4gICAgICAgICAgPiBDYW4geW91IHBsZWFz
ZSBhbHNvIHJldmlldyBvdGhlciAzIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMuCj4gICAgICAgICAg
Pgo+ICAgICAgICAgID4KPiAgICAgICAgICAKPiAgICAgICAgICBUaGVzZSBvZW1uYW1lIHNldHRp
bmdzIHNob3VsZCBub3QgYmUgYWRkZWQgaW50byBoZXJlLiBZb3UgY2FuIGFkZCB0aGVzZQo+ICAg
ICAgICAgIGluZm9ybWF0aW9uIGludG8gY29uZmlndXJhdGlvbiBvZiBlbnRpdHkgbWFuYWdlciB3
aGljaCB1c2VzIG92ZXJsYXkKPiAgICAgICAgICB0ZW1wbGF0ZXMgZm9yIGRidXMtc2Vuc29ycy4g
QWxzbywgYXMgSm9lbCBzYWlkLCAib2VtbmFtZSIgaXNuJ3QgcGFydCBvZgo+ICAgICAgICAgIHRo
ZSB1cHN0cmVhbSBiaW5kaW5ncy4KPiAgICAgIAo+ICAgICAgT3ZlcmxheSB0ZW1wbGF0ZXMgZnJv
bSBlbnRpdHkgbWFuYWdlciBpcyBub3Qgd29ya2luZyBmb3IgZmFuIGFuZCBhZGMgc2Vuc29ycyB0
aGF0J3Mgd2h5IGl0IGlzIGEgd29ya2Fyb3VuZCBzdWdnZXN0ZWQgYnkgSmFtZXMgRmVpc3QgKEF1
dGhvciBvZiBkYnVzLXNlbnNvcnMpLgo+IAo+IEBqYW1lcy5mZWlzdEBsaW51eC5pbnRlbC5jb20s
Cj4gUGxlYXNlIGNvbW1lbnQgb24gYWJvdmUgcGF0Y2gsIHBsZWFzZSBhZHZpc2UgaWYgSSBuZWVk
IHRvIGZpeCB0aGlzLgoKWWVzLCB0aGlzIGlzIGEgd29ya2Fyb3VuZC4gSXQgc2hvdWxkIG5vdCBi
ZSBhZGRlZCB0byB5b3VyIGRldmljZSB0cmVlLiAKVGhpcyBoYXMgYWxyZWFkeSBiZWVuIGZpeGVk
IGZvciB0aGUgZmFucywgc29tZW9uZSBqdXN0IG5lZWRzIHRvIHNwZW5kIGEgCmxpdHRsZSBiaXQg
b2YgdGltZSB0byBmaXggdGhlIEFEQ3MgdGhlbiBpdCB3b24ndCBiZSBuZWVkZWQuCgpUaGFua3Ms
CgpKYW1lcwoKCj4gICAgICAgICAgCj4gICAgICAgICAgQ2hlZXJzLAo+ICAgICAgICAgIEphZQo+
ICAgICAgICAgIAo+ICAgICAgCj4gICAgICAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
