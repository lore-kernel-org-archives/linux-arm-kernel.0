Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC677C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:10:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9BA2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VjCHN165";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MAbq23BF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9BA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Subject:To:From:
	Date:Message-id:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VCRkFiQevv55IPoDO5itm/xA54loDvkSHOjTh2N9Y+c=; b=VjCHN165feXhuo
	xzyNj+Nqt/7OF9eNzY3dugDVRpKboDHsSZU03NkTFMN9o4M/Lg2FCU4HkfbxbCrqfRa+UngtDdRey
	jioePaXEK/etGneH4Bb3Qtec+a5IRhLVKk8Iy6kqgsxZgV00tXwYqy3kT4eBgJyo39VGoqRU7tQd2
	hVQPwvRJaF139Eg/lKEbTf7nTTLtXyWAQtos8M68ofVmySCx+278Y95zryxyDHb4urTuLl5FalQot
	HYqihhRu6rPwrP8ACAFaslJRAg8q5tbpsLH83KuNqEomZV/FEc4uOxl1YCm/3qq017n+5mkDfaQZd
	OkWhPWtk+4Xd9c+w1T3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU3v5-00086I-2z; Tue, 04 Dec 2018 06:10:55 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU3v0-00084y-Kh
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 06:10:52 +0000
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20181204061035epoutp043fa0a03cdb3b86d09221b5c6bfa275a8~tDFu8GR8P0722507225epoutp04s;
 Tue,  4 Dec 2018 06:10:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20181204061035epoutp043fa0a03cdb3b86d09221b5c6bfa275a8~tDFu8GR8P0722507225epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543903835;
 bh=4+VwYZ6Xyo7nNuBKziSikLxXqYyXpf8jpntNyG8EGtE=;
 h=Date:From:To:Cc:Subject:In-reply-to:References:From;
 b=MAbq23BFiN2RkvqxutGgL6TJ3okS3W4AaIkehi7Zx1iOunWnZcV3md7NvzTVdBU0v
 v1rMZYGhy+La5JDYyrEEtWs8ttl+iAvpMCE51TCkf/tXwR2hsfS3/MsyKOpX5pBSLj
 GA5PZWLP4uaSMyxkhxKRnCmG9acnKCDYJhIWRp4A=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181204061032epcas1p2ede234c97ac4ebe289e0e2e7732cea0d~tDFsjsyc-2154021540epcas1p2D;
 Tue,  4 Dec 2018 06:10:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 B2.56.04058.85A160C5; Tue,  4 Dec 2018 15:10:32 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20181204061031epcas1p35234fb21941830b2ff1dd5920aff0709~tDFrvsBN_1960219602epcas1p3M;
 Tue,  4 Dec 2018 06:10:31 +0000 (GMT)
X-AuditID: b6c32a35-e37ff70000000fda-c8-5c061a58bcec
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
 (Symantec Messaging Gateway) with SMTP id 9C.B2.03601.75A160C5; Tue,  4 Dec
 2018 15:10:31 +0900 (KST)
