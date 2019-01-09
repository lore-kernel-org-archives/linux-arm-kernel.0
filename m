Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943E2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:56:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9CD206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I5r4lF/S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+3x8aGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9CD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6w+2sEZp0HU86Dv8uZlmzvlwOT5La7nIbTnwIOt4yVA=; b=I5r4lF/S5iFqoe
	FvDcncr1gVzDcX3Zf9LwMtjam0E5vV+wvoJCX+/weQcXFpO1D/Ax4qo8hLNiVERCCUhw/4xtNYvdG
	G/+zpRyMYeJxMyuzGxhcpXH1Vb182IRyJFRXt000lnzfkElL1ccewJhAqAqZIWp/09Q7bdrjTB/pB
	k4gsdzgO3edWpU3ggzfAuYqbJWgWSoazT5PSDHhYbVAs0jIRz2xCm5a1xp2l7msKEC1XAJpNPH++s
	GLF+PMcN/sgM6pWw6VheB57lSSFHyyBbXUcs5HSBWFUu3n93HUgorFlY/XlonzZBMoyQ9WruglmCp
	iIqaPHv0RoFShBXgZC2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghH97-0005wr-SK; Wed, 09 Jan 2019 16:56:01 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghH94-0005wO-Ln
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 16:56:00 +0000
Received: by mail-io1-xd43.google.com with SMTP id l14so6553986ioj.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kki7GX0S+t7hj/hdc6mJj5VtGMKtQZTAwoWP5KR8oJA=;
 b=Q+3x8aGDd/+bdRQp6N+2ZpUI327wJoexTa/6+Tyqu20NnYA2zzh8tCkcaO1tkFHKnA
 jjLaNk/rS/r2luVOoDyyGqM/ujcSa3DbAgotT3KDq99s784yRD8jrMB5+48pj9RmkFwS
 313Ft4ncFR0AyqIIXs4fx2bP7U2xt8BaK5IcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kki7GX0S+t7hj/hdc6mJj5VtGMKtQZTAwoWP5KR8oJA=;
 b=pK2nYOJ7amS2ndAYwBcWY6o+BLsfdu1/lpJym4u+s+eN81y+UDtIid8+Rs7354qYp0
 K+EFMeanSigrkqrQrydd3cMkbRrtdKYyIkUiQCNK2IMbHqoqE571rj9HYDb2EVIgDbrV
 N2fheTDr+WkCRmHGP0ebWO0LgW6wqydOS7YGfrT5tZy/10Lfry7h7/eYvSt97CL5nD46
 JTOldc7DkgNEZ3U1cwWvSi086EsVzk9FcuFmJuHKYDrfIUYW5AZ/6WQQdPhO5DJIkmPy
 +TjpEXFitjp70sVVk8H46GQ0WKivV/a69ZdMTZoACe9iOuBWLcZWQR2kA9y9rMbHp2em
 DPdQ==
X-Gm-Message-State: AJcUukdlGoK9edMkcmm3Dhh4PMLzGvL9KEwzvrM1PDSnycEN9BHKprH+
 8NgVlZWaHU4+6p5STecyEsSOOFMTnlYMd8xFm2q4KQ==
X-Google-Smtp-Source: ALg8bN61k2I49EIfEaI7zbl2JZ1N1JnLQc4jMeV2GRJPyIicfNIkneVXL61psqRGnawj9on/bi2MeTTm70cokk+5RzM=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr4101980iof.183.1547052957562; 
 Wed, 09 Jan 2019 08:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com>
 <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
 <20190109162846.GP5544@atomide.com>
 <CAKfTPtBzE9fqDgUOJ4uTj_Dtfe2KCp+R4FajAaQqpV02upQZJA@mail.gmail.com>
 <20190109165004.GQ5544@atomide.com>
