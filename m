Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:39:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5632146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vscrjfe6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj1+dY2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5632146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/WoKrQLl+E+MEQRMyzsyvTEOFQ1hUp6gZEICrGcl2XA=; b=Vscrjfe6JPrKSr
	BhQBofhBwotEllLIXMf5/O1QF/qrwr+p7my/BYXk/849W0Ax0ooq/+jdl2CXKXwYFMHS8QuG0562M
	JhGVNazH7c4t0g5gPcXOizyAEn19p8KLsv1BuEIJ2ao69fdTl24DC3W5K2bNjCHBVEqvQSvLlfBo5
	3ENdKJoRI5WvQi22gztV3c7clv3mh1St7EFpTQW7bnnaiNAqpXluNeEQipxwyb6USfDsbfjOtSr7g
	r9mJbrNBnT22Ihmm9hHolg2R0B8qh5SzumUMDM0rkWExD50qW3WMxsFqQby3GbPeeM0Jlt8hEh2pd
	R1Byyn1VbNluxhSQUReA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt4Jf-0004bD-Qj; Mon, 11 Feb 2019 05:39:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt4Jc-0004QO-He
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 05:39:38 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 642FF2146F;
 Mon, 11 Feb 2019 05:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549863574;
 bh=FvQdnsYS6AZuendbS1RL03u7n4yaYMZ+qRCQPQqZkXQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fj1+dY2Gtu0lZIhnaHAbgyfqXPmB/heqFYFouuI31LdP34pZwL2o2aa/lKDOiIuJU
 S9LJhFjBh22m1BW3c839Z+dGYWumeJO95mcf3GJFgzMnMQ5sTe1NhxHN4/5H2sXiug
 Wytv44uboO1/yU3L1u15gTldguR7hmNXTNV2oU5Q=
Date: Mon, 11 Feb 2019 13:39:22 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [v5 2/2] arm64: dts: lx2160a: add sata node support
Message-ID: <20190211053920.GM22487@dragon>
References: <20190125081013.21663-1-peng.ma@nxp.com>
 <20190125081013.21663-2-peng.ma@nxp.com>
 <20190201063011.GL19882@dragon>
 <VI1PR04MB44313B08539AA7081DC53BAFED640@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44313B08539AA7081DC53BAFED640@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_213936_623797_DFD71CC4 
