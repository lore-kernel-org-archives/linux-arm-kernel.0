Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18665C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7252084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cmD6noxd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s1ErGYnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7252084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tPHlQTORVbM272OMkH0ZRiXg0M3X3UYjVDJETKM0RBc=; b=cmD6noxd3JNikn
	Fsv2ssueBFwpMSAKvSoYyPWhn7CjmtXHpD8VF9DjXPDFl+UvXsHDkRbtileB4FydlbnwlC9lpsrdL
	vLJHx/csw7wQY4ZZJgH8y4xphzYkXFpuO8HI1lv0wslIfua2Om4b4fNpi2HckJhlRRiDFOVrQR6lk
	xQsNVsXsL6LN8GzBkC8vOKYZTYIU0B8bnoGLoFHaH6uusHKuG+8PKs5SAOaWOeslOvdlmXuv+CVnz
	X3RyNuRyafSihlGJEY4dPiqueHMLq99k/pdCDhpAGCVCjZMoF5rZ2af1Lq+TI6RMhSHiUdhy1x5eJ
	ON3EbM3gJ0QPOBCXwXJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZBV-0005m4-Rl; Wed, 05 Dec 2018 15:33:57 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZBR-0005jw-I8
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:33:56 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181205153341euoutp020f32744de8ca25979d41c4e0e8f5269a~teaq7STma2215122151euoutp02W
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 15:33:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181205153341euoutp020f32744de8ca25979d41c4e0e8f5269a~teaq7STma2215122151euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544024021;
 bh=NIIayDVnsscvK2KS6LhVsZsJnl1s/5/jFldtqUDvwWw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=s1ErGYnHxYvGnMmaBb+9PMJD0LI/6+IhY0OMYpQ1UqZJL24R18b6jtjew9GyK+yer
 POBsb5n2ODoB6kkKMshVlmq0QXtzvkKxODLe9YPdq/MrBZkxuF4k6w7tzvf43hCSk9
 OzU2S2FPSlseoOYs3xPnBILMhZNy8EOz1kTwIVTQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181205153340eucas1p2ccb9dab1ab5e42f55f33a1f399ad8058~teaqKfvQm2703327033eucas1p2h;
 Wed,  5 Dec 2018 15:33:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 3C.D2.04294.4DFE70C5; Wed,  5
 Dec 2018 15:33:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181205153339eucas1p25e35fee10542f5bd1d5e3d1d36122d58~teapcTFhG3067030670eucas1p2r;
 Wed,  5 Dec 2018 15:33:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181205153339eusmtrp1a32f41be35599c7cd8a2799400d5370c~teapNfuR30905509055eusmtrp1c;
 Wed,  5 Dec 2018 15:33:39 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-d7-5c07efd49a68
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.48.04128.3DFE70C5; Wed,  5
 Dec 2018 15:33:39 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181205153339eusmtip2767744ec18d2587d3ce185a33ab62f89~teaop8au03260132601eusmtip2H;
 Wed,  5 Dec 2018 15:33:38 +0000 (GMT)
