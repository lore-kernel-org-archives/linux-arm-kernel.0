Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61BAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862AD213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sZPbpb0k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FvDD3zdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862AD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Subject:To:From:
	Date:Message-id:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aqJ7fLr2YlHUWYST2Yb1k+t9uwEADprNpeWLu+s4lUM=; b=sZPbpb0kcqKgnR
	N8sY/ptT+ztYIQ877wYKr4po3sHA7kZZxfld0r2Ty29oWX1+dVU4JPz1xdnBSC77VRSdxCd2Ua9cV
	sYCD/MI17P2vMkpEApFfI2YIKG4WSjWbtGWJgaB8HO2DFhiaFWqEMNSO7c7rNq2bGzX8ZK5FzNxCg
	nn3484gtLYsJhRGWUJPRaYD9C4Ssnwcd2xRiJjnDr9Izdf3wHkDjyCHMZEY6WYx48fosTHXQSmqaS
	xeVYx4+6pYGtRl5+6Kq4KiUCfCNyufP5O870RG5KOTc6L6WNFtNZwwbfzklz0ucnRBPPBSMLlN3Fk
	16fencf4UnmSWH+Eh7Ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUiJ0-0005pE-J2; Thu, 06 Dec 2018 01:18:18 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUiIu-0005lf-BN
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:18:16 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20181206011756epoutp0264540841ab7d1f32a0d9e36445dabc8f~tmYyKDTvb3148831488epoutp02_;
 Thu,  6 Dec 2018 01:17:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20181206011756epoutp0264540841ab7d1f32a0d9e36445dabc8f~tmYyKDTvb3148831488epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544059076;
 bh=rO6+7vedM3VIPPy+ACWq9sRhJJmlX93RUgnGkA4sq34=;
 h=Date:From:To:Cc:Subject:In-reply-to:References:From;
 b=FvDD3zdJhBnZwTHuF41oQkwi/HC69D04ZDXwX9Y/tY2KdVEfE66ACf6FoPWNPfhks
 WIBSmMclL5PqGW/OGscjtycOetzaJrUignFTe+NrzC52KlEUsQrqV4pk8eeWkvzHwd
 fl5Jqtw46A4B+purHegklyBG1Z5Bfq/TaMEbDxkI=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.153]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181206011753epcas1p2a1ee8c954d993b6a116f4f5b05db601d~tmYv2oHhA0770307703epcas1p2x;
 Thu,  6 Dec 2018 01:17:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 05.A6.04060.1C8780C5; Thu,  6 Dec 2018 10:17:53 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20181206011753epcas2p3a45b7e5e2f1758e887613df51a7ad801~tmYvYlXJw0727007270epcas2p3B;
 Thu,  6 Dec 2018 01:17:53 +0000 (GMT)
X-AuditID: b6c32a46-b45ff70000000fdc-cc-5c0878c195df
Received: from epmmp1.local.host ( [203.254.227.16]) by
 epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E7.E6.03627.0C8780C5; Thu,  6 Dec 2018 10:17:53 +0900 (KST)
MIME-version: 1.0
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJA008NAJLSEI00@mmp1.samsung.com>; Thu, 06 Dec 2018 10:17:52 +0900 (KST)
Message-id: <5C0878C0.4060500@samsung.com>
Date: Thu, 06 Dec 2018 10:17:52 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.6.0
To: Lukasz Luba <l.luba@partner.samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/5] devfreq: add support for suspend/resume of a
 devfreq device
