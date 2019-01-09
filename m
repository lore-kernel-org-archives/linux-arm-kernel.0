Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC5EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D0A206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tcI27/IU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFqBCiAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D0A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DVJnL2ZiKJVmOZJh6NSFPsGKyfiygpVHtXA7ZT3KZkc=; b=tcI27/IUVRusbz
	6QqpUqFoc63AHExD4VUD5EwofDE1kOqpe+YSgdeFSgCmEM+fRTCC4SkUMFPsmPC0zVSwWNi6RrFGQ
	+A3kmZNShKrX+nAltkbxlAgJ6B1I2PF1n7MM6yfaZxKBXTxmVKKkuF+Yb6xbdFRl98CRucGHIBhHH
	8mQyJXqd62ucUCn2MGYg7RGXe6bVwhXBJb7yOWugqebCoaj+JRB/1GIYxSCXlO1bmOdaPa1borJcy
	mwFbel0GSPVkdiBqxpNKrDKUXM+NCBnoa93kiV2DoohShgJCtqGRxDmH3Rx4xUtQrVZQpF8JIGA6o
	mrazzDpUJo51GLK7MNkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghH20-0001lm-2Q; Wed, 09 Jan 2019 16:48:40 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghH1x-0001lG-6Z
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 16:48:38 +0000
Received: by mail-io1-xd44.google.com with SMTP id b23so6521764ios.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 08:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fdCynCQXJR51Uq88sO1InC8ROmQ7T31Q2pMI8I3KRIY=;
 b=BFqBCiADprgxye+2BS0wxgDl9lErgr8cSN6izzYo8ORz7+eTVv76AIP+9ORHl9CJco
 2wvdQX/qWVKUwMfr5hC0oyLaXyyQQQ/P/nufVdFam6MOx9ZyMX2kHfX8g93gQ5bmdJy6
 xyrmWN4DLI7ohts8fK85H6eCs7gjl4dz6ydx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fdCynCQXJR51Uq88sO1InC8ROmQ7T31Q2pMI8I3KRIY=;
 b=iqsMfxlTpbBTW30wK0DrTvd8VVgJlWxGHd0VxiEDTbhzyrlCYqnUl0TZGeQkHbqC1S
 ffvT0IsQ+He17CpMiVUO/AEtsBNZwS4uC4cCSz9pbt6sbKJqXE979UiCD+8LSRYnqCjI
 Wwe2HzKX90yyIFVrP5TiqtJQA/d/OaA/Zb/H0TNo5N4ndwaeEZEJKJRA9Akrv2GpR8nr
 TDx6Tu7/+946mw3+ZiVBHQzSEQZOfCgtfnVGUlmzrbKfJfRtOj8gtQVjdItLxLUMScNg
 Iuky8to7prx0FzM7ULcp9GT3FUh6r/MSCs+Mc1z//NUSVtydYyB6SZ4hR0ax8ywwjBc+
 6svw==
X-Gm-Message-State: AJcUukfwyK3O+1fMFGZQuRa+wQiTt7Z63hnPCgWhurqzNLXgMRkCovRo
 ah1VSdjzoxPTONg9wKzE5GV2x+7QmFxuklZx30ULwg==
X-Google-Smtp-Source: ALg8bN46TfwF2T9uKnRpMHXxc2amErUpK307V7pvh/LihSLwY/nSB41VOSrL8lYO01v+ZQU/+Cc9DbX0Pwb4CqrjaUc=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr4084607iof.183.1547052514283; 
 Wed, 09 Jan 2019 08:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com>
 <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
 <20190109162846.GP5544@atomide.com>
In-Reply-To: <20190109162846.GP5544@atomide.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 9 Jan 2019 17:48:23 +0100
Message-ID: <CAKfTPtBzE9fqDgUOJ4uTj_Dtfe2KCp+R4FajAaQqpV02upQZJA@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_084837_242234_BCD6D4D7 
X-CRM114-Status: GOOD (  12.85  )
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

