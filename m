Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB169C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:50:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78412222CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fqc5jJlT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mi849S4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78412222CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=88WKAOqp1OA6Us5lMQ4al7RQCxC6Qhb1ANwscyF8AZY=; b=Fqc5jJlTSlevZs
	AJVp+2BuH/gLOtOFvQyoQW13sJYqSP4Yb7rUtBexbpnQ3QHmxQ6+xtkP6lCBWK/Dq3VBxmWd9xWPu
	G0WLzrf9XbWP7hu4kC59vEKuXuWrZCOSXQ/uzKSQhPqd5g4M6sAN4F6vGMEIqUgsdzz+5mbUTyuzz
	g7sqV6OhU2sKdTlSTNQ6RQT3Q8w7np083121Z0ZZKcze7SvygEjANMlUeLgg9cwmJIBMShqYV26xd
	L6H4LhS57hZegiuzRETnMTVkaBtbaXBrviikapOcYnH7JkeVCL1Zc392FbelyS10kW0iEqBdEll8C
	unjAJNEgsEfIa6voO25A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu828-0003VZ-LU; Thu, 14 Feb 2019 03:49:56 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu823-0003V4-Hm
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 03:49:54 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190214034941epoutp034c2aa08dfcdba9b6afed0f429a6503f9~DHnRj2CO53004130041epoutp03V
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 03:49:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20190214034941epoutp034c2aa08dfcdba9b6afed0f429a6503f9~DHnRj2CO53004130041epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550116182;
 bh=+FlN4TrELWk62V0opIWTvR9r+o/knFWJtr6LKmr8cbw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Mi849S4VshZk0qMc3r5Q2r25VJW0gibq61Nn2zig1K0KXAjDwA46tZ1AZhoqf3uuX
 hvFgEZHAzyM+fWpsHsACCM6BKH6i64mBWWzaqWsUQeS0l5BbA77GMsWErZ+0Nfk0pu
 i7cYBBKumFCKA/2l8SgckEclObPpXtYH7YaVujRw=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20190214034939epcas1p390a7ea2330b96e083ac338b920bd7625~DHnPDqeSm2904529045epcas1p3W;
 Thu, 14 Feb 2019 03:49:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 FB.64.04074.355E46C5; Thu, 14 Feb 2019 12:49:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20190214034938epcas1p455b53b20fd2e4f01876dba2d1b8c5ffe~DHnOoNCsX1913819138epcas1p4H;
 Thu, 14 Feb 2019 03:49:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190214034938epsmtrp2c82124e8220b81608bc9a31ac6558960~DHnOnACY32339123391epsmtrp2I;
 Thu, 14 Feb 2019 03:49:38 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-57-5c64e5535ab1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 4E.69.03601.255E46C5; Thu, 14 Feb 2019 12:49:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190214034938epsmtip1593510c0efc24157fc076d79a66007e0~DHnOVcIG-2753127531epsmtip17;
 Thu, 14 Feb 2019 03:49:38 +0000 (GMT)
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5cc4b5a3-c4ad-46a9-2856-3ed67c6755d3@samsung.com>
Date: Thu, 14 Feb 2019 12:49:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmrm7w05QYg59LuS3mHznHatH/+DWz
 xfnzG9gtzja9YbfY9Pgaq8XlXXPYLD73HmG0mHF+H5PF7cYVbBb/9+xgd+Dy2LSqk81j85J6
 j74tqxg9Pm+SC2CJyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
 8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpec
 n2tlaGBgZApUmJCd8XffccaC/SIVE1f3sDcwPuXvYuTgkBAwkZj93LCLkYtDSGAHo8Tl891M
 EM4nRolnvzvZuhg5gZxvjBJPO/NAbJCG3R+3skEU7WWUuDl7BlTHe0aJf62LWECqhAW8JTY/
 6WAFsUUE6iT6dl9gBSliFnjPJDH7/n+wsWwCWhL7X9wAs/kFFCWu/njMCGLzCthJ3P71nx3E
 ZhFQlfj9ewlYjahAhMTh3ndQNYISJ2c+AVvGKRAosXPiXbA4s4C4xK0n85kgbHmJ5q2zmSHO
 bmaXeLMoHcJ2kXhy5TkLhC0s8er4FnYIW0ri87u9bBB2tcTKk0fA3pQQ6GCU2LL/AitEwlhi
 /9LJTKDAYxbQlFi/Sx9iF5/Eu689rJAw5ZXoaBOCqFaWuPzgLhOELSmxuL0TaryHxJ+Vnxkn
 MCrOQvLNLCQfzELywSyEZQsYWVYxiqUWFOempxYbFhgiR/YmRnBS1TLdwTjlnM8hRgEORiUe
 3gqhlBgh1sSy4srcQ4wSHMxKIry7HwGFeFMSK6tSi/Lji0pzUosPMZoCA3sis5Rocj4w4eeV
 xBuaGhkbG1uYGJqZGhoqifOud3COERJITyxJzU5NLUgtgulj4uCUamDccsRhctibO0XV92eq
 BRxwELFi8j7llDqxJTIr6WO5zZYtt8sOqZsmmHRqZL1zuDmPLYt/TYNUSeRrV48uz3Uzmjfp
 RIhG1M3pFFzLkbZpVvzPFbEvPyzbkN3xIrdj24Sj7FsumlZMrJW3/PdzfW/VJZeXjuKfJX1u
 ftKo6pOt+rQiXrpmwm4lluKMREMt5qLiRABmlt1BwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnG7Q05QYg2uTtC3mHznHatH/+DWz
 xfnzG9gtzja9YbfY9Pgaq8XlXXPYLD73HmG0mHF+H5PF7cYVbBb/9+xgd+Dy2LSqk81j85J6
 j74tqxg9Pm+SC2CJ4rJJSc3JLEst0rdL4Mr4u+84Y8F+kYqJq3vYGxif8ncxcnJICJhI7P64
 la2LkYtDSGA3o8SCK5MZIRKSEtMuHmXuYuQAsoUlDh8uhqh5yyjx+sEsJpAaYQFvic1POlhB
 bBGBOolNy74xgxQxC3xkklg96yYrRMc5RomF99vYQarYBLQk9r+4wQZi8wsoSlz98RhsG6+A
 ncTtX//BalgEVCV+/14CViMqECHx8ek+JogaQYmTM5+wgNicAoESOyfeBetlFlCX+DPvEjOE
 LS5x68l8JghbXqJ562zmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfm
 Fpfmpesl5+duYgTHmJbWDsYTJ+IPMQpwMCrx8CoIpMQIsSaWFVfmHmKU4GBWEuHd/QgoxJuS
 WFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgTGMp/DbmgDx0xIN
 U+6+8EsvfJldUNC4mGWd8d4jRcdeP/9wlqWsmmX//Yg4RctNfxctNPnJFaEUEKh47vik2Ud6
 LQJYLun/c2GftfHOg3+5s36yL8xuPtp5Ucjmp/mE02tZC+6cUf+w9dyjRz8Psv+u3TLfS7K4
 6NfiuAPBm9x8TDwtl/47Pv21EktxRqKhFnNRcSIAexXXBq0CAAA=
