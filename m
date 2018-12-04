Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25071C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:36:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FF3208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HVeWICHJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XqOowwIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FF3208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Subject:To:From:
	Date:Message-id:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OWnxn4AX6uQIiuqztEFs0b8E1bof10IDDiXsZuzG32g=; b=HVeWICHJUQM4h4
	55Jqtl0P+a89UU5hWjzw3JZnxZq7LTGI8Ol98s6q0QLxYFM+K1RnDg+TNiRo8CWLWda+tss3Nilj/
	H9lao0kqW0iJsSkcyIneWmVONAFn5vaUX/wdSVRJ6an/ykWYB4neojnHnKon93j8/bF+5cyA+LA8f
	KLY49T32t0Y6m72lFeWpxN2oCmihOJkXQGJgzAMgHUzvCM7kQL+ulmaa+va0GZF4ES8rntN7Uc3Pc
	BrL/NTnIREA9uqMa3xxSHSmAGheLECVV+rqDvi0IuxELhdgsdqIQpIkjeToKscjw/6JpRKB1fNIoa
	bHgCs7nuXZowBN9On5CA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU3Np-0004Av-Bu; Tue, 04 Dec 2018 05:36:33 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU3Nl-0004A9-PI
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 05:36:32 +0000
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20181204053615epoutp02380fc98edc33c4350effa94c4d6e87d5~tCnwXBp2k1281112811epoutp02C;
 Tue,  4 Dec 2018 05:36:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20181204053615epoutp02380fc98edc33c4350effa94c4d6e87d5~tCnwXBp2k1281112811epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543901775;
 bh=KcuQ2k4cSB8paUNuhdomC7q2w0oKUqGv1RxpN+45NUA=;
 h=Date:From:To:Cc:Subject:In-reply-to:References:From;
 b=XqOowwIyyYJ7bIgnVXVEMLZgRrxukD5fC18PkGUPFAfxlSpVCAmhvHpuPtfr/uP2t
 ydy9NT9P2yhDoADEuxm5WLs+KCjZejbvFYrSjMpe+b5yGh/jU1CqfQOucZadL23uMj
 RLfrVvGQ8iCIZ4daICX6BqleX4XAdKyaV347QAZo=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.153]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181204053612epcas1p2030242731222dadd867a8b416b49c15b~tCnuAEJgF1499314993epcas1p2m;
 Tue,  4 Dec 2018 05:36:12 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 67.36.04055.C42160C5; Tue,  4 Dec 2018 14:36:12 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20181204053612epcas2p2d2bae82ef8af2e80261abc67c6a43962~tCntr-Rwi2921329213epcas2p2P;
 Tue,  4 Dec 2018 05:36:12 +0000 (GMT)
X-AuditID: b6c32a48-3c1ff70000000fd7-a7-5c06124cbf3d
Received: from epmmp1.local.host ( [203.254.227.16]) by
 epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6A.31.03627.C42160C5; Tue,  4 Dec 2018 14:36:12 +0900 (KST)
