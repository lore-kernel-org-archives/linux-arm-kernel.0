Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E04EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:49:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB44220675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DrzmC8es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB44220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fTgomIsHj3+1ltkmPvnb0n5Wo13ykuXKmnx9EPS2Yls=; b=DrzmC8esRMwCL5m+Wi8uD0gsv
	no0wdnT+4cglhekVyA5ykUA5NccnxTspxu95VmhnqroaEU1tM3v9aPtQI3kPP9z/fV9pZrS9iHLl7
	8ii0tMma6QhBZ5m2uneW8v4FJ7Xs0skoZAzyKRGZA16WCYVcC/vU48KiVVWWKstSwXXKqtIkikJvz
	0OVVN/SVNBDTemyDJtQRRpxfpcImNpQsT5xWas5Ge9MCQSn22mnzHg281XlVREy6Ij/PY1OiRVVkO
	8LZvti0cgU4b7LBoUezq0hhNzf2eyyYL+/RXoosn9ddvNHfrA33YXUcZXyNA0LVVU56ixAJF6KRLh
	gsbNEDJdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggLvD-0007Te-C8; Mon, 07 Jan 2019 03:49:51 +0000
Received: from regular1.263xmail.com ([211.150.99.136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggLv9-0007Sb-Ks; Mon, 07 Jan 2019 03:49:49 +0000
Received: from randy.li?rock-chips.com (unknown [192.168.165.135])
 by regular1.263xmail.com (Postfix) with ESMTP id 77EC33A2;
 Mon,  7 Jan 2019 11:49:34 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [192.168.10.130] (localhost [127.0.0.1])
 by smtp.263.net (Postfix) with ESMTPA id 06089400;
 Mon,  7 Jan 2019 11:49:30 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: randy.li@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: randy.li@rock-chips.com
X-UNIQUE-TAG: <59498dd63bfc6f538d4f0346ef14fc0b>
X-ATTACHMENT-NUM: 0
X-SENDER: randy.li@rock-chips.com
X-DNS-TYPE: 0
Received: from [192.168.10.130] (unknown [103.29.142.67])
 by smtp.263.net (Postfix) whith ESMTP id 27737D1YHFF;
 Mon, 07 Jan 2019 11:49:34 +0800 (CST)
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for the
 HEVC slice format and controls
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20181123130209.11696-1-paul.kocialkowski@bootlin.com>
 <20181123130209.11696-2-paul.kocialkowski@bootlin.com>
 <5515174.7lFZcYkk85@jernej-laptop>
 <ffe9c81db34b599f675ca5bbf02de360bf0a1608.camel@bootlin.com>
From: Randy Li <randy.li@rock-chips.com>
Message-ID: <776e63c9-d4a5-342a-e0f7-200ef144ffc4@rock-chips.com>
Date: Mon, 7 Jan 2019 11:49:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ffe9c81db34b599f675ca5bbf02de360bf0a1608.camel@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_194948_050131_865533AE 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: devel@driverdev.osuosl.org, Alexandre Courbot <acourbot@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Randy Li <ayaka@soulik.info>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
 Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-rockchip@lists.infradead.org, linux-sunxi@googlegroups.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDEyLzEyLzE4IDg6NTEgUE0sIFBhdWwgS29jaWFsa293c2tpIHdyb3RlOgo+IEhpLAo+Cj4g
T24gV2VkLCAyMDE4LTEyLTA1IGF0IDIxOjU5ICswMTAwLCBKZXJuZWogxaBrcmFiZWMgd3JvdGU6
Cj4KPj4+ICsKPj4+ICsjZGVmaW5lIFY0TDJfSEVWQ19EUEJfRU5UUllfUlBTX1NUX0NVUlJfQkVG
T1JFCTB4MDEKPj4+ICsjZGVmaW5lIFY0TDJfSEVWQ19EUEJfRU5UUllfUlBTX1NUX0NVUlJfQUZU
RVIJMHgwMgo+Pj4gKyNkZWZpbmUgVjRMMl9IRVZDX0RQQl9FTlRSWV9SUFNfTFRfQ1VSUgkJMHgw
Mwo+Pj4gKwo+Pj4gKyNkZWZpbmUgVjRMMl9IRVZDX0RQQl9FTlRSSUVTX05VTV9NQVgJCTE2Cj4+
PiArCj4+PiArc3RydWN0IHY0bDJfaGV2Y19kcGJfZW50cnkgewo+Pj4gKwlfX3UzMglidWZmZXJf
dGFnOwo+Pj4gKwlfX3U4CXJwczsKPj4+ICsJX191OAlmaWVsZF9waWM7Cj4+PiArCV9fdTE2CXBp
Y19vcmRlcl9jbnRbMl07Cj4+PiArfTsKClBsZWFzZSBhZGQgYSBwcm9wZXJ0eSBmb3IgcmVmZXJl
bmNlIGluZGV4LCBpZiB0aGF0IHJwcyBpcyBub3QgdXNlZCBmb3IgCnRoaXMsIHNvbWUgZGV2aWNl
IHdvdWxkIHJlcXVlc3QgdGhhdChub3QgdGhlIHJvY2tjaGlwIG9uZSkuIEFuZCAKUm9ja2NoaXAn
cyBWRFBVMSBhbmQgVkRQVTIgZm9yIEFWQyB3b3VsZCByZXF1ZXN0IGEgc2ltaWxhciBwcm9wZXJ0
eS4KCkFkZGluZyBhbm90aGVyIGJ1ZmZlcl90YWcgZm9yIHJlZmVycmluZyB0aGUgbWVtb3J5IG9m
IHRoZSBtb3Rpb24gdmVjdG9ycyAKZm9yIGVhY2ggZnJhbWVzLiBPciBhIGJldHRlciBtZXRob2Qg
aXMgYWRkIGEgbWV0YSBkYXRhIHRvIGVjaG8gcGljdHVyZSAKYnVmZmVyLMKgIHNpbmNlIHRoZSBw
aWN0dXJlIG91dHB1dCBpcyBqdXN0IHRoZSBzYW1lIGFzIHRoZSBvcmlnaW5hbCwgCmRpc3BsYXkg
d29uJ3QgY2FyZSB3aGV0aGVyIHRoZSBtb3Rpb24gdmVjdG9ycyBhcmUgd3JpdHRlbiB0aGUgYnV0
dG9uIG9mIApwaWN0dXJlIG9yIHNvbWV3aGVyZSBlbHNlLgoKCj4+PiArCj4+PiArc3RydWN0IHY0
bDJfaGV2Y19wcmVkX3dlaWdodF90YWJsZSB7Cj4+PiArCV9fdTgJbHVtYV9sb2cyX3dlaWdodF9k
ZW5vbTsKPj4+ICsJX19zOAlkZWx0YV9jaHJvbWFfbG9nMl93ZWlnaHRfZGVub207Cj4+PiArCj4+
PiArCV9fczgJZGVsdGFfbHVtYV93ZWlnaHRfbDBbVjRMMl9IRVZDX0RQQl9FTlRSSUVTX05VTV9N
QVhdOwo+Pj4gKwlfX3M4CWx1bWFfb2Zmc2V0X2wwW1Y0TDJfSEVWQ19EUEJfRU5UUklFU19OVU1f
TUFYXTsKPj4+ICsJX19zOAlkZWx0YV9jaHJvbWFfd2VpZ2h0X2wwW1Y0TDJfSEVWQ19EUEJfRU5U
UklFU19OVU1fTUFYXVsyXTsKPj4+ICsJX19zOAljaHJvbWFfb2Zmc2V0X2wwW1Y0TDJfSEVWQ19E
UEJfRU5UUklFU19OVU1fTUFYXVsyXTsKPj4+ICsKPj4+ICsJX19zOAlkZWx0YV9sdW1hX3dlaWdo
dF9sMVtWNEwyX0hFVkNfRFBCX0VOVFJJRVNfTlVNX01BWF07Cj4+PiArCV9fczgJbHVtYV9vZmZz
ZXRfbDFbVjRMMl9IRVZDX0RQQl9FTlRSSUVTX05VTV9NQVhdOwo+Pj4gKwlfX3M4CWRlbHRhX2No
cm9tYV93ZWlnaHRfbDFbVjRMMl9IRVZDX0RQQl9FTlRSSUVTX05VTV9NQVhdWzJdOwo+Pj4gKwlf
X3M4CWNocm9tYV9vZmZzZXRfbDFbVjRMMl9IRVZDX0RQQl9FTlRSSUVTX05VTV9NQVhdWzJdOwo+
Pj4gK307Cj4+PiArClRob3NlIHByb3BlcnRpZXMgSSB0aGluayBhcmUgbm90IG5lY2Vzc2FyeSBh
cmUgYXBwbHlpbmcgZm9yIHRoZSAKUm9ja2NoaXAncyBkZXZpY2UsIG1heSBub3Qgd29yayBmb3Ig
dGhlIG90aGVycy4KPj4+ICtzdHJ1Y3QgdjRsMl9jdHJsX2hldmNfc2xpY2VfcGFyYW1zIHsKPj4+
ICsJX191MzIJYml0X3NpemU7Cj4+PiArCV9fdTMyCWRhdGFfYml0X29mZnNldDsKPj4+ICsKPj4+
ICsJLyogSVNPL0lFQyAyMzAwOC0yLCBJVFUtVCBSZWMuIEguMjY1OiBOQUwgdW5pdCBoZWFkZXIg
Ki8KPj4+ICsJX191OAluYWxfdW5pdF90eXBlOwo+Pj4gKwlfX3U4CW51aF90ZW1wb3JhbF9pZF9w
bHVzMTsKPj4+ICsKPj4+ICsJLyogSVNPL0lFQyAyMzAwOC0yLCBJVFUtVCBSZWMuIEguMjY1OiBH
ZW5lcmFsIHNsaWNlIHNlZ21lbnQgaGVhZGVyICovCj4+PiArCV9fdTgJc2xpY2VfdHlwZTsKPj4+
ICsJX191OAljb2xvdXJfcGxhbmVfaWQ7Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+ICsJX191MTYJ
c2xpY2VfcGljX29yZGVyX2NudDsKPj4+ICsJX191OAlzbGljZV9zYW9fbHVtYV9mbGFnOwo+Pj4g
KwlfX3U4CXNsaWNlX3Nhb19jaHJvbWFfZmxhZzsKPj4+ICsJX191OAlzbGljZV90ZW1wb3JhbF9t
dnBfZW5hYmxlZF9mbGFnOwo+Pj4gKwlfX3U4CW51bV9yZWZfaWR4X2wwX2FjdGl2ZV9taW51czE7
Cj4+PiArCV9fdTgJbnVtX3JlZl9pZHhfbDFfYWN0aXZlX21pbnVzMTsKUm9ja2NoaXAncyBkZWNv
ZGVyIGRvZXNuJ3QgdXNlIHRoaXMgcGFydC4KPj4+ICsJX191OAltdmRfbDFfemVyb19mbGFnOwo+
Pj4gKwlfX3U4CWNhYmFjX2luaXRfZmxhZzsKPj4+ICsJX191OAljb2xsb2NhdGVkX2Zyb21fbDBf
ZmxhZzsKPj4+ICsJX191OAljb2xsb2NhdGVkX3JlZl9pZHg7Cj4+PiArCV9fdTgJZml2ZV9taW51
c19tYXhfbnVtX21lcmdlX2NhbmQ7Cj4+PiArCV9fdTgJdXNlX2ludGVnZXJfbXZfZmxhZzsKPj4+
ICsJX19zOAlzbGljZV9xcF9kZWx0YTsKPj4+ICsJX19zOAlzbGljZV9jYl9xcF9vZmZzZXQ7Cj4+
PiArCV9fczgJc2xpY2VfY3JfcXBfb2Zmc2V0Owo+Pj4gKwlfX3M4CXNsaWNlX2FjdF95X3FwX29m
ZnNldDsKPj4+ICsJX19zOAlzbGljZV9hY3RfY2JfcXBfb2Zmc2V0Owo+Pj4gKwlfX3M4CXNsaWNl
X2FjdF9jcl9xcF9vZmZzZXQ7Cj4+PiArCV9fdTgJc2xpY2VfZGVibG9ja2luZ19maWx0ZXJfZGlz
YWJsZWRfZmxhZzsKPj4+ICsJX19zOAlzbGljZV9iZXRhX29mZnNldF9kaXYyOwo+Pj4gKwlfX3M4
CXNsaWNlX3RjX29mZnNldF9kaXYyOwo+Pj4gKwlfX3U4CXNsaWNlX2xvb3BfZmlsdGVyX2Fjcm9z
c19zbGljZXNfZW5hYmxlZF9mbGFnOwo+Pj4gKwo+Pj4gKwkvKiBJU08vSUVDIDIzMDA4LTIsIElU
VS1UIFJlYy4gSC4yNjU6IFBpY3R1cmUgdGltaW5nIFNFSSBtZXNzYWdlICovCj4+PiArCV9fdTgJ
cGljX3N0cnVjdDsKSSB0aGluayB0aGUgZGVjb2RlciBkb2Vzbid0IGNhcmUgYWJvdXQgdGhpcywg
aXQgaXMgdXNlZCBmb3IgZGlzcGxheS4KPj4+ICsKPj4+ICsJLyogSVNPL0lFQyAyMzAwOC0yLCBJ
VFUtVCBSZWMuIEguMjY1OiBHZW5lcmFsIHNsaWNlIHNlZ21lbnQgaGVhZGVyICovCj4+PiArCXN0
cnVjdCB2NGwyX2hldmNfZHBiX2VudHJ5IGRwYltWNEwyX0hFVkNfRFBCX0VOVFJJRVNfTlVNX01B
WF07Cj4+PiArCV9fdTgJbnVtX2FjdGl2ZV9kcGJfZW50cmllczsKPj4+ICsJX191OAlyZWZfaWR4
X2wwW1Y0TDJfSEVWQ19EUEJfRU5UUklFU19OVU1fTUFYXTsKPj4+ICsJX191OAlyZWZfaWR4X2wx
W1Y0TDJfSEVWQ19EUEJfRU5UUklFU19OVU1fTUFYXTsKPj4+ICsKPj4+ICsJX191OAludW1fcnBz
X3BvY19zdF9jdXJyX2JlZm9yZTsKPj4+ICsJX191OAludW1fcnBzX3BvY19zdF9jdXJyX2FmdGVy
Owo+Pj4gKwlfX3U4CW51bV9ycHNfcG9jX2x0X2N1cnI7Cj4+PiArCj4+PiArCS8qIElTTy9JRUMg
MjMwMDgtMiwgSVRVLVQgUmVjLiBILjI2NTogV2VpZ2h0ZWQgcHJlZGljdGlvbiBwYXJhbWV0ZXIg
Ki8KPj4+ICsJc3RydWN0IHY0bDJfaGV2Y19wcmVkX3dlaWdodF90YWJsZSBwcmVkX3dlaWdodF90
YWJsZTsKPj4+ICt9Owo+Pj4gKwo+Pj4gICAjZW5kaWYKPj4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
