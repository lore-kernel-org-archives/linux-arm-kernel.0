Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34699C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:45:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0495920645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T4jckt13";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b6VZoOkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0495920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Date:Message-ID:
	In-Reply-To:To:From:Subject:Mime-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9B32IPOI6aAizez0bN6+l3bVVu9MEXqTfmVBMhTKwRM=; b=T4jckt133MrPI5
	BtlqSgxCd9nNxjRUHpfE3S51h/gcGGv90d0qFcKzwCIu1gEzhaMhQPuUHgVmdW/7geddtYIQKOK/C
	lEy2hpvZ5HqMHiqe+lxsQ5kBLEYBbf4EaVSwi8whpeQinCVLzqjttNM/O5hyea3a7tuZPpX4S1PBJ
	E6GOQKRzBwvWbmQkl6JubQ6ld3TQvEKpoWYZe+oq3SnpBYPZBedKXoI0xs6XGqPLKvCjcIZi3M6WA
	ni3mJJM5p2mONYQZYy/FnoTjS1dXymhyAap6zVAt8yWWBag5yYab0iFZhOcGA6hrmDa36GWi7nJv6
	tU9pcFaQzCuf6u8+ijww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWY3I-000494-C9; Tue, 11 Dec 2018 02:45:40 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWY3E-00048C-BJ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 02:45:38 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20181211024518epoutp028b575cc3ae4bd1ed4c4586d009235c02~vJzfu8bGw0036200362epoutp024
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:45:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20181211024518epoutp028b575cc3ae4bd1ed4c4586d009235c02~vJzfu8bGw0036200362epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544496318;
 bh=nk+OwosOKiyxXRumfbgppOX5mjdzpDJ1RVVVuD8Ot/I=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=b6VZoOkggATzVvEZRYcUClPo1KIpN4RsyOYxORBGkQDC+5jZ2XCYtjzB5Wd5pXvoJ
 ant0z6alT65BnI1K3mqugit50IhuaHGZkH0aC0odQly/QvmbXu0+Dz5XbZFHmxs/Fl
 XP3qb9TZTTd46sVjldAU942+0CQNzNPjciaI5UHY=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20181211024514epcas1p482deb2c0b1c7db055b0df34a789171fb~vJzcixyxK0469704697epcas1p4C;
 Tue, 11 Dec 2018 02:45:14 +0000 (GMT)
X-AuditID: b6c32a37-411ff70000000fdc-41-5c0f24ba7ffb
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 92.42.04060.AB42F0C5; Tue, 11 Dec 2018 11:45:14 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v3 3/5] devfreq: add devfreq_suspend/resume() functions
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Luba
 <l.luba@partner.samsung.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <5C087BC3.1050405@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181211024514epcms1p3ad01341631793f00a4161ff39139a1ce@epcms1p3>
