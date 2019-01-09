Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AE3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:17:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AD221783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F9sdRVWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AD221783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wO8xRevvQEuOOk8vs38d35FteXMEMWkw05ft2aiU6C0=; b=F9sdRVWSkLlZqR
	StijcaldmBfULqHGpjbZex4jmj/0lDjRJUYQhn0J3kBuhgeh77eI0aPAX4DSqAs1L5oipp4UTfI9n
	ja/LJ0vcWY05j+ztU09G0noYopEC/79N1Tdcf9LUttkAqT3KdcsBZh5m7qbjqDDDqt1GKc60HgK8t
	xVBmdj1eMfad80FKJisK84lXbUzCS4TlxyAVytgEXs4wKvdHG70om+f+83y4qNUbp/TiYDUFQ0o7N
	rCLNhqYDZpeTEzTLCLLRzQ/KeHnpKPdK9+YbLeD4McA+Iyv3CEAUVnehzZAIjA5PngsaAZ31pnBRo
	i3vlY84DBh6fxR9sPK1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBrE-0001at-H1; Wed, 09 Jan 2019 11:17:12 +0000
Received: from eddie.linux-mips.org ([148.251.95.138] helo=cvs.linux-mips.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBrB-0001Zw-7D
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 11:17:11 +0000
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993832AbfAILRFLEeRV (ORCPT
 <rfc822;linux-arm-kernel@lists.infradead.org>);
 Wed, 9 Jan 2019 12:17:05 +0100
Date: Wed, 9 Jan 2019 12:17:03 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190109111703.GA28605@lenoch>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109014218.GA8363@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_031709_255227_E8C3091F 
X-CRM114-Status: GOOD (  22.94  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBKYW4gMDksIDIwMTkgYXQgMDI6NDI6MThBTSArMDEwMCwgVmluY2VudCBHdWl0dG90
IHdyb3RlOgo+IExlIFR1ZXNkYXkgMDggSmFuIDIwMTkgw6AgMTM6Mzc6NDMgKC0wODAwKSwgVG9u
eSBMaW5kZ3JlbiBhIMOpY3JpdCA6Cj4gPiAqIFZpbmNlbnQgR3VpdHRvdCA8dmluY2VudC5ndWl0
dG90QGxpbmFyby5vcmc+IFsxOTAxMDggMTY6NDJdOgo+ID4gPiBPbiBUdWUsIDggSmFuIDIwMTkg
YXQgMTY6NTMsIFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+IHdyb3RlOgo+ID4gPiA+
IEhtbSBzbyBjb3VsZCBpdCBiZSB0aGF0IHdlIG5vdyByZWx5IG9uIHRpbWVycyB0aGF0IHRoYXQg
bWF5Cj4gPiA+ID4gbm90IGJlIGNhcGFibGUgb2Ygd2FraW5nIHVwIHRoZSBzeXN0ZW0gZnJvbSBp
ZGxlIHN0YXRlcyB3aXRoCj4gPiA+ID4gaHJ0aW1lcj8KPiA+ID4gCj4gPiA+IFdpdGggbm9oeiBh
bmQgaHJ0aW1lciBlbmFibGVkLCAgdGltZXIgcmVsaWVzIG9uIGhydGltZXIgdG8gZ2VuZXJhdGUK
PiA+ID4gdGhlIHRpY2sgc28geW91IHNob3VsZCB1c2UgdGhlIHNhbWUgaW50ZXJydXB0Lgo+ID4g
Cj4gPiBPSyB5ZWFoIGxvb2tzIGxpa2UgdGhhdCBwYXJ0IGlzIHdvcmtpbmcganVzdCBmaW5lLgo+
ID4gCj4gPiBBZGRpbmcgc29tZSBwcmludGtzIGFuZCBkZWJ1Z2dpbmcgb3ZlciBzc2gsIGxvb2tz
IGxpa2UKPiA+IG9tYXA4MjUwX3J1bnRpbWVfcmVzdW1lKCkgZ2V0cyBjYWxsZWQganVzdCBmaW5l
IGJhc2VkIG9uIGEgd2FrZWlycSwKPiA+IGJ1dCB0aGVuIG9tYXA4MjUwX3J1bnRpbWVfc3VzcGVu
ZCgpIHJ1bnMgaW1tZWRpYXRlbHkgaW5zdGVhZCBvZgo+ID4gd2FpdGluZyBmb3IgdGhlIHRocmVl
IHNlY29uZCB0aW1lb3V0Lgo+ID4gCj4gPiBMb3dlcmluZyB0aGUgYXV0b3N1c3BlbmRfZGVsYXlf
bXMgdG8gMjEwMCBtcyBtYWtlcyB0aGluZ3Mgd29yayBhZ2Fpbi4KPiA+IEFueXRoaW5nIGhpZ2hl
ciB0aGFuIDIyMDAgbXMgc2VlbXMgdG8gc29tZWhvdyB0aW1lIG91dCBpbW1lZGlhdGVseQo+ID4g
bm93IDopCj4gCj4gVGhpcyBpcyBxdWl0ZSBjbG9zZSB0byB0aGUgbWF4IG5zIG9mIGFuIGludCBv
biBhcm0gMzJiaXRzCj4gCj4gQ291bGQgeW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cgPwo+IAo+IC0t
LQo+ICBkcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9iYXNlL3Bvd2VyL3J1bnRpbWUuYyBiL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMKPiBp
bmRleCA3MDYyNDY5Li40NGM1Yzc2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9y
dW50aW1lLmMKPiArKysgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCj4gQEAgLTE0MSw3
ICsxNDEsNyBAQCB1NjQgcG1fcnVudGltZV9hdXRvc3VzcGVuZF9leHBpcmF0aW9uKHN0cnVjdCBk
ZXZpY2UgKmRldikKPiAgCj4gIAlsYXN0X2J1c3kgPSBSRUFEX09OQ0UoZGV2LT5wb3dlci5sYXN0
X2J1c3kpOwo+ICAKPiAtCWV4cGlyZXMgPSBsYXN0X2J1c3kgKyBhdXRvc3VzcGVuZF9kZWxheSAq
IE5TRUNfUEVSX01TRUM7Cj4gKwlleHBpcmVzID0gbGFzdF9idXN5ICsgKHU2NCkoYXV0b3N1c3Bl
bmRfZGVsYXkpICogTlNFQ19QRVJfTVNFQzsKPiAgCWlmIChleHBpcmVzIDw9IG5vdykKPiAgCQll
eHBpcmVzID0gMDsJLyogQWxyZWFkeSBleHBpcmVkLiAqLwoKSG1tLCBjb21tZW50IGFib3ZlIGZ1
bmN0aW9uIHN0YXRlcyBpdCByZXR1cm5zICJ0aGUgZXhwaXJhdGlvbiB0aW1lIGluIGppZmZpZXMK
KGFkanVzdGVkIHRvIGJlIG5vbnplcm8pIiwgc28gdGhlcmUncyBwcm9iYWJseSBtb3JlIHRvIGZp
eC4uLgoKWW91IGNhbiBhbHNvIGNvbnNpZGVyIGNoYW5nZSBsaWtlIHRoaXMgKHN0aWxsIGRvZXMg
bm90IHJldHVybiBqaWZmaWVzKToKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50
aW1lLmMgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCmluZGV4IDcwNjI0Njk1YjZkNS4u
YzcyZWFmMjFhNjFjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCisr
KyBiL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMKQEAgLTEyOSwyMyArMTI5LDIwIEBAIHN0
YXRpYyB2b2lkIHBtX3J1bnRpbWVfY2FuY2VsX3BlbmRpbmcoc3RydWN0IGRldmljZSAqZGV2KQog
dTY0IHBtX3J1bnRpbWVfYXV0b3N1c3BlbmRfZXhwaXJhdGlvbihzdHJ1Y3QgZGV2aWNlICpkZXYp
CiB7CiAJaW50IGF1dG9zdXNwZW5kX2RlbGF5OwotCXU2NCBsYXN0X2J1c3ksIGV4cGlyZXMgPSAw
OwotCXU2NCBub3cgPSBrdGltZV90b19ucyhrdGltZV9nZXQoKSk7CisJa3RpbWVfdCBleHBpcmVz
OwogCiAJaWYgKCFkZXYtPnBvd2VyLnVzZV9hdXRvc3VzcGVuZCkKLQkJZ290byBvdXQ7CisJCXJl
dHVybiAwOwogCiAJYXV0b3N1c3BlbmRfZGVsYXkgPSBSRUFEX09OQ0UoZGV2LT5wb3dlci5hdXRv
c3VzcGVuZF9kZWxheSk7CiAJaWYgKGF1dG9zdXNwZW5kX2RlbGF5IDwgMCkKLQkJZ290byBvdXQ7
Ci0KLQlsYXN0X2J1c3kgPSBSRUFEX09OQ0UoZGV2LT5wb3dlci5sYXN0X2J1c3kpOworCQlyZXR1
cm4gMDsKIAotCWV4cGlyZXMgPSBsYXN0X2J1c3kgKyBhdXRvc3VzcGVuZF9kZWxheSAqIE5TRUNf
UEVSX01TRUM7Ci0JaWYgKGV4cGlyZXMgPD0gbm93KQotCQlleHBpcmVzID0gMDsJLyogQWxyZWFk
eSBleHBpcmVkLiAqLworCWV4cGlyZXMgPSBrdGltZV9hZGRfbnMobXNfdG9fa3RpbWUoYXV0b3N1
c3BlbmRfZGVsYXkpLAorCQkJICAgICAgIFJFQURfT05DRShkZXYtPnBvd2VyLmxhc3RfYnVzeSkp
OworCWlmIChleHBpcmVzIDw9IGt0aW1lX2dldCgpKQorCQlyZXR1cm4gMDsJLyogQWxyZWFkeSBl
eHBpcmVkLiAqLwogCi0gb3V0OgogCXJldHVybiBleHBpcmVzOwogfQogRVhQT1JUX1NZTUJPTF9H
UEwocG1fcnVudGltZV9hdXRvc3VzcGVuZF9leHBpcmF0aW9uKTsKClJlZ2FyZHMsCglsYWRpcwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