MIME-version: 1.0
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJ700CVJ7TJ6J50@mmp2.samsung.com>; Tue, 04 Dec 2018 15:10:31 +0900 (KST)
Message-id: <5C061A57.7040002@samsung.com>
Date: Tue, 04 Dec 2018 15:10:31 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.6.0
To: Lukasz Luba <l.luba@partner.samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
In-reply-to: <5C06140E.7010603@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTVxjHd+47ZsW7ovOkzg2v2ZZikF5q2XGx27Khu4nGsLkPTFi6O7gD
 Qt/opW5scat1qKBTdCZrOhANLjFQAUuBluELrMykG1ZqmIQNl7U6cSpphKmZmVvLjRnfnuc5
 v/9zzv855zC4+g6lYaqstZLDKpo5ahHR9702L7dYQ5Xq9t5chYZ6tei0p4tE/afvkag1fJFE
 u9q6KPTTPgs6mLiFo2i0m0aj7ts0mnQ9g7xHzmDIn/iZRJcHmik0+2UYIE/0LIZOhado9O2V
 MQz9svMkhaYiI6keP8ZIVH8mTKPdHUkS3b50lXhtmdD3XR8p+I76gPCNa4wQmg7eBULb4E1M
 8Lc3UMK5Fh8t9Jz4XHj0Ay0MzQxiQmB8DyEcCLQD4WTHfVqY9T9blLmten2lJJZLjmzJWmYr
 r7JWGLlNW01vmAwFOj6XX4de4rKtokUycoWbi3I3VplT9rns7aLZmSoVibLM5b2y3mFz1krZ
 lTa51shJ9nKzfZ19jSxaZKe1Yk2ZzfIyr9PlG1Lg+9WVA0P1pN2b93HvwHXgAp4XGkEGA9m1
 0B3vJxvBIkbNBgH0J+NEekHN3gdwzLf8MTS1rw9X6t0Aus+WpGMV+xR88NXVFM8wOPscDMeq
 02Wc1cLpucOE0nMKwNFIPa3wOXCk4wZIxwT7PEyON8/vRaXq56YnqHS8mF0Jxx8k5pmlbDEM
 td6j042WsFEAfaFBLJ3gbD0OHyUD84os9l0YabuOp0+Rwa6GvzesSjOQ3cnAwN3LQHFQCCcf
 HqaUOAv+eSFAp3nILoexEaPC7wFwbnoXqSRNACYjPZgi0MM/jjdiirdMOPPXflIRq+De3WoF
 EeCB/Z20YrkFg71dXxBNYIV3wZS8/0/Ju2BKxwDeDp6W7LKlQpJ5O7/w9vxg/qnnGILgyMXN
 w4BlAPekyvM6Waomxe1ynWUYQAbnlqjsNUSpWlUu1n0iOWwmh9MsycPAkBryIVyztMyW+jjW
 WhNvyNfr9WgtX2DgeW6Z6pqmpUTNVoi1UrUk2SXHYx3GZGhcoLO5ZiQ3qnWLkzZn0Pd27J07
 qxNXut4rToY0v754PpE1s3VD8HyPflPcQxS4Fne35SUbvu6XRkOX8lcEZ1dataEtA39/Nqme
 ezXTN/HWbPzGLV1mcsdH1vih8X+v5ZS8+bDwnwj5QfGg+zfpgm2i1dhpqjtV82nTjqMbNCe2
 xT584jhHyJUin4M7ZPE/Ee5iigAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t9jQd1wKbYYg2dfjC0ObtW02DhjPavF
 9o3fWC3mHznHatG8eD2bxZnuXIv+x6+ZLc6f38BucbbpDbvFrQYZi1lT9jJZbHp8jdXi8q45
 bBafe48wWsw4v4/JYu2Ru+wWS69fZLK43biCzeLuqaNAM05fYrVo3XuE3aJt9QdWizcX7rE4
 iHts272N1WPNvDWMHrMbLrJ4TOj/xOixeM9LJo9NqzrZPPbPXcPusXlJvce/Y+weB9/tYfLY
 crWdxaNvyypGjxWrv7N7fN4kF8AXxWWTkpqTWZZapG+XwJWx62Ara8Es/Yqtu54yNjDOUOti
 5OSQEDCRuNu9jbmLkYtDSGAdo8Sloz8YQRK8AoISPybfY+li5OBgFpCXOHIpG8JUl5gyJRei
 /D6jxIKWM8wQ5VoSR1c/B2tlEVCV+HB1DguIzQYU3//iBhuIzS+gKHH1x2NGkDmiAhES3Scq
 QeaICJxnlDjY18kKUsMs0Mos8agtC8QWFoiUOLX4Kdh8IYG5TBJtzcYgvZwC2hIPO5UnMArM
 QnLoLIRDZyEcuoCReRWjZGpBcW56brFRgWFearlecWJucWleul5yfu4mRmBUbzus1beD8f6S
 +EOMAhyMSjy8M5xYY4RYE8uKK3MPMUpwMCuJ8BYUssQI8aYkVlalFuXHF5XmpBYfYpTmYFES
 572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwOjNv+z7+6sXvlyPKWcJXVCc2+DD8Dfm6cvE3/c3
 VZvKbXTdclnlyHzFEkGra9O8hI3frQ+KqFg22f23dRPPk0fOX9w0m37/OPry5uOzBrdSpHv3
 fg2u/XY1XHVei3nK6xLGkkUVj4SY799gW7TOkyl0YVfV18zpdnfvrpj6ZAeD0VRV9veh3lxK
 LMUZiYZazEXFiQAcnK+25gIAAA==
X-CMS-MailID: 20181204061031epcas1p35234fb21941830b2ff1dd5920aff0709
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
 <5C06124B.5030409@samsung.com> <5C06140E.7010603@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_221050_897754_1B732BC8 