In-reply-to: <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjeubf3A7PqWUE9wNR6F00gAVu6yqkRt2XG3ES2sfhnGyx4Q+8K
 o1/rbYmYZasi6FgUNsni2MRt4MZqiVALyKcBysxw8qGCzoHONXEdIiHDAfEDbXvdxr/nfd/n
 fc77vOccllRN0wlsgdUpOqyCmaOXKVr6ktJTevawOZrSBxzuaU7CTcdOU7i1aY7CJwKDFC6p
 PU3jXz614IrgHRIPDTUy+OL+KQZfdz+Pq6u6COwLjlH4cvvXNJ49HAD42FA3gRsCEww+eXWE
 wL/tq6fxxEB/WOPCJQqXdgUYXHZqhsJTwzcUL6/mWzpaKN5b4wX8V+4RBV9Z8Tfgazv/Inif
 5xOaP3fcy/Bn6j7mF39i+J7pToL3jx5U8Ef8HsDXn5pn+Fnf2qzl7xRuzRcFo+hQi9Y8m7HA
 asrgdu7KfTVXv1mjTdEacDqntgoWMYPbnpmVsqPAHLbPqYsEsyucyhIkidu0bavD5nKK6nyb
 5MzgRLvRbDfYUyXBIrmsptQ8m2WLVqNJ04eJuwvzq7rnCPs4t+eHmmI3WEgsBzEsgi+i+slm
 uhwsY1XwLEAl072kHMwD5CvrBv+x7noJudARZt26TkQKSvgcWjh6Q1EOWJaE61DgUmEkTcIk
 FLr3uULmTwD0YNhPy/xk9P2v7WQEK+AG1P9HKxPBdDh/LnQtylkB16PRhWD04JXwLdR2Yo6J
 CMXBIYC8bZ3RKUhYSqLFGVk1Fr6NFgfd0Y4YuBNdHP+Slsf+h0Htk+/LeDs60Njx1E4smjzv
 Z2SciG57mkBEFMGDAN0LlVByUAnQzMAZQmbp0O1vywnZ3HJ0qO8RE/GMoBIdKlPJkEfD/WrZ
 8k2AaquuEJVgTfWSLVX/v6XqJVv6BpAesEq0SxaTKKXZ05Zenw9E33ryjrOgbjCzF0AWcM8q
 Q78zOSpKKJKKLb0AsSQXp3wmlc1RKY1C8V7RYct1uMyi1Av04SV/RiaszLOFf47VmavVp+l0
 OqxPN+g0Bm618lbi8WwVNAlOsVAU7aLj3z6CjUlwg+w3Zj1ryA0v8TB7spkNrTh//6N4zarZ
 C4GT73V8sLZxXTdl6dk23ze2d+KmJXi3bP3hR8qqqxtHr/049rAt9rXvaphg64dxA/2mXYbA
 7njuaMvPXUV3iJEF4+XxA953hY1/xr/pff2LqVcaGh4zyXPs5sp0jT8z4Yrk4upeqAgUbDrC
 KaR8QZtMOiThCf1UIBABBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RW0iTYRjHfb+zy+XnVHzTqBxIJOSJLl4izIuID7opCM1Y2dAvNd2hzdMi
 aGkaU/JQI9TyAJrKnJlTZ5qHZlMk06WlZqmhSyo8YI3UvJCcUnb343n+/J4/PAwuek/4Mony
 FF4llyaLKQExuGlnj1oyGElIdyuFLK1HUFNxI4namlZJVGEdJlFWVSOF3uTJUIF9AUc22zMa
 DWUu0uijdj8q1XdhyGQfJ9G7jscUctyzAlRs68ZQg3WaRk8mRjD06XYdhaZf9205BkdJlN1l
 pVFO/QqJFt/OEBE+nPmFmeSM5UbAPdKOEFxhwU/AVXV+xziTQUdxPWVGmmuuvsVt9tOcZbkT
 41rG7hJcfosBcHX1azTnMB04u/ei4EQcn5yYxquCw68IEvTdq5hySpxRW67RgnW/XODKQPYY
 rFsyYrlAwIjYdgDvzBpp50LIesD1BzNELmAYnD0IraNJO3gY6vWynfhnAJv6l8mdeCCsmezA
 nUywAbBvrm1bQ23Ne759oJzszvrDsXU7cHq82Qswb0Dj9HixNgAt+bptD85m43Au55qTPdlo
 uDmsBf+Omds3tqWu7Bk4NFVCFQK29L+qpbtVS3erVgLcAPbxSrUsXqYOU4bJ+fQgtVSmTpXH
 B8UqZCaw9Wvzq8CC58BeHdMLWAaI3YSFM7RERErT1BpZL4AMLvYSugQxEpEwTqq5wasUMarU
 ZF7dC/wYQuwjdFf0R4vYeGkKn8TzSl71d4sxrr5aoOhg5biLDfhpBwTHZ6c3lzI4h91Umb/H
 UJNnCeAlblcH/R+Og0uO0/a1vRrl74D56+ewmyvESK3kS4RHclRkqNF+WWTOjD1UpHjaXFKU
 FfmjTyd7mbmiO/WrJCq9uN39/gY8r28IOJmz9nUor8wTuE0Kguc3FkIqgMF7IlxMqBOkoYG4
 Si39A/BL+J3nAgAA
