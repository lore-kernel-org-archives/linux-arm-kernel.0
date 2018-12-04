Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A615C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:40:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7FF20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WA6lNdfk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B59GUeRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7FF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Subject:To:From:
	Date:Message-id:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G9IaLNXCWAPYuMWJZjaqHh4BeT81U46hQUPO4q6si0s=; b=WA6lNdfk8pOI8G
	M4n+JVq7+9oqkaP7gLIk5ISfz3JDtqwUr13X6MapyPcb2SLokTi7bml9sfFp7nwKR8ODg4q9ukAtZ
	OlyI6Pk49uw9TtciowrQ/sRlSjO4k/vanmf7wqR0TEm6U3jZv0a5fHdQ+UfYB1ZsS0sUcFL/kV2BB
	lXKMnpLmAqv2wBaZVPIiJdiks6taZApw82ZpujrCbGAR/jVISLeZxY/b3E2GA2PZL2WRKYAQz0j8b
	QDuigiPLPcph5s+qceiUisF1ngLrat6L+4S1o0090BIh80txcI+Davu724Eq55CiTXzLgBjvQ7KpG
	n0eWrhKno3cTbOFekVmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU2VH-0003Sw-GG; Tue, 04 Dec 2018 04:40:11 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU2VD-0002Dp-L2
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 04:40:09 +0000
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20181204043950epoutp01606f64eac8b6135d5033c0840b1f6a79~tB2gI20eR1222212222epoutp01I;
 Tue,  4 Dec 2018 04:39:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20181204043950epoutp01606f64eac8b6135d5033c0840b1f6a79~tB2gI20eR1222212222epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543898390;
 bh=FStVKS8Y+vrU/6MdfWAaEVGW8zwAeikhlhRYJ4rjjaY=;
 h=Date:From:To:Cc:Subject:In-reply-to:References:From;
 b=B59GUeRjjCYK5G+AsiVnVIvwkekWxQLaIUIyJawPxPuuZqM8zw3lxruPR3t9mZdxh
 hMqZSD9ooSURPjuewEUm2ZUPDkY6aj92YvtGiR6A4zfFKizFuXs2QB26wF3f+B4pSh
 Tyf9ITmGtnjf+iz1+KgZX3PIUpzx1g7qWudQHwt8=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181204043947epcas1p28327d1824343c3b03104d1b55ec51907~tB2cwdzjz2636026360epcas1p2J;
 Tue,  4 Dec 2018 04:39:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 AA.9C.04146.215060C5; Tue,  4 Dec 2018 13:39:46 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181204043946epcas1p130439f684c1137c352588bff19927815~tB2cDgM1A2960229602epcas1p17;
 Tue,  4 Dec 2018 04:39:46 +0000 (GMT)
X-AuditID: b6c32a38-177ff70000001032-50-5c060512249b
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
 (Symantec Messaging Gateway) with SMTP id B4.EF.03601.115060C5; Tue,  4 Dec
 2018 13:39:46 +0900 (KST)
