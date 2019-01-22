Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A937CC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:41:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B6E20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="toLqegH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B6E20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7UFM0EvwDFTI6QwH5DpUL7ZZDa2f/LIzkZ9JVZAOAW8=; b=toLqegH+p6kCQA
	zhbyw9yz0xHo7RAPHWSCCr/+Bps+6UIxjdrChPklwIIhLpNwmWkpokqT2p2cfspVu4Wfp+JSyOObM
	NZ0VJcuioqpaXmjPkgrHKeeMmzzdUzaQN/5NL0+Ksc3uFadXKyyewWGsGkBgCFDN0sv6jGNwCcfcV
	OGmaoCFePpagWXFjePx3EzZL56gMrW44VsQ4Ycjg5hYk1tBp+4oddu2yyJV/9m/OlJEMlA1hzdHY2
	oVkD7c8PkElWSL1paSWelL77cqd1kfKoB9VOW0QAIPTkgdo94mJ2H6L9R07n5YjYIXm0rF9Is01tA
	lMl4OTElJjlAh3bJ3Wnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glpky-00053W-Hp; Tue, 22 Jan 2019 06:41:56 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glpki-0004vD-Aq; Tue, 22 Jan 2019 06:41:53 +0000
X-UUID: a41fe38ee5124b33a80ab730cbbf6fe3-20190121
X-UUID: a41fe38ee5124b33a80ab730cbbf6fe3-20190121
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 857406126; Mon, 21 Jan 2019 22:41:21 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 22:41:19 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 22 Jan 2019 14:41:11 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 14:41:10 +0800
Message-ID: <1548139270.1697.1.camel@mszsdaap41>
Subject: Re: [PATCH 9/9] drm/mediatek: add dpi dual edge support
From: Jitao Shi <jitao.shi@mediatek.com>
To: CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= <ck.hu@mediatek.com>
Date: Tue, 22 Jan 2019 14:41:10 +0800
In-Reply-To: <6021c8950c3146bb941ed1355391106d@mtkmbs01n1.mediatek.inc>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
 <1546585439-30455-10-git-send-email-chunhui.dai@mediatek.com>
 <6021c8950c3146bb941ed1355391106d@mtkmbs01n1.mediatek.inc>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_224140_715220_0F3693C9 
X-CRM114-Status: GOOD (  21.35  )
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
Cc: JamesJJ Liao =?UTF-8?Q?=28=E5=BB=96=E5=BB=BA=E6=99=BA=29?=
 <jamesjj.liao@mediatek.com>,
 Ryder Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BA=9A=E8=AB=BA=29?=
 <Ryder.Lee@mediatek.com>,
 Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?=
 <Bibby.Hsieh@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>,
 Chunhui Dai =?UTF-8?Q?=28=E6=88=B4=E6=98=A5=E6=99=96=29?=
 <Chunhui.Dai@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
 --to=Michael Turquette <mturquette@baylibre.com>,
 Sean Wang <Sean.Wang@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Colin Ian King <colin.king@canonical.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ0ssCgpPaywgSSdsbCBzZW5kIGl0IGFnYWluIGluIGFuIGluZGVwZW5kZW50IHBhdGNoLgoK
