Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C20C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:39:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C47A2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RjqOz6qW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eeLzNH08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C47A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8GNLjM3fETwwEoQa/LpucQp+6t0WjjTcWrgP5N4L7BM=; b=RjqOz6qWl3FCYx
	SoatL5Sa8lCozaqWuRxqWqS6BEDxeDYjfa9bJ35241RYj8QFHWAXQlI6wC802fL/qadHhfRP2Qw8d
	8mK/B9AFunDNmuPfleiqmWsXYsX8fBw6+Bpko5FykmlHSwzwv7ts7+cCwPJ46c08cw52vPcPsMucv
	rhuyBxbELkNMbNUBRoG8TAe8SE9VYA1HUmV3Uqvbva1dvna3ibfbJ/MWGGS77/xGMgKuRFB+qfL9g
	jxDjNdnzgjSr6sBVjecszuhzk8ZKem92ZMEaZaJpYoI0QS3GsVvZ3IiFGxuM68tGMkaOSeLUdMe4l
	aPW9bL1imjM8mCVFq5Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7Ax-0007nJ-RE; Tue, 04 Dec 2018 09:39:31 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7Au-0007mv-6y
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:39:29 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181204093917euoutp029f4d883f80dbb5150bbf19e7e710928c~tF78mGfED1107611076euoutp02N
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 09:39:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181204093917euoutp029f4d883f80dbb5150bbf19e7e710928c~tF78mGfED1107611076euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543916357;
 bh=C8IBKV9+nMmxFxhmNUDLidx1UPSncRAX3HQbcV0+l6M=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=eeLzNH08lllc00+0MInxCoQTOcxawFFH5000iTCM600mKepD/gxuTG53hlAOFZ8sQ
 caUsSlnI6kF0ziKx6e4YRgRLJac8GoihY2WJwqDoyJ62ZJfjzUbvBkVE/44J1YbrP9
 QtqTpmuCgicuKvRI75PkCdkP3oD0tgVMoHef5Cvg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181204093916eucas1p21984ecd86d3ff6b99699c90570af9034~tF77xghcB2456524565eucas1p2r;
 Tue,  4 Dec 2018 09:39:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id D7.12.04806.34B460C5; Tue,  4
 Dec 2018 09:39:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181204093915eucas1p240fb2571fce0b0cd226ca096d077b449~tF768HLm-2434424344eucas1p25;
 Tue,  4 Dec 2018 09:39:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181204093914eusmtrp2630c1d5f94eff1802e7ab0d2d658123e~tF76sCBWf0442304423eusmtrp2d;
 Tue,  4 Dec 2018 09:39:14 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-aa-5c064b430b88
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 1F.2B.04284.24B460C5; Tue,  4
 Dec 2018 09:39:14 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181204093913eusmtip17e5df4b724e70f45bb461ba845e5f603~tF75t2xR62932329323eusmtip1E;
 Tue,  4 Dec 2018 09:39:13 +0000 (GMT)
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
To: Chanwoo Choi <cw00.choi@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <f88c4bda-d2d4-0f5c-67ea-eecf32c2fe4c@partner.samsung.com>
Date: Tue, 4 Dec 2018 10:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C06124B.5030409@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNcRjH/d57Z057Oy49K2M7M8RU6I/fxtzZOzaXyYQ2Dt5VdJLzVnLZ
 5BIpFEM5RYiV00k63tLtFMfRGXW6uGWIY5hbuSXWcOj0HtN/n+/3eX7P83y3H0dq8pgALiYu
 QTTE6WK1jIqqaOhtnjhnIRMZmu0MxTfKg3BZTimNr5V9p3H7tzc0zrc303hvQSmDmzL0OPPl
 BxK3tFxhsXNPJ4uNx60Etrx8SON71XkM7j5sRzinpY7AJfYOFl9sbyPwk91FDO64c6vvfeNd
 Gqda7SzeX/yZxp2tz6iZ/kJFTQUtmM+YkZCb0kYJWZlfkVBQ+44QLKaDjFB/2swKVy/sEtwN
 rCA/OEAJR2QTEoqKf7BCt2XkEvUq1bQNYmxMkmgImb5WFX2020XFu8Ymv/n+k01BTaPSkQ8H
 fBi4i84S6UjFafgiBG0uJ6mIbwhqqnsoRXQjOGLNIv49yay84S0UIpC78hlFdCEwl19mPF1D
 +JVwp+B1/6yhfCOC+npbfxfJp5Lg/iz3CY5j+GCoNG3xoJqfD9Xpyz1I8aOh5ZrKM2YYHwFp
 z4v7R6p5P7h96hXlYR9+Apx64exnkveHx6/yCYVHwd7yXFI59CkHcskihedCc1WJ1x8C7x0y
 q/AI+FOV7w0mgTPNxCi8Ew7crvT2TIWbjjbacxrJB0FpdYhiz4LS842ExwbeFx51+SkX+MKx
 imxSsdWQtl+jdI8D+VCrd9FwKDSfZLOQ1jggl3FAFuOALMb/e88iyoT8xURJHyVKU+LErcGS
 Ti8lxkUFr9+st6C+P9vodvRUorpf62yI55B2sDpnNh2poXVJ0ja9DQFHaoeqn45hIjXqDbpt
 20XD5jWGxFhRsqFAjtL6q3cMcq3W8FG6BHGTKMaLhn9VgvMJSEGL6kssvc+t5wMXdiwOSpwR
 8TY+MForR1jDbxrbQzeGF15fcf/B+oPRMZ/myZs683aWTbqafMIxk0id13Dm3tqJVfMLWrMm
 //64INz15fqtnhnuJXZzRphfQHJDb/bv11GjL/c2SWuO21xhy4xLWa3jRdLpd4d9z626lFA7
 ndi3smlkT4aWkqJ1k8aTBkn3Fz/SIaOvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe89daXCat1fpIiOKbst5fS2ViJJTfoku0EXRkSeN3KbnbJJF
 aIlFRs3MyqZdyAIzc82pc11cylLy0lJLo7Q0jVgmiYZd0bZG4Lffw///e+CBh8GlJjKIOajW
 8oJamSGjvImOmbbBNRsTqMSQ1osINdevQKZSI4kspmkS9X/7RKLr9uckyq8wUqjzjArpR8Zw
 5HDcp1HXiS80MpQ8xlDtSB+Jeh+UU2jqrB2gUkcThu7ZB2l0u78bQ2+PV1JosP2py+/oIVHB
 YzuNTt6dINGXF++IDQFcw8MGkqu+Vg24srxugivSTwKu4pET42qrTlOc7Wo1zZlv5XIzrTRX
 9+oUwZ2rqwJc5d3vNDdVu3ibZK88RtDotHxwukbUxsr2KVCoXBGN5KHh0XJFWFTSutAI2dq4
 mFQ+42A2L6yNS5Gnn58aIjKHlh/+NP2bzgOdSwqBFwPZcKhvbCYKgTcjZW8DePZWMeYJ/GFx
 k4X2sA/801dIeUpjALZdtlHuwIfdA9srPuLuwJftALDE0Y65B5wtwKFz/CbwKDMAdjWcctUY
 hmLlsLEqy40SNh4+KNzlRoJdCh0Wb/dOP3Y37HLWADdL2AXw2ZVRws1e7Cp4ZbjrH+NsJLxm
 HsY9HADfjF7HPLwE5teX4UVAapijG+YohjmKYY5yAxBVwJfXiao0laiQi0qVqFOnyfdrVLXA
 9S4NrT/NjaDHtKMFsAyQzZeUbiQTpaQyW8xRtQDI4DJfycAyKlEqSVXmHOEFTbKgy+DFFhDh
 uu08HuS3X+N6PrU2WRGhiELRiqiwqLBIJAuQOEJy9krZNKWWP8Tzmbzw38MYr6A8sGic35ob
 +zT4x2L7L11/zeat/ZUhnT25KRmRu55glyztSmtK70TvQvhD0FvxLPvrnBif+FndhXk1M+XR
 64sCjo0EMrbAAk1I/na9xvghsrvc9sg8kOtcvU+r+1xmthr9k6TPnZOZsyVbrF/v7FT3CS8v
 e6XXbYpblHD0gO19/BYZIaYrFStxQVT+BUoSXWlEAwAA