MIME-version: 1.0
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJ700CC03M96J10@mmp2.samsung.com>; Tue, 04 Dec 2018 13:39:45 +0900 (KST)
Message-id: <5C060511.8020802@samsung.com>
Date: Tue, 04 Dec 2018 13:39:45 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.6.0
To: Lukasz Luba <l.luba@partner.samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] devfreq: refactor set_target frequency function
In-reply-to: <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmga4QK1uMwefVehYHt2pabJyxntVi
 +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
 NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
 xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
 udrO4tG3ZRWjx4rV39k9Pm+SC+CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
 V1LIS8xNtVVy8QnQdcvMAXpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBX
 nJhbXJqXrpecn2tlaGBgZApUmJCdMWfvHLaCFTIV3Vfa2BoYO8S7GDk5JARMJPr372bsYuTi
 EBLYwSgx7/oCZgjnO6PE/y07mWCqOqY8g0psYJR4/HgVI0iCV0BQ4sfkeyxdjBwczALyEkcu
 ZYOEmQU0JV58mcQCUX+XUWJV32uoei2J84dXsIPYLAKqEl8nHWIBsdmA4vtf3GADsfkFFCWu
 /ngMVi8qECGxc/43dpBBIgLnGSXW7NzDBOIwC7QyS/z7sAWsQ1jAW2JJy1uwSZwCXhK7H58D
 Wy0h8JNd4vW9B6wQP7hI7D60gR3CFpZ4dXwLO8jZEgLSEpeO2kLUtzNKfHnRzArhTGCU+HBq
 MzQAjCWeLexigniOT+Ld1x5WiGZeiY42IYgSD4mrX3eCHQT28+XtFRMYZWchhdIsRCjNQgql
 BYzMqxjFUguKc9NTiw0LTJDjbxMjOLFrWexg3HPO5xCjAAejEg/vDCfWGCHWxLLiytxDjBIc
 zEoivAWFLDFCvCmJlVWpRfnxRaU5qcWHGE2BgTyRWUo0OR+YdfJK4g1NjYyNjS1MDM1MDQ2V
 xHmfSM2NFhJITyxJzU5NLUgtgulj4uCUamA8JnZsO6NrlZmH1yLLZRw79ukd/SLxwDjjTvYM
 mWW5ovlTb71/n+WvxfCrtyHR78vKhBKG9g4u8Xs597dYhx+dbytZeLA/RvbZiln3a5/vKGdX
 yn9f2f1rz/+zbu+/VDucFs+0exKVveTphS/C53ZuyXQyET474+Aex4IwuaRIKQk99cCZZWlK
 LMUZiYZazEXFiQAEweNLAgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RXUhTYRzGe3c+Xa6Oy/B1mdUgRCPN6OIlpKSbjvMm6KIswUY7qOnm3HGm
 Xugsv8WvGiHLL3DVUtP8mqFOcy6NLJerZSQqOKgkk1AqE7Q8jbC7H//n4Xke+NOY1I3L6GRN
 BqfTKFPlpBif2PT4HZUSZPyxIasYjfSGos7aDgL1df4gUKNjkkA3mztI9LJcjao8XzDkdD6m
 0KsbSxT6YAhCJqNNhLo87wj0pr+ORKsVDoBqnUMi9MgxS6F701MiNJNvIdHsi2dbGRMuAhXa
 HBQqav1GoKXXc3h0AGsdsBJsW0MbYO8apnC2umoFsM2DiyK2q6WUZIfr2yi225zHbo5R7Mjy
 oIjtcRfjbGVPC2AtrT8pdrUr+NyuS+IoFZeanMnpIk5dESfV2epIrSUoq/xtEWkAJQFlwIeG
 zAlYYvyIlQExLWXaAaxxLQNBkDB+cO32HF4GaBpjDkCHK8WLIdBoVHvt8wAujv/GvPYw6By1
 UALjzGH4/ZYdF5jcug9/fk8KvJs5BN1rHiDk7GUuwvLn2UKOP+MEcKSylBA8GFOIwYWiawLv
 YWKhueAr7i2bBbChuONvmQ+jgAOeSbwaMKb/ppq2p5q2pzYBrAUEclpenajmj2sjNdz1cF6p
 5vWaxPCraeousPVs62hY5RMwb06wA4YGcl9J7RkiXkooM/lstR1AGpP7S7TpeLxUolJm53C6
 tASdPpXj7WAfjcsDJDOasTgpk6jM4FI4Tsvp/qki2kdmAEzauPnB6U+2et61f+dIY57ePzNi
 5sjw5Zrc/BiV2WqdLihdcc/FaUP6fdnlUHGCgj9voZ8qotp/pVfMy2wPF7JimlRuzf2N4Bz7
 2Y2JOtednhBFp7n7YP14kL4wcAclqemW95FUoYTrHY0PUdkq12M5GdmUe+GkrH49WifH+SRl
 ZBim45V/ACZ7Na3oAgAA
X-CMS-MailID: 20181204043946epcas1p130439f684c1137c352588bff19927815
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5@eucas1p2.samsung.com>
 <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_204007_881810_6F78D178 
X-CRM114-Status: GOOD (  26.43  )
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

