Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FCEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:24:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E6B206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HDKvVt7T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBivxxLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E6B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tYTb5fRuf1dKY8bZ1UP0gBDg/pR8fYe7uphN/OvcG5Q=; b=HDKvVt7T1e2pe9
	2k3Tt7MBh6L43tpMyc0jzn7Ja+X16rF1llQ0WANg19EmYaVXlMbqVmnmzTJ6JIJyOtvbpZCZYA6n7
	d4klQYcFY2jvg72GZtHO4g24hGZlAbPyjgg9lnRHN7lUEW5Zca289SZe267Gxcne8i6Y/WTf+YBLX
	1We/ytySy+ts06fy6ssNau1jk5WNlohRiRcaBqD6NQx0HLdqAH6CqonRmAKpX0brMYa49PLdfsuGb
	P/pbkNbl8coptCMZdnJ+lWcxMQ1zQQ1l27xKpCxJD2ZKlAjxFIqdO/A1kbAf0iQCppygE8Irw/bhT
	SURd7WPq2yGtk4CsIDAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghDqn-0007qz-AR; Wed, 09 Jan 2019 13:24:53 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghDqk-0007qV-D9
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:24:52 +0000
Received: by mail-io1-xd41.google.com with SMTP id g8so5999248iok.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 05:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5hsdTeezotDqIwqu1cpLVURCriWtQKJNakUlAd/T5M8=;
 b=cBivxxLopiyns29Buj8DXZhRdxv0QVQ7JpNDg6m4Uy8zENx1YEZh2iioI3AC99ILg+
 C5Dv4uvcH9wr3ADtxhcbQqZWqdkNtFFOH0AJev2sXlXF/s/+ayFByifmAbQUhfLA2v/z
 oRFHXMKrrwiEf5i8Z5Cji2+RIySMRPqr49dPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5hsdTeezotDqIwqu1cpLVURCriWtQKJNakUlAd/T5M8=;
 b=iZNcWs1bTs/GLbCLYK1YxA9gJWQJnO5CQzGGMCHVboCrebAvcLRgF4dbpd9/nlXLgF
 bnvafU0+L8hQOFDpkIy4Pkc23goB/HDcDZC5qB72nsirlp1ZA0tt8w87cUtzz2+5kmH1
 GW8FUm6N/4ZHcJxaQ+ECHB2OblipCvybipKtv6BX3b0EvIqgTa7mNgJReD1Q76hxYnzF
 6pftfMcBYjUXSvkUKFa3uGcsSkLtCmkuUcDgC+D5Z6aTjh/CtUHvoFgndryx0HY+v0X3
 y/grdI436X+FCbAHv8NcaOiHD5yFkJJ5nrCISaRfm8Bf26qMmBKQlDe4SxcLcDz86STa
 5KMQ==
X-Gm-Message-State: AJcUukfO9e5dchxOsEfNLpF3nrW6bOKhz6Yvhsx/yxH+MeBIajPWpIPL
 Uta++qP0/S2uCOIDtunYpHVApaMzNK+imywe26pM3w==
X-Google-Smtp-Source: ALg8bN7r3Q5mBhMW/YN+kdyWFcyVCBLJX6/vR+CAzPTAt79hgENFZVQOfQqc59tz29Edb8k4cls4b0PfV3fmzQoRFUI=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr3606580ioh.294.1547040288779; 
 Wed, 09 Jan 2019 05:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109111703.GA28605@lenoch>
 <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch>
In-Reply-To: <20190109115824.GA1353@lenoch>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 9 Jan 2019 14:24:37 +0100
Message-ID: <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Ladislav Michl <ladis@linux-mips.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_052450_446232_E09BF9FB 
X-CRM114-Status: GOOD (  27.73  )
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