MIME-version: 1.0
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJ7006V668BWR60@mmp1.samsung.com>; Tue, 04 Dec 2018 14:36:12 +0900 (KST)
Message-id: <5C06124B.5030409@samsung.com>
Date: Tue, 04 Dec 2018 14:36:11 +0900
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
In-reply-to: <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJsWRmVeSWpSXmKPExsWy7bCmua6PEFuMwfl2HYuDWzUtNs5Yz2qx
 feM3Vov5R86xWjQvXs9mcaY716L/8Wtmi/PnN7BbnG16w25xq0HGYtaUvUwWmx5fY7W4vGsO
 m8Xn3iOMFjPO72OyWHvkLrvF0usXmSxuN65gs7h76ijQjNOXWC1a9x5ht2hb/YHV4s2FeywO
 4h7bdm9j9Vgzbw2jx+yGiyweE/o/MXos3vOSyWPTqk42j/1z17B7bF5S7/HvGLvHwXd7mDy2
 XG1n8ejbsorRY8Xq7+wenzfJBfBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
 KynkJeam2iq5+AToumXmAL2vpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNAr
 TswtLs1L10vOz7UyNDAwMgUqTMjO+HDhJlvBXtWKmyd/MzUw/pTtYuTkkBAwkXjb3cTUxcjF
 ISSwg1Hi0KJ3LBDOd0aJm5N3s8JUtU4+DpXYzShxf+cBZpAEr4CgxI/J94ASHBzMAvISRy5l
 g4SZBTQlXnyZBFV/l1Hi/6xPUPVaEpO+bQSzWQRUJbbfegNmswHF97+4wQZi8wsoSlz98ZgR
 xBYViJDYOf8bO8ggEYHzjBJrdu4Bu5VZoJVZ4t+HLWAdwgKREqcWPwWbxCngJTH5xDlWkCIJ
 gUYOiWX39jND/OAi8XPhZyYIW1ji1fEt7BC2tMSzVRsZIRraGSW+vGiG6p7AKPHh1GaoDmOJ
 Zwu7mCC+45PoOPyXHeRpCQFeiY42IYgSD4m+nnXscE8/nN7HNIFRdhZSOM1ChNMspHBawMi8
 ilEstaA4Nz212KjABDkGNzGCk7uWxw7GA+d8DjEKcDAq8fA6OLDGCLEmlhVX5h5ilOBgVhLh
 LShkiRHiTUmsrEotyo8vKs1JLT7EaAoM5onMUqLJ+cDMk1cSb2hqZGxsbGFqbmlsYKkkzvtQ
 em60kEB6YklqdmpqQWoRTB8TB6dUA+N8s2tz/vttYaow7/n44F7DoqKn8w89fKDCnxx9+eOd
 c+0fXO9/N1/6T5+jfgLrnrPn2op4292vzg56Ebyw7vn88w7ZTNXrp/a6zi9NND5qIH/z7CPb
 qyeP358T2dU1UXDvpoanDsv5Pq9NPtl1sKDtXXjVtAuBDnJGKyq1z8hc67yumvxTOFRLiaU4
 I9FQi7moOBEAvojoEAQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t9jAV0fIbYYg/vdEhYHt2pabJyxntVi
 +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
 NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
 xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
 udrO4tG3ZRWjx4rV39k9Pm+SC+CL4rJJSc3JLEst0rdL4Mr4cOEmW8Fe1YqbJ38zNTD+lO1i
 5OSQEDCRaJ18nKWLkYtDSGAno0T7shfMIAleAUGJH5PvASU4OJgF5CWOXMqGMNUlpkzJhSi/
 zyhx5dsiFohyLYlJ3zaCtbIIqEpsv/UGzGYDiu9/cYMNxOYXUJS4+uMxI8gcUYEIie4TlSBz
 RATOM0oc7OtkBalhFmhllnjUlgViCwtESpxa/JQZYtldRokJ+9YygSQ4BbwkJp84xzqBUWAW
 klNnIZw6C+HUBYzMqxglUwuKc9Nzi40KjPJSy/WKE3OLS/PS9ZLzczcxAiN722Gt/h2Mj5fE
 H2IU4GBU4uF1cGCNEWJNLCuuzD3EKMHBrCTCW1DIEiPEm5JYWZValB9fVJqTWnyIUZqDRUmc
 lz//WKSQQHpiSWp2ampBahFMlomDU6qBcf8a5/QWx/bPbKf71Z9tMGM8rsCYVnYuNfTJWW+n
 HudWmTX7jie0v9o//1y7gt8Vddd5tb17qjdN3NBYN0XliPA6icyzrbtnTN70O3nF9FNya+Ys
 v/Z4/e2wOZxzV1unPLwXnhu9eB2v7//NIXl8bczKS1M/FwW8uXvc8O2l+7K/X10UieJg+KnE
 UpyRaKjFXFScCACbozxJ6AIAAA==
X-CMS-MailID: 20181204053612epcas2p2d2bae82ef8af2e80261abc67c6a43962
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_213630_170906_8A1ACCFA 
X-CRM114-Status: GOOD (  26.21  )
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