X-CMS-MailID: 20190214034938epcas1p455b53b20fd2e4f01876dba2d1b8c5ffe
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190213161024epcas3p3acc5c074714ad1d44fb90ab3f21cfcff
References: <20181205195050.4759-6-robh@kernel.org>
 <CGME20190213161024epcas3p3acc5c074714ad1d44fb90ab3f21cfcff@epcas3p3.samsung.com>
 <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_194951_921681_B192957F 
X-CRM114-Status: GOOD (  22.39  )
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
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iLAoKT24gMTkuIDIuIDE0LiDsmKTsoIQgMTowOSwgUm9iIEhlcnJpbmcgd3JvdGU6Cj4g
T24gV2VkLCBEZWMgNSwgMjAxOCBhdCAxOjUwIFBNIFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+IHdyb3RlOgo+Pgo+PiBDb252ZXJ0IHN0cmluZyBjb21wYXJlcyBvZiBEVCBub2RlIG5hbWVz
IHRvIHVzZSBvZl9ub2RlX25hbWVfZXEgaGVscGVyCj4+IGluc3RlYWQuIFRoaXMgcmVtb3ZlcyBk
aXJlY3QgYWNjZXNzIHRvIHRoZSBub2RlIG5hbWUgcG9pbnRlci4KPj4KPj4gRm9yIGluc3RhbmNl
cyB1c2luZyBvZl9ub2RlX2NtcCwgdGhpcyBoYXMgdGhlIHNpZGUgZWZmZWN0IG9mIG5vdyB1c2lu
Zwo+PiBjYXNlIHNlbnNpdGl2ZSBjb21wYXJpc29ucy4gVGhpcyBzaG91bGQgbm90IG1hdHRlciBm
b3IgYW55IEZEVCBiYXNlZAo+PiBzeXN0ZW0gd2hpY2ggYWxsIG9mIHRoZXNlIGFyZS4KPj4KPj4g
Q2M6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgo+PiBDYzogTXl1bmdKb28g
SGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+Cj4+IENjOiBLeXVuZ21pbiBQYXJrIDxreXVu
Z21pbi5wYXJrQHNhbXN1bmcuY29tPgo+PiBDYzogS3VramluIEtpbSA8a2dlbmVAa2VybmVsLm9y
Zz4KPj4gQ2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4KPj4gQ2M6IGxp
bnV4LXBtQHZnZXIua2VybmVsLm9yZwo+PiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCj4+IENjOiBsaW51eC1zYW1zdW5nLXNvY0B2Z2VyLmtlcm5lbC5vcmcKPj4gU2ln
bmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KPj4gLS0tCj4+ICBkcml2
ZXJzL2RldmZyZXEvZGV2ZnJlcS1ldmVudC5jICAgICB8IDIgKy0KPj4gIGRyaXZlcnMvZGV2ZnJl
cS9ldmVudC9leHlub3MtcHBtdS5jIHwgMiArLQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gQ2FuIHNvbWVvbmUgYXBwbHkgdGhpcyBwbGVh
c2UuCgpNeXVuZ2pvbyBwaWNrZWQgdXAgdGhpcyBwYXRjaFsxXSBvbiBkZXZmcmVxLmdpdApidXQg
aGFzIG5vdCB5ZXQgc2VudCB0aGUgcHVsbCByZXF1ZXN0LgoKWzFdCmh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L216eC9kZXZmcmVxLmdpdC9jb21taXQvP2g9
Zm9yLW5leHQmaWQ9MGMxZThjZTI5NWFjYzNiZWNjOTVlMzkzZTg4YTlhNmRhMjMzMDc0ZgoKPiAK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLWV2ZW50LmMgYi9kcml2
ZXJzL2RldmZyZXEvZGV2ZnJlcS1ldmVudC5jCj4+IGluZGV4IGQ2NzI0MmQ4Nzc0NC4uODdlOTM0
MDZkN2NkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS1ldmVudC5jCj4+
ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLWV2ZW50LmMKPj4gQEAgLTI0MCw3ICsyNDAs
NyBAQCBzdHJ1Y3QgZGV2ZnJlcV9ldmVudF9kZXYgKmRldmZyZXFfZXZlbnRfZ2V0X2VkZXZfYnlf
cGhhbmRsZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+ICAgICAgICAgfQo+Pgo+PiAgICAgICAgIGxp
c3RfZm9yX2VhY2hfZW50cnkoZWRldiwgJmRldmZyZXFfZXZlbnRfbGlzdCwgbm9kZSkgewo+PiAt
ICAgICAgICAgICAgICAgaWYgKCFzdHJjbXAoZWRldi0+ZGVzYy0+bmFtZSwgbm9kZS0+bmFtZSkp
Cj4+ICsgICAgICAgICAgICAgICBpZiAob2Zfbm9kZV9uYW1lX2VxKG5vZGUsIGVkZXYtPmRlc2Mt
Pm5hbWUpKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsKPj4gICAgICAgICB9
Cj4+ICAgICAgICAgZWRldiA9IE5VTEw7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEv
ZXZlbnQvZXh5bm9zLXBwbXUuYyBiL2RyaXZlcnMvZGV2ZnJlcS9ldmVudC9leHlub3MtcHBtdS5j
Cj4+IGluZGV4IGM2MWRlMGJkZjA1My4uYzJlYTk0OTU3NTAxIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2RldmZyZXEvZXZlbnQvZXh5bm9zLXBwbXUuYwo+PiArKysgYi9kcml2ZXJzL2RldmZyZXEv
ZXZlbnQvZXh5bm9zLXBwbXUuYwo+PiBAQCAtNTI5LDcgKzUyOSw3IEBAIHN0YXRpYyBpbnQgb2Zf
Z2V0X2RldmZyZXFfZXZlbnRzKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmICghcHBtdV9ldmVudHNbaV0ubmFtZSkKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb250aW51ZTsKPj4KPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
aWYgKCFvZl9ub2RlX2NtcChub2RlLT5uYW1lLCBwcG11X2V2ZW50c1tpXS5uYW1lKSkKPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKG9mX25vZGVfbmFtZV9lcShub2RlLCBwcG11X2V2ZW50
c1tpXS5uYW1lKSkKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPj4g
ICAgICAgICAgICAgICAgIH0KPj4KPj4gLS0KPj4gMi4xOS4xCj4+Cj4gCj4gCgoKLS0gCkJlc3Qg
UmVnYXJkcywKQ2hhbndvbyBDaG9pClNhbXN1bmcgRWxlY3Ryb25pY3MKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