T24gV2VkLCA5IEphbiAyMDE5IGF0IDEyOjU4LCBMYWRpc2xhdiBNaWNobCA8bGFkaXNAbGludXgt
bWlwcy5vcmc+IHdyb3RlOgo+Cj4gT24gV2VkLCBKYW4gMDksIDIwMTkgYXQgMTI6Mjc6NTdQTSAr
MDEwMCwgVmluY2VudCBHdWl0dG90IHdyb3RlOgo+ID4gT24gV2VkLCA5IEphbiAyMDE5IGF0IDEy
OjE3LCBMYWRpc2xhdiBNaWNobCA8bGFkaXNAbGludXgtbWlwcy5vcmc+IHdyb3RlOgo+ID4gPgo+
ID4gPiBPbiBXZWQsIEphbiAwOSwgMjAxOSBhdCAwMjo0MjoxOEFNICswMTAwLCBWaW5jZW50IEd1
aXR0b3Qgd3JvdGU6Cj4gPiA+ID4gTGUgVHVlc2RheSAwOCBKYW4gMjAxOSDDoCAxMzozNzo0MyAo
LTA4MDApLCBUb255IExpbmRncmVuIGEgw6ljcml0IDoKPiA+ID4gPiA+ICogVmluY2VudCBHdWl0
dG90IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4gWzE5MDEwOCAxNjo0Ml06Cj4gPiA+ID4g
PiA+IE9uIFR1ZSwgOCBKYW4gMjAxOSBhdCAxNjo1MywgVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9t
aWRlLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gSG1tIHNvIGNvdWxkIGl0IGJlIHRoYXQgd2Ug
bm93IHJlbHkgb24gdGltZXJzIHRoYXQgdGhhdCBtYXkKPiA+ID4gPiA+ID4gPiBub3QgYmUgY2Fw
YWJsZSBvZiB3YWtpbmcgdXAgdGhlIHN5c3RlbSBmcm9tIGlkbGUgc3RhdGVzIHdpdGgKPiA+ID4g
PiA+ID4gPiBocnRpbWVyPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBXaXRoIG5vaHogYW5kIGhy
dGltZXIgZW5hYmxlZCwgIHRpbWVyIHJlbGllcyBvbiBocnRpbWVyIHRvIGdlbmVyYXRlCj4gPiA+
ID4gPiA+IHRoZSB0aWNrIHNvIHlvdSBzaG91bGQgdXNlIHRoZSBzYW1lIGludGVycnVwdC4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBPSyB5ZWFoIGxvb2tzIGxpa2UgdGhhdCBwYXJ0IGlzIHdvcmtpbmcg
anVzdCBmaW5lLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEFkZGluZyBzb21lIHByaW50a3MgYW5kIGRl
YnVnZ2luZyBvdmVyIHNzaCwgbG9va3MgbGlrZQo+ID4gPiA+ID4gb21hcDgyNTBfcnVudGltZV9y
ZXN1bWUoKSBnZXRzIGNhbGxlZCBqdXN0IGZpbmUgYmFzZWQgb24gYSB3YWtlaXJxLAo+ID4gPiA+
ID4gYnV0IHRoZW4gb21hcDgyNTBfcnVudGltZV9zdXNwZW5kKCkgcnVucyBpbW1lZGlhdGVseSBp
bnN0ZWFkIG9mCj4gPiA+ID4gPiB3YWl0aW5nIGZvciB0aGUgdGhyZWUgc2Vjb25kIHRpbWVvdXQu
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gTG93ZXJpbmcgdGhlIGF1dG9zdXNwZW5kX2RlbGF5X21zIHRv
IDIxMDAgbXMgbWFrZXMgdGhpbmdzIHdvcmsgYWdhaW4uCj4gPiA+ID4gPiBBbnl0aGluZyBoaWdo
ZXIgdGhhbiAyMjAwIG1zIHNlZW1zIHRvIHNvbWVob3cgdGltZSBvdXQgaW1tZWRpYXRlbHkKPiA+
ID4gPiA+IG5vdyA6KQo+ID4gPiA+Cj4gPiA+ID4gVGhpcyBpcyBxdWl0ZSBjbG9zZSB0byB0aGUg
bWF4IG5zIG9mIGFuIGludCBvbiBhcm0gMzJiaXRzCj4gPiA+ID4KPiA+ID4gPiBDb3VsZCB5b3Ug
dHJ5IHRoZSBwYXRjaCBiZWxvdyA/Cj4gPiA+ID4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgZHJpdmVy
cy9iYXNlL3Bvd2VyL3J1bnRpbWUuYyB8IDIgKy0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYyBiL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1l
LmMKPiA+ID4gPiBpbmRleCA3MDYyNDY5Li40NGM1Yzc2IDEwMDY0NAo+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL2Jhc2UvcG93
ZXIvcnVudGltZS5jCj4gPiA+ID4gQEAgLTE0MSw3ICsxNDEsNyBAQCB1NjQgcG1fcnVudGltZV9h
dXRvc3VzcGVuZF9leHBpcmF0aW9uKHN0cnVjdCBkZXZpY2UgKmRldikKPiA+ID4gPgo+ID4gPiA+
ICAgICAgIGxhc3RfYnVzeSA9IFJFQURfT05DRShkZXYtPnBvd2VyLmxhc3RfYnVzeSk7Cj4gPiA+
ID4KPiA+ID4gPiAtICAgICBleHBpcmVzID0gbGFzdF9idXN5ICsgYXV0b3N1c3BlbmRfZGVsYXkg
KiBOU0VDX1BFUl9NU0VDOwo+ID4gPiA+ICsgICAgIGV4cGlyZXMgPSBsYXN0X2J1c3kgKyAodTY0
KShhdXRvc3VzcGVuZF9kZWxheSkgKiBOU0VDX1BFUl9NU0VDOwo+ID4gPiA+ICAgICAgIGlmIChl
eHBpcmVzIDw9IG5vdykKPiA+ID4gPiAgICAgICAgICAgICAgIGV4cGlyZXMgPSAwOyAgICAvKiBB
bHJlYWR5IGV4cGlyZWQuICovCj4gPiA+Cj4gPiA+IEhtbSwgY29tbWVudCBhYm92ZSBmdW5jdGlv
biBzdGF0ZXMgaXQgcmV0dXJucyAidGhlIGV4cGlyYXRpb24gdGltZSBpbiBqaWZmaWVzCj4gPiA+
IChhZGp1c3RlZCB0byBiZSBub256ZXJvKSIsIHNvIHRoZXJlJ3MgcHJvYmFibHkgbW9yZSB0byBm
aXguLi4KPiA+Cj4gPiBUaGUgY29tbWVudCBpcyB3cm9uZyBhbmQgc2hvdWxkIGJlIHVwZGF0ZWQg
YXMgY29tbWl0IDgyMzRmNjczNGM1ZCBoYXMKPiA+IG1vdmVkIG9uIGhydGltZXIgYW5kIGV4cGly
ZXMgaXMgbm93IGluIHJhdyBucyB1bml0Cj4KPiBZdXAuIFdobydsbCBzZW5kIGEgcGF0Y2g/IElz
IGl0IHdvcnRoIG9wdGltaXppbmcgYXMgYmVsbG93PyBJJ20gZmluZSB3aXRoIGRvaW5nCgpZb3Ug
Y2FuIHNlbmQgYSBwYXRjaCBmb3IgdXBkYXRpbmcgdGhlIGNvbW1lbnQuCgo+IGJvdGguCgpSZWdh
cmRpbmcgcHJvcG9zYWwgYmVsb3c6Ci0gcG1fcnVudGltZV9hdXRvc3VzcGVuZF9leHBpcmF0aW9u
KCkgcmV0dXJucyB1NjQgYW5kIG5vdCBrdGltZV90Ci0gdXNlIGhlbHBlciBrdGltZV9iZWZvcmUv
YWZ0ZXIgdG8gY29tcGFyZSBrdGltZV90IHZhbHVlCgpVc2luZyBrdGltZSBoZWxwZXIgZnVuY3Rp
b24gbWFrZXMgdGhlIGNvZGUgbGVzcyByZWFkYWJsZSBhbmQgdGhlCnByb3Bvc2FsIG1ha2UgdGhl
IGZ1bmN0aW9uIG1vcmUgZGlmZmljdWx0IHRvIHJlYWQgSU1ITyB3aGVuIHlvdQpjb21wYXJlCiAg
ZXhwaXJlcyA9IGxhc3RfYnVzeSArIGF1dG9zdXNwZW5kX2RlbGF5ICogTlNFQ19QRVJfTVNFQzsK
d2l0aAogIGV4cGlyZXMgPSBrdGltZV9hZGRfbnMobXNfdG9fa3RpbWUoYXV0b3N1c3BlbmRfZGVs
YXkpLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSRUFEX09OQ0UoZGV2LT5wb3dlci5s
YXN0X2J1c3kpKTsKb3Igd2hlbiB5b3UgY29tcGFyZQogaWYgKGV4cGlyZXMgPD0gbm93KQp3aXRo
CiBpZiAoa3RpbWVfYWZ0ZXIobm93LCBleHBpcmVzKSkKCkFuZCAgSSdtIG5vdCBzdXJlIHRoYXQg
dGhpcyB3aWxsIG9wdGltaXplIHRoZSBjb2RlIGF0IHRoZSBlbmQKCk9ubHkgdGhlIHJlcGxhY2Vt
ZW50IG9mIHRoZSAiZ290byBvdXQiIGJ5IHJldHVybiAwIHdvdWxkIG1ha2Ugc2Vuc2UgSU1PCgpS
ZWdhcmRzLApWaW5jZW50Cgo+Cj4gPiA+IFlvdSBjYW4gYWxzbyBjb25zaWRlciBjaGFuZ2UgbGlr
ZSB0aGlzIChzdGlsbCBkb2VzIG5vdCByZXR1cm4gamlmZmllcyk6Cj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jIGIvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRp
bWUuYwo+ID4gPiBpbmRleCA3MDYyNDY5NWI2ZDUuLmM3MmVhZjIxYTYxYyAxMDA2NDQKPiA+ID4g
LS0tIGEvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYwo+ID4gPiArKysgYi9kcml2ZXJzL2Jh
c2UvcG93ZXIvcnVudGltZS5jCj4gPiA+IEBAIC0xMjksMjMgKzEyOSwyMCBAQCBzdGF0aWMgdm9p
ZCBwbV9ydW50aW1lX2NhbmNlbF9wZW5kaW5nKHN0cnVjdCBkZXZpY2UgKmRldikKPiA+ID4gIHU2
NCBwbV9ydW50aW1lX2F1dG9zdXNwZW5kX2V4cGlyYXRpb24oc3RydWN0IGRldmljZSAqZGV2KQo+
ID4gPiAgewo+ID4gPiAgICAgICAgIGludCBhdXRvc3VzcGVuZF9kZWxheTsKPiA+ID4gLSAgICAg
ICB1NjQgbGFzdF9idXN5LCBleHBpcmVzID0gMDsKPiA+ID4gLSAgICAgICB1NjQgbm93ID0ga3Rp
bWVfdG9fbnMoa3RpbWVfZ2V0KCkpOwo+ID4gPiArICAgICAgIGt0aW1lX3QgZXhwaXJlczsKPiA+
ID4KPiA+ID4gICAgICAgICBpZiAoIWRldi0+cG93ZXIudXNlX2F1dG9zdXNwZW5kKQo+ID4gPiAt
ICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsK
PiA+ID4KPiA+ID4gICAgICAgICBhdXRvc3VzcGVuZF9kZWxheSA9IFJFQURfT05DRShkZXYtPnBv
d2VyLmF1dG9zdXNwZW5kX2RlbGF5KTsKPiA+ID4gICAgICAgICBpZiAoYXV0b3N1c3BlbmRfZGVs
YXkgPCAwKQo+ID4gPiAtICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gPiA+IC0KPiA+ID4gLSAg
ICAgICBsYXN0X2J1c3kgPSBSRUFEX09OQ0UoZGV2LT5wb3dlci5sYXN0X2J1c3kpOwo+ID4gPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiA+Cj4gPiA+IC0gICAgICAgZXhwaXJlcyA9IGxh
c3RfYnVzeSArIGF1dG9zdXNwZW5kX2RlbGF5ICogTlNFQ19QRVJfTVNFQzsKPiA+ID4gLSAgICAg
ICBpZiAoZXhwaXJlcyA8PSBub3cpCj4gPiA+IC0gICAgICAgICAgICAgICBleHBpcmVzID0gMDsg
ICAgLyogQWxyZWFkeSBleHBpcmVkLiAqLwo+ID4gPiArICAgICAgIGV4cGlyZXMgPSBrdGltZV9h
ZGRfbnMobXNfdG9fa3RpbWUoYXV0b3N1c3BlbmRfZGVsYXkpLAo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgUkVBRF9PTkNFKGRldi0+cG93ZXIubGFzdF9idXN5KSk7Cj4gPiA+
ICsgICAgICAgaWYgKGV4cGlyZXMgPD0ga3RpbWVfZ2V0KCkpCj4gPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gMDsgICAgICAgLyogQWxyZWFkeSBleHBpcmVkLiAqLwo+ID4gPgo+ID4gPiAtIG91
dDoKPiA+ID4gICAgICAgICByZXR1cm4gZXhwaXJlczsKPiA+ID4gIH0KPiA+ID4gIEVYUE9SVF9T
WU1CT0xfR1BMKHBtX3J1bnRpbWVfYXV0b3N1c3BlbmRfZXhwaXJhdGlvbik7Cj4gPiA+Cj4gPiA+
IFJlZ2FyZHMsCj4gPiA+ICAgICAgICAgbGFkaXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