Subject: Re: [PATCH v2 00/11] thermal: add new flag irq-mode for trip point
To: Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <ffca9e30-7a7c-7f61-24a1-016c9ea1e611@partner.samsung.com>
Date: Wed, 5 Dec 2018 16:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544022486.2841.42.camel@intel.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87pX3rPHGEzfJWKxccZ6VosnB9oZ
 LeZ9lrWYf+Qcq8X8K9dYLc6f38BusekxkLWwbQmLxeVdc9gsPvceYbRYev0ik0Xr3iPsFk8e
 9rE58HqsmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R7LO6bzOrRt2UVo8fnTXIBnFFc
 NimpOZllqUX6dglcGWePf2YpOKBScXhOSAPjIrkuRk4OCQETiX2TzrOC2EICKxgl/t+Q6mLk
 ArK/MEr8brjDDuF8ZpTYu3wWC0zHzM2vmSASy4Gqlk1nhHDeMkocvPGSHaRKWMBb4uD/aWC2
 iMAeRonz33VAipgFZjNKdC2fC9TOwcEmoCexY1UhSA2vgJvE4XvTwepZBFQktkz9yQhiiwpE
 SHTcX80GUSMocXLmE7ArOAUMJXZen8oEYjMLiEvcejIfypaXaN46mxlkl4TAT3aJ/d/a2SHO
 dpF4dvgdE4QtLPHq+BaouIzE6ck9UK8VS5ztWMUGYddItJ/cAVVjLXH4+EVWkJuZBTQl1u/S
 BzElBBwlPq62hjD5JG68FYS4gE9i0rbpzBBhXomONiGIGRoSW3ouQO0Xk1i+Zhr7BEalWUj+
 moXkl1lIfpmFsHYBI8sqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwOR2+t/xLzsYd/1J
 OsQowMGoxMP74gF7jBBrYllxZe4hRgkOZiUR3hU2QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
 1QwPooUE0hNLUrNTUwtSi2CyTBycUg2MwktiKtvWN81yd/FVWLS9S2vd/iotXZXX5/P9XA+4
 5TPsu7CYR54lKPmFCJvrPCUnhttGmk7H4q0jS9Ye9FGzsmp73WieWn0jX1tc6TPXNFepHUv/
 Sk5isf75uef4qjVx7/bwW81NPVSwdsuXRDNr8yevgtesO899XHUdp6LAZb/QgjaPmmtKLMUZ
 iYZazEXFiQBGZohGagMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7qX37PHGBzfrmCxccZ6VosnB9oZ
 LeZ9lrWYf+Qcq8X8K9dYLc6f38BusekxkLWwbQmLxeVdc9gsPvceYbRYev0ik0Xr3iPsFk8e
 9rE58HqsmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R7LO6bzOrRt2UVo8fnTXIBnFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GWePf2Yp
 OKBScXhOSAPjIrkuRk4OCQETiZmbXzN1MXJxCAksZZT49nIiI0RCTGLSvu3sELawxJ9rXWwQ
 Ra+Bih6fZQJJCAt4Sxz8Pw2sSERgD6PEo9WaIEXMArMZJT68Ogo19iijxNQNL4DaOTjYBPQk
 dqwqBGngFXCTOHxvOlgzi4CKxJapP8E2iwpESJx9uY4RokZQ4uTMJywgNqeAocTO61PBFjML
 mEnM2/yQGcIWl7j1ZD5UXF6ieets5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kV
 J+YWl+al6yXn525iBEb1tmM/t+xg7HoXfIhRgINRiYf3xQP2GCHWxLLiytxDjBIczEoivCts
 gEK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0w4eSXxhqaG5haWhubG5sZmFkrivOcNKqOE
 BNITS1KzU1MLUotg+pg4OKUaGANO//jAPmtLtenvp090FfXyMi5P31f36d2PCb4TThQ3HpN7
 Nn/dc66aWe5LNi44Y7a5S/lP1zt97vlT3rpFfqzSvln+e+Kl7BSRaQsE96eVMoZ/nHWHbR7z
 kc3f5h75YmnAfuTEp8PT1swyuOD29YVF3ErueRIqsxpO3M9jeLb9q7yrB9uap/t2KLEUZyQa
 ajEXFScCACbHJ8UAAwAA
X-CMS-MailID: 20181205153339eucas1p25e35fee10542f5bd1d5e3d1d36122d58
X-Msg-Generator: CA
X-RootMTR: 20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94
References: <CGME20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94@eucas1p1.samsung.com>
 <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
 <1544022486.2841.42.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_073353_735638_C46289A8 
X-CRM114-Status: GOOD (  22.99  )
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
Cc: mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
 daniel.lezcano@linaro.org, krzk@kernel.org, edubezval@gmail.com,
 robh+dt@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUnVpLAoKT24gMTIvNS8xOCA0OjA4IFBNLCBaaGFuZyBSdWkgd3JvdGU6Cj4gT24g5LiJLCAy
