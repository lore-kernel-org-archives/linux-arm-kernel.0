Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:28:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB80521738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G0bxU3Oy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvEgHCGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB80521738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NE5oRdQghpovPV+vifm4fo0poIjsGwddTAkvjqCHdws=; b=G0bxU3Oy9nIb/2
	j6SkJuXbg2LW0o0ZljzzniwEhGKXmMZijE7pR4a9y8UieIMjPqeWe1+WxiYckev9+BiYzHj4TnkJ1
	hw+qCFt8B64ofA3ME/1lcAryeeeSBRxrBn0e6FZCapXMGkjjn99olyzz4abGUDRIantZYozMACW8m
	TVL/RQAQAraFkPBl57+IAEMZ7p5d5++wXrE05N3gzhLp4KhjUUZrxw56iq6m8eHuI2YYDoSDQo7Y+
	bE0MpwXLhwv1FioxLWvoTqPBmYERyclEYcg94f7mSYjujdcY1sbnQY4mRzJPUU99afzPtd3SaXJqe
	g5goHMYkCi8NvisoHLig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghC1v-0005eF-Ku; Wed, 09 Jan 2019 11:28:15 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghC1s-0005dg-Ez
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 11:28:14 +0000
Received: by mail-it1-x142.google.com with SMTP id i145so11174968ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 03:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dUWGm/4sPfFN1UJt6UEtJ/PK1+2pHD5Y0JKS7yOTNDA=;
 b=UvEgHCGUwfarWCc7/zBI+UiEkSkzynG6Vpcd0ZY5TEpy090k6LeW/wX2I/sF7fS7VX
 deN1/pJCZWssjtAQIt98U/fQR7jPsorbb9pFYBvya2qFc0ZfIPBlpDkoo5EVOpGYM3g+
 8GxtP+75TzebzPX8BtdIzr/2F0pS0Ce1/MWfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dUWGm/4sPfFN1UJt6UEtJ/PK1+2pHD5Y0JKS7yOTNDA=;
 b=ZI7/Cwe6vEPXhcGyMBn4mr1PtuTLI/lepPF2NPEY5rNr/mk0Aq3NBQh87mu7u9vqat
 r+8kkau6s33nYHyyVzdMNcMptY6+31xxg5gHMQZQPeko4V6X4S5hzirxzd7qBHSAoWEv
 2MSacYomO5jLfBMs2GcNDyiUWqnIGHCuLrfKq/avXlinz6bZblQpMBRGLIBfReD2P9Y+
 BLAEE8tiIXbE3voA/qRQw5o0yaxy5xAHpA3KUMmqe4dT13AoTM2ZEHQLmFk0/W1Qus6J
 ktQx4tbX0F9RDtUAGD+FOBjvlrpDb072o6b/OJMCul7A1DTI6Ul5bbqv0jWr6D3T2oak
 DQNQ==
X-Gm-Message-State: AJcUukdJ7EPirjDp9NkG8hABaUUrqMgEs7SqBbDIkXCdiuDE+5wotM7y
 4O7IZWN/X9G23y8IM9kmOj20Bsp+wz8yi7DeMN/Fuw==
X-Google-Smtp-Source: ALg8bN4Mo4MydjW0+YfIov1HCQrQMsgj7BYwckBh9C5va6ptuExvBqnA2b2qakUy/Cl8vEUw6eNtfKjiHQgkTt5JJcY=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr3921367itf.14.1547033289883; 
 Wed, 09 Jan 2019 03:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109111703.GA28605@lenoch>
In-Reply-To: <20190109111703.GA28605@lenoch>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 9 Jan 2019 12:27:57 +0100
Message-ID: <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Ladislav Michl <ladis@linux-mips.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_032812_505730_CA4BEE38 
X-CRM114-Status: GOOD (  25.09  )
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

