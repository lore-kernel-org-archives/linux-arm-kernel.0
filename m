Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE83C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:12:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F46206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ckh8vCKo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYVIK8PW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F46206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y6edKAa0OavTrTXyJWq/bpUShv3BwV2N3MZCai4xwII=; b=Ckh8vCKoerVQ7C
	0DDyq2cxlwz7itFp21iraDvI4eLexU5RYR5SRgnB07irDrCc1tgVpF4zQ0leMsqikXuW1WCNNESi1
	2JQvhIpO6hYkIW9PZUPaVuTv2Mkh5RQkjS5WLs/LqJsyk2WjbT6jzUISYbphY9PeukOod/mYOCkX0
	ZyvXGLq91tmi8qP19ChVYWY1LkKskdM10d0RzmHPzyqbM/1iHZlLDiz+XV9PL+1WqgOG5ud3TQi9U
	hgq8J7a2TofrxTWAPp8sE1PLKRC7DoGxAGTakfLvnP/UnZ7ur78kRCIUQZACSZGUUEup//pK1EY8i
	FXxOM+uPdL1FFmZQhQqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEb4-0004fs-KQ; Wed, 09 Jan 2019 14:12:42 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEb0-0004fH-Gp
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:12:40 +0000
Received: by mail-io1-xd43.google.com with SMTP id c2so6077868iom.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 06:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0nl716eAE7GZXTIOr6MtAR6wxSXrMDpGuwhYZIWFNu8=;
 b=kYVIK8PWEFIVLns5XbgfzNM29cEgjEiyFDGvuS68M0A1aoZ0c6QVSmCD797y4IJwE8
 1+0Z/wVipeWfWPyqZ8Vap/wXRBYqcZSnoG/7SgnmbOD0/aY4qVc0iP0IyE4P6/5cvTe8
 W5uTeRLjjCPlAcmD0bPhUwGgamwAfLggmo4wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0nl716eAE7GZXTIOr6MtAR6wxSXrMDpGuwhYZIWFNu8=;
 b=S/iF9c8Q0BRs6OjOjHzIiDcLHJ/56RbEHqtjFfjGXKg0+PetDBq5IbX187R/l8pEtz
 TBMVsP3IajRRrqjzYtcL0BNooCiLOD3x+FCYBqidI/MGo0FQYFryCb5bCip+AOEg3CZk
 D/kTs4CbFy+SUR5PtI68gGfW+bMw3lyU6PfCQj86YmPrfZW6Jln97RvEVtA53o4f04Ul
 rvN/mwC5Iwd1sSQm+kQ/9Oo+yDGZMqPxDETx4dkcwn/blLqHawR1NWw2xS5hHmYueaLy
 oJcgQRPmtXtcMAbKT8fZ4mRZBfgyMe3kKPnA2wwTaWieTtZYkXzhB/ILF0Q50Jqr/yrN
 9r3g==
X-Gm-Message-State: AJcUukceaIcjyvL5T17Mc0xstzNzfBNekjCGW0L/Vlk0qa98fFgKHwtO
 rjYYtRZhqaB9DTXsYrR45tnipWJBD0cLT4DwqIM6DQ==
X-Google-Smtp-Source: ALg8bN4i6g+do94SE0K3kd9bP561s1z028QzgfvZ5BycqrZqGshkwktWXF7m5xpWmX+sdBf6SaVqeRyJ/rZvL0HYWrQ=
X-Received: by 2002:a6b:6b02:: with SMTP id g2mr3774737ioc.18.1547043156498;
 Wed, 09 Jan 2019 06:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109111703.GA28605@lenoch>
 <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch>
 <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch>
In-Reply-To: <20190109133337.GA13579@lenoch>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 9 Jan 2019 15:12:25 +0100
Message-ID: <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Ladislav Michl <ladis@linux-mips.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_061238_567444_ADFCA5AC 
X-CRM114-Status: GOOD (  33.51  )
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