MDE4LTExLTA3IGF0IDE4OjA5ICswMTAwLCBMdWthc3ogTHViYSB3cm90ZToKPj4gSGkgYWxsLAo+
Pgo+PiBUaGlzIHBhdGNoIHNldCBhZGRzIGEgbmV3IGZsYWcgYW5kIG1lY2hhbmlzbSBpbiB0aGVy
bWFsIHRyaXAgcG9pbnRzCj4+IGluCj4+IERULsKgwqBUaGUgb2xkIGltcGxlbWVudGF0aW9uIGlu
IHRoZXJtYWwgem9uZSBpbiBEVCBzZXRzIHRoZSBzYW1lCj4+IGNvbmZpZ3VyYXRpb24gZm9yIGFs
bCBpbnRlcm5hbCB0cmlwIHBvaW50cy4gSXQgZG9lcyBub3Qgd29yayBmb3IgYWxsCj4+IEhXLsKg
wqBUaGVyZSBhcmUgU29DcyB3aGljaCBzdXBwb3J0IElSUXMgZm9yIHNvbWUgdHJpcCBwb2ludHMg
KGkuZS4KPj4gRXh5bm9zIDQgaGFzIDQgdHJpcCBwb2ludHMgd2l0aCBJUlFzKS4gRm9yIGFkZGl0
aW9uYWwgb25lIGRlZmluZWQKPj4gaW5zaWRlIHRoZSB0aGVybWFsIHpvbmUgdGhlcmUgaXMgYSBu
ZWVkIG9mICdwb2xsaW5nJy4gV2hlbiBkZXZlbG9wZXIKPj4gYWRkcyBwb2xsaW5nIG1vZGUgc2V0
dGluZ3MgaW5zaWRlIHRoZSB0aGVybWFsIHpvbmUsIGFsbCB0aGUgdHJpcAo+PiBwb2ludHMgd2ls
bCBiZSByZWdpc3RlcmVkIGZvciBwb2xsaW5nLCBldmVuIHRob3NlIHN1cHBvcnRpbmcgSVJRcywK
Pj4gd2hpY2ggZG9lcyBub3QgbWFrZSBzZW5zZS4KPiAKPiB3ZSBoYXZlIHR3byB0aW1lcnMsIG9u
ZSBmb3IgcG9sbGluZywgYW5kIG9uZSBmb3IgcGFzc2l2ZSBjb29saW5nLgo+IEkgdGhpbmsgd2Ug
YXJlIHRhbGtpbmcgYWJvdXQgcGFzc2l2ZSBjb29saW5nIHRpbWVyIG9ubHksIHJpZ2h0Pwo+IEFu
ZCB0aGUgcmVhbCBwcm9ibGVtIGlzIHRoYXQgd2UgaGF2ZSBtdWx0aXBsZSBwYXNzaXZlIHRyaXAg
cG9pbnRzIGFuZAo+IG9ubHkgcGFydCBvZiB0aGVtIHN1cHBvcnQgaXJxX21vZGUsIGFuZCB3ZSBk
b24ndCB3YW50IHRvIHN0YXJ0IHRoZQo+IHBhc3NpdmUgcG9sbGluZyB0aW1lciBmb3IgYWxsIG9m
IHRoZSBwYXNzaXZlIHRyaXAgcG9pbnRzLgpZZXMgZXhhY3RseSwgd2UgZG9uJ3Qgd2FudCB0byBw
b2xsIGFsbCBvZiB0aGVtIGJ5IHN0YXJ0aW5nICdwYXNzaXZlIApwb2xsaW5nIHRpbWVyJy4KClJl
Z2FyZHMsCkx1a2Fzego+IAo+IHRoYW5rcywKPiBydWkKPiAKPj4gICBUaHVzLCBkZXZlbG9wZXJz
IGNyZWF0ZSB3b3JrYXJvdW5kcywgd2hpY2gKPj4gYXJlIGNvbmZ1c2luZyBmb3Igc29tZSBvdGhl
ciBkZXZlbG9wZXJzLsKgwqBUbyB3b3JrYXJvdW5kLAo+PiBwZW9wbGUgZGVjbGFyZSBzb21lIHRy
aXAgcG9pbnRzIGFzICdhY3RpdmUnICh0aG9zZSB3aXRoIElSUSBzdXBwb3J0KS4KPj4gSXQgYWxs
b3dzIHRvIGJ5cGFzcyBwb2xsaW5nIG1vZGUgaW4gdGhlcm1hbCBmcmFtZXdvcmsgYXBwbGllZCBm
b3IKPj4gYWxsIHRoZXJtYWwgem9uZSdzIHRyaXAgcG9pbnRzLgo+Pgo+PiBUaGVybWFsIGZyYW1l
d29yayBkZWZpbmVzIDQgdHlwZXMgb2YgdHJpcCBwb2ludHMuIFRoZSAncGFzc2l2ZScgbWVhbnMK
Pj4gcGFzc2l2ZSBjb29saW5nIHVzaW5nIERWRlMsICdhY3RpdmUnIGlzIGRlc2lnbmVkIGZvciBm
YW4gYW5kIG90aGVyCj4+IGRldmljZXMgYWN0aXZlbHkgY2hhbmdpbmcgdGhlIG91dHNpZGUgY29u
ZGl0aW9ucy4gVGhlcmVmb3JlLCBhCj4+IHdvcmthcm91bmQKPj4gbWVudGlvbmVkIGVhcmxpZXIg
aXMgY29uZnVzaW5nIHdoZW4gc29tZW9uZSBkb2VzIG5vdCBrbm93IGFib3V0IHRoZQo+PiBmcmFt
ZXdvcmsgbGltaXRhdGlvbnMuCj4+Cj4+IFRoaXMgcGF0Y2ggc2V0IHRyaWVzIHRvIHNvbHZlIHRo
ZSBpc3N1ZSBieSBhZGRpbmcgb25lIGZsYWcgaW5zaWRlIHRoZQo+PiB0cmlwIHBvaW50OiAnaXJx
LW1vZGU7Jy7CoMKgVGhlIHRyaXAgcG9pbnQgJ3Bhc3NpdmUnIGRlY2xhcmVkIGluIERUCj4+IHdp
dGgKPj4gZXhwbGljaXQgZmxhZyAnaXJxLW1vZGU7JyB3aWxsIG5vdCByZWdpc3RlciBpdHNlbGYg
YXMgcG9sbGluZyBtb2RlLgo+PiBUaGVybWFsIGZyYW1ld29yayB3aWxsIHNraXAgaXQgZHVyaW5n
IHNjaGVkdWxpbmcgbmV4dCByZWFkIG91dCB3b3JrLgo+PiBUaGUgb2xkIGdsb2JhbC1wb2xsaW5n
LW1vZGUtY29uZmlndXJhdGlvbi1pbnNpZGUtdGhlcm1hbC16b25lIGlzCj4+IHN0aWxsCj4+IHZh
bGlkLsKgwqBQYXRjaCBzZXQgZG9lcyBub3QgYnJlYWsgZXhpc3RpbmcgZGVzaWduIGZvciB0cmlw
IHBvaW50cwo+PiB3aGljaAo+PiBkbyBub3QgaGF2ZSAnaXJxLW1vZGUnIGZsYWcgLSB0aGV5IHdp
bGwgdXNlIHBvbGxpbmcuCj4+Cj4+IEFzIGFuIGV4YW1wbGUgcGxlYXNlIGNoZWNrIHBhdGNoICMx
MCBmb3IgRXh5bm9zNCBTb0MgZmFtaWx5LCB3aGVyZQo+PiB0aGVyZQo+PiBpcyA0IEhXIHN1cHBv
cnRlZCB0cmlwIHBvaW50cyBhbmQgdGhlcmUgaXMgYSBuZWVkIG9mIDYuIFRoZSByZXN0IDIKPj4g
YXJlCj4+IGRlY2xhcmVkIGFzICdwYXNzaXZlJyB3aXRob3V0ICdpcnEtbW9kZTsnIGZsYWcsIHdo
aWNoIG1lYW5zIHBvbGxpbmcKPj4gbW9kZSBuZWVkZWQgZm9yIHRoZW0uCj4+Cj4+IFBhdGNoICMx
IGlzIGEgc21hbGwgY2xlYW51cCBpbiB0aGVybWFsIGZyYW1ld29yay4KPj4KPj4gQ2hhbmdlIGxv
ZzoKPj4gdjIKPj4gLSBjaGFuZ2VkIGRlc2NyaXB0aW9uIGluIGNvdmVyIGxldHRlcgo+PiAtIGNo
YW5nZSBjb21taXQgbWVzc2FnZXMgYWNjb3JkaW5nIHRvIEtyenlzenRvZiBjb21tZW50cwo+PiAt
IHJlYmFzZSBvbiB0b3Agb2YgY3VycmVudCBtYWlubGluZSAodjQuMjAtcmMxKQo+Pgo+PiBSZWdh
cmRzLAo+PiBMdWthc3ogTHViYQo+Pgo+PiBMdWthc3ogTHViYSAoMTEpOgo+PiAgwqAgdGhlcm1h
bDogcmVtb3ZlIHVudXNlZCBmdW5jdGlvbiBwYXJhbWV0ZXIKPj4gIMKgIHRoZXJtYWw6IGFkZCBp
cnEtbW9kZSBjb25maWd1cmF0aW9uIGZvciB0cmlwIHBvaW50Cj4+ICDCoCB0aGVybWFsOiBhZGQg
bmV3IHN5c2ZzIGZpbGUgZm9yIGlycS1tb2RlCj4+ICDCoCBEb2M6IHRoZXJtYWw6IG5ldyBpcnEt
bW9kZSBmb3IgdHJpcCBwb2ludAo+PiAgwqAgRG9jOiBEVDogdGhlcm1hbDogbmV3IGlycS1tb2Rl
IGZvciB0cmlwIHBvaW50Cj4+ICDCoCBhcm02NDogZHRzOiBleHlub3M1NDMzOiBhZGQgc3VwcG9y
dCBmb3IgdGhlcm1hbCB0cmlwIGlycS1tb2RlCj4+ICDCoCBhcm02NDogZHRzOiBleHlub3M3OiBh
ZGQgc3VwcG9ydCBmb3IgdGhlcm1hbCB0cmlwIGlycS1tb2RlCj4+ICDCoCBhcm06IGR0czogZXh5
bm9zNDogYWRkIHN1cHBvcnQgZm9yIHRoZXJtYWwgdHJpcCBpcnEtbW9kZQo+PiAgwqAgYXJtOiBk
dHM6IGV4eW5vczU0MjA6IGFkZCBzdXBwb3J0IGZvciB0aGVybWFsIHRyaXAgaXJxLW1vZGUKPj4g
IMKgIGFybTogZHRzOiBleHlub3M1NDIyOiBhZGQgc3VwcG9ydCBmb3IgdGhlcm1hbCB0cmlwIGly
cS1tb2RlCj4+ICDCoCBhcm06IGR0czogZXh5bm9zNTQxMDogYWRkIHN1cHBvcnQgZm9yIHRoZXJt
YWwgdHJpcCBpcnEtbW9kZQo+Pgo+PiAgwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFs
L3RoZXJtYWwudHh0wqDCoMKgwqDCoMKgwqDCoHzCoMKgwqA3ICsrCj4+ICDCoERvY3VtZW50YXRp
b24vdGhlcm1hbC9zeXNmcy1hcGkudHh0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8
wqDCoMKgOSArKwo+PiAgwqBhcmNoL2FybS9ib290L2R0cy9leHlub3M0LWNwdS10aGVybWFsLmR0
c2nCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDEwICstCj4+ICDCoGFyY2gvYXJtL2Jvb3QvZHRzL2V4
eW5vczU0MTAtb2Ryb2lkeHUuZHRzwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDEwICstCj4+ICDC
oGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczU0MjAtdHJpcC1wb2ludHMuZHRzacKgwqDCoMKgwqDC
oHzCoMKgMTAgKy0KPj4gIMKgYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTQyMi1vZHJvaWR4dTMt
Y29tbW9uLmR0c2kgfMKgwqA0MCArKysrKy0tLQo+PiAgwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2V4
eW5vcy9leHlub3M1NDMzLXRtdS5kdHNpwqDCoMKgwqDCoHwgMTA1Cj4+ICsrKysrKysrKysrKysr
LS0tLS0tLQo+PiAgwqAuLi4vYXJtNjQvYm9vdC9kdHMvZXh5bm9zL2V4eW5vczctdHJpcC1wb2lu
dHMuZHRzaSB8wqDCoMKgOCArKwo+PiAgwqBkcml2ZXJzL3RoZXJtYWwvb2YtdGhlcm1hbC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgMTcgKysrKwo+
PiAgwqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDE2ICsrLS0KPj4gIMKgZHJpdmVycy90aGVybWFsL3Ro
ZXJtYWxfc3lzZnMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDC
oDUzICsrKysrKysrKystCj4+ICDCoGluY2x1ZGUvbGludXgvdGhlcm1hbC5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgNSArCj4+
ICDCoDEyIGZpbGVzIGNoYW5nZWQsIDIyNiBpbnNlcnRpb25zKCspLCA2NCBkZWxldGlvbnMoLSkK
Pj4KPiAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
