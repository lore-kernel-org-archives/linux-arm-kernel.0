Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBACC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:10:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70A2222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="str1UtsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70A2222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PJi7J1aLSzca95eyHU7N6+Obp1aIWZTUC/IqHswFV2E=; b=str1UtsRjEM6pK
	vqpWMx/D/Ufi6KfdGqD2XjELnJAIUKxLPurO5m4My9Q+9PuiiP4Oy0j+ZU9EywrRWI5orzpk4LP9A
	oBCCuajQpAg8McILuVrzAfoZgJP7MwbRqGo7envk5Epbmmf4MT3reyA0tJoQ2dGTmN/ueT1cQ0LQC
	f4jC1novpJmfZ9fVpBOWmdPa5rFZRkh0juBZktVA1qvbnCvMhU+i3/CN0L59GAXwdevUekN/YsrnN
	HEXdckuYGrjjiIdWPsgw94xkYwRoxEN+VThVFXyiepu9N7aAIuqU9Xn1ng4RIEB0fd7yHhP4ifPiw
	dW3FhDLOdxes8BDeiKrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gunYf-00053K-KT; Sat, 16 Feb 2019 00:10:17 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gunYc-00052r-Ky; Sat, 16 Feb 2019 00:10:16 +0000
X-UUID: fcb59953a0f449199ca67f7b6e2f58ce-20190215
X-UUID: fcb59953a0f449199ca67f7b6e2f58ce-20190215
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <andrew-sh.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 582495959; Fri, 15 Feb 2019 16:10:06 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 16:10:04 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 16 Feb 2019 08:09:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 16 Feb 2019 08:09:50 +0800
Message-ID: <1550275790.23797.2.camel@mtksdaap41>
Subject: Re: [PATCH 2/3] dt-bindings: devfreq: add compatible for mt8183 cci
 devfreq
From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
To: Chanwoo Choi <cw00.choi@samsung.com>
Date: Sat, 16 Feb 2019 08:09:50 +0800
In-Reply-To: <803eacf2-a3c7-a4d0-682a-837b7367bf2f@samsung.com>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <CGME20190129063540epcas2p2562f42dd248030292eb438259e54236b@epcas2p2.samsung.com>
 <1548743704-16821-3-git-send-email-andrew-sh.cheng@mediatek.com>
 <803eacf2-a3c7-a4d0-682a-837b7367bf2f@samsung.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_161014_696567_773FB001 