QmVzdCBSZWdhcmRzCkppdGFvCgpPbiBXZWQsIDIwMTktMDEtMTYgYXQgMTQ6NTIgKzA4MDAsIENL
IEh1ICjog6Hkv4rlhYkpIHdyb3RlOgo+IEhpLCBDaHVuaHVpOgo+IAo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IGNodW5odWkgZGFpIFttYWlsdG86Y2h1bmh1aS5kYWlA
bWVkaWF0ZWsuY29tXQo+ID4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDA0LCAyMDE5IDM6MDQgUE0K
PiA+IFRvOiAtLXRvPU1pY2hhZWwgVHVycXVldHRlOyBTdGVwaGVuIEJveWQ7IENLIEh1ICjog6Hk
v4rlhYkpCj4gPiBDYzogTWF0dGhpYXMgQnJ1Z2dlcjsgUGhpbGlwcCBaYWJlbDsgRGF2aWQgQWly
bGllOyBDaHVuaHVpIERhaSAo5oi05pil5pmWKTsgU2Vhbgo+ID4gV2FuZzsgUnlkZXIgTGVlICjm
nY7luproq7opOyBDb2xpbiBJYW4gS2luZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsKPiA+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsKPiA+IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7Cj4gPiBzcnZfaGV1cHN0cmVhbTsgQmliYnkgSHNp
ZWggKOisnea/n+mBoCk7IEphbWVzSkogTGlhbyAo5buW5bu65pm6KTsgSml0YW8gU2hpICjnn7Po
rrAKPiA+IOa2mykKPiA+IFN1YmplY3Q6IFtQQVRDSCA5LzldIGRybS9tZWRpYXRlazogYWRkIGRw
aSBkdWFsIGVkZ2Ugc3VwcG9ydAo+ID4gCj4gPiBEUEkgc2FtcGxlIG9uIHJpc2luZyBhbmQgZmFs
bGluZyBlZGdlLiBJdCBjYW4gcmVkdWNlIGhhbGYgZGF0YSBpby4KPiAKPiBUaGlzIHBhdGNoIGxv
b2tzIGxpa2UgYSBwYXRjaCBmb3IgTVQ4MTgzLiBGb3IgTVQ4MTczIGFuZCBNVDI3MDEsIGR1YWxf
ZWRnZSBpcyBmYWxzZS4KPiBGb3Igbm93LCB3ZSBoYXZlIG5vdCBzdXBwb3J0IE1UODE4MyB5ZXQu
Cj4gU28geW91IGNvdWxkIGp1c3Qgc2V0IGR1YWxfZWRnZSB0byBmYWxzZSBhbmQgcmVtb3ZlIE1U
ODE4MyBwYXJ0IGluIHRoaXMgcGF0Y2guCj4gWW91IGNvdWxkIHNlbmQgdGhlIE1UODE4MyBwYXJ0
IGluIGFuIGluZGVwZW5kZW50IHBhdGNoLCBub3QgaW4gYSBzZXJpZXMgb2YgTVQyNzAxLgo+IAo+
IFJlZ2FyZHMsCj4gQ0sKPiAKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRh
by5zaGlAbWVkaWF0ZWsuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogY2h1bmh1aSBkYWkgPGNodW5o
dWkuZGFpQG1lZGlhdGVrLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBpLmMgfCAzMAo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMKPiA+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcGkuYwo+ID4gaW5kZXggNGEyZjRhNi4uYWNiNGY0NyAxMDA2NDQKPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMKPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMKPiA+IEBAIC0xMTcsNiArMTE3LDcgQEAgc3RydWN0
IG10a19kcGlfY29uZiB7Cj4gPiAgCXVuc2lnbmVkIGludCAoKmNhbF9mYWN0b3IpKGludCBjbG9j
ayk7Cj4gPiAgCXUzMiByZWdfaF9mcmVfY29uOwo+ID4gIAlib29sIGVkZ2Vfc2VsX2VuOwo+ID4g
Kwlib29sIGR1YWxfZWRnZTsKPiA+ICB9Owo+ID4gCj4gPiAgc3RhdGljIHZvaWQgbXRrX2RwaV9t
YXNrKHN0cnVjdCBtdGtfZHBpICpkcGksIHUzMiBvZmZzZXQsIHUzMiB2YWwsIHUzMiBtYXNrKQo+
ID4gQEAgLTM1Myw2ICszNTQsMTUgQEAgc3RhdGljIHZvaWQgbXRrX2RwaV9jb25maWdfZGlzYWJs
ZV9lZGdlKHN0cnVjdAo+ID4gbXRrX2RwaSAqZHBpKQo+ID4gIAkJbXRrX2RwaV9tYXNrKGRwaSwg
ZHBpLT5jb25mLT5yZWdfaF9mcmVfY29uLCAwLCBFREdFX1NFTF9FTik7ICB9Cj4gPiAKPiA+ICtz
dGF0aWMgdm9pZCBtdGtfZHBpX2NvbmZpZ19kdWFsX2VkZ2Uoc3RydWN0IG10a19kcGkgKmRwaSkg
ewo+ID4gKwlpZiAoZHBpLT5jb25mLT5kdWFsX2VkZ2UpIHsKPiA+ICsJCW10a19kcGlfbWFzayhk
cGksIERQSV9ERFJfU0VUVElORywgRERSX0VOIHwKPiA+ICsJCQkJRERSXzRQSEFTRSwgRERSX0VO
IHwgRERSXzRQSEFTRSk7Cj4gPiArCQltdGtfZHBpX21hc2soZHBpLCBEUElfT1VUUFVUX1NFVFRJ
TkcsIEVER0VfU0VMLCBFREdFX1NFTCk7Cj4gPiArCX0KPiA+ICt9Cj4gPiArCj4gPiAgc3RhdGlj
IHZvaWQgbXRrX2RwaV9jb25maWdfY29sb3JfZm9ybWF0KHN0cnVjdCBtdGtfZHBpICpkcGksCj4g
PiAgCQkJCQllbnVtIG10a19kcGlfb3V0X2NvbG9yX2Zvcm1hdCBmb3JtYXQpICB7IEBACj4gPiAt
NTA5LDYgKzUxOSw3IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2RlKHN0cnVj
dCBtdGtfZHBpICpkcGksCj4gPiAgCW10a19kcGlfY29uZmlnX2NvbG9yX2Zvcm1hdChkcGksIGRw
aS0+Y29sb3JfZm9ybWF0KTsKPiA+ICAJbXRrX2RwaV9jb25maWdfMm5faF9mcmUoZHBpKTsKPiA+
ICAJbXRrX2RwaV9jb25maWdfZGlzYWJsZV9lZGdlKGRwaSk7Cj4gPiArCW10a19kcGlfY29uZmln
X2R1YWxfZWRnZShkcGkpOwo+ID4gIAltdGtfZHBpX3N3X3Jlc2V0KGRwaSwgZmFsc2UpOwo+ID4g
Cj4gPiAgCXJldHVybiAwOwo+ID4gQEAgLTY2OSw2ICs2ODAsMTYgQEAgc3RhdGljIHVuc2lnbmVk
IGludCBtdDI3MDFfY2FsY3VsYXRlX2ZhY3RvcihpbnQKPiA+IGNsb2NrKQo+ID4gIAkJcmV0dXJu
IDE7Cj4gPiAgfQo+ID4gCj4gPiArc3RhdGljIHVuc2lnbmVkIGludCBtdDgxODNfY2FsY3VsYXRl
X2ZhY3RvcihpbnQgY2xvY2spIHsKPiA+ICsJaWYgKGNsb2NrIDw9IDI3MDAwKQo+ID4gKwkJcmV0
dXJuIDg7Cj4gPiArCWVsc2UgaWYgKGNsb2NrIDw9IDE2NzAwMCkKPiA+ICsJCXJldHVybiA0Owo+
ID4gKwllbHNlCj4gPiArCQlyZXR1cm4gMjsKPiA+ICt9Cj4gPiArCj4gPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTczX2NvbmYgPSB7Cj4gPiAgCS5jYWxfZmFjdG9yID0g
bXQ4MTczX2NhbGN1bGF0ZV9mYWN0b3IsCj4gPiAgCS5yZWdfaF9mcmVfY29uID0gMHhlMCwKPiA+
IEBAIC02ODAsNiArNzAxLDEyIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXQyNzAxX2NhbGN1bGF0
ZV9mYWN0b3IoaW50Cj4gPiBjbG9jaykKPiA+ICAJLmVkZ2Vfc2VsX2VuID0gdHJ1ZSwKPiA+ICB9
Owo+ID4gCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTgzX2NvbmYg
PSB7Cj4gPiArCS5jYWxfZmFjdG9yID0gbXQ4MTgzX2NhbGN1bGF0ZV9mYWN0b3IsCj4gPiArCS5y
ZWdfaF9mcmVfY29uID0gMHhlMCwKPiA+ICsJLmR1YWxfZWRnZSA9IHRydWUsCj4gPiArfTsKPiA+
ICsKPiA+ICBzdGF0aWMgaW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikgIHsKPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsKPiA+IEBAIC03
NzUsNiArODAyLDkgQEAgc3RhdGljIGludCBtdGtfZHBpX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlCj4gPiAqcGRldikKPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMt
ZHBpIiwKPiA+ICAJICAuZGF0YSA9ICZtdDgxNzNfY29uZiwKPiA+ICAJfSwKPiA+ICsJeyAuY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZHBpIiwKPiA+ICsJICAuZGF0YSA9ICZtdDgxODNf
Y29uZiwKPiA+ICsJfSwKPiA+ICAJeyB9LAo+ID4gIH07Cj4gPiAKPiA+IC0tCj4gPiAxLjkuMQo+
IAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
