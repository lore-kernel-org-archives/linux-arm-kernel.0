Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C712C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:00:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADFC217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jnP2bQSE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R1/J+w97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADFC217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iUUbXXgQDyB8+BiimuU3Ob0joo2cf/OsqzZQeF33tcY=; b=jnP2bQSEtyuVWk
	2GaMwy6FU6xXz7yhsYqxyGqWTLjWMr3D2xdgIbmxE9SwTPqxFW9WdZPQgORHUjbWNfnwTIglyiwKd
	Esuu0o2UAp/J89s3zQiYryN5+EXdCHXGa9wd9DX2gkGbVNsRcSxpznc3mYcRM1qolwUKKIBN7eIPR
	FZCb4ar6pwHs4f/gUrOOeW3CCiLemqm9yQyr8gLX3EFKqwn9b0hx4ZnYDvG7ZgNbrZ5Gn/hTnWhG6
	5U2zHfe4epqil5s7fXtpCTYKDoKKTHBOHOoH5+LfceHGABVisOgWylAaiGmVZGamX1fYZY3/zpS5G
	ptcyLKdiS/fYXOn74lpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtMRA-0001S6-2A; Tue, 12 Feb 2019 01:00:36 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtMR4-0001QS-AU
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 01:00:33 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20190212010025epoutp0472255b29ae23f74eb9215dfdd0dfab9f~CeA5wv4981381013810epoutp04I
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 01:00:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20190212010025epoutp0472255b29ae23f74eb9215dfdd0dfab9f~CeA5wv4981381013810epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549933225;
 bh=VA0lNo4csi/ad0keB4R7g0GZE7isxRAd21ddeg5CWoY=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=R1/J+w97QMPLGA8EUVSNPyRCy1Zkp/2riiLq45nLa0OR871+WI2ozmkg9Je1AcGx1
 83cNqM7JKCI4n25O93FoAbdIqol6DVkkBivln1zCW2NBF6ID01/56NEixxxsWZ4WMd
 cFdzOXMjAOqfR33X4JVa1Nb8X/9bUZOiImfJwXpA=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190212010021epcas1p181e7dd376c45ec30fcd6f075ddfcdb4f~CeA2KXoVO0448204482epcas1p1C;
 Tue, 12 Feb 2019 01:00:21 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 97.DC.04074.5AA126C5; Tue, 12 Feb 2019 10:00:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20190212010020epcas1p30ed98e10f06aaf90e1c6c35e8391d2e1~CeA1ulgD43144631446epcas1p3a;
 Tue, 12 Feb 2019 01:00:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190212010020epsmtrp233393632d7a60ce5d0c3cca8c5971626~CeA1tIk-v0992709927epsmtrp2j;
 Tue, 12 Feb 2019 01:00:20 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-53-5c621aa52c3c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D5.CB.03601.4AA126C5; Tue, 12 Feb 2019 10:00:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190212010020epsmtip12c63fd5255a1c95fc074167873d5d94f~CeA1c0Ie60770907709epsmtip1c;
 Tue, 12 Feb 2019 01:00:20 +0000 (GMT)
Subject: Re: [PATCH 2/3] dt-bindings: devfreq: add compatible for mt8183 cci
 devfreq
