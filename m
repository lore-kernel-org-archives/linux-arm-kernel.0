Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:37:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACA72082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P/ao8IHA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HkQPftd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACA72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EEZgq+skJ3HFQTBqtJG6FIRFTqtSUUr059QGXuBuL8w=; b=P/ao8IHAEsBAR3
	iXUwJ3zTrhVjBN9fxSsevKcVajlQuP2aLNTmFCnfz6iNHvk+zdoDZBJCpPMyuBxbWj7ohEVahgFLo
	fyUDXhZyFW8afUFJ/o0HTjdhPM1lXCs08tzqsQyNYykNwZ/BDDJodO3R0SZ0IqMei+x1s+4Tx56U3
	DPjIAHEnGdQoamR5dwk9LIHVrSnvvL92G37OoolXc37TkMr7aNIq9RASqUOuX3UOArlj75i+74DUR
	wS7owGt7RiT/fRvIxT+mCa8A7vPSi5eKKVHmj0BWgn0KRINhT3sTWI+9RcBwWjDX38XosvcNwf4i1
	UuQPQAg/jvZke796Gvdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU78j-00076S-6o; Tue, 04 Dec 2018 09:37:13 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU78f-0006xO-5t
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:37:11 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181204093655euoutp02e4cd1b253e0acdba2028245a9afbbc9f~tF54-FBwz1066110661euoutp02R
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 09:36:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181204093655euoutp02e4cd1b253e0acdba2028245a9afbbc9f~tF54-FBwz1066110661euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543916215;
 bh=5oHwbkNBwZ8vyA7aiFkSdMNnG2mYoDqJwLr7psoNemc=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=HkQPftd/kukHaVN4am1IcXmytVT/aRGRvroja5EID4/igZMKc9vk9b+EBWn7zwxxU
 dD5975dRhB5O0u5J2m9mmPw0UXsluuUe+NYKQRf7VXOPQpO2KdC/Dh/w9kHpP/iCn6
 rJ9QmOpZfKa2BigTskWmfsxAwCVAhV3gV/NEaGLE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181204093654eucas1p2d116d06566f9845accdc7c3863f5fe8a~tF54Ju3rX1999119991eucas1p2f;
 Tue,  4 Dec 2018 09:36:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 18.A7.04441.6BA460C5; Tue,  4
 Dec 2018 09:36:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181204093653eucas1p131c58415f6a494ca38c28bce87663f25~tF53C37vv1164211642eucas1p1p;
 Tue,  4 Dec 2018 09:36:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181204093653eusmtrp24278476d6886c845d59dbb463545726c~tF52zHntu0363703637eusmtrp2S;
 Tue,  4 Dec 2018 09:36:53 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-49-5c064ab6b0f6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.90.04128.5BA460C5; Tue,  4
 Dec 2018 09:36:53 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181204093652eusmtip20f4a75b67b676023661632c12d2b8ef0~tF512CYcj2472424724eusmtip2e;
 Tue,  4 Dec 2018 09:36:52 +0000 (GMT)