T24gV2VkLCA5IEphbiAyMDE5IGF0IDE3OjI4LCBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUu
Y29tPiB3cm90ZToKPgo+ICogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPiBb
MTkwMTA5IDA5OjQ0XToKPiA+IE9uIFdlZCwgSmFuIDksIDIwMTkgYXQgMjo1MSBBTSBUb255IExp
bmRncmVuIDx0b255QGF0b21pZGUuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gKiBWaW5jZW50IEd1
aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPiBbMTkwMTA5IDAxOjQyXToKPiA+ID4g
PiBMZSBUdWVzZGF5IDA4IEphbiAyMDE5IMOgIDEzOjM3OjQzICgtMDgwMCksIFRvbnkgTGluZGdy
ZW4gYSDDqWNyaXQgOgo+ID4gPiA+ID4gTG93ZXJpbmcgdGhlIGF1dG9zdXNwZW5kX2RlbGF5X21z
IHRvIDIxMDAgbXMgbWFrZXMgdGhpbmdzIHdvcmsgYWdhaW4uCj4gPiA+ID4gPiBBbnl0aGluZyBo
aWdoZXIgdGhhbiAyMjAwIG1zIHNlZW1zIHRvIHNvbWVob3cgdGltZSBvdXQgaW1tZWRpYXRlbHkK
PiA+ID4gPiA+IG5vdyA6KQo+ID4gPiA+Cj4gPiA+ID4gVGhpcyBpcyBxdWl0ZSBjbG9zZSB0byB0
aGUgbWF4IG5zIG9mIGFuIGludCBvbiBhcm0gMzJiaXRzCj4gPiA+ID4KPiA+ID4gPiBDb3VsZCB5
b3UgdHJ5IHRoZSBwYXRjaCBiZWxvdyA/Cj4gPiA+Cj4gPiA+IFl1cCBncmVhdCB0aGFua3MsIHRo
YXQncyBpdDoKPiA+ID4KPiA+ID4gVGVzdGVkLWJ5OiBUb255IExpbmRncmVuIDx0b255QGF0b21p
ZGUuY29tPgo+ID4KPiA+IENvb2wuICBUaGFua3MgZm9yIGdldHRpbmcgdG8gdGhlIGJvdHRvbSBv
ZiB0aGlzIQo+Cj4gTm8gcHJvYmxlbS4KPgo+IE9uZSBtb3JlIHRoaW5nIEkgbm90aWNlZDogVGhl
IDI1JSBzbGFjayBjYW4gZ2V0IG5vdGljZWFibGUKPiBmb3IgbGFyZ2VyIHZhbHVlcy4gRm9yIHRo
aW5ncyBsaWtlIGEgMyBzZWNvbmQgdWFydCBjb25zb2xlCj4gdGltZW91dCBzbGFjayBvZiA3NTAg
bXMgaXMgcXVpdGUgbGFyZ2UgdmFyaWF0aW9uLgo+Cj4gU2hvdWxkIHdlIGhhdmUgYSBsaW1pdCBv
ZiBtYXggMTAwIG1zIGZvciB0aGUgc2xhY2s/CgpLZWVwIGluIG1pbmQgdGhhdCB3aGVuIGppZmZp
ZXMgd2VyZSB1c2VkLCBleHBpcmVzIHdhcyByb3VuZGVkIHRvIGEKZnVsbCBzZWNvbmQgd2hlbiBk
ZWxheSB3YXMgZ3JlYXRlciB0aGFuIGEgc2Vjb25kLiBTbyB5b3UgY291bGQgYWxyZWFkeQpoYXZl
IGRpZmZlcmVuY2Ugb2YgdXAgOTkwbXMgb24gYXJtIGJlZm9yZSB0aGlzIHBhdGNoCkFuZCBpIGRv
bid0IHRha2UgaW50byBhY2NvdW50IHRoZSByZXdvcmsgb2YgdGltZXIgaW5mcmEgd2hpY2ggYWRk
CmFub3RoZXIgbGV2ZWwgb2YgdmFyaWF0aW9uLCBzb21ldGhpbmcgbGlrZSB1cCB0byA2NDAgbXMg
bW9yZSB3aGVuIHRoZQp0aW1lciBpcyBncmVhdGVyIHRoYW4gMjg4MCBtcyBmb3IgYXJtIElJUkMK
Pgo+IFJlZ2FyZHMsCj4KPiBUb255CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
