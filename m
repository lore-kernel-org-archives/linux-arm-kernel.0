Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BADC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1479821904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pjh9jkGl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PkUPEjM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1479821904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pJeQmxqKX0CAvuy653b4e2Yf1Sf5ZSStkg8rlHHrhgk=; b=Pjh9jkGlp9gpWg
	Pl0LztSwluMzpBlgJ7/03UNInO90XDyb9PC9NPYneaE9XKAmdgHlFZ3l7BSH1OaxBjFvJQ6nj+57k
	uzJpIwiQHis3Vqdq3d6jJ5MQ4fbn1nloZvlkM0FwkP8eHhtCQsprEexgtH59tLZUhD5L5IZeiIKgC
	WXyEEPwm1YC8wV1c+BEybod9Zpwdr7TVJa8Xa/vyQ51oZ0VUQRe7Wj3mWMIdLbXEm6x9MUgBH6Jfm
	su1tIdXwU5jgP4tnvo9Y0/YuL5XKTEgMY622J9qO5h24IbFxETVcNMw/Ajn+oTe7S1gbRK+P3DrjB
	L4tPmZLnuQh9lad7BOWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtoaz-00012h-Uq; Wed, 13 Feb 2019 07:04:37 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoav-00011f-PG
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 07:04:35 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20190213070425epoutp0297473527193ef43c44df6631ee0bac6d~C2oAhC7Fb2039420394epoutp02g
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:04:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20190213070425epoutp0297473527193ef43c44df6631ee0bac6d~C2oAhC7Fb2039420394epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550041465;
 bh=GcmfMIjCsjLAjFaF9yhH3fgJREV1qtbvxTQ2hHMHf1U=;
 h=Subject:To:From:Date:In-Reply-To:References:From;
 b=PkUPEjM3cTXVMqupqoh+P7NDSJJcjDUpewb3IatXHAQJhxueK+7sNHxffl2N9k8x/
 9I+k6Rk867OFYkCXuPur1RDWi75xoZnItv68LWPetkmHgMB2eWRHYtGNC2kE5QaYyM
 /t9oGyLDLe96wb4DZD6BWVnao2UM6W3ZHuriEIPM=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20190213070422epcas1p3178d5a6fb094190f80053002b6437245~C2n9SwNf01396713967epcas1p3L;
 Wed, 13 Feb 2019 07:04:22 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 45.45.04288.071C36C5; Wed, 13 Feb 2019 16:04:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190213070415epcas1p26c32c7d372f5e492d3c25edeb2077cda~C2n3hj0bm1917519175epcas1p2a;
 Wed, 13 Feb 2019 07:04:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190213070415epsmtrp1abcf92032192dbe45938c51e590e9955~C2n3gFBoW2580625806epsmtrp1J;
 Wed, 13 Feb 2019 07:04:15 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-02-5c63c170d72d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 0C.54.03971.F61C36C5; Wed, 13 Feb 2019 16:04:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190213070415epsmtip1f03acaf5a39650e981f69867fe9bedc3~C2n3QIR3M1869018690epsmtip1N;
 Wed, 13 Feb 2019 07:04:15 +0000 (GMT)
Subject: Re: [PATCH 1/4] dt-bindings: clock: exynos: Put CLK_UART3 in order
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa
 <tomasz.figa@gmail.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5f504ab8-33ca-4033-3d17-e2ba59bfd4ae@samsung.com>