SGkgTHVrYXN6LAoKT24gMjAxOOuFhCAxMuyblCAwM+ydvCAyMzozMSwgTHVrYXN6IEx1YmEgd3Jv
dGU6Cj4gVGhlIHJlZmFjdG9yaW5nIGlzIG5lZWRlZCBmb3IgdGhlIG5ldyBjbGllbnQgaW4gZGV2
ZnJlcTogc3VzcGVuZC4KPiBUbyBhdm9pZCBjb2RlIGR1cGxpY2F0aW9uLCBtb3ZlIGl0IHRvIHRo
ZSBuZXcgbG9jYWwgZnVuY3Rpb24KPiBkZXZmcmVxX3NldF90YXJnZXQuCj4gCj4gVGhlIHBhdGNo
IGlzIGJhc2VkIG9uIGVhcmxpZXIgd29yayBieSBUb2JpYXMgSmFrb2JpLgoKQXMgSSBhbHJlYWR5
IGNvbW1lbnRlZCwgUGxlYXNlIHJlbW92ZSBpdC4gWW91IGFscmVhZHkgbWVudGlvbmVkIGl0IG9u
IGNvdmVyLWxldHRlci4KSWYgeW91IHdhbnQgdG8gY29udGFpbiB0aGUgY29udHJpYnV0aW9uIGhp
c3Rvcnkgb2YgVG9iaWFzLCB5b3UgbWlnaHQgYmV0dGVyCnRvIGFkZCAnU2lnbmVkLW9mZi1ieScg
b3Igb3RoZXJzLgoKPiAKPiBTdWdnZXN0ZWQtYnk6IFRvYmlhcyBKYWtvYmkgPHRqYWtvYmlAbWF0
aC51bmktYmllbGVmZWxkLmRlPgo+IFN1Z2dlc3RlZC1ieTogQ2hhbndvbyBDaG9pIDxjdzAwLmNo
b2lAc2Ftc3VuZy5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTHVrYXN6IEx1YmEgPGwubHViYUBwYXJ0
bmVyLnNhbXN1bmcuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIHwgNjIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEu
Ywo+IGluZGV4IDE0MTQxMzAuLmE5ZmQ2MWIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9kZXZmcmVx
L2RldmZyZXEuYwo+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPiBAQCAtMjg1LDYg
KzI4NSw0MCBAQCBzdGF0aWMgaW50IGRldmZyZXFfbm90aWZ5X3RyYW5zaXRpb24oc3RydWN0IGRl
dmZyZXEgKmRldmZyZXEsCj4gIAlyZXR1cm4gMDsKPiAgfQo+ICAKPiArc3RhdGljIGludCBkZXZm
cmVxX3NldF90YXJnZXQoc3RydWN0IGRldmZyZXEgKmRldmZyZXEsIHVuc2lnbmVkIGxvbmcgbmV3
X2ZyZXEsCj4gKwkJCSAgICAgIHUzMiBmbGFncykKPiArewo+ICsJc3RydWN0IGRldmZyZXFfZnJl
cXMgZnJlcXM7Cj4gKwl1bnNpZ25lZCBsb25nIGN1cl9mcmVxOwo+ICsJaW50IGVyciA9IDA7Cj4g
Kwo+ICsJaWYgKGRldmZyZXEtPnByb2ZpbGUtPmdldF9jdXJfZnJlcSkKPiArCQlkZXZmcmVxLT5w
cm9maWxlLT5nZXRfY3VyX2ZyZXEoZGV2ZnJlcS0+ZGV2LnBhcmVudCwgJmN1cl9mcmVxKTsKPiAr
CWVsc2UKPiArCQljdXJfZnJlcSA9IGRldmZyZXEtPnByZXZpb3VzX2ZyZXE7Cj4gKwo+ICsJZnJl
cXMub2xkID0gY3VyX2ZyZXE7Cj4gKwlmcmVxcy5uZXcgPSBuZXdfZnJlcTsKPiArCWRldmZyZXFf
bm90aWZ5X3RyYW5zaXRpb24oZGV2ZnJlcSwgJmZyZXFzLCBERVZGUkVRX1BSRUNIQU5HRSk7Cj4g
Kwo+ICsJZXJyID0gZGV2ZnJlcS0+cHJvZmlsZS0+dGFyZ2V0KGRldmZyZXEtPmRldi5wYXJlbnQs
ICZuZXdfZnJlcSwgZmxhZ3MpOwo+ICsJaWYgKGVycikgewo+ICsJCWZyZXFzLm5ldyA9IGN1cl9m
cmVxOwo+ICsJCWRldmZyZXFfbm90aWZ5X3RyYW5zaXRpb24oZGV2ZnJlcSwgJmZyZXFzLCBERVZG
UkVRX1BPU1RDSEFOR0UpOwo+ICsJCXJldHVybiBlcnI7Cj4gKwl9Cj4gKwo+ICsJZnJlcXMubmV3
ID0gbmV3X2ZyZXE7Cj4gKwlkZXZmcmVxX25vdGlmeV90cmFuc2l0aW9uKGRldmZyZXEsICZmcmVx
cywgREVWRlJFUV9QT1NUQ0hBTkdFKTsKPiArCj4gKwlpZiAoZGV2ZnJlcV91cGRhdGVfc3RhdHVz
KGRldmZyZXEsIG5ld19mcmVxKSkKPiArCQlkZXZfZXJyKCZkZXZmcmVxLT5kZXYsCj4gKwkJCSJD
b3VsZG4ndCB1cGRhdGUgZnJlcXVlbmN5IHRyYW5zaXRpb24gaW5mb3JtYXRpb24uXG4iKTsKPiAr
Cj4gKwlkZXZmcmVxLT5wcmV2aW91c19mcmVxID0gbmV3X2ZyZXE7Cj4gKwlyZXR1cm4gZXJyOwo+
ICt9Cj4gKwo+ICAvKiBMb2FkIG1vbml0b3JpbmcgaGVscGVyIGZ1bmN0aW9ucyBmb3IgZ292ZXJu
b3JzIHVzZSAqLwo+ICAKPiAgLyoqCj4gQEAgLTI5Niw4ICszMzAsNyBAQCBzdGF0aWMgaW50IGRl
dmZyZXFfbm90aWZ5X3RyYW5zaXRpb24oc3RydWN0IGRldmZyZXEgKmRldmZyZXEsCj4gICAqLwo+
ICBpbnQgdXBkYXRlX2RldmZyZXEoc3RydWN0IGRldmZyZXEgKmRldmZyZXEpCj4gIHsKPiAtCXN0
cnVjdCBkZXZmcmVxX2ZyZXFzIGZyZXFzOwo+IC0JdW5zaWduZWQgbG9uZyBmcmVxLCBjdXJfZnJl
cSwgbWluX2ZyZXEsIG1heF9mcmVxOwo+ICsJdW5zaWduZWQgbG9uZyBmcmVxLCBtaW5fZnJlcSwg
bWF4X2ZyZXE7Cj4gIAlpbnQgZXJyID0gMDsKPiAgCXUzMiBmbGFncyA9IDA7Cj4gIAo+IEBAIC0z
MzMsMzEgKzM2Niw4IEBAIGludCB1cGRhdGVfZGV2ZnJlcShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJl
cSkKPiAgCQlmbGFncyB8PSBERVZGUkVRX0ZMQUdfTEVBU1RfVVBQRVJfQk9VTkQ7IC8qIFVzZSBM
VUIgKi8KPiAgCX0KPiAgCj4gLQlpZiAoZGV2ZnJlcS0+cHJvZmlsZS0+Z2V0X2N1cl9mcmVxKQo+
IC0JCWRldmZyZXEtPnByb2ZpbGUtPmdldF9jdXJfZnJlcShkZXZmcmVxLT5kZXYucGFyZW50LCAm
Y3VyX2ZyZXEpOwo+IC0JZWxzZQo+IC0JCWN1cl9mcmVxID0gZGV2ZnJlcS0+cHJldmlvdXNfZnJl
cTsKPiAtCj4gLQlmcmVxcy5vbGQgPSBjdXJfZnJlcTsKPiAtCWZyZXFzLm5ldyA9IGZyZXE7Cj4g
LQlkZXZmcmVxX25vdGlmeV90cmFuc2l0aW9uKGRldmZyZXEsICZmcmVxcywgREVWRlJFUV9QUkVD
SEFOR0UpOwo+ICsJcmV0dXJuIGRldmZyZXFfc2V0X3RhcmdldChkZXZmcmVxLCBmcmVxLCBmbGFn
cyk7Cj4gIAo+IC0JZXJyID0gZGV2ZnJlcS0+cHJvZmlsZS0+dGFyZ2V0KGRldmZyZXEtPmRldi5w
YXJlbnQsICZmcmVxLCBmbGFncyk7Cj4gLQlpZiAoZXJyKSB7Cj4gLQkJZnJlcXMubmV3ID0gY3Vy
X2ZyZXE7Cj4gLQkJZGV2ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbihkZXZmcmVxLCAmZnJlcXMsIERF
VkZSRVFfUE9TVENIQU5HRSk7Cj4gLQkJcmV0dXJuIGVycjsKPiAtCX0KPiAtCj4gLQlmcmVxcy5u
ZXcgPSBmcmVxOwo+IC0JZGV2ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbihkZXZmcmVxLCAmZnJlcXMs
IERFVkZSRVFfUE9TVENIQU5HRSk7Cj4gLQo+IC0JaWYgKGRldmZyZXFfdXBkYXRlX3N0YXR1cyhk
ZXZmcmVxLCBmcmVxKSkKPiAtCQlkZXZfZXJyKCZkZXZmcmVxLT5kZXYsCj4gLQkJCSJDb3VsZG4n
dCB1cGRhdGUgZnJlcXVlbmN5IHRyYW5zaXRpb24gaW5mb3JtYXRpb24uXG4iKTsKPiAtCj4gLQlk
ZXZmcmVxLT5wcmV2aW91c19mcmVxID0gZnJlcTsKPiAtCXJldHVybiBlcnI7Cj4gIH0KPiAgRVhQ
T1JUX1NZTUJPTCh1cGRhdGVfZGV2ZnJlcSk7Cj4gIAo+IAoKCi0tIApCZXN0IFJlZ2FyZHMsCkNo
YW53b28gQ2hvaQpTYW1zdW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