SGkgTHVrYXN6LAoKTG9va3MgZ29vZCB0byBtZS4gQnV0LCBJIGFkZCB0aGUgc29tZSBjb21tZW50
cy4KSWYgeW91IHdpbGwgZml4IGl0LCBmZWVsIGZyZWUgdG8gYWRkIG15IHRhZzoKUmV2aWV3ZWQt
Ynk6IENoYW53b28gY2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgoKT24gMjAxOOuFhCAxMuyb
lCAwM+ydvCAyMzozMSwgTHVrYXN6IEx1YmEgd3JvdGU6Cj4gVGhlIHBhdGNoIHByZXBhcmVzIGRl
dmZyZXEgZGV2aWNlIGZvciBoYW5kbGluZyBzdXNwZW5kL3Jlc3VtZQo+IGZ1bmN0aW9uYWxpdHku
ICBUaGUgbmV3IGZpZWxkcyB3aWxsIHN0b3JlIG5lZWRlZCBpbmZvcm1hdGlvbiBkdXJpbmcgdGhp
cwoKbml0cGljay4gUmVtb3ZlIHVubmVlZGVkIHNwYWNlLiBUaGVyZSBhcmUgdHdvIHNwYWNlcyBi
ZXR3ZWVuICcuJyBhbmQgJ1RoZSBuZXcnLiAKCj4gcHJvY2Vzcy4gIERldmZyZXEgZnJhbWV3b3Jr
IGhhbmRsZXMgb3BwLXN1c3BlbmQgRFQgZW50cnkgYW5kIHRoZXJlIGlzIG5vCgpkaXR0by4KCj4g
bmVlZCBvZiBtb2R5ZmljYXRpb25zIGluIHRoZSBkcml2ZXJzIGNvZGUuICBJdCB1c2VzIGF0b21p
YyB2YXJpYWJsZXMgdG8KCmRpdHRvLgoKPiBtYWtlIHN1cmUgbm8gcmFjZSBjb25kaXRpb24gYWZm
ZWN0cyB0aGUgcHJvY2Vzcy4KPiAKPiBUaGUgcGF0Y2ggaXMgYmFzZWQgb24gZWFybGllciB3b3Jr
IGJ5IFRvYmlhcyBKYWtvYmkuCgpQbGVhc2UgcmVtb3ZlIGl0IGZyb20gZWFjaCBwYXRjaCBkZXNj
cmlwdGlvbi4KCj4gCj4gU3VnZ2VzdGVkLWJ5OiBUb2JpYXMgSmFrb2JpIDx0amFrb2JpQG1hdGgu
dW5pLWJpZWxlZmVsZC5kZT4KPiBTdWdnZXN0ZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9p
QHNhbXN1bmcuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsLmx1YmFAcGFydG5l
ci5zYW1zdW5nLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDUxICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4gIGluY2x1ZGUv
bGludXgvZGV2ZnJlcS5oICAgfCAgNyArKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZm
cmVxL2RldmZyZXEuYyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPiBpbmRleCBhOWZkNjFi
Li4zNmJlZDI0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPiArKysg
Yi9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4gQEAgLTMxNiw2ICszMTYsMTAgQEAgc3RhdGlj
IGludCBkZXZmcmVxX3NldF90YXJnZXQoc3RydWN0IGRldmZyZXEgKmRldmZyZXEsIHVuc2lnbmVk
IGxvbmcgbmV3X2ZyZXEsCj4gIAkJCSJDb3VsZG4ndCB1cGRhdGUgZnJlcXVlbmN5IHRyYW5zaXRp
b24gaW5mb3JtYXRpb24uXG4iKTsKPiAgCj4gIAlkZXZmcmVxLT5wcmV2aW91c19mcmVxID0gbmV3
X2ZyZXE7Cj4gKwo+ICsJaWYgKGRldmZyZXEtPnN1c3BlbmRfZnJlcSkKPiArCQlkZXZmcmVxLT5y
ZXN1bWVfZnJlcSA9IGN1cl9mcmVxOwo+ICsKPiAgCXJldHVybiBlcnI7Cj4gIH0KPiAgCj4gQEAg
LTY2Nyw2ICs2NzEsOSBAQCBzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcV9hZGRfZGV2aWNlKHN0cnVj
dCBkZXZpY2UgKmRldiwKPiAgCX0KPiAgCWRldmZyZXEtPm1heF9mcmVxID0gZGV2ZnJlcS0+c2Nh
bGluZ19tYXhfZnJlcTsKPiAgCj4gKwlkZXZmcmVxLT5zdXNwZW5kX2ZyZXEgPSBkZXZfcG1fb3Bw
X2dldF9zdXNwZW5kX29wcF9mcmVxKGRldik7Cj4gKwlhdG9taWNfc2V0KCZkZXZmcmVxLT5zdXNw
ZW5kX2NvdW50LCAwKTsKPiArCj4gIAlkZXZfc2V0X25hbWUoJmRldmZyZXEtPmRldiwgImRldmZy
ZXElZCIsCj4gIAkJCQlhdG9taWNfaW5jX3JldHVybigmZGV2ZnJlcV9ubykpOwo+ICAJZXJyID0g
ZGV2aWNlX3JlZ2lzdGVyKCZkZXZmcmVxLT5kZXYpOwo+IEBAIC04NjcsMTQgKzg3NCwyOCBAQCBF
WFBPUlRfU1lNQk9MKGRldm1fZGV2ZnJlcV9yZW1vdmVfZGV2aWNlKTsKPiAgICovCj4gIGludCBk
ZXZmcmVxX3N1c3BlbmRfZGV2aWNlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+ICB7Cj4gKwlp
bnQgcmV0Owo+ICsKPiAgCWlmICghZGV2ZnJlcSkKPiAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgCj4g
LQlpZiAoIWRldmZyZXEtPmdvdmVybm9yKQo+IC0JCXJldHVybiAwOwo+ICsJaWYgKGRldmZyZXEt
PmdvdmVybm9yKSB7Cj4gKwkJcmV0ID0gZGV2ZnJlcS0+Z292ZXJub3ItPmV2ZW50X2hhbmRsZXIo
ZGV2ZnJlcSwKPiArCQkJCQlERVZGUkVRX0dPVl9TVVNQRU5ELCBOVUxMKTsKPiArCQlpZiAocmV0
KQo+ICsJCQlyZXR1cm4gcmV0Owo+ICsJfQo+ICsKPiArCWlmIChkZXZmcmVxLT5zdXNwZW5kX2Zy
ZXEpIHsKPiArCQlpZiAoYXRvbWljX2luY19yZXR1cm4oJmRldmZyZXEtPnN1c3BlbmRfY291bnQp
ID4gMSkKPiArCQkJcmV0dXJuIDA7Cj4gKwo+ICsJCXJldCA9IGRldmZyZXFfc2V0X3RhcmdldChk
ZXZmcmVxLCBkZXZmcmVxLT5zdXNwZW5kX2ZyZXEsIDApOwo+ICsJCWlmIChyZXQpCj4gKwkJCXJl
dHVybiByZXQ7Cj4gKwl9Cj4gIAo+IC0JcmV0dXJuIGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9o
YW5kbGVyKGRldmZyZXEsCj4gLQkJCQlERVZGUkVRX0dPVl9TVVNQRU5ELCBOVUxMKTsKPiArCXJl
dHVybiAwOwo+ICB9Cj4gIEVYUE9SVF9TWU1CT0woZGV2ZnJlcV9zdXNwZW5kX2RldmljZSk7Cj4g
IAo+IEBAIC04ODgsMTQgKzkwOSwyOCBAQCBFWFBPUlRfU1lNQk9MKGRldmZyZXFfc3VzcGVuZF9k
ZXZpY2UpOwo+ICAgKi8KPiAgaW50IGRldmZyZXFfcmVzdW1lX2RldmljZShzdHJ1Y3QgZGV2ZnJl
cSAqZGV2ZnJlcSkKPiAgewo+ICsJaW50IHJldDsKPiArCj4gIAlpZiAoIWRldmZyZXEpCj4gIAkJ
cmV0dXJuIC1FSU5WQUw7Cj4gIAo+IC0JaWYgKCFkZXZmcmVxLT5nb3Zlcm5vcikKPiAtCQlyZXR1
cm4gMDsKPiArCWlmIChkZXZmcmVxLT5yZXN1bWVfZnJlcSkgewo+ICsJCWlmIChhdG9taWNfZGVj
X3JldHVybigmZGV2ZnJlcS0+c3VzcGVuZF9jb3VudCkgPj0gMSkKPiArCQkJcmV0dXJuIDA7Cj4g
IAo+IC0JcmV0dXJuIGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4g
LQkJCQlERVZGUkVRX0dPVl9SRVNVTUUsIE5VTEwpOwo+ICsJCXJldCA9IGRldmZyZXFfc2V0X3Rh
cmdldChkZXZmcmVxLCBkZXZmcmVxLT5yZXN1bWVfZnJlcSwgMCk7Cj4gKwkJaWYgKHJldCkKPiAr
CQkJcmV0dXJuIHJldDsKPiArCX0KPiArCj4gKwlpZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPiAr
CQlyZXQgPSBkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+ICsJCQkJ
CURFVkZSRVFfR09WX1JFU1VNRSwgTlVMTCk7Cj4gKwkJaWYgKHJldCkKPiArCQkJcmV0dXJuIHJl
dDsKPiArCX0KPiArCj4gKwlyZXR1cm4gMDsKPiAgfQo+ICBFWFBPUlRfU1lNQk9MKGRldmZyZXFf
cmVzdW1lX2RldmljZSk7Cj4gIAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RldmZyZXEu
aCBiL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4gaW5kZXggZTQ5NjNiMC4uZDk4NTE5OSAxMDA2
NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RldmZyZXEuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgv
ZGV2ZnJlcS5oCj4gQEAgLTEzMSw2ICsxMzEsOSBAQCBzdHJ1Y3QgZGV2ZnJlcV9kZXZfcHJvZmls
ZSB7Cj4gICAqIEBzY2FsaW5nX21pbl9mcmVxOglMaW1pdCBtaW5pbXVtIGZyZXF1ZW5jeSByZXF1
ZXN0ZWQgYnkgT1BQIGludGVyZmFjZQo+ICAgKiBAc2NhbGluZ19tYXhfZnJlcToJTGltaXQgbWF4
aW11bSBmcmVxdWVuY3kgcmVxdWVzdGVkIGJ5IE9QUCBpbnRlcmZhY2UKPiAgICogQHN0b3BfcG9s
bGluZzoJIGRldmZyZXEgcG9sbGluZyBzdGF0dXMgb2YgYSBkZXZpY2UuCj4gKyAqIEBzdXNwZW5k
X2ZyZXE6CSBmcmVxdWVuY3kgb2YgYSBkZXZpY2Ugc2V0IGR1cmluZyBzdXNwZW5kIHBoYXNlLgo+
ICsgKiBAcmVzdW1lX2ZyZXE6CSBmcmVxdWVuY3kgb2YgYSBkZXZpY2Ugc2V0IGluIHJlc3VtZSBw
aGFzZS4KPiArICogQHN1c3BlbmRfY291bnQ6CSBzdXNwZW5kIHJlcXVlc3RzIGNvdW50ZXIgZm9y
IGEgZGV2aWNlLgo+ICAgKiBAdG90YWxfdHJhbnM6CU51bWJlciBvZiBkZXZmcmVxIHRyYW5zaXRp
b25zCj4gICAqIEB0cmFuc190YWJsZToJU3RhdGlzdGljcyBvZiBkZXZmcmVxIHRyYW5zaXRpb25z
Cj4gICAqIEB0aW1lX2luX3N0YXRlOglTdGF0aXN0aWNzIG9mIGRldmZyZXEgc3RhdGVzCj4gQEAg
LTE2Nyw2ICsxNzAsMTAgQEAgc3RydWN0IGRldmZyZXEgewo+ICAJdW5zaWduZWQgbG9uZyBzY2Fs
aW5nX21heF9mcmVxOwo+ICAJYm9vbCBzdG9wX3BvbGxpbmc7Cj4gIAo+ICsJdW5zaWduZWQgbG9u
ZyBzdXNwZW5kX2ZyZXE7Cj4gKwl1bnNpZ25lZCBsb25nIHJlc3VtZV9mcmVxOwo+ICsJYXRvbWlj
X3Qgc3VzcGVuZF9jb3VudDsKPiArCj4gIAkvKiBpbmZvcm1hdGlvbiBmb3IgZGV2aWNlIGZyZXF1
ZW5jeSB0cmFuc2l0aW9uICovCj4gIAl1bnNpZ25lZCBpbnQgdG90YWxfdHJhbnM7Cj4gIAl1bnNp
Z25lZCBpbnQgKnRyYW5zX3RhYmxlOwo+IAoKCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53b28gQ2hv
aQpTYW1zdW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