Date: Tue, 11 Dec 2018 11:45:14 +0900
X-CMS-MailID: 20181211024514epcms1p3ad01341631793f00a4161ff39139a1ce
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkl+LIzCtJLcpLzFFi42LZdlhTX3eXCn+MwZ3j5hYHt2pabJyxntVi
 +8ZvrBbXvzxntZh/5ByrRfPi9WwWZ7pzLfofv2a2OH9+A7vF2aY37Ba3GmQsZk3Zy2Sx6fE1
 VovLu+awWXzuPcJoMeP8PiaLtUfuslssvX6RyeLuqaNA7acvsVq07j3CbtG2+gOrxZsL91gc
 xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
 udrO4tG3ZRWjx4rV39k9Pm+SC+CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
 V1LIS8xNtVVy8QnQdcvMAXpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBX
 nJhbXJqXrpecn2tlaGBgZApUmJCdcfDiZuaCnZwVW648ZWxgnMjZxcjJISFgIjGlaRZ7FyMX
 h5DADkaJdddfMncxcnDwCghK/N0hDGIKCwRKdPz1AikXElCSaLi5jxnEFhbQl+h4sI0RxGYT
 0JXYuuEuC8gYEYHlzBKfljcwgzjMAm9ZJU7d3skEsYxXYkb7UxYIW1pi+/KtYN2cAtoSs5ru
 sEPERSVurn4LZ78/Np8RwhaRaL13lhnCFpR48HM3VFxK4snbhVD19RLXPy9iAlksITCBUeL3
 jf9QCX2JR1dms4HYvAK+EpP27wFrZhFQlVh95SErRI2LRMOsKWCHMgMdtGzha3BAMAtoSqzf
 pQ8R5pN497WHFeaXHfOeQP2lJnFo9xKoVTISp6cvBGuVEPCQuPMuBxK2XxglPq1dwzaBUX4W
 InhnIVk2C2HZAkbmVYxiqQXFuempxYYFxsgxuokRnPy1zHcwbjjnc4hRgINRiYdXoYUvRog1
 say4MvcQowQHs5IIr24ab4wQb0piZVVqUX58UWlOavEhRlOgnycyS4km5wMzU15JvKGpkbGx
 sYWJoZmpoaGSOO8TqbnRQgLpiSWp2ampBalFMH1MHJxSDYwzZRVzDeZunOfhpp65TKFc0+Gv
 qtrjFvmNN48Vu8ta+1+2OPW2U9v7hpXf5JXHL/h9nf2vaVptg+OuXVNusNyb2HV10vnakDm1
 bRv6X/Guj59Q1rFRVzqrfGq+2xZLFuPKu5eZ7rhPbAlM2m5zcdNu2wmlUtH5TOcC3ZfmSx2R
 zfzt9ebGnVVKLMUZiYZazEXFiQD6GzsrFAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110622eucas1p23d788afd54ad34c0a2663efac8734648
References: <5C087BC3.1050405@samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110622eucas1p23d788afd54ad34c0a2663efac8734648@epcms1p3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_184536_565883_A71869F4 
X-CRM114-Status: GOOD (  21.37  )
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
Reply-To: myungjoo.ham@samsung.com
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "len.brown@intel.com" <len.brown@intel.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "anton@enomsg.org" <anton@enomsg.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "kgene@kernel.org" <kgene@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
 "ccross@android.com" <ccross@android.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PiBIaSBMdWthc3osCj4gCj4gT24gMjAxOOuFhCAxMuyblCAwNeydvCAyMDowNSwgTHVrYXN6IEx1
YmEgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGltcGxlbWVudGF0aW9uIGZvciBnbG9iYWwg
c3VzcGVuZC9yZXN1bWUgZm9yDQo+ID4gZGV2ZnJlcSBmcmFtZXdvcmsuIFN5c3RlbSBzdXNwZW5k
IHdpbGwgbmV4dCB1c2UgdGhlc2UgZnVuY3Rpb25zLg0KPiA+IA0KPiA+IFN1Z2dlc3RlZC1ieTog
VG9iaWFzIEpha29iaSA8dGpha29iaUBtYXRoLnVuaS1iaWVsZWZlbGQuZGU+DQo+ID4gU3VnZ2Vz
dGVkLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBMdWthc3ogTHViYSA8bC5sdWJhQHBhcnRuZXIuc2Ftc3VuZy5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCA0NCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L2RldmZyZXEuaCAg
IHwgIDYgKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPg0KDQpB
Y2tlZC1ieTogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQoNClRoZSBw
YXRjaGVzIGZyb20gMSB0byAzIGFyZSBiZWluZyBhcHBsaWVkIGFuZCB0ZXN0ZWQuDQpJJ2xsIHBy
b2JhYmx5IHNlbmQgcHVsbC1yZXF1ZXN0IHRvIFJhZmFlbCB0b2RheSBhZnRlciBzb21lIHRlc3Rp
bmcgdGFyZ2V0dGluZyA0LjIxKw0KDQpDaGVlcnMsDQpNeXVuZ0pvbw0KDQoNCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