Subject: Re: [PATCH v2 1/5] devfreq: refactor set_target frequency function
To: Chanwoo Choi <cw00.choi@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <545653c6-d68f-9177-6765-15a1beccb60f@partner.samsung.com>
Date: Tue, 4 Dec 2018 10:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C060511.8020802@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTaRSG/XpX0JqP6tgT11iNGxEko+HDFeOSG52JM3/UKMlMHe8gGVq1
 F1BHowiCFTc0aqGyGEElpQattRRQUEAJi2wOMoNUajAaGVECuEWDcrk18u85y5vzvsnhKU0m
 O56PMsaIJqM+Wsf60677H+vnutawEfPOtkwhd2/OJtfTChhSeP0dQ1r7XzAku7KeIYk5BSyp
 O2ogJzv/p0hDwzWOPEh4xRHrmdsq4uh8xJCHxRks6TteiUhaQ6mKXK30cORSa5OKPD6YxxJP
 zb1BfW0zQ5JuV3IkOb+HIa8an9DhWsFV4mIEe5YdCefjm2gh9WQvEnJuvVQJDtsRVijLtHPC
 jdwDwsB9TnC2HKaFE04bEvLy33NCn2PyL+pN/ou3itFRcaIpeOnv/ts8HVZ2R92k3fWXnlDx
 yAwpyI8HPB+uZp5iU5A/r8F5CLrak2il6Efg+ZjuK/oQ3M16rvom+VDYQymDKwhep/xDyQMN
 7kZgzoqSeQxeC7mHuofUY3EtgrKy8qEjFE6iYKDHOVjwPIuDwG3bKaMar4YE7xZZS+PpUGFJ
 42T+AW8Ec0c+K7MaB0B1+jNaZj8cCL39hUM7FNZC27NslcJTIPHm+SFzgL08NPsEgFdC64nX
 nMJjoKvK6eOJ8KUo25dMggdmG6vwPjhc7fbtLIKKqiZG9knh2VBQHKy0l4OlKIGT24BHw7/d
 AYqF0XDaZaGUthrMyRplexY4jzX6Do2DK/ZzXCrSWYcFsw4LYx0Wxvr97gVE25BWjJUMkaIU
 YhR3BUl6gxRrjAz6Y7vBgQaftnagqteN3jZvKUeYR7pR6vBwJkLD6OOkPYZyBDylG6tun8FG
 aNRb9Xv+Fk3bfzPFRotSOZrA0zqteu8I72YNjtTHiH+J4g7R9G2q4v3Gx6PcBS8u/1RS5Bk5
 0j3t6Z3smuDasLZSMTVwXUro5c/GT6ri/5bZp/16B6Ynl9oWQl7CBW9b2nPLl9B5mV0ZYYkH
 vX9yj9tnhm3wVIS65/d8bv5x34oJ3nv2mJYVSwYcTu3cORd/fmN5mrG+U2sN8OuI09Z5pazG
 tR2GhSG3clZNLV2+X0dL2/QhcyiTpP8KAXFL5bADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO/e1O/HGbWkehDKmFRZOpy6PZRH9EZfS6AXmo2zVbVpus90p
 KUU+eyxKC8O1SsuUbFrm0k2sJZoZpbVUelD5CI1aag+VMhDJNQL/+xy+53PO7wdfGpdYSF86
 RaPndRplqpTyIDqmn/QFNWykEkOsY/NQS0MgqjPWkshW94tEbyY+k6is7QWJ8m7UUqjzjBoV
 Dg7jyOG4K0LPc0dEyFRsx5Bl8DWJepquUGj8bBtARsdDDN1u6xWhyjddGHqfU0Wh3mePZ/yO
 bhIV2NtE6ET1DxKNvOwj1vlw1vtWkqsprQHc5ewugisqHAPcjQdOjLOYT1Nc89UaEXev4jg3
 3S7i6l+dJLhz9WbAVVX/FnHjlkVbmHhZlE6brucXJ2sF/RppghyFyuSRSBYaHimTh0XsWhWq
 kAavjdrPp6Zk8LrgtXtkyb39Jiqtc+GRF5V9eDY4BQ1ATEM2HE7afuAG4EFL2EoA65tuUe5g
 Abzw0CZy83w49dpAuS8NA9hvs2OuYD67CVbkjxKuwIvtALDY8QxzHXC2AIfO0XLgVqYBPD0x
 SRoATVOsDDaaD7uQYTfA3IG9rocINgA+KjH++82b3QmfO+8AFzPsPPj00hDhYjG7Ao5NuCfC
 2ZWw9N5H3M0+8N1QGeZmP5jXcBkvAhLTLN00SzHNUkyzlGuAMAMvPl1Qq9RCqExQqoV0jUq2
 T6u2gJm+WNv/1DcCw7ftrYClgdSTMa4nEyWkMkPIVLcCSONSL+bDUipRwuxXZmbxOm2SLj2V
 F1qBYma587iv9z7tTPs0+iS5Qh6BIuURYRFhK5HUh3GEZMZLWJVSzx/i+TRe99/DaLFvNmjZ
 EZig8hdiDjYGpVy3x2lCvgZU+3sta3aO9kTXwdTyL7W5Jwhm99FIvclzceEjydyBJZvz7VsO
 GOlyz20/bYpxVeyBkmNpU1n9hvYrMXFYRmxnQLfJqlg9PpQWrT76ntPPebLDT5zv+9ZuTsrx
 +L5VfNHq/DRtaUw4eDOc6S6QEkKyUr4c1wnKv3JJz8JFAwAA