X-CMS-MailID: 20181204093915eucas1p240fb2571fce0b0cd226ca096d077b449
X-Msg-Generator: CA
X-RootMTR: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
 <5C06124B.5030409@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_013928_389591_BF1DD50C 
X-CRM114-Status: GOOD (  24.26  )
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
Cc: mark.rutland@arm.com, len.brown@intel.com, tony.luck@intel.com,
 keescook@chromium.org, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
 anton@enomsg.org, rjw@rjwysocki.net, robh+dt@kernel.org,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com,
 myungjoo.ham@samsung.com, kgene@kernel.org, pavel@ucw.cz, ccross@android.com,
 krzk@kernel.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hhbndvbywKCk9uIDEyLzQvMTggNjozNiBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhp
IEx1a2FzeiwKPiAKPiBMb29rcyBnb29kIHRvIG1lLiBCdXQsIEkgYWRkIHRoZSBzb21lIGNvbW1l
bnRzLgo+IElmIHlvdSB3aWxsIGZpeCBpdCwgZmVlbCBmcmVlIHRvIGFkZCBteSB0YWc6Cj4gUmV2
aWV3ZWQtYnk6IENoYW53b28gY2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgo+IAo+IE9uIDIw
MTjrhYQgMTLsm5QgMDPsnbwgMjM6MzEsIEx1a2FzeiBMdWJhIHdyb3RlOgo+PiBUaGUgcGF0Y2gg
cHJlcGFyZXMgZGV2ZnJlcSBkZXZpY2UgZm9yIGhhbmRsaW5nIHN1c3BlbmQvcmVzdW1lCj4+IGZ1
bmN0aW9uYWxpdHkuICBUaGUgbmV3IGZpZWxkcyB3aWxsIHN0b3JlIG5lZWRlZCBpbmZvcm1hdGlv
biBkdXJpbmcgdGhpcwo+IAo+IG5pdHBpY2suIFJlbW92ZSB1bm5lZWRlZCBzcGFjZS4gVGhlcmUg
YXJlIHR3byBzcGFjZXMgYmV0d2VlbiAnLicgYW5kICdUaGUgbmV3Jy4KPiAKPj4gcHJvY2Vzcy4g
IERldmZyZXEgZnJhbWV3b3JrIGhhbmRsZXMgb3BwLXN1c3BlbmQgRFQgZW50cnkgYW5kIHRoZXJl
IGlzIG5vCj4gCj4gZGl0dG8uCj4gCj4+IG5lZWQgb2YgbW9keWZpY2F0aW9ucyBpbiB0aGUgZHJp
dmVycyBjb2RlLiAgSXQgdXNlcyBhdG9taWMgdmFyaWFibGVzIHRvCj4gCj4gZGl0dG8uCj4gCj4+
IG1ha2Ugc3VyZSBubyByYWNlIGNvbmRpdGlvbiBhZmZlY3RzIHRoZSBwcm9jZXNzLgo+Pgo+PiBU
aGUgcGF0Y2ggaXMgYmFzZWQgb24gZWFybGllciB3b3JrIGJ5IFRvYmlhcyBKYWtvYmkuCj4gCj4g
UGxlYXNlIHJlbW92ZSBpdCBmcm9tIGVhY2ggcGF0Y2ggZGVzY3JpcHRpb24uCj4gCkNvbW1lbnRz
IGFkZHJlc3NlZCBpbiBuZXh0IHYzIHBhdGNoIHNldC4gVGhhbmsgeW91LgoKUmVnYXJkcywKTHVr
YXN6Cj4+Cj4+IFN1Z2dlc3RlZC1ieTogVG9iaWFzIEpha29iaSA8dGpha29iaUBtYXRoLnVuaS1i
aWVsZWZlbGQuZGU+Cj4+IFN1Z2dlc3RlZC1ieTogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ft
c3VuZy5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsLmx1YmFAcGFydG5lci5z
YW1zdW5nLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDUxICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4+ICAgaW5jbHVk
ZS9saW51eC9kZXZmcmVxLmggICB8ICA3ICsrKysrKysKPj4gICAyIGZpbGVzIGNoYW5nZWQsIDUw
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2RldmZyZXEvZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+PiBpbmRleCBh
OWZkNjFiLi4zNmJlZDI0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5j
Cj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4gQEAgLTMxNiw2ICszMTYsMTAg
QEAgc3RhdGljIGludCBkZXZmcmVxX3NldF90YXJnZXQoc3RydWN0IGRldmZyZXEgKmRldmZyZXEs
IHVuc2lnbmVkIGxvbmcgbmV3X2ZyZXEsCj4+ICAgCQkJIkNvdWxkbid0IHVwZGF0ZSBmcmVxdWVu
Y3kgdHJhbnNpdGlvbiBpbmZvcm1hdGlvbi5cbiIpOwo+PiAgIAo+PiAgIAlkZXZmcmVxLT5wcmV2
aW91c19mcmVxID0gbmV3X2ZyZXE7Cj4+ICsKPj4gKwlpZiAoZGV2ZnJlcS0+c3VzcGVuZF9mcmVx
KQo+PiArCQlkZXZmcmVxLT5yZXN1bWVfZnJlcSA9IGN1cl9mcmVxOwo+PiArCj4+ICAgCXJldHVy
biBlcnI7Cj4+ICAgfQo+PiAgIAo+PiBAQCAtNjY3LDYgKzY3MSw5IEBAIHN0cnVjdCBkZXZmcmVx
ICpkZXZmcmVxX2FkZF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2LAo+PiAgIAl9Cj4+ICAgCWRl
dmZyZXEtPm1heF9mcmVxID0gZGV2ZnJlcS0+c2NhbGluZ19tYXhfZnJlcTsKPj4gICAKPj4gKwlk
ZXZmcmVxLT5zdXNwZW5kX2ZyZXEgPSBkZXZfcG1fb3BwX2dldF9zdXNwZW5kX29wcF9mcmVxKGRl
dik7Cj4+ICsJYXRvbWljX3NldCgmZGV2ZnJlcS0+c3VzcGVuZF9jb3VudCwgMCk7Cj4+ICsKPj4g
ICAJZGV2X3NldF9uYW1lKCZkZXZmcmVxLT5kZXYsICJkZXZmcmVxJWQiLAo+PiAgIAkJCQlhdG9t
aWNfaW5jX3JldHVybigmZGV2ZnJlcV9ubykpOwo+PiAgIAllcnIgPSBkZXZpY2VfcmVnaXN0ZXIo
JmRldmZyZXEtPmRldik7Cj4+IEBAIC04NjcsMTQgKzg3NCwyOCBAQCBFWFBPUlRfU1lNQk9MKGRl
dm1fZGV2ZnJlcV9yZW1vdmVfZGV2aWNlKTsKPj4gICAgKi8KPj4gICBpbnQgZGV2ZnJlcV9zdXNw
ZW5kX2RldmljZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPj4gICB7Cj4+ICsJaW50IHJldDsK
Pj4gKwo+PiAgIAlpZiAoIWRldmZyZXEpCj4+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPj4gICAKPj4g
LQlpZiAoIWRldmZyZXEtPmdvdmVybm9yKQo+PiAtCQlyZXR1cm4gMDsKPj4gKwlpZiAoZGV2ZnJl
cS0+Z292ZXJub3IpIHsKPj4gKwkJcmV0ID0gZGV2ZnJlcS0+Z292ZXJub3ItPmV2ZW50X2hhbmRs
ZXIoZGV2ZnJlcSwKPj4gKwkJCQkJREVWRlJFUV9HT1ZfU1VTUEVORCwgTlVMTCk7Cj4+ICsJCWlm
IChyZXQpCj4+ICsJCQlyZXR1cm4gcmV0Owo+PiArCX0KPj4gKwo+PiArCWlmIChkZXZmcmVxLT5z
dXNwZW5kX2ZyZXEpIHsKPj4gKwkJaWYgKGF0b21pY19pbmNfcmV0dXJuKCZkZXZmcmVxLT5zdXNw
ZW5kX2NvdW50KSA+IDEpCj4+ICsJCQlyZXR1cm4gMDsKPj4gKwo+PiArCQlyZXQgPSBkZXZmcmVx
X3NldF90YXJnZXQoZGV2ZnJlcSwgZGV2ZnJlcS0+c3VzcGVuZF9mcmVxLCAwKTsKPj4gKwkJaWYg
KHJldCkKPj4gKwkJCXJldHVybiByZXQ7Cj4+ICsJfQo+PiAgIAo+PiAtCXJldHVybiBkZXZmcmVx
LT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+PiAtCQkJCURFVkZSRVFfR09WX1NV
U1BFTkQsIE5VTEwpOwo+PiArCXJldHVybiAwOwo+PiAgIH0KPj4gICBFWFBPUlRfU1lNQk9MKGRl
dmZyZXFfc3VzcGVuZF9kZXZpY2UpOwo+PiAgIAo+PiBAQCAtODg4LDE0ICs5MDksMjggQEAgRVhQ
T1JUX1NZTUJPTChkZXZmcmVxX3N1c3BlbmRfZGV2aWNlKTsKPj4gICAgKi8KPj4gICBpbnQgZGV2
ZnJlcV9yZXN1bWVfZGV2aWNlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+PiAgIHsKPj4gKwlp
bnQgcmV0Owo+PiArCj4+ICAgCWlmICghZGV2ZnJlcSkKPj4gICAJCXJldHVybiAtRUlOVkFMOwo+
PiAgIAo+PiAtCWlmICghZGV2ZnJlcS0+Z292ZXJub3IpCj4+IC0JCXJldHVybiAwOwo+PiArCWlm
IChkZXZmcmVxLT5yZXN1bWVfZnJlcSkgewo+PiArCQlpZiAoYXRvbWljX2RlY19yZXR1cm4oJmRl
dmZyZXEtPnN1c3BlbmRfY291bnQpID49IDEpCj4+ICsJCQlyZXR1cm4gMDsKPj4gICAKPj4gLQly
ZXR1cm4gZGV2ZnJlcS0+Z292ZXJub3ItPmV2ZW50X2hhbmRsZXIoZGV2ZnJlcSwKPj4gLQkJCQlE
RVZGUkVRX0dPVl9SRVNVTUUsIE5VTEwpOwo+PiArCQlyZXQgPSBkZXZmcmVxX3NldF90YXJnZXQo
ZGV2ZnJlcSwgZGV2ZnJlcS0+cmVzdW1lX2ZyZXEsIDApOwo+PiArCQlpZiAocmV0KQo+PiArCQkJ
cmV0dXJuIHJldDsKPj4gKwl9Cj4+ICsKPj4gKwlpZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPj4g
KwkJcmV0ID0gZGV2ZnJlcS0+Z292ZXJub3ItPmV2ZW50X2hhbmRsZXIoZGV2ZnJlcSwKPj4gKwkJ
CQkJREVWRlJFUV9HT1ZfUkVTVU1FLCBOVUxMKTsKPj4gKwkJaWYgKHJldCkKPj4gKwkJCXJldHVy
biByZXQ7Cj4+ICsJfQo+PiArCj4+ICsJcmV0dXJuIDA7Cj4+ICAgfQo+PiAgIEVYUE9SVF9TWU1C
T0woZGV2ZnJlcV9yZXN1bWVfZGV2aWNlKTsKPj4gICAKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvZGV2ZnJlcS5oIGIvaW5jbHVkZS9saW51eC9kZXZmcmVxLmgKPj4gaW5kZXggZTQ5NjNi
MC4uZDk4NTE5OSAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9kZXZmcmVxLmgKPj4gKysr
IGIvaW5jbHVkZS9saW51eC9kZXZmcmVxLmgKPj4gQEAgLTEzMSw2ICsxMzEsOSBAQCBzdHJ1Y3Qg
ZGV2ZnJlcV9kZXZfcHJvZmlsZSB7Cj4+ICAgICogQHNjYWxpbmdfbWluX2ZyZXE6CUxpbWl0IG1p
bmltdW0gZnJlcXVlbmN5IHJlcXVlc3RlZCBieSBPUFAgaW50ZXJmYWNlCj4+ICAgICogQHNjYWxp
bmdfbWF4X2ZyZXE6CUxpbWl0IG1heGltdW0gZnJlcXVlbmN5IHJlcXVlc3RlZCBieSBPUFAgaW50
ZXJmYWNlCj4+ICAgICogQHN0b3BfcG9sbGluZzoJIGRldmZyZXEgcG9sbGluZyBzdGF0dXMgb2Yg
YSBkZXZpY2UuCj4+ICsgKiBAc3VzcGVuZF9mcmVxOgkgZnJlcXVlbmN5IG9mIGEgZGV2aWNlIHNl
dCBkdXJpbmcgc3VzcGVuZCBwaGFzZS4KPj4gKyAqIEByZXN1bWVfZnJlcToJIGZyZXF1ZW5jeSBv
ZiBhIGRldmljZSBzZXQgaW4gcmVzdW1lIHBoYXNlLgo+PiArICogQHN1c3BlbmRfY291bnQ6CSBz
dXNwZW5kIHJlcXVlc3RzIGNvdW50ZXIgZm9yIGEgZGV2aWNlLgo+PiAgICAqIEB0b3RhbF90cmFu
czoJTnVtYmVyIG9mIGRldmZyZXEgdHJhbnNpdGlvbnMKPj4gICAgKiBAdHJhbnNfdGFibGU6CVN0
YXRpc3RpY3Mgb2YgZGV2ZnJlcSB0cmFuc2l0aW9ucwo+PiAgICAqIEB0aW1lX2luX3N0YXRlOglT
dGF0aXN0aWNzIG9mIGRldmZyZXEgc3RhdGVzCj4+IEBAIC0xNjcsNiArMTcwLDEwIEBAIHN0cnVj
dCBkZXZmcmVxIHsKPj4gICAJdW5zaWduZWQgbG9uZyBzY2FsaW5nX21heF9mcmVxOwo+PiAgIAli
b29sIHN0b3BfcG9sbGluZzsKPj4gICAKPj4gKwl1bnNpZ25lZCBsb25nIHN1c3BlbmRfZnJlcTsK
Pj4gKwl1bnNpZ25lZCBsb25nIHJlc3VtZV9mcmVxOwo+PiArCWF0b21pY190IHN1c3BlbmRfY291
bnQ7Cj4+ICsKPj4gICAJLyogaW5mb3JtYXRpb24gZm9yIGRldmljZSBmcmVxdWVuY3kgdHJhbnNp
dGlvbiAqLwo+PiAgIAl1bnNpZ25lZCBpbnQgdG90YWxfdHJhbnM7Cj4+ICAgCXVuc2lnbmVkIGlu
dCAqdHJhbnNfdGFibGU7Cj4+Cj4gCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