UGxlYXNlIGtlZXAgYWxsIHRocmVhZCBsaXN0IHdoZW4gcmVwbHlpbmcgOi0pCgpPbiBXZWQsIDkg
SmFuIDIwMTkgYXQgMTQ6MzMsIExhZGlzbGF2IE1pY2hsIDxsYWRpc0BsaW51eC1taXBzLm9yZz4g
d3JvdGU6Cj4KPiBPbiBXZWQsIEphbiAwOSwgMjAxOSBhdCAwMjoyNDozN1BNICswMTAwLCBWaW5j
ZW50IEd1aXR0b3Qgd3JvdGU6Cj4gPiBPbiBXZWQsIDkgSmFuIDIwMTkgYXQgMTI6NTgsIExhZGlz
bGF2IE1pY2hsIDxsYWRpc0BsaW51eC1taXBzLm9yZz4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFdl
ZCwgSmFuIDA5LCAyMDE5IGF0IDEyOjI3OjU3UE0gKzAxMDAsIFZpbmNlbnQgR3VpdHRvdCB3cm90
ZToKPiA+ID4gPiBPbiBXZWQsIDkgSmFuIDIwMTkgYXQgMTI6MTcsIExhZGlzbGF2IE1pY2hsIDxs
YWRpc0BsaW51eC1taXBzLm9yZz4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gV2VkLCBK
YW4gMDksIDIwMTkgYXQgMDI6NDI6MThBTSArMDEwMCwgVmluY2VudCBHdWl0dG90IHdyb3RlOgo+
ID4gPiA+ID4gPiBMZSBUdWVzZGF5IDA4IEphbiAyMDE5IMOgIDEzOjM3OjQzICgtMDgwMCksIFRv
bnkgTGluZGdyZW4gYSDDqWNyaXQgOgo+ID4gPiA+ID4gPiA+ICogVmluY2VudCBHdWl0dG90IDx2
aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4gWzE5MDEwOCAxNjo0Ml06Cj4gPiA+ID4gPiA+ID4g
PiBPbiBUdWUsIDggSmFuIDIwMTkgYXQgMTY6NTMsIFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlk
ZS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBIbW0gc28gY291bGQgaXQgYmUgdGhhdCB3
ZSBub3cgcmVseSBvbiB0aW1lcnMgdGhhdCB0aGF0IG1heQo+ID4gPiA+ID4gPiA+ID4gPiBub3Qg
YmUgY2FwYWJsZSBvZiB3YWtpbmcgdXAgdGhlIHN5c3RlbSBmcm9tIGlkbGUgc3RhdGVzIHdpdGgK
PiA+ID4gPiA+ID4gPiA+ID4gaHJ0aW1lcj8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiBXaXRoIG5vaHogYW5kIGhydGltZXIgZW5hYmxlZCwgIHRpbWVyIHJlbGllcyBvbiBocnRpbWVy
IHRvIGdlbmVyYXRlCj4gPiA+ID4gPiA+ID4gPiB0aGUgdGljayBzbyB5b3Ugc2hvdWxkIHVzZSB0
aGUgc2FtZSBpbnRlcnJ1cHQuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPSyB5ZWFoIGxv
b2tzIGxpa2UgdGhhdCBwYXJ0IGlzIHdvcmtpbmcganVzdCBmaW5lLgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gQWRkaW5nIHNvbWUgcHJpbnRrcyBhbmQgZGVidWdnaW5nIG92ZXIgc3NoLCBs
b29rcyBsaWtlCj4gPiA+ID4gPiA+ID4gb21hcDgyNTBfcnVudGltZV9yZXN1bWUoKSBnZXRzIGNh
bGxlZCBqdXN0IGZpbmUgYmFzZWQgb24gYSB3YWtlaXJxLAo+ID4gPiA+ID4gPiA+IGJ1dCB0aGVu
IG9tYXA4MjUwX3J1bnRpbWVfc3VzcGVuZCgpIHJ1bnMgaW1tZWRpYXRlbHkgaW5zdGVhZCBvZgo+
ID4gPiA+ID4gPiA+IHdhaXRpbmcgZm9yIHRoZSB0aHJlZSBzZWNvbmQgdGltZW91dC4KPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+IExvd2VyaW5nIHRoZSBhdXRvc3VzcGVuZF9kZWxheV9tcyB0
byAyMTAwIG1zIG1ha2VzIHRoaW5ncyB3b3JrIGFnYWluLgo+ID4gPiA+ID4gPiA+IEFueXRoaW5n
IGhpZ2hlciB0aGFuIDIyMDAgbXMgc2VlbXMgdG8gc29tZWhvdyB0aW1lIG91dCBpbW1lZGlhdGVs
eQo+ID4gPiA+ID4gPiA+IG5vdyA6KQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGlzIGlzIHF1
aXRlIGNsb3NlIHRvIHRoZSBtYXggbnMgb2YgYW4gaW50IG9uIGFybSAzMmJpdHMKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gQ291bGQgeW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cgPwo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1l
LmMgfCAyICstCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YmFzZS9wb3dlci9ydW50aW1lLmMgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCj4gPiA+
ID4gPiA+IGluZGV4IDcwNjI0NjkuLjQ0YzVjNzYgMTAwNjQ0Cj4gPiA+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMKPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9iYXNl
L3Bvd2VyL3J1bnRpbWUuYwo+ID4gPiA+ID4gPiBAQCAtMTQxLDcgKzE0MSw3IEBAIHU2NCBwbV9y
dW50aW1lX2F1dG9zdXNwZW5kX2V4cGlyYXRpb24oc3RydWN0IGRldmljZSAqZGV2KQo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiAgICAgICBsYXN0X2J1c3kgPSBSRUFEX09OQ0UoZGV2LT5wb3dlci5s
YXN0X2J1c3kpOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAtICAgICBleHBpcmVzID0gbGFzdF9i
dXN5ICsgYXV0b3N1c3BlbmRfZGVsYXkgKiBOU0VDX1BFUl9NU0VDOwo+ID4gPiA+ID4gPiArICAg
ICBleHBpcmVzID0gbGFzdF9idXN5ICsgKHU2NCkoYXV0b3N1c3BlbmRfZGVsYXkpICogTlNFQ19Q
RVJfTVNFQzsKPiA+ID4gPiA+ID4gICAgICAgaWYgKGV4cGlyZXMgPD0gbm93KQo+ID4gPiA+ID4g
PiAgICAgICAgICAgICAgIGV4cGlyZXMgPSAwOyAgICAvKiBBbHJlYWR5IGV4cGlyZWQuICovCj4g
PiA+ID4gPgo+ID4gPiA+ID4gSG1tLCBjb21tZW50IGFib3ZlIGZ1bmN0aW9uIHN0YXRlcyBpdCBy
ZXR1cm5zICJ0aGUgZXhwaXJhdGlvbiB0aW1lIGluIGppZmZpZXMKPiA+ID4gPiA+IChhZGp1c3Rl
ZCB0byBiZSBub256ZXJvKSIsIHNvIHRoZXJlJ3MgcHJvYmFibHkgbW9yZSB0byBmaXguLi4KPiA+
ID4gPgo+ID4gPiA+IFRoZSBjb21tZW50IGlzIHdyb25nIGFuZCBzaG91bGQgYmUgdXBkYXRlZCBh
cyBjb21taXQgODIzNGY2NzM0YzVkIGhhcwo+ID4gPiA+IG1vdmVkIG9uIGhydGltZXIgYW5kIGV4
cGlyZXMgaXMgbm93IGluIHJhdyBucyB1bml0Cj4gPiA+Cj4gPiA+IFl1cC4gV2hvJ2xsIHNlbmQg
YSBwYXRjaD8gSXMgaXQgd29ydGggb3B0aW1pemluZyBhcyBiZWxsb3c/IEknbSBmaW5lIHdpdGgg
ZG9pbmcKPiA+Cj4gPiBZb3UgY2FuIHNlbmQgYSBwYXRjaCBmb3IgdXBkYXRpbmcgdGhlIGNvbW1l
bnQuCj4gPgo+ID4gPiBib3RoLgo+ID4KPiA+IFJlZ2FyZGluZyBwcm9wb3NhbCBiZWxvdzoKPiA+
IC0gcG1fcnVudGltZV9hdXRvc3VzcGVuZF9leHBpcmF0aW9uKCkgcmV0dXJucyB1NjQgYW5kIG5v
dCBrdGltZV90Cj4KPiBXZWxsLCB0aGF0J3MgbWF0dGVyIG9mIGFkZGluZyBrdGltZV90b19ucyAo
d2hpY2ggaXMgbm9vcCkuCj4KPiA+IC0gdXNlIGhlbHBlciBrdGltZV9iZWZvcmUvYWZ0ZXIgdG8g
Y29tcGFyZSBrdGltZV90IHZhbHVlCj4gPgo+ID4gVXNpbmcga3RpbWUgaGVscGVyIGZ1bmN0aW9u
IG1ha2VzIHRoZSBjb2RlIGxlc3MgcmVhZGFibGUgYW5kIHRoZQo+Cj4gVGhhdCB3aHkgSSBhdm9p
ZGVkIGl0LgoKQnV0IHlvdSBtdXN0IHVzZSBoZWxwZXIgZnVuY3Rpb24gaWYgeW91IHVzZSBrdGlt
ZV90ClRoYXQncyBvbmUgbWFpbiByZWFzb24gZm9yIHVzaW5nIHU2NCBpbnN0ZWFkIG9mIGt0aW1l
X3QKCj4KPiA+IHByb3Bvc2FsIG1ha2UgdGhlIGZ1bmN0aW9uIG1vcmUgZGlmZmljdWx0IHRvIHJl
YWQgSU1ITyB3aGVuIHlvdQo+ID4gY29tcGFyZQo+ID4gICBleHBpcmVzID0gbGFzdF9idXN5ICsg
YXV0b3N1c3BlbmRfZGVsYXkgKiBOU0VDX1BFUl9NU0VDOwo+ID4gd2l0aAo+ID4gICBleHBpcmVz
ID0ga3RpbWVfYWRkX25zKG1zX3RvX2t0aW1lKGF1dG9zdXNwZW5kX2RlbGF5KSwKPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFJFQURfT05DRShkZXYtPnBvd2VyLmxhc3RfYnVzeSkp
Owo+Cj4gSSBhZ3JlZSwgYnV0IGl0IGRvZWEgYWxsIHRoZSBtYWdpYyBjb3JyZWN0bHksIHNvIHlv
dSB3b24ndCBuZWVkCj4gdG8gdG91Y2ggdGhhdCBjb2RlIGlzIGt0aW1lX3QgY2hhbmdlcyAoSSBr
bm93LCB1bmxpa2VseS4uKQoKQnV0IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGRvZXNuJ3Qg
Y2FyZSBvZiBhbnkgY2hhbmdlcyBpbiBrdGltZV90CmFzIGl0IHVzZXMgcmF3IG5zCgo+Cj4gPiBv
ciB3aGVuIHlvdSBjb21wYXJlCj4gPiAgaWYgKGV4cGlyZXMgPD0gbm93KQo+ID4gd2l0aAo+ID4g
IGlmIChrdGltZV9hZnRlcihub3csIGV4cGlyZXMpKQo+ID4KPiA+IEFuZCAgSSdtIG5vdCBzdXJl
IHRoYXQgdGhpcyB3aWxsIG9wdGltaXplIHRoZSBjb2RlIGF0IHRoZSBlbmQKPgo+IENoZWNrZWQg
Z2VuZXJhdGVkIGNvZGUgb24gQVJNIGFuZCB4ODYgYW5kIGdjYyBkb2VzIHByZXR0eSBnb29kIGpv
YiBoZXJlLgo+Cj4gPiBPbmx5IHRoZSByZXBsYWNlbWVudCBvZiB0aGUgImdvdG8gb3V0IiBieSBy
ZXR1cm4gMCB3b3VsZCBtYWtlIHNlbnNlIElNTwo+Cj4gV2VsbCwgbWFpbiBjb25jZXJuIHdhcyBu
b3QgdG8gY2FsbCBrdGltZV9nZXQgYXQgdGhlIGJlZ2lubmluZyBvZiBmdW5jdGlvbgo+IGFzIGl0
IGlzIG5vdCB0b28gY2hlYXAuCgpEb2Vzbid0IHRoZSBjb21waWxlciBvcHRpbWl6ZSB0aGF0IHRv
IGp1c3QgYmVmb3JlIHRoZSB0ZXN0ID8KCj4KPiA+IFJlZ2FyZHMsCj4gPiBWaW5jZW50Cj4gPgo+
ID4gPgo+ID4gPiA+ID4gWW91IGNhbiBhbHNvIGNvbnNpZGVyIGNoYW5nZSBsaWtlIHRoaXMgKHN0
aWxsIGRvZXMgbm90IHJldHVybiBqaWZmaWVzKToKPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jIGIvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYwo+
ID4gPiA+ID4gaW5kZXggNzA2MjQ2OTViNmQ1Li5jNzJlYWYyMWE2MWMgMTAwNjQ0Cj4gPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCj4gPiA+ID4gPiArKysgYi9kcml2
ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCj4gPiA+ID4gPiBAQCAtMTI5LDIzICsxMjksMjAgQEAg
c3RhdGljIHZvaWQgcG1fcnVudGltZV9jYW5jZWxfcGVuZGluZyhzdHJ1Y3QgZGV2aWNlICpkZXYp
Cj4gPiA+ID4gPiAgdTY0IHBtX3J1bnRpbWVfYXV0b3N1c3BlbmRfZXhwaXJhdGlvbihzdHJ1Y3Qg
ZGV2aWNlICpkZXYpCj4gPiA+ID4gPiAgewo+ID4gPiA+ID4gICAgICAgICBpbnQgYXV0b3N1c3Bl
bmRfZGVsYXk7Cj4gPiA+ID4gPiAtICAgICAgIHU2NCBsYXN0X2J1c3ksIGV4cGlyZXMgPSAwOwo+
ID4gPiA+ID4gLSAgICAgICB1NjQgbm93ID0ga3RpbWVfdG9fbnMoa3RpbWVfZ2V0KCkpOwo+ID4g
PiA+ID4gKyAgICAgICBrdGltZV90IGV4cGlyZXM7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAg
ICBpZiAoIWRldi0+cG93ZXIudXNlX2F1dG9zdXNwZW5kKQo+ID4gPiA+ID4gLSAgICAgICAgICAg
ICAgIGdvdG8gb3V0Owo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gPiA+
ID4KPiA+ID4gPiA+ICAgICAgICAgYXV0b3N1c3BlbmRfZGVsYXkgPSBSRUFEX09OQ0UoZGV2LT5w
b3dlci5hdXRvc3VzcGVuZF9kZWxheSk7Cj4gPiA+ID4gPiAgICAgICAgIGlmIChhdXRvc3VzcGVu
ZF9kZWxheSA8IDApCj4gPiA+ID4gPiAtICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gPiA+ID4g
PiAtCj4gPiA+ID4gPiAtICAgICAgIGxhc3RfYnVzeSA9IFJFQURfT05DRShkZXYtPnBvd2VyLmxh
c3RfYnVzeSk7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiA+ID4gPgo+
ID4gPiA+ID4gLSAgICAgICBleHBpcmVzID0gbGFzdF9idXN5ICsgYXV0b3N1c3BlbmRfZGVsYXkg
KiBOU0VDX1BFUl9NU0VDOwo+ID4gPiA+ID4gLSAgICAgICBpZiAoZXhwaXJlcyA8PSBub3cpCj4g
PiA+ID4gPiAtICAgICAgICAgICAgICAgZXhwaXJlcyA9IDA7ICAgIC8qIEFscmVhZHkgZXhwaXJl
ZC4gKi8KPiA+ID4gPiA+ICsgICAgICAgZXhwaXJlcyA9IGt0aW1lX2FkZF9ucyhtc190b19rdGlt
ZShhdXRvc3VzcGVuZF9kZWxheSksCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgUkVBRF9PTkNFKGRldi0+cG93ZXIubGFzdF9idXN5KSk7Cj4gPiA+ID4gPiArICAgICAg
IGlmIChleHBpcmVzIDw9IGt0aW1lX2dldCgpKQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiAwOyAgICAgICAvKiBBbHJlYWR5IGV4cGlyZWQuICovCj4gPiA+ID4gPgo+ID4gPiA+ID4g
LSBvdXQ6Cj4gPiA+ID4gPiAgICAgICAgIHJldHVybiBleHBpcmVzOwo+ID4gPiA+ID4gIH0KPiA+
ID4gPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChwbV9ydW50aW1lX2F1dG9zdXNwZW5kX2V4cGlyYXRp
b24pOwo+ID4gPiA+ID4KPiA+ID4gPiA+IFJlZ2FyZHMsCj4gPiA+ID4gPiAgICAgICAgIGxhZGlz
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