Date: Wed, 13 Feb 2019 16:04:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212175052.6310-2-krzk@kernel.org>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmgW7BweQYg479Yhbzj5xjteh//JrZ
 4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyWHr9IpPFxVOuFq17j7BbHH7Tzmrx79pGFotV
 u/4wOvB6rJm3htHj/Y1Wdo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwR2XbZKQmpqQWKaTm
 JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdq6RQlphTChQKSCwuVtK3
 synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIznj1dQZrwUyOilVH
 9rM2MB5l62Lk5JAQMJH48KSbqYuRi0NIYAejxPJbS1ggnE+MEl9mTmGEcL4xSjyf+I8RpuXv
 rhnsEIm9jBIXz+1nhXDeM0o8fnCZBaRKWMBb4nX/O7DBIgI3mSUOTO4H28gmoCWx/8UNMJtf
 QFHi6o/HYGN5BewkDmz7DdbMIqAqsen9CbAaUYEIicO976BqBCVOznwCVsMJdMbtpZPB4swC
 4hK3nsxngrDlJZq3zmYGWSwhMI9doqtrHjPE3S4Sq9Y8hfpBWOLV8S3sELaUxMv+Nii7WmLl
 ySNsEM0djBJb9l9ghUgYS+xfOhloAwfQBk2J9bv0IZbxSbz72sMKEpYQ4JXoaBOCqFaWuPzg
 LhOELSmxuL0TGtoeEleWtUHDdCOjxIEXO9gmMCrMQvLbLCT/zELyzyyEzQsYWVYxiqUWFOem
 pxYbFpggR/gmRnBa1rLYwbjnnM8hRgEORiUe3hVHk2KEWBPLiitzDzFKcDArifDGb0yOEeJN
 SaysSi3Kjy8qzUktPsRoCgz6icxSosn5wJyRVxJvaGpkbGxsYWJoZmpoqCTOu97BOUZIID2x
 JDU7NbUgtQimj4mDU6qBcYX/3vSJDE6/04N91GxY54pvUNZomrryoe0q3W9J7d0HPTeGP1oR
 XPpu3r2O9ifRkV8vfGHv7XY+tLOd93vIvw0nuo21Kgoq5H4/1J6VHmHHvfp5+oMphQV/w0UN
 /l+VPuT2gGlK9+fXswRu/PqtpDHZvqff0fTA+9qftl8s54cwimUXNJStVWIpzkg01GIuKk4E
 AITaX5nhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnG7+weQYg2ttphbzj5xjteh//JrZ
 4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyWHr9IpPFxVOuFq17j7BbHH7Tzmrx79pGFotV
 u/4wOvB6rJm3htHj/Y1Wdo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwR3HZpKTmZJalFunb
 JXBlvPo6g7VgJkfFqiP7WRsYj7J1MXJySAiYSPzdNYMdxBYS2M0osWlXBURcUmLaxaPMXYwc
 QLawxOHDxV2MXEAlbxkltk69BdYrLOAt8br/HRNIQkTgNrPE0ldt7BBVGxkldhw5DTaVTUBL
 Yv+LG2Ad/AKKEld/PGYEsXkF7CQObPvNAmKzCKhKbHp/AqxGVCBC4uPTfUwQNYISJ2c+Aavh
 BLr09tLJYL3MAuoSf+ZdYoawxSVuPZnPBGHLSzRvnc08gVFoFpL2WUhaZiFpmYWkZQEjyypG
 ydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAY1NLcwXh5SfwhRgEORiUe3hVHk2KEWBPL
 iitzDzFKcDArifDGb0yOEeJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFq
 EUyWiYNTqoExgOnbqmgl4RC7Oa4ln4L09e80bfNueB6d96nz2kGPm/c2S5atkA1s+jTf9Ih3
 34a/u048aOhrzaxiPvnX5tNDx9q6+4xXVNfNPPyzpW12b8A+0eWVavzC+ao7p/0ufHMj9qJQ
 fMMWnmtzD3RolwavnrnJ11g+aK9eGPu8bxZJPbFcU21ZL9xQYinOSDTUYi4qTgQA3lAJrb0C
 AAA=
X-CMS-MailID: 20190213070415epcas1p26c32c7d372f5e492d3c25edeb2077cda
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212175224epcas5p2f8735fb888b2fae241eb1d6c153a1d88
References: <20190212175052.6310-1-krzk@kernel.org>
 <CGME20190212175224epcas5p2f8735fb888b2fae241eb1d6c153a1d88@epcas5p2.samsung.com>
 <20190212175052.6310-2-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_230433_997259_E029DD6B 
X-CRM114-Status: GOOD (  18.81  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAxOS4gMi4gMTMuIOyYpOyghCAyOjUwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3Rl
Ogo+IE9yZGVyIHRoZSBDTEtfVUFSVDMgYnkgSUQuICBObyBjaGFuZ2UgaW4gZnVuY3Rpb25hbGl0
eS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5v
cmc+Cj4gLS0tCj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZXh5bm9zNTQxMC5oIHwgMiAr
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9leHlub3M1NDEwLmggYi9pbmNs
dWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2V4eW5vczU0MTAuaAo+IGluZGV4IGYxNzllYWJiY2RiNy4u
NWI5MTFlZGUwNTM0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZXh5
bm9zNTQxMC5oCj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9leHlub3M1NDEwLmgK
PiBAQCAtMzYsNiArMzYsNyBAQAo+ICAjZGVmaW5lIENMS19VQVJUMAkJMjU3Cj4gICNkZWZpbmUg
Q0xLX1VBUlQxCQkyNTgKPiAgI2RlZmluZSBDTEtfVUFSVDIJCTI1OQo+ICsjZGVmaW5lIENMS19V
QVJUMwkJMjYwCj4gICNkZWZpbmUgQ0xLX0kyQzAJCTI2MQo+ICAjZGVmaW5lIENMS19JMkMxCQky
NjIKPiAgI2RlZmluZSBDTEtfSTJDMgkJMjYzCj4gQEAgLTQ0LDcgKzQ1LDYgQEAKPiAgI2RlZmlu
ZSBDTEtfVVNJMQkJMjY2Cj4gICNkZWZpbmUgQ0xLX1VTSTIJCTI2Nwo+ICAjZGVmaW5lIENMS19V
U0kzCQkyNjgKPiAtI2RlZmluZSBDTEtfVUFSVDMJCTI2MAo+ICAjZGVmaW5lIENMS19QV00JCQky
NzkKPiAgI2RlZmluZSBDTEtfTUNUCQkJMzE1Cj4gICNkZWZpbmUgQ0xLX1dEVAkJCTMxNgo+IAoK
QWNrZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgoKLS0gCkJlc3Qg
UmVnYXJkcywKQ2hhbndvbyBDaG9pClNhbXN1bmcgRWxlY3Ryb25pY3MKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