X-CRM114-Status: GOOD (  20.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, fan.chen@mediatek.com,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMDE5LTAyLTEyIGF0IDEwOjAwICswOTAwLCBDaGFud29vIENob2kgd3JvdGU6Cj4g
SGkgQW5kcmV3LXNoLkNoZW5nLAo+IAo+IE9uIDE5LiAxLiAyOS4g7Jik7ZuEIDM6MzUsIEFuZHJl
dy1zaCBDaGVuZyB3cm90ZToKPiA+IEZyb206ICJBbmRyZXctc2guQ2hlbmciIDxhbmRyZXctc2gu
Y2hlbmdAbWVkaWF0ZWsuY29tPgo+ID4gCj4gPiBUaGlzIGFkZHMgZHQtYmluZGluZyBkb2N1bWVu
dGF0aW9uIG9mIGNjaSBkZXZmcmVxCj4gPiBmb3IgTWVkaWF0ZWsgTVQ4MTgzIFNvQyBwbGF0Zm9y
bS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmV3LXNoLkNoZW5nIDxhbmRyZXctc2guY2hl
bmdAbWVkaWF0ZWsuY29tPgo+ID4gLS0tCj4gPiAgLi4uL2JpbmRpbmdzL2RldmZyZXEvbXQ4MTgz
LWNjaS1kZXZmcmVxLnR4dCAgICAgICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RldmZyZXEvbXQ4MTgzLWNjaS1kZXZm
cmVxLnR4dAo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2RldmZyZXEvbXQ4MTgzLWNjaS1kZXZmcmVxLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kZXZmcmVxL210ODE4My1jY2ktZGV2ZnJlcS50eHQKPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRleCAwMDAwMDAwLi5lMmI2MWNmCj4gPiAtLS0gL2Rldi9u
dWxsCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGV2ZnJlcS9t
dDgxODMtY2NpLWRldmZyZXEudHh0Cj4gPiBAQCAtMCwwICsxLDE5IEBACj4gPiArKiBNZWRpYXRl
ayBDQ0kgZnJlcXVlbmN5IGRldmljZQo+IAo+IFlvdSBoYXZlIHRvIGFkZCBtb3JlIGRldGFpbGVk
IHdoYXQgdG8gZG8gb24gdGhpcyBkcml2ZXIuCj4gQWxzbywgcGxlYXNlIGFkZCB0aGUgZnVsbCBh
bHBoYWJldCBmb3IgQ0NJLgpJIHdpbGwgbW9kaWZ5IGluIG5leHQgcGF0Y2guCj4gCj4gPiArCj4g
PiArUmVxdWlyZWQgcHJvcGVydGllczoKPiA+ICstIGNvbXBhdGlibGU6IHNob3VsZCBjb250YWlu
ICJtZWRpYXRlayxtdDgxODMtY2NpIiBmb3IgY2NpIGRldmZyZXEKPiAKPiBVc3VhbGx5LCBkdC1i
aW5kaW5nIGRvY3VtZW50IG9ubHkgc3BlY2lmaWVzIGgvdyBpbmZvcm1hdGlvbgo+IGFuZCBob3cg
dG8gYmluZCBkZXZpY2UuICdkZXZmcmVxJyBpcyB0aGUgd29yZCBvZiBsaW51eC1zaWRlLgo+IEl0
IG1lYW5zIHRoYXQgJ2RldmZyZXEnIGNhbm5vdCBpbmRpY2F0ZSB0aGUgYW55IGgvdyBkZXZpY2Uu
Cj4gCj4gWW91IHNob3VsZCB1c2UgdGhlIGgvdyBkZXZpY2UgaW5mb3JtYXRpb24gYW5kIHdvcmQg
b2YgQ0NJIGZvciB3cml0aW5nCj4gdGhlIGR0LWJpbmRpbmcgZG9jdW1lbnQgd2l0aG91dCBsaW51
eC1zaWRlIHdvcmQgbGlrZSBkZXZmcmVxLgo+IAo+IEZvciBleGFtcGxlLCAKPiAtIGNjaSBkZXZm
cmVxIC0+IGZyZXF1ZW5jeSBzY2FsaW5nIG9mIENDSQpUaGFuayB5b3UgZm9yIGFkdmljZS4KSSB3
aWxsIG1vZGlmeSBpbiBuZXh0IHBhdGNoLgo+IAo+ID4gKwo+IAo+IFJlbW92ZSB1bm5lZWRlZCBi
bGFuayBsaW5lLgpJIHdpbGwgbW9kaWZ5IGluIG5leHQgcGF0Y2guCj4gCj4gPiArLSBjbG9ja3M6
IGZvciBjY2kgZGV2ZnJlcQo+IAo+IGRpdHRvIG9mICdkZXZmcmVxJyB3b3JkLgpJIHdpbGwgbW9k
aWZ5IGluIG5leHQgcGF0Y2guCj4gCj4gPiArCj4gCj4gZGl0dG8gb2YgYmxhbmsgbGluZQpJIHdp
bGwgbW9kaWZ5IGluIG5leHQgcGF0Y2guCj4gCj4gPiArLSBjbG9jay1uYW1lczogZm9yIGNjaSBk
ZXZmcmVxIGRyaXZlciB0byByZWZlcmVuY2UKPiAKPiBkaXR0byBvZiAnZGV2ZnJlcScgd29yZC4K
SSB3aWxsIG1vZGlmeSBpbiBuZXh0IHBhdGNoLgo+IAo+ID4gKwo+IAo+IGRpdHRvIG9mIGJsYW5r
IGxpbmUKSSB3aWxsIG1vZGlmeSBpbiBuZXh0IHBhdGNoLgo+IAo+ID4gKy0gb3BlcmF0aW5nLXBv
aW50cy12MjogZm9yIGNjaSBkZXZmcmVxIG9wcCB0YWJsZQo+IAo+IGRpdHRvIG9mICdkZXZmcmVx
JyB3b3JkLgpJIHdpbGwgbW9kaWZ5IGluIG5leHQgcGF0Y2guCj4gCj4gPiArCj4gPiArRXhhbXBs
ZToKPiA+ICsJY2NpOiBjY2kgewo+ID4gKwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxjY2kiOwo+
ID4gKwkJY2xvY2tzID0gPCZhcG1peGVkc3lzIENMS19BUE1JWEVEX0NDSVBMTD47Cj4gPiArCQlj
bG9jay1uYW1lcyA9ICJjY2lfY2xvY2siOwo+ID4gKwkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwm
Y2NpX29wcD47Cj4gPiArCX07Cj4gPiArCj4gPiAKPiAKPiBUaGlzIGRvY3VtZW50IGlzIG1pc3Np
bmcgdGhlICdyZWd1bGF0b3InIHByb3BlcnR5LiBQbGVhc2UgYWRkIGl0Ckkgd2lsbCBhZGQgaXQg
aW4gbmV4dCBwYXRjaAo+IAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