X-CRM114-Status: GOOD (  25.03  )
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

SGkgTHVrYXN6LAoKSSBhZGQgdGhlIGNvbW1lbnQgYWJvdXQgJ3N1c3BlbmRfY291bnQnLgoKT24g
MjAxOOuFhCAxMuyblCAwNOydvCAxNDo0MywgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhpLAo+IAo+
IE9uIDIwMTjrhYQgMTLsm5QgMDTsnbwgMTQ6MzYsIENoYW53b28gQ2hvaSB3cm90ZToKPj4gSGkg
THVrYXN6LAo+Pgo+PiBMb29rcyBnb29kIHRvIG1lLiBCdXQsIEkgYWRkIHRoZSBzb21lIGNvbW1l
bnRzLgo+PiBJZiB5b3Ugd2lsbCBmaXggaXQsIGZlZWwgZnJlZSB0byBhZGQgbXkgdGFnOgo+PiBS
ZXZpZXdlZC1ieTogQ2hhbndvbyBjaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+Cj4gCj4gU29y
cnkuIEZpeCB0eXBvICdjaG9pJyB0byAnQ2hvaScgYXMgZm9sbG93aW5nLgo+IFJldmlld2VkLWJ5
OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPiAKPj4KPj4gT24gMjAxOOuF
hCAxMuyblCAwM+ydvCAyMzozMSwgTHVrYXN6IEx1YmEgd3JvdGU6Cj4+PiBUaGUgcGF0Y2ggcHJl
cGFyZXMgZGV2ZnJlcSBkZXZpY2UgZm9yIGhhbmRsaW5nIHN1c3BlbmQvcmVzdW1lCj4+PiBmdW5j
dGlvbmFsaXR5LiAgVGhlIG5ldyBmaWVsZHMgd2lsbCBzdG9yZSBuZWVkZWQgaW5mb3JtYXRpb24g
ZHVyaW5nIHRoaXMKPj4KPj4gbml0cGljay4gUmVtb3ZlIHVubmVlZGVkIHNwYWNlLiBUaGVyZSBh
cmUgdHdvIHNwYWNlcyBiZXR3ZWVuICcuJyBhbmQgJ1RoZSBuZXcnLiAKPj4KPj4+IHByb2Nlc3Mu
ICBEZXZmcmVxIGZyYW1ld29yayBoYW5kbGVzIG9wcC1zdXNwZW5kIERUIGVudHJ5IGFuZCB0aGVy
ZSBpcyBubwo+Pgo+PiBkaXR0by4KPj4KPj4+IG5lZWQgb2YgbW9keWZpY2F0aW9ucyBpbiB0aGUg
ZHJpdmVycyBjb2RlLiAgSXQgdXNlcyBhdG9taWMgdmFyaWFibGVzIHRvCj4+Cj4+IGRpdHRvLgo+
Pgo+Pj4gbWFrZSBzdXJlIG5vIHJhY2UgY29uZGl0aW9uIGFmZmVjdHMgdGhlIHByb2Nlc3MuCj4+
Pgo+Pj4gVGhlIHBhdGNoIGlzIGJhc2VkIG9uIGVhcmxpZXIgd29yayBieSBUb2JpYXMgSmFrb2Jp
Lgo+Pgo+PiBQbGVhc2UgcmVtb3ZlIGl0IGZyb20gZWFjaCBwYXRjaCBkZXNjcmlwdGlvbi4KPj4K
Pj4+Cj4+PiBTdWdnZXN0ZWQtYnk6IFRvYmlhcyBKYWtvYmkgPHRqYWtvYmlAbWF0aC51bmktYmll
bGVmZWxkLmRlPgo+Pj4gU3VnZ2VzdGVkLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1z
dW5nLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsLmx1YmFAcGFydG5lci5z
YW1zdW5nLmNvbT4KPj4+IC0tLQo+Pj4gIGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCA1MSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQo+Pj4gIGluY2x1
ZGUvbGludXgvZGV2ZnJlcS5oICAgfCAgNyArKysrKysrCj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA1
MCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+Pj4gaW5k
ZXggYTlmZDYxYi4uMzZiZWQyNCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZm
cmVxLmMKPj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4+IEBAIC0zMTYsNiAr
MzE2LDEwIEBAIHN0YXRpYyBpbnQgZGV2ZnJlcV9zZXRfdGFyZ2V0KHN0cnVjdCBkZXZmcmVxICpk
ZXZmcmVxLCB1bnNpZ25lZCBsb25nIG5ld19mcmVxLAo+Pj4gIAkJCSJDb3VsZG4ndCB1cGRhdGUg
ZnJlcXVlbmN5IHRyYW5zaXRpb24gaW5mb3JtYXRpb24uXG4iKTsKPj4+ICAKPj4+ICAJZGV2ZnJl
cS0+cHJldmlvdXNfZnJlcSA9IG5ld19mcmVxOwo+Pj4gKwo+Pj4gKwlpZiAoZGV2ZnJlcS0+c3Vz
cGVuZF9mcmVxKQo+Pj4gKwkJZGV2ZnJlcS0+cmVzdW1lX2ZyZXEgPSBjdXJfZnJlcTsKPj4+ICsK
Pj4+ICAJcmV0dXJuIGVycjsKPj4+ICB9Cj4+PiAgCj4+PiBAQCAtNjY3LDYgKzY3MSw5IEBAIHN0
cnVjdCBkZXZmcmVxICpkZXZmcmVxX2FkZF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2LAo+Pj4g
IAl9Cj4+PiAgCWRldmZyZXEtPm1heF9mcmVxID0gZGV2ZnJlcS0+c2NhbGluZ19tYXhfZnJlcTsK
Pj4+ICAKPj4+ICsJZGV2ZnJlcS0+c3VzcGVuZF9mcmVxID0gZGV2X3BtX29wcF9nZXRfc3VzcGVu
ZF9vcHBfZnJlcShkZXYpOwo+Pj4gKwlhdG9taWNfc2V0KCZkZXZmcmVxLT5zdXNwZW5kX2NvdW50
LCAwKTsKPj4+ICsKPj4+ICAJZGV2X3NldF9uYW1lKCZkZXZmcmVxLT5kZXYsICJkZXZmcmVxJWQi
LAo+Pj4gIAkJCQlhdG9taWNfaW5jX3JldHVybigmZGV2ZnJlcV9ubykpOwo+Pj4gIAllcnIgPSBk
ZXZpY2VfcmVnaXN0ZXIoJmRldmZyZXEtPmRldik7Cj4+PiBAQCAtODY3LDE0ICs4NzQsMjggQEAg
RVhQT1JUX1NZTUJPTChkZXZtX2RldmZyZXFfcmVtb3ZlX2RldmljZSk7Cj4+PiAgICovCj4+PiAg
aW50IGRldmZyZXFfc3VzcGVuZF9kZXZpY2Uoc3RydWN0IGRldmZyZXEgKmRldmZyZXEpCj4+PiAg
ewo+Pj4gKwlpbnQgcmV0Owo+Pj4gKwo+Pj4gIAlpZiAoIWRldmZyZXEpCj4+PiAgCQlyZXR1cm4g
LUVJTlZBTDsKPj4+ICAKPj4+IC0JaWYgKCFkZXZmcmVxLT5nb3Zlcm5vcikKPj4+IC0JCXJldHVy
biAwOwo+Pj4gKwlpZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPj4+ICsJCXJldCA9IGRldmZyZXEt
PmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+PiArCQkJCQlERVZGUkVRX0dPVl9T
VVNQRU5ELCBOVUxMKTsKPj4+ICsJCWlmIChyZXQpCj4+PiArCQkJcmV0dXJuIHJldDsKPj4+ICsJ
fQo+Pj4gKwo+Pj4gKwlpZiAoZGV2ZnJlcS0+c3VzcGVuZF9mcmVxKSB7Cj4+PiArCQlpZiAoYXRv
bWljX2luY19yZXR1cm4oJmRldmZyZXEtPnN1c3BlbmRfY291bnQpID4gMSkKPj4+ICsJCQlyZXR1
cm4gMDsKPj4+ICsKPj4+ICsJCXJldCA9IGRldmZyZXFfc2V0X3RhcmdldChkZXZmcmVxLCBkZXZm
cmVxLT5zdXNwZW5kX2ZyZXEsIDApOwo+Pj4gKwkJaWYgKHJldCkKPj4+ICsJCQlyZXR1cm4gcmV0
Owo+Pj4gKwl9CgpJbiB0aGlzIHBhdGNoLCBpZiBzb21lIHVzZXJzIGNhbGwgJ2RldmZyZXFfc3Vz
cGVuZF9kZXZpY2UnIHR3aWNlLAonZGV2ZnJlcS0+Z292ZXJub3ItPmV2ZW50X2hhbmRsZXIoZGV2
ZnJlcSwgREVWRlJFUV9HT1ZfU1VTUEVORCwgTlVMTCknCmlzIGNhbGxlZCB0d2ljZSBidXQgZGV2
ZnJlcV9zZXRfdGFyZ2V0KCkgaXMgY2FsbGVkIG9ubHkgb25lLgpJIGtuZXcgdGhhdCBpdCBpcyBu
byBwcm9ibGVtIGZvciBvcGVyYXRpb24uCgpCdXQsCkkgdGhpbmsgdGhhdCB5b3UgYmV0dGVyIHRv
IHVzZSAnc3VzcGVuZF9jb3VudCcgYXMgdGhlIHJlZmVyZW5jZSBjb3VudApvZiBkZXZmcmVxX3N1
c3BlbmQvcmVzdW1lX2RldmljZSgpLiBCdXQsIGlmIHlvdSB1c2UgJ3N1c3BlbmRfY291bnQnCmlu
IG9yZGVyIHRvIGNoZWNrIHdoZXRoZXIgdGhpcyBkZXZmcmVxIGlzIHN1c3BlbmRlZCBvciBub3Qs
CndlIGNhbiByZWR1Y2UgdGhlIHVubmVlZGVkIHJlZHVuZGFudCBjYWxsIHdoZW4gY2FsbGluZyBp
dCB0d2ljZS4KCmNsb2NrIGFuZCByZWd1bGF0b3IgdXNlZCB0aGUgJ3JlZmVyZW5jZSBjb3VudCcg
bWV0aG9kIGluIG9yZGVyIHRvCnJlbW92ZSB0aGUgcmVkdW5kYW50IGNhbGwuCgoKPj4+ICAKPj4+
IC0JcmV0dXJuIGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+PiAt
CQkJCURFVkZSRVFfR09WX1NVU1BFTkQsIE5VTEwpOwo+Pj4gKwlyZXR1cm4gMDsKPj4+ICB9Cj4+
PiAgRVhQT1JUX1NZTUJPTChkZXZmcmVxX3N1c3BlbmRfZGV2aWNlKTsKPj4+ICAKPj4+IEBAIC04
ODgsMTQgKzkwOSwyOCBAQCBFWFBPUlRfU1lNQk9MKGRldmZyZXFfc3VzcGVuZF9kZXZpY2UpOwo+
Pj4gICAqLwo+Pj4gIGludCBkZXZmcmVxX3Jlc3VtZV9kZXZpY2Uoc3RydWN0IGRldmZyZXEgKmRl
dmZyZXEpCj4+PiAgewo+Pj4gKwlpbnQgcmV0Owo+Pj4gKwo+Pj4gIAlpZiAoIWRldmZyZXEpCj4+
PiAgCQlyZXR1cm4gLUVJTlZBTDsKPj4+ICAKPj4+IC0JaWYgKCFkZXZmcmVxLT5nb3Zlcm5vcikK
Pj4+IC0JCXJldHVybiAwOwo+Pj4gKwlpZiAoZGV2ZnJlcS0+cmVzdW1lX2ZyZXEpIHsKPj4+ICsJ
CWlmIChhdG9taWNfZGVjX3JldHVybigmZGV2ZnJlcS0+c3VzcGVuZF9jb3VudCkgPj0gMSkKPj4+
ICsJCQlyZXR1cm4gMDsKCmRpdHRvLgoKPj4+ICAKPj4+IC0JcmV0dXJuIGRldmZyZXEtPmdvdmVy
bm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+PiAtCQkJCURFVkZSRVFfR09WX1JFU1VNRSwg
TlVMTCk7Cj4+PiArCQlyZXQgPSBkZXZmcmVxX3NldF90YXJnZXQoZGV2ZnJlcSwgZGV2ZnJlcS0+
cmVzdW1lX2ZyZXEsIDApOwo+Pj4gKwkJaWYgKHJldCkKPj4+ICsJCQlyZXR1cm4gcmV0Owo+Pj4g
Kwl9Cj4+PiArCj4+PiArCWlmIChkZXZmcmVxLT5nb3Zlcm5vcikgewo+Pj4gKwkJcmV0ID0gZGV2
ZnJlcS0+Z292ZXJub3ItPmV2ZW50X2hhbmRsZXIoZGV2ZnJlcSwKPj4+ICsJCQkJCURFVkZSRVFf
R09WX1JFU1VNRSwgTlVMTCk7Cj4+PiArCQlpZiAocmV0KQo+Pj4gKwkJCXJldHVybiByZXQ7Cj4+
PiArCX0KPj4+ICsKPj4+ICsJcmV0dXJuIDA7Cj4+PiAgfQo+Pj4gIEVYUE9SVF9TWU1CT0woZGV2
ZnJlcV9yZXN1bWVfZGV2aWNlKTsKPj4+ICAKPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2RldmZyZXEuaCBiL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+PiBpbmRleCBlNDk2M2IwLi5k
OTg1MTk5IDEwMDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9kZXZmcmVxLmgKPj4+ICsrKyBi
L2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+PiBAQCAtMTMxLDYgKzEzMSw5IEBAIHN0cnVjdCBk
ZXZmcmVxX2Rldl9wcm9maWxlIHsKPj4+ICAgKiBAc2NhbGluZ19taW5fZnJlcToJTGltaXQgbWlu
aW11bSBmcmVxdWVuY3kgcmVxdWVzdGVkIGJ5IE9QUCBpbnRlcmZhY2UKPj4+ICAgKiBAc2NhbGlu
Z19tYXhfZnJlcToJTGltaXQgbWF4aW11bSBmcmVxdWVuY3kgcmVxdWVzdGVkIGJ5IE9QUCBpbnRl
cmZhY2UKPj4+ICAgKiBAc3RvcF9wb2xsaW5nOgkgZGV2ZnJlcSBwb2xsaW5nIHN0YXR1cyBvZiBh
IGRldmljZS4KPj4+ICsgKiBAc3VzcGVuZF9mcmVxOgkgZnJlcXVlbmN5IG9mIGEgZGV2aWNlIHNl
dCBkdXJpbmcgc3VzcGVuZCBwaGFzZS4KPj4+ICsgKiBAcmVzdW1lX2ZyZXE6CSBmcmVxdWVuY3kg
b2YgYSBkZXZpY2Ugc2V0IGluIHJlc3VtZSBwaGFzZS4KPj4+ICsgKiBAc3VzcGVuZF9jb3VudDoJ
IHN1c3BlbmQgcmVxdWVzdHMgY291bnRlciBmb3IgYSBkZXZpY2UuCj4+PiAgICogQHRvdGFsX3Ry
YW5zOglOdW1iZXIgb2YgZGV2ZnJlcSB0cmFuc2l0aW9ucwo+Pj4gICAqIEB0cmFuc190YWJsZToJ
U3RhdGlzdGljcyBvZiBkZXZmcmVxIHRyYW5zaXRpb25zCj4+PiAgICogQHRpbWVfaW5fc3RhdGU6
CVN0YXRpc3RpY3Mgb2YgZGV2ZnJlcSBzdGF0ZXMKPj4+IEBAIC0xNjcsNiArMTcwLDEwIEBAIHN0
cnVjdCBkZXZmcmVxIHsKPj4+ICAJdW5zaWduZWQgbG9uZyBzY2FsaW5nX21heF9mcmVxOwo+Pj4g
IAlib29sIHN0b3BfcG9sbGluZzsKPj4+ICAKPj4+ICsJdW5zaWduZWQgbG9uZyBzdXNwZW5kX2Zy
ZXE7Cj4+PiArCXVuc2lnbmVkIGxvbmcgcmVzdW1lX2ZyZXE7Cj4+PiArCWF0b21pY190IHN1c3Bl
bmRfY291bnQ7Cj4+PiArCj4+PiAgCS8qIGluZm9ybWF0aW9uIGZvciBkZXZpY2UgZnJlcXVlbmN5
IHRyYW5zaXRpb24gKi8KPj4+ICAJdW5zaWduZWQgaW50IHRvdGFsX3RyYW5zOwo+Pj4gIAl1bnNp
Z25lZCBpbnQgKnRyYW5zX3RhYmxlOwo+Pj4KPj4KPj4KPiAKPiAKCgotLSAKQmVzdCBSZWdhcmRz
LApDaGFud29vIENob2kKU2Ftc3VuZyBFbGVjdHJvbmljcwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