X-CMS-MailID: 20181204093653eucas1p131c58415f6a494ca38c28bce87663f25
X-Msg-Generator: CA
X-RootMTR: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5@eucas1p2.samsung.com>
 <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
 <5C060511.8020802@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_013709_525170_88ADECB1 
X-CRM114-Status: GOOD (  21.09  )
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

SGkgQ2hhbndvbywKCk9uIDEyLzQvMTggNTozOSBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhp
IEx1a2FzeiwKPiAKPiBPbiAyMDE464WEIDEy7JuUIDAz7J28IDIzOjMxLCBMdWthc3ogTHViYSB3
cm90ZToKPj4gVGhlIHJlZmFjdG9yaW5nIGlzIG5lZWRlZCBmb3IgdGhlIG5ldyBjbGllbnQgaW4g
ZGV2ZnJlcTogc3VzcGVuZC4KPj4gVG8gYXZvaWQgY29kZSBkdXBsaWNhdGlvbiwgbW92ZSBpdCB0
byB0aGUgbmV3IGxvY2FsIGZ1bmN0aW9uCj4+IGRldmZyZXFfc2V0X3RhcmdldC4KPj4KPj4gVGhl
IHBhdGNoIGlzIGJhc2VkIG9uIGVhcmxpZXIgd29yayBieSBUb2JpYXMgSmFrb2JpLgo+IAo+IEFz
IEkgYWxyZWFkeSBjb21tZW50ZWQsIFBsZWFzZSByZW1vdmUgaXQuIFlvdSBhbHJlYWR5IG1lbnRp
b25lZCBpdCBvbiBjb3Zlci1sZXR0ZXIuCj4gSWYgeW91IHdhbnQgdG8gY29udGFpbiB0aGUgY29u
dHJpYnV0aW9uIGhpc3Rvcnkgb2YgVG9iaWFzLCB5b3UgbWlnaHQgYmV0dGVyCj4gdG8gYWRkICdT
aWduZWQtb2ZmLWJ5JyBvciBvdGhlcnMuCk9LCgpSZWdhcmRzLApMdWthc3oKPiAKPj4KPj4gU3Vn
Z2VzdGVkLWJ5OiBUb2JpYXMgSmFrb2JpIDx0amFrb2JpQG1hdGgudW5pLWJpZWxlZmVsZC5kZT4K
Pj4gU3VnZ2VzdGVkLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPj4g
U2lnbmVkLW9mZi1ieTogTHVrYXN6IEx1YmEgPGwubHViYUBwYXJ0bmVyLnNhbXN1bmcuY29tPgo+
PiAtLS0KPj4gICBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIHwgNjIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMzYg
aW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2RldmZyZXEvZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+PiBpbmRleCAx
NDE0MTMwLi5hOWZkNjFiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5j
Cj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4gQEAgLTI4NSw2ICsyODUsNDAg
QEAgc3RhdGljIGludCBkZXZmcmVxX25vdGlmeV90cmFuc2l0aW9uKHN0cnVjdCBkZXZmcmVxICpk
ZXZmcmVxLAo+PiAgIAlyZXR1cm4gMDsKPj4gICB9Cj4+ICAgCj4+ICtzdGF0aWMgaW50IGRldmZy
ZXFfc2V0X3RhcmdldChzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSwgdW5zaWduZWQgbG9uZyBuZXdf
ZnJlcSwKPj4gKwkJCSAgICAgIHUzMiBmbGFncykKPj4gK3sKPj4gKwlzdHJ1Y3QgZGV2ZnJlcV9m
cmVxcyBmcmVxczsKPj4gKwl1bnNpZ25lZCBsb25nIGN1cl9mcmVxOwo+PiArCWludCBlcnIgPSAw
Owo+PiArCj4+ICsJaWYgKGRldmZyZXEtPnByb2ZpbGUtPmdldF9jdXJfZnJlcSkKPj4gKwkJZGV2
ZnJlcS0+cHJvZmlsZS0+Z2V0X2N1cl9mcmVxKGRldmZyZXEtPmRldi5wYXJlbnQsICZjdXJfZnJl
cSk7Cj4+ICsJZWxzZQo+PiArCQljdXJfZnJlcSA9IGRldmZyZXEtPnByZXZpb3VzX2ZyZXE7Cj4+
ICsKPj4gKwlmcmVxcy5vbGQgPSBjdXJfZnJlcTsKPj4gKwlmcmVxcy5uZXcgPSBuZXdfZnJlcTsK
Pj4gKwlkZXZmcmVxX25vdGlmeV90cmFuc2l0aW9uKGRldmZyZXEsICZmcmVxcywgREVWRlJFUV9Q
UkVDSEFOR0UpOwo+PiArCj4+ICsJZXJyID0gZGV2ZnJlcS0+cHJvZmlsZS0+dGFyZ2V0KGRldmZy
ZXEtPmRldi5wYXJlbnQsICZuZXdfZnJlcSwgZmxhZ3MpOwo+PiArCWlmIChlcnIpIHsKPj4gKwkJ
ZnJlcXMubmV3ID0gY3VyX2ZyZXE7Cj4+ICsJCWRldmZyZXFfbm90aWZ5X3RyYW5zaXRpb24oZGV2
ZnJlcSwgJmZyZXFzLCBERVZGUkVRX1BPU1RDSEFOR0UpOwo+PiArCQlyZXR1cm4gZXJyOwo+PiAr
CX0KPj4gKwo+PiArCWZyZXFzLm5ldyA9IG5ld19mcmVxOwo+PiArCWRldmZyZXFfbm90aWZ5X3Ry
YW5zaXRpb24oZGV2ZnJlcSwgJmZyZXFzLCBERVZGUkVRX1BPU1RDSEFOR0UpOwo+PiArCj4+ICsJ
aWYgKGRldmZyZXFfdXBkYXRlX3N0YXR1cyhkZXZmcmVxLCBuZXdfZnJlcSkpCj4+ICsJCWRldl9l
cnIoJmRldmZyZXEtPmRldiwKPj4gKwkJCSJDb3VsZG4ndCB1cGRhdGUgZnJlcXVlbmN5IHRyYW5z
aXRpb24gaW5mb3JtYXRpb24uXG4iKTsKPj4gKwo+PiArCWRldmZyZXEtPnByZXZpb3VzX2ZyZXEg
PSBuZXdfZnJlcTsKPj4gKwlyZXR1cm4gZXJyOwo+PiArfQo+PiArCj4+ICAgLyogTG9hZCBtb25p
dG9yaW5nIGhlbHBlciBmdW5jdGlvbnMgZm9yIGdvdmVybm9ycyB1c2UgKi8KPj4gICAKPj4gICAv
KioKPj4gQEAgLTI5Niw4ICszMzAsNyBAQCBzdGF0aWMgaW50IGRldmZyZXFfbm90aWZ5X3RyYW5z
aXRpb24oc3RydWN0IGRldmZyZXEgKmRldmZyZXEsCj4+ICAgICovCj4+ICAgaW50IHVwZGF0ZV9k
ZXZmcmVxKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+PiAgIHsKPj4gLQlzdHJ1Y3QgZGV2ZnJl
cV9mcmVxcyBmcmVxczsKPj4gLQl1bnNpZ25lZCBsb25nIGZyZXEsIGN1cl9mcmVxLCBtaW5fZnJl
cSwgbWF4X2ZyZXE7Cj4+ICsJdW5zaWduZWQgbG9uZyBmcmVxLCBtaW5fZnJlcSwgbWF4X2ZyZXE7
Cj4+ICAgCWludCBlcnIgPSAwOwo+PiAgIAl1MzIgZmxhZ3MgPSAwOwo+PiAgIAo+PiBAQCAtMzMz
LDMxICszNjYsOCBAQCBpbnQgdXBkYXRlX2RldmZyZXEoc3RydWN0IGRldmZyZXEgKmRldmZyZXEp
Cj4+ICAgCQlmbGFncyB8PSBERVZGUkVRX0ZMQUdfTEVBU1RfVVBQRVJfQk9VTkQ7IC8qIFVzZSBM
VUIgKi8KPj4gICAJfQo+PiAgIAo+PiAtCWlmIChkZXZmcmVxLT5wcm9maWxlLT5nZXRfY3VyX2Zy
ZXEpCj4+IC0JCWRldmZyZXEtPnByb2ZpbGUtPmdldF9jdXJfZnJlcShkZXZmcmVxLT5kZXYucGFy
ZW50LCAmY3VyX2ZyZXEpOwo+PiAtCWVsc2UKPj4gLQkJY3VyX2ZyZXEgPSBkZXZmcmVxLT5wcmV2
aW91c19mcmVxOwo+PiAtCj4+IC0JZnJlcXMub2xkID0gY3VyX2ZyZXE7Cj4+IC0JZnJlcXMubmV3
ID0gZnJlcTsKPj4gLQlkZXZmcmVxX25vdGlmeV90cmFuc2l0aW9uKGRldmZyZXEsICZmcmVxcywg
REVWRlJFUV9QUkVDSEFOR0UpOwo+PiArCXJldHVybiBkZXZmcmVxX3NldF90YXJnZXQoZGV2ZnJl
cSwgZnJlcSwgZmxhZ3MpOwo+PiAgIAo+PiAtCWVyciA9IGRldmZyZXEtPnByb2ZpbGUtPnRhcmdl
dChkZXZmcmVxLT5kZXYucGFyZW50LCAmZnJlcSwgZmxhZ3MpOwo+PiAtCWlmIChlcnIpIHsKPj4g
LQkJZnJlcXMubmV3ID0gY3VyX2ZyZXE7Cj4+IC0JCWRldmZyZXFfbm90aWZ5X3RyYW5zaXRpb24o
ZGV2ZnJlcSwgJmZyZXFzLCBERVZGUkVRX1BPU1RDSEFOR0UpOwo+PiAtCQlyZXR1cm4gZXJyOwo+
PiAtCX0KPj4gLQo+PiAtCWZyZXFzLm5ldyA9IGZyZXE7Cj4+IC0JZGV2ZnJlcV9ub3RpZnlfdHJh
bnNpdGlvbihkZXZmcmVxLCAmZnJlcXMsIERFVkZSRVFfUE9TVENIQU5HRSk7Cj4+IC0KPj4gLQlp
ZiAoZGV2ZnJlcV91cGRhdGVfc3RhdHVzKGRldmZyZXEsIGZyZXEpKQo+PiAtCQlkZXZfZXJyKCZk
ZXZmcmVxLT5kZXYsCj4+IC0JCQkiQ291bGRuJ3QgdXBkYXRlIGZyZXF1ZW5jeSB0cmFuc2l0aW9u
IGluZm9ybWF0aW9uLlxuIik7Cj4+IC0KPj4gLQlkZXZmcmVxLT5wcmV2aW91c19mcmVxID0gZnJl
cTsKPj4gLQlyZXR1cm4gZXJyOwo+PiAgIH0KPj4gICBFWFBPUlRfU1lNQk9MKHVwZGF0ZV9kZXZm
cmVxKTsKPj4gICAKPj4KPiAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