To: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <803eacf2-a3c7-a4d0-682a-837b7367bf2f@samsung.com>
Date: Tue, 12 Feb 2019 10:00:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548743704-16821-3-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmru5SqaQYg6ObBCy2r3/BajH/yDlW
 i293fjNZnG16w26x6fE1VovLu+awWVxuvsho8bn3CKPF0usXmSyaWowtbjeuYLM4c/oSq0Xr
 3iPsFtPvClls/OrhwO+xZt4aRo+ds+6ye2xa1cnmcefaHjaPzUvqPVpO7mfx2HK1ncWjb8sq
 Ro/Pm+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
 MnOAzldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn5haX5qXrJefnWhka
 GBiZAhUmZGc0/V/GWLBPoOLX003MDYzLebsYOTkkBEwkrtycw9LFyMUhJLCDUeLV1cuMEM4n
 Romze46wQjjfGCUObjvDAtNy/NshJhBbSGAvo8Siu3oQRe8ZJfYc+M0OkhAWCJO49WUbWLeI
 wEUmiW1L1jKDJJgFbjFKvN7PBmKzCWhJ7H9xA8zmF1CUuPrjMSOIzStgJ9F87C+YzSKgKtFy
 fTfYNlGBCInDve+gagQlTs58AnYRp4CvxJz+vewQ88Ulbj2ZzwRhy0s0b53NDHKEhMApdolT
 n7YyQrzgIrFv7iqod4QlXh3fwg5hS0l8freXDcKullh58ggbRHMHo8SW/RdYIRLGEvuXTgba
 wAG0QVNi/S59iGV8Eu++9rCChCUEeCU62oQgqpUlLj+4ywRhS0osbu+EGu8h8WHlM6YJjIqz
 kLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBYbI0b2JEZy2tUx3ME4553OIUYCDUYmHVyE3
 MUaINbGsuDL3EKMEB7OSCK+BcFKMEG9KYmVValF+fFFpTmrxIUZTYGhPZJYSTc4H5pS8knhD
 UyNjY2MLE0MzU0NDJXHe9Q7OMUIC6YklqdmpqQWpRTB9TBycUg2Me1qzNjlM563uvFS86OeC
 b6Fr3VozGb+Hf72puXnTwslTI/nNRcrt0ick7An4s/H05PjJ3eXy3FFS98I9JP4cFzIL3lrH
 /y58i2LYjTQe1hkfEmvNV+q9Lr0VeTLz758Hd75KFnzi2BXb3THr2q2oq79LTy5w3rSnvOGN
 s9A9yTNOZYsmTNDcrcRSnJFoqMVcVJwIAM12fKLxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSnO4SqaQYg0XndSy2r3/BajH/yDlW
 i293fjNZnG16w26x6fE1VovLu+awWVxuvsho8bn3CKPF0usXmSyaWowtbjeuYLM4c/oSq0Xr
 3iPsFtPvClls/OrhwO+xZt4aRo+ds+6ye2xa1cnmcefaHjaPzUvqPVpO7mfx2HK1ncWjb8sq
 Ro/Pm+QCOKO4bFJSczLLUov07RK4Mpr+L2Ms2CdQ8evpJuYGxuW8XYycHBICJhLHvx1i6mLk
 4hAS2M0oseTMIUaIhKTEtItHmbsYOYBsYYnDh4shat4ySsxbsY8JpEZYIEzi1pdtrCAJEYGr
 TBK9E9tYQBxmgVuMEpuaj7BDtDxmlHh3vIkdpIVNQEti/4sbbCA2v4CixNUfj8HW8QrYSTQf
 +wtmswioSrRc3w22QlQgQuLjU4h1vAKCEidnPmEBsTkFfCXm9O8Fm8ksoC7xZ94lZghbXOLW
 k/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L
 10vOz93ECI5hLa0djCdOxB9iFOBgVOLhVchNjBFiTSwrrsw9xCjBwawkwmsgnBQjxJuSWFmV
 WpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgTHiF3eN65HTjqJ/dGdJ
 CUfzzrd3fH5SU//hRiuTDUwnQ574ihhU6eyzPfW+doP1a7NkqTStdzUzlqeH5u8tb5S+u7FN
 NvQox6KkpLc/f0/WqshLFrvqlPD378RPmq2v8357H1jHVDdz3u0X1ZER0n7zfX7/E7x/YUVa
 SvXFg88b2Y76nK2vuKfEUpyRaKjFXFScCAB/fZXv3QIAAA==
X-CMS-MailID: 20190212010020epcas1p30ed98e10f06aaf90e1c6c35e8391d2e1
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190129063540epcas2p2562f42dd248030292eb438259e54236b
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <CGME20190129063540epcas2p2562f42dd248030292eb438259e54236b@epcas2p2.samsung.com>
 <1548743704-16821-3-git-send-email-andrew-sh.cheng@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_170030_691198_2BC3A6E0 