T24gV2VkLCA5IEphbiAyMDE5IGF0IDEyOjE3LCBMYWRpc2xhdiBNaWNobCA8bGFkaXNAbGludXgt
bWlwcy5vcmc+IHdyb3RlOgo+Cj4gT24gV2VkLCBKYW4gMDksIDIwMTkgYXQgMDI6NDI6MThBTSAr
MDEwMCwgVmluY2VudCBHdWl0dG90IHdyb3RlOgo+ID4gTGUgVHVlc2RheSAwOCBKYW4gMjAxOSDD
oCAxMzozNzo0MyAoLTA4MDApLCBUb255IExpbmRncmVuIGEgw6ljcml0IDoKPiA+ID4gKiBWaW5j
ZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPiBbMTkwMTA4IDE2OjQyXToK
PiA+ID4gPiBPbiBUdWUsIDggSmFuIDIwMTkgYXQgMTY6NTMsIFRvbnkgTGluZGdyZW4gPHRvbnlA
YXRvbWlkZS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gSG1tIHNvIGNvdWxkIGl0IGJlIHRoYXQgd2Ug
bm93IHJlbHkgb24gdGltZXJzIHRoYXQgdGhhdCBtYXkKPiA+ID4gPiA+IG5vdCBiZSBjYXBhYmxl
IG9mIHdha2luZyB1cCB0aGUgc3lzdGVtIGZyb20gaWRsZSBzdGF0ZXMgd2l0aAo+ID4gPiA+ID4g
aHJ0aW1lcj8KPiA+ID4gPgo+ID4gPiA+IFdpdGggbm9oeiBhbmQgaHJ0aW1lciBlbmFibGVkLCAg
dGltZXIgcmVsaWVzIG9uIGhydGltZXIgdG8gZ2VuZXJhdGUKPiA+ID4gPiB0aGUgdGljayBzbyB5
b3Ugc2hvdWxkIHVzZSB0aGUgc2FtZSBpbnRlcnJ1cHQuCj4gPiA+Cj4gPiA+IE9LIHllYWggbG9v
a3MgbGlrZSB0aGF0IHBhcnQgaXMgd29ya2luZyBqdXN0IGZpbmUuCj4gPiA+Cj4gPiA+IEFkZGlu
ZyBzb21lIHByaW50a3MgYW5kIGRlYnVnZ2luZyBvdmVyIHNzaCwgbG9va3MgbGlrZQo+ID4gPiBv
bWFwODI1MF9ydW50aW1lX3Jlc3VtZSgpIGdldHMgY2FsbGVkIGp1c3QgZmluZSBiYXNlZCBvbiBh
IHdha2VpcnEsCj4gPiA+IGJ1dCB0aGVuIG9tYXA4MjUwX3J1bnRpbWVfc3VzcGVuZCgpIHJ1bnMg
aW1tZWRpYXRlbHkgaW5zdGVhZCBvZgo+ID4gPiB3YWl0aW5nIGZvciB0aGUgdGhyZWUgc2Vjb25k
IHRpbWVvdXQuCj4gPiA+Cj4gPiA+IExvd2VyaW5nIHRoZSBhdXRvc3VzcGVuZF9kZWxheV9tcyB0
byAyMTAwIG1zIG1ha2VzIHRoaW5ncyB3b3JrIGFnYWluLgo+ID4gPiBBbnl0aGluZyBoaWdoZXIg
dGhhbiAyMjAwIG1zIHNlZW1zIHRvIHNvbWVob3cgdGltZSBvdXQgaW1tZWRpYXRlbHkKPiA+ID4g
bm93IDopCj4gPgo+ID4gVGhpcyBpcyBxdWl0ZSBjbG9zZSB0byB0aGUgbWF4IG5zIG9mIGFuIGlu
dCBvbiBhcm0gMzJiaXRzCj4gPgo+ID4gQ291bGQgeW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cgPwo+
ID4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMgfCAyICstCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMgYi9kcml2ZXJzL2Jhc2UvcG93
ZXIvcnVudGltZS5jCj4gPiBpbmRleCA3MDYyNDY5Li40NGM1Yzc2IDEwMDY0NAo+ID4gLS0tIGEv
ZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYwo+ID4gKysrIGIvZHJpdmVycy9iYXNlL3Bvd2Vy
L3J1bnRpbWUuYwo+ID4gQEAgLTE0MSw3ICsxNDEsNyBAQCB1NjQgcG1fcnVudGltZV9hdXRvc3Vz
cGVuZF9leHBpcmF0aW9uKHN0cnVjdCBkZXZpY2UgKmRldikKPiA+Cj4gPiAgICAgICBsYXN0X2J1
c3kgPSBSRUFEX09OQ0UoZGV2LT5wb3dlci5sYXN0X2J1c3kpOwo+ID4KPiA+IC0gICAgIGV4cGly
ZXMgPSBsYXN0X2J1c3kgKyBhdXRvc3VzcGVuZF9kZWxheSAqIE5TRUNfUEVSX01TRUM7Cj4gPiAr
ICAgICBleHBpcmVzID0gbGFzdF9idXN5ICsgKHU2NCkoYXV0b3N1c3BlbmRfZGVsYXkpICogTlNF
Q19QRVJfTVNFQzsKPiA+ICAgICAgIGlmIChleHBpcmVzIDw9IG5vdykKPiA+ICAgICAgICAgICAg
ICAgZXhwaXJlcyA9IDA7ICAgIC8qIEFscmVhZHkgZXhwaXJlZC4gKi8KPgo+IEhtbSwgY29tbWVu
dCBhYm92ZSBmdW5jdGlvbiBzdGF0ZXMgaXQgcmV0dXJucyAidGhlIGV4cGlyYXRpb24gdGltZSBp
biBqaWZmaWVzCj4gKGFkanVzdGVkIHRvIGJlIG5vbnplcm8pIiwgc28gdGhlcmUncyBwcm9iYWJs
eSBtb3JlIHRvIGZpeC4uLgoKVGhlIGNvbW1lbnQgaXMgd3JvbmcgYW5kIHNob3VsZCBiZSB1cGRh
dGVkIGFzIGNvbW1pdCA4MjM0ZjY3MzRjNWQgaGFzCm1vdmVkIG9uIGhydGltZXIgYW5kIGV4cGly
ZXMgaXMgbm93IGluIHJhdyBucyB1bml0Cgo+Cj4gWW91IGNhbiBhbHNvIGNvbnNpZGVyIGNoYW5n
ZSBsaWtlIHRoaXMgKHN0aWxsIGRvZXMgbm90IHJldHVybiBqaWZmaWVzKToKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYyBiL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50
aW1lLmMKPiBpbmRleCA3MDYyNDY5NWI2ZDUuLmM3MmVhZjIxYTYxYyAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCj4gKysrIGIvZHJpdmVycy9iYXNlL3Bvd2VyL3J1
bnRpbWUuYwo+IEBAIC0xMjksMjMgKzEyOSwyMCBAQCBzdGF0aWMgdm9pZCBwbV9ydW50aW1lX2Nh
bmNlbF9wZW5kaW5nKHN0cnVjdCBkZXZpY2UgKmRldikKPiAgdTY0IHBtX3J1bnRpbWVfYXV0b3N1
c3BlbmRfZXhwaXJhdGlvbihzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gIHsKPiAgICAgICAgIGludCBh
dXRvc3VzcGVuZF9kZWxheTsKPiAtICAgICAgIHU2NCBsYXN0X2J1c3ksIGV4cGlyZXMgPSAwOwo+
IC0gICAgICAgdTY0IG5vdyA9IGt0aW1lX3RvX25zKGt0aW1lX2dldCgpKTsKPiArICAgICAgIGt0
aW1lX3QgZXhwaXJlczsKPgo+ICAgICAgICAgaWYgKCFkZXYtPnBvd2VyLnVzZV9hdXRvc3VzcGVu
ZCkKPiAtICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gKyAgICAgICAgICAgICAgIHJldHVybiAw
Owo+Cj4gICAgICAgICBhdXRvc3VzcGVuZF9kZWxheSA9IFJFQURfT05DRShkZXYtPnBvd2VyLmF1
dG9zdXNwZW5kX2RlbGF5KTsKPiAgICAgICAgIGlmIChhdXRvc3VzcGVuZF9kZWxheSA8IDApCj4g
LSAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+IC0KPiAtICAgICAgIGxhc3RfYnVzeSA9IFJFQURf
T05DRShkZXYtPnBvd2VyLmxhc3RfYnVzeSk7Cj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+
Cj4gLSAgICAgICBleHBpcmVzID0gbGFzdF9idXN5ICsgYXV0b3N1c3BlbmRfZGVsYXkgKiBOU0VD
X1BFUl9NU0VDOwo+IC0gICAgICAgaWYgKGV4cGlyZXMgPD0gbm93KQo+IC0gICAgICAgICAgICAg
ICBleHBpcmVzID0gMDsgICAgLyogQWxyZWFkeSBleHBpcmVkLiAqLwo+ICsgICAgICAgZXhwaXJl
cyA9IGt0aW1lX2FkZF9ucyhtc190b19rdGltZShhdXRvc3VzcGVuZF9kZWxheSksCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFJFQURfT05DRShkZXYtPnBvd2VyLmxhc3RfYnVzeSkp
Owo+ICsgICAgICAgaWYgKGV4cGlyZXMgPD0ga3RpbWVfZ2V0KCkpCj4gKyAgICAgICAgICAgICAg
IHJldHVybiAwOyAgICAgICAvKiBBbHJlYWR5IGV4cGlyZWQuICovCj4KPiAtIG91dDoKPiAgICAg
ICAgIHJldHVybiBleHBpcmVzOwo+ICB9Cj4gIEVYUE9SVF9TWU1CT0xfR1BMKHBtX3J1bnRpbWVf
YXV0b3N1c3BlbmRfZXhwaXJhdGlvbik7Cj4KPiBSZWdhcmRzLAo+ICAgICAgICAgbGFkaXMKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