X-CMS-MailID: 20181206011753epcas2p3a45b7e5e2f1758e887613df51a7ad801
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110620eucas1p14de70dc092580b684a0304b5ce771605@eucas1p1.samsung.com>
 <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_171812_558594_19609767 
X-CRM114-Status: GOOD (  23.46  )
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

SGkgTHVrYXN6LAoKT24gMjAxOOuFhCAxMuyblCAwNeydvCAyMDowNSwgTHVrYXN6IEx1YmEgd3Jv
dGU6Cj4gVGhlIHBhdGNoIHByZXBhcmVzIGRldmZyZXEgZGV2aWNlIGZvciBoYW5kbGluZyBzdXNw
ZW5kL3Jlc3VtZQo+IGZ1bmN0aW9uYWxpdHkuIFRoZSBuZXcgZmllbGRzIHdpbGwgc3RvcmUgbmVl
ZGVkIGluZm9ybWF0aW9uIGR1cmluZyB0aGlzCj4gcHJvY2Vzcy4gRGV2ZnJlcSBmcmFtZXdvcmsg
aGFuZGxlcyBvcHAtc3VzcGVuZCBEVCBlbnRyeSBhbmQgdGhlcmUgaXMgbm8KPiBuZWVkIG9mIG1v
ZHlmaWNhdGlvbnMgaW4gdGhlIGRyaXZlcnMgY29kZS4gSXQgdXNlcyBhdG9taWMgdmFyaWFibGVz
IHRvCj4gbWFrZSBzdXJlIG5vIHJhY2UgY29uZGl0aW9uIGFmZmVjdHMgdGhlIHByb2Nlc3MuCj4g
Cj4gU3VnZ2VzdGVkLWJ5OiBUb2JpYXMgSmFrb2JpIDx0amFrb2JpQG1hdGgudW5pLWJpZWxlZmVs
ZC5kZT4KPiBTdWdnZXN0ZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsLmx1YmFAcGFydG5lci5zYW1zdW5nLmNv
bT4KPiAtLS0KPiAgZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDQ3ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCj4gIGluY2x1ZGUvbGludXgvZGV2ZnJl
cS5oICAgfCAgNyArKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkKClJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1z
dW5nLmNvbT4KCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgYi9k
cml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4gaW5kZXggYTlmZDYxYi4uNDY1MTdiNiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4gKysrIGIvZHJpdmVycy9kZXZmcmVx
L2RldmZyZXEuYwo+IEBAIC0zMTYsNiArMzE2LDEwIEBAIHN0YXRpYyBpbnQgZGV2ZnJlcV9zZXRf
dGFyZ2V0KHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxLCB1bnNpZ25lZCBsb25nIG5ld19mcmVxLAo+
ICAJCQkiQ291bGRuJ3QgdXBkYXRlIGZyZXF1ZW5jeSB0cmFuc2l0aW9uIGluZm9ybWF0aW9uLlxu
Iik7Cj4gIAo+ICAJZGV2ZnJlcS0+cHJldmlvdXNfZnJlcSA9IG5ld19mcmVxOwo+ICsKPiArCWlm
IChkZXZmcmVxLT5zdXNwZW5kX2ZyZXEpCj4gKwkJZGV2ZnJlcS0+cmVzdW1lX2ZyZXEgPSBjdXJf
ZnJlcTsKPiArCj4gIAlyZXR1cm4gZXJyOwo+ICB9Cj4gIAo+IEBAIC02NjcsNiArNjcxLDkgQEAg
c3RydWN0IGRldmZyZXEgKmRldmZyZXFfYWRkX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4g
IAl9Cj4gIAlkZXZmcmVxLT5tYXhfZnJlcSA9IGRldmZyZXEtPnNjYWxpbmdfbWF4X2ZyZXE7Cj4g
IAo+ICsJZGV2ZnJlcS0+c3VzcGVuZF9mcmVxID0gZGV2X3BtX29wcF9nZXRfc3VzcGVuZF9vcHBf
ZnJlcShkZXYpOwo+ICsJYXRvbWljX3NldCgmZGV2ZnJlcS0+c3VzcGVuZF9jb3VudCwgMCk7Cj4g
Kwo+ICAJZGV2X3NldF9uYW1lKCZkZXZmcmVxLT5kZXYsICJkZXZmcmVxJWQiLAo+ICAJCQkJYXRv
bWljX2luY19yZXR1cm4oJmRldmZyZXFfbm8pKTsKPiAgCWVyciA9IGRldmljZV9yZWdpc3Rlcigm
ZGV2ZnJlcS0+ZGV2KTsKPiBAQCAtODY3LDE0ICs4NzQsMjggQEAgRVhQT1JUX1NZTUJPTChkZXZt
X2RldmZyZXFfcmVtb3ZlX2RldmljZSk7Cj4gICAqLwo+ICBpbnQgZGV2ZnJlcV9zdXNwZW5kX2Rl
dmljZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPiAgewo+ICsJaW50IHJldDsKPiArCj4gIAlp
ZiAoIWRldmZyZXEpCj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4gIAo+IC0JaWYgKCFkZXZmcmVxLT5n
b3Zlcm5vcikKPiArCWlmIChhdG9taWNfaW5jX3JldHVybigmZGV2ZnJlcS0+c3VzcGVuZF9jb3Vu
dCkgPiAxKQo+ICAJCXJldHVybiAwOwo+ICAKPiAtCXJldHVybiBkZXZmcmVxLT5nb3Zlcm5vci0+
ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+IC0JCQkJREVWRlJFUV9HT1ZfU1VTUEVORCwgTlVMTCk7
Cj4gKwlpZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPiArCQlyZXQgPSBkZXZmcmVxLT5nb3Zlcm5v
ci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+ICsJCQkJCURFVkZSRVFfR09WX1NVU1BFTkQsIE5V
TEwpOwo+ICsJCWlmIChyZXQpCj4gKwkJCXJldHVybiByZXQ7Cj4gKwl9Cj4gKwo+ICsJaWYgKGRl
dmZyZXEtPnN1c3BlbmRfZnJlcSkgewo+ICsJCXJldCA9IGRldmZyZXFfc2V0X3RhcmdldChkZXZm
cmVxLCBkZXZmcmVxLT5zdXNwZW5kX2ZyZXEsIDApOwo+ICsJCWlmIChyZXQpCj4gKwkJCXJldHVy
biByZXQ7Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gIH0KPiAgRVhQT1JUX1NZTUJPTChkZXZm
cmVxX3N1c3BlbmRfZGV2aWNlKTsKPiAgCj4gQEAgLTg4OCwxNCArOTA5LDI4IEBAIEVYUE9SVF9T
WU1CT0woZGV2ZnJlcV9zdXNwZW5kX2RldmljZSk7Cj4gICAqLwo+ICBpbnQgZGV2ZnJlcV9yZXN1
bWVfZGV2aWNlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+ICB7Cj4gKwlpbnQgcmV0Owo+ICsK
PiAgCWlmICghZGV2ZnJlcSkKPiAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgCj4gLQlpZiAoIWRldmZy
ZXEtPmdvdmVybm9yKQo+ICsJaWYgKGF0b21pY19kZWNfcmV0dXJuKCZkZXZmcmVxLT5zdXNwZW5k
X2NvdW50KSA+PSAxKQo+ICAJCXJldHVybiAwOwo+ICAKPiAtCXJldHVybiBkZXZmcmVxLT5nb3Zl
cm5vci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+IC0JCQkJREVWRlJFUV9HT1ZfUkVTVU1FLCBO
VUxMKTsKPiArCWlmIChkZXZmcmVxLT5yZXN1bWVfZnJlcSkgewo+ICsJCXJldCA9IGRldmZyZXFf
c2V0X3RhcmdldChkZXZmcmVxLCBkZXZmcmVxLT5yZXN1bWVfZnJlcSwgMCk7Cj4gKwkJaWYgKHJl
dCkKPiArCQkJcmV0dXJuIHJldDsKPiArCX0KPiArCj4gKwlpZiAoZGV2ZnJlcS0+Z292ZXJub3Ip
IHsKPiArCQlyZXQgPSBkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+
ICsJCQkJCURFVkZSRVFfR09WX1JFU1VNRSwgTlVMTCk7Cj4gKwkJaWYgKHJldCkKPiArCQkJcmV0
dXJuIHJldDsKPiArCX0KPiArCj4gKwlyZXR1cm4gMDsKPiAgfQo+ICBFWFBPUlRfU1lNQk9MKGRl
dmZyZXFfcmVzdW1lX2RldmljZSk7Cj4gIAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Rl
dmZyZXEuaCBiL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4gaW5kZXggZTQ5NjNiMC4uZDk4NTE5
OSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RldmZyZXEuaAo+ICsrKyBiL2luY2x1ZGUv
bGludXgvZGV2ZnJlcS5oCj4gQEAgLTEzMSw2ICsxMzEsOSBAQCBzdHJ1Y3QgZGV2ZnJlcV9kZXZf
cHJvZmlsZSB7Cj4gICAqIEBzY2FsaW5nX21pbl9mcmVxOglMaW1pdCBtaW5pbXVtIGZyZXF1ZW5j
eSByZXF1ZXN0ZWQgYnkgT1BQIGludGVyZmFjZQo+ICAgKiBAc2NhbGluZ19tYXhfZnJlcToJTGlt
aXQgbWF4aW11bSBmcmVxdWVuY3kgcmVxdWVzdGVkIGJ5IE9QUCBpbnRlcmZhY2UKPiAgICogQHN0
b3BfcG9sbGluZzoJIGRldmZyZXEgcG9sbGluZyBzdGF0dXMgb2YgYSBkZXZpY2UuCj4gKyAqIEBz
dXNwZW5kX2ZyZXE6CSBmcmVxdWVuY3kgb2YgYSBkZXZpY2Ugc2V0IGR1cmluZyBzdXNwZW5kIHBo
YXNlLgo+ICsgKiBAcmVzdW1lX2ZyZXE6CSBmcmVxdWVuY3kgb2YgYSBkZXZpY2Ugc2V0IGluIHJl
c3VtZSBwaGFzZS4KPiArICogQHN1c3BlbmRfY291bnQ6CSBzdXNwZW5kIHJlcXVlc3RzIGNvdW50
ZXIgZm9yIGEgZGV2aWNlLgo+ICAgKiBAdG90YWxfdHJhbnM6CU51bWJlciBvZiBkZXZmcmVxIHRy
YW5zaXRpb25zCj4gICAqIEB0cmFuc190YWJsZToJU3RhdGlzdGljcyBvZiBkZXZmcmVxIHRyYW5z
aXRpb25zCj4gICAqIEB0aW1lX2luX3N0YXRlOglTdGF0aXN0aWNzIG9mIGRldmZyZXEgc3RhdGVz
Cj4gQEAgLTE2Nyw2ICsxNzAsMTAgQEAgc3RydWN0IGRldmZyZXEgewo+ICAJdW5zaWduZWQgbG9u
ZyBzY2FsaW5nX21heF9mcmVxOwo+ICAJYm9vbCBzdG9wX3BvbGxpbmc7Cj4gIAo+ICsJdW5zaWdu
ZWQgbG9uZyBzdXNwZW5kX2ZyZXE7Cj4gKwl1bnNpZ25lZCBsb25nIHJlc3VtZV9mcmVxOwo+ICsJ
YXRvbWljX3Qgc3VzcGVuZF9jb3VudDsKPiArCj4gIAkvKiBpbmZvcm1hdGlvbiBmb3IgZGV2aWNl
IGZyZXF1ZW5jeSB0cmFuc2l0aW9uICovCj4gIAl1bnNpZ25lZCBpbnQgdG90YWxfdHJhbnM7Cj4g
IAl1bnNpZ25lZCBpbnQgKnRyYW5zX3RhYmxlOwo+IAoKCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53
b28gQ2hvaQpTYW1zdW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