In-Reply-To: <20190109165004.GQ5544@atomide.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 9 Jan 2019 17:55:46 +0100
Message-ID: <CAKfTPtD4ZnRDKF6wG_AdX-5+R0cW0=uwj9Ww6y7O0xocuL+bkQ@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_085558_710430_157DFCF6 
X-CRM114-Status: GOOD (  16.43  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ladislav Michl <ladis@linux-mips.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCA5IEphbiAyMDE5IGF0IDE3OjUwLCBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUu
Y29tPiB3cm90ZToKPgo+ICogVmluY2VudCBHdWl0dG90IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJv
Lm9yZz4gWzE5MDEwOSAxNjo0OF06Cj4gPiBPbiBXZWQsIDkgSmFuIDIwMTkgYXQgMTc6MjgsIFRv
bnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiAqIFJhZmFl
bCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4gWzE5MDEwOSAwOTo0NF06Cj4gPiA+ID4g
T24gV2VkLCBKYW4gOSwgMjAxOSBhdCAyOjUxIEFNIFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlk
ZS5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+ICogVmluY2VudCBHdWl0dG90IDx2aW5j
ZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4gWzE5MDEwOSAwMTo0Ml06Cj4gPiA+ID4gPiA+IExlIFR1
ZXNkYXkgMDggSmFuIDIwMTkgw6AgMTM6Mzc6NDMgKC0wODAwKSwgVG9ueSBMaW5kZ3JlbiBhIMOp
Y3JpdCA6Cj4gPiA+ID4gPiA+ID4gTG93ZXJpbmcgdGhlIGF1dG9zdXNwZW5kX2RlbGF5X21zIHRv
IDIxMDAgbXMgbWFrZXMgdGhpbmdzIHdvcmsgYWdhaW4uCj4gPiA+ID4gPiA+ID4gQW55dGhpbmcg
aGlnaGVyIHRoYW4gMjIwMCBtcyBzZWVtcyB0byBzb21laG93IHRpbWUgb3V0IGltbWVkaWF0ZWx5
Cj4gPiA+ID4gPiA+ID4gbm93IDopCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoaXMgaXMgcXVp
dGUgY2xvc2UgdG8gdGhlIG1heCBucyBvZiBhbiBpbnQgb24gYXJtIDMyYml0cwo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBDb3VsZCB5b3UgdHJ5IHRoZSBwYXRjaCBiZWxvdyA/Cj4gPiA+ID4gPgo+
ID4gPiA+ID4gWXVwIGdyZWF0IHRoYW5rcywgdGhhdCdzIGl0Ogo+ID4gPiA+ID4KPiA+ID4gPiA+
IFRlc3RlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4KPiA+ID4gPgo+ID4g
PiA+IENvb2wuICBUaGFua3MgZm9yIGdldHRpbmcgdG8gdGhlIGJvdHRvbSBvZiB0aGlzIQo+ID4g
Pgo+ID4gPiBObyBwcm9ibGVtLgo+ID4gPgo+ID4gPiBPbmUgbW9yZSB0aGluZyBJIG5vdGljZWQ6
IFRoZSAyNSUgc2xhY2sgY2FuIGdldCBub3RpY2VhYmxlCj4gPiA+IGZvciBsYXJnZXIgdmFsdWVz
LiBGb3IgdGhpbmdzIGxpa2UgYSAzIHNlY29uZCB1YXJ0IGNvbnNvbGUKPiA+ID4gdGltZW91dCBz
bGFjayBvZiA3NTAgbXMgaXMgcXVpdGUgbGFyZ2UgdmFyaWF0aW9uLgo+ID4gPgo+ID4gPiBTaG91
bGQgd2UgaGF2ZSBhIGxpbWl0IG9mIG1heCAxMDAgbXMgZm9yIHRoZSBzbGFjaz8KPiA+Cj4gPiBL
ZWVwIGluIG1pbmQgdGhhdCB3aGVuIGppZmZpZXMgd2VyZSB1c2VkLCBleHBpcmVzIHdhcyByb3Vu
ZGVkIHRvIGEKPiA+IGZ1bGwgc2Vjb25kIHdoZW4gZGVsYXkgd2FzIGdyZWF0ZXIgdGhhbiBhIHNl
Y29uZC4gU28geW91IGNvdWxkIGFscmVhZHkKPiA+IGhhdmUgZGlmZmVyZW5jZSBvZiB1cCA5OTBt
cyBvbiBhcm0gYmVmb3JlIHRoaXMgcGF0Y2gKPiA+IEFuZCBpIGRvbid0IHRha2UgaW50byBhY2Nv
dW50IHRoZSByZXdvcmsgb2YgdGltZXIgaW5mcmEgd2hpY2ggYWRkCj4gPiBhbm90aGVyIGxldmVs
IG9mIHZhcmlhdGlvbiwgc29tZXRoaW5nIGxpa2UgdXAgdG8gNjQwIG1zIG1vcmUgd2hlbiB0aGUK
PiA+IHRpbWVyIGlzIGdyZWF0ZXIgdGhhbiAyODgwIG1zIGZvciBhcm0gSUlSQwo+Cj4gSSB0aGlu
ayBpdCB3YXMgcm91bmRlZCB1cCBlYXJsaWVyLgo+Cj4gRG9uJ3Qgd2UgZ2V0IHJvdW5kZWQgZG93
biBub3cgYWxzbz8KCldlIHN0aWxsIHJvdW5kIHVwLiBJbiBocnRpbWVyIHdlIGhhdmUgOgp0aW1l
ci0+X3NvZnRleHBpcmVzID0gdGltZTsKdGltZXItPm5vZGUuZXhwaXJlcyA9IGt0aW1lX2FkZF9z
YWZlKHRpbWUsIGRlbHRhKTsKc28gdGhlIGhydGltZXIgd2lsbCBleHBpcmUgYmV0d2VlbiAidGlt
ZSIgYW5kICJ0aW1lK2RlbHRhIgoKPgo+IFJlZ2FyZHMsCj4KPiBUb255CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