X-CRM114-Status: GOOD (  15.64  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, Andy Tang <andy.tang@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTEsIDIwMTkgYXQgMDI6NTM6MThBTSArMDAwMCwgUGVuZyBNYSB3cm90ZToK
PiAKPiAKPiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+RnJvbTogU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPgo+ID5TZW50OiAyMDE55bm0MuaciDHml6UgMTQ6MzAKPiA+VG86
IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT4KPiA+Q2M6IGF4Ym9lQGtlcm5lbC5kazsgcm9iaCtk
dEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgTGVvIExpCj4gPjxsZW95YW5nLmxp
QG54cC5jb20+OyBsaW51eC1pZGVAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsKPiA+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBBbmR5IFRhbmcKPiA+PGFuZHkudGFuZ0BueHAuY29tPgo+
ID5TdWJqZWN0OiBSZTogW3Y1IDIvMl0gYXJtNjQ6IGR0czogbHgyMTYwYTogYWRkIHNhdGEgbm9k
ZSBzdXBwb3J0Cj4gPgo+ID5PbiBGcmksIEphbiAyNSwgMjAxOSBhdCAwODoxMDoxM0FNICswMDAw
LCBQZW5nIE1hIHdyb3RlOgo+ID4+IEFkZCBTQVRBIGRldmljZSBub2RlcyBmb3IgZnNsLWx4MjE2
MGEgYW5kIGVuYWJsZSBzdXBwb3J0IGZvciBRRFMgYW5kCj4gPj4gUkRCIGJvYXJkcy4KPiA+Pgo+
ID4+IFNpZ25lZC1vZmYtYnk6IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT4KPiA+PiAtLS0KPiA+
PiBjaGFuZ2VkIGZvciBWNToKPiA+PiAJLSBubyBjaGFuZ2UKPiA+Pgo+ID4+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzIHwgICAxNiArKysrKysrCj4g
Pj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMgfCAg
IDE2ICsrKysrKysKPiA+PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2
MGEuZHRzaSAgICB8ICAgNDQKPiA+KysrKysrKysrKysrKysrKysrKysrCj4gPj4gIDMgZmlsZXMg
Y2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKPiA+Pgo+ID4+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRz
Cj4gPj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRz
Cj4gPj4gaW5kZXggOTlhMjJhYi4uMWE1YWNmNiAxMDA2NDQKPiA+PiAtLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzCj4gPj4gKysrIGIvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcWRzLmR0cwo+ID4+IEBAIC05NSw2
ICs5NSwyMiBAQAo+ID4+ICAJfTsKPiA+PiAgfTsKPiA+Pgo+ID4+ICsmc2F0YTAgewo+ID4+ICsJ
c3RhdHVzID0gIm9rYXkiOwo+ID4+ICt9Owo+ID4+ICsKPiA+PiArJnNhdGExIHsKPiA+PiArCXN0
YXR1cyA9ICJva2F5IjsKPiA+PiArfTsKPiA+PiArCj4gPj4gKyZzYXRhMiB7Cj4gPj4gKwlzdGF0
dXMgPSAib2theSI7Cj4gPj4gK307Cj4gPj4gKwo+ID4+ICsmc2F0YTMgewo+ID4+ICsJc3RhdHVz
ID0gIm9rYXkiOwo+ID4+ICt9Owo+ID4+ICsKPiA+PiAgJnVhcnQwIHsKPiA+PiAgCXN0YXR1cyA9
ICJva2F5IjsKPiA+PiAgfTsKPiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cwo+ID4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cwo+ID4+IGluZGV4IDY0ODFlNWYuLjViNjc5OWUg
MTAwNjQ0Cj4gPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2
MGEtcmRiLmR0cwo+ID4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
eDIxNjBhLXJkYi5kdHMKPiA+PiBAQCAtMTAyLDYgKzEwMiwyMiBAQAo+ID4+ICAJfTsKPiA+PiAg
fTsKPiA+Pgo+ID4+ICsmc2F0YTAgewo+ID4+ICsJc3RhdHVzID0gIm9rYXkiOwo+ID4+ICt9Owo+
ID4+ICsKPiA+PiArJnNhdGExIHsKPiA+PiArCXN0YXR1cyA9ICJva2F5IjsKPiA+PiArfTsKPiA+
PiArCj4gPj4gKyZzYXRhMiB7Cj4gPj4gKwlzdGF0dXMgPSAib2theSI7Cj4gPj4gK307Cj4gPj4g
Kwo+ID4+ICsmc2F0YTMgewo+ID4+ICsJc3RhdHVzID0gIm9rYXkiOwo+ID4+ICt9Owo+ID4+ICsK
PiA+PiAgJnVhcnQwIHsKPiA+PiAgCXN0YXR1cyA9ICJva2F5IjsKPiA+PiAgfTsKPiA+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQo+
ID4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQo+ID4+
IGluZGV4IGE3OWY1YzEuLjU5MjAzNGIgMTAwNjQ0Cj4gPj4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQo+ID4+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kKPiA+PiBAQCAtNjcxLDYgKzY3MSw1MCBA
QAo+ID4+ICAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4+ICAJCX07Cj4gPj4KPiA+PiArCQlz
YXRhMDogc2F0YUAzMjAwMDAwIHsKPiA+PiArCQkJY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1h
aGNpIjsKPiA+Cj4gPkhhcyB0aGUga2VybmVsIGRyaXZlciBiZWVuIHBhdGNoZWQgdG8gcHJvYmUg
dGhlIGNvbXBhdGlibGU/Cj4gPgo+ID5TaGF3bgo+IFllcywgdGhlIGRyaXZlciBwYXRjaCBpcyBo
dHRwOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMTAzNDA4My8KClBpbmcgbWUgd2hlbiB0
aGUgZHJpdmVyIHBhdGNoIGlzIGFjY2VwdGVkLiAgSWRlYWxseSwgd2Ugb25seSBhY2NlcHQgZHRz
CmNoYW5nZXMgYWZ0ZXIgdGhlIGRyaXZlciBjb3VudGVycGFydCBsYW5kcyBvbiBtYWlubGluZS4K
ClNoYXduCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