X-CRM114-Status: GOOD (  22.69  )
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
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, fan.chen@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQW5kcmV3LXNoLkNoZW5nLAoKT24gMTkuIDEuIDI5LiDsmKTtm4QgMzozNSwgQW5kcmV3LXNo
IENoZW5nIHdyb3RlOgo+IEZyb206ICJBbmRyZXctc2guQ2hlbmciIDxhbmRyZXctc2guY2hlbmdA
bWVkaWF0ZWsuY29tPgo+IAo+IFRoaXMgYWRkcyBkdC1iaW5kaW5nIGRvY3VtZW50YXRpb24gb2Yg
Y2NpIGRldmZyZXEKPiBmb3IgTWVkaWF0ZWsgTVQ4MTgzIFNvQyBwbGF0Zm9ybS4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZXctc2guQ2hlbmcgPGFuZHJldy1zaC5jaGVuZ0BtZWRpYXRlay5jb20+
Cj4gLS0tCj4gIC4uLi9iaW5kaW5ncy9kZXZmcmVxL210ODE4My1jY2ktZGV2ZnJlcS50eHQgICAg
ICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5z
ZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2RldmZyZXEvbXQ4MTgzLWNjaS1kZXZmcmVxLnR4dAo+IAo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGV2ZnJlcS9tdDgxODMtY2NpLWRl
dmZyZXEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RldmZyZXEvbXQ4
MTgzLWNjaS1kZXZmcmVxLnR4dAo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAw
MC4uZTJiNjFjZgo+IC0tLSAvZGV2L251bGwKPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGV2ZnJlcS9tdDgxODMtY2NpLWRldmZyZXEudHh0Cj4gQEAgLTAsMCArMSwx
OSBAQAo+ICsqIE1lZGlhdGVrIENDSSBmcmVxdWVuY3kgZGV2aWNlCgpZb3UgaGF2ZSB0byBhZGQg
bW9yZSBkZXRhaWxlZCB3aGF0IHRvIGRvIG9uIHRoaXMgZHJpdmVyLgpBbHNvLCBwbGVhc2UgYWRk
IHRoZSBmdWxsIGFscGhhYmV0IGZvciBDQ0kuCgo+ICsKPiArUmVxdWlyZWQgcHJvcGVydGllczoK
PiArLSBjb21wYXRpYmxlOiBzaG91bGQgY29udGFpbiAibWVkaWF0ZWssbXQ4MTgzLWNjaSIgZm9y
IGNjaSBkZXZmcmVxCgpVc3VhbGx5LCBkdC1iaW5kaW5nIGRvY3VtZW50IG9ubHkgc3BlY2lmaWVz
IGgvdyBpbmZvcm1hdGlvbgphbmQgaG93IHRvIGJpbmQgZGV2aWNlLiAnZGV2ZnJlcScgaXMgdGhl
IHdvcmQgb2YgbGludXgtc2lkZS4KSXQgbWVhbnMgdGhhdCAnZGV2ZnJlcScgY2Fubm90IGluZGlj
YXRlIHRoZSBhbnkgaC93IGRldmljZS4KCllvdSBzaG91bGQgdXNlIHRoZSBoL3cgZGV2aWNlIGlu
Zm9ybWF0aW9uIGFuZCB3b3JkIG9mIENDSSBmb3Igd3JpdGluZwp0aGUgZHQtYmluZGluZyBkb2N1
bWVudCB3aXRob3V0IGxpbnV4LXNpZGUgd29yZCBsaWtlIGRldmZyZXEuCgpGb3IgZXhhbXBsZSwg
Ci0gY2NpIGRldmZyZXEgLT4gZnJlcXVlbmN5IHNjYWxpbmcgb2YgQ0NJCgo+ICsKClJlbW92ZSB1
bm5lZWRlZCBibGFuayBsaW5lLgoKPiArLSBjbG9ja3M6IGZvciBjY2kgZGV2ZnJlcQoKZGl0dG8g
b2YgJ2RldmZyZXEnIHdvcmQuCgo+ICsKCmRpdHRvIG9mIGJsYW5rIGxpbmUKCj4gKy0gY2xvY2st
bmFtZXM6IGZvciBjY2kgZGV2ZnJlcSBkcml2ZXIgdG8gcmVmZXJlbmNlCgpkaXR0byBvZiAnZGV2
ZnJlcScgd29yZC4KCj4gKwoKZGl0dG8gb2YgYmxhbmsgbGluZQoKPiArLSBvcGVyYXRpbmctcG9p
bnRzLXYyOiBmb3IgY2NpIGRldmZyZXEgb3BwIHRhYmxlCgpkaXR0byBvZiAnZGV2ZnJlcScgd29y
ZC4KCj4gKwo+ICtFeGFtcGxlOgo+ICsJY2NpOiBjY2kgewo+ICsJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssY2NpIjsKPiArCQljbG9ja3MgPSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfQ0NJUExM
PjsKPiArCQljbG9jay1uYW1lcyA9ICJjY2lfY2xvY2siOwo+ICsJCW9wZXJhdGluZy1wb2ludHMt
djIgPSA8JmNjaV9vcHA+Owo+ICsJfTsKPiArCj4gCgpUaGlzIGRvY3VtZW50IGlzIG1pc3Npbmcg
dGhlICdyZWd1bGF0b3InIHByb3BlcnR5LiBQbGVhc2UgYWRkIGl0CgotLSAKQmVzdCBSZWdhcmRz
LApDaGFud29vIENob2kKU2Ftc3VuZyBFbGVjdHJvbmljcwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
