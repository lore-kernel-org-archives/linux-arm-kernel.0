Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B15C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:44:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8956821773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kiya8rLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8956821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zXe+JYgj4d2TjPfrWybA9fPQK93Ut1kenufh9gZVIYE=; b=kiya8rLOacZIF5
	pUJ1gxjrqvlvACLqcsnJRLVO80mqb3bJUZtA8Dq8VPR5++NaBospRpIuZ74RjEbNqXZKL6LCddKKY
	JhjUq2uoXKOAZeTvjlRyd8Od0T552k/IURuAf608dTnwmmm9FRQzjTXVJsbDrwrezRb4IcmsJfNVK
	RdWZA3afKdPzOTvve0VGTBcGzgFpcqPMeJ66zz0Mkw76qpQ2DZMTh6SqEHSCAuHPGsfOkJ9ukr1ts
	i6DtGHZYZIEFzGwc6g0UWikAwCH6lF8zlORtJqULpS6eguPcgwnKsOBCNoe6H/lpjZah3TqEIE4jL
	xwieOMy7RsTf62JI83zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghAP7-0003pB-Ng; Wed, 09 Jan 2019 09:44:05 +0000
Received: from mail-oi1-f175.google.com ([209.85.167.175])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghAP5-0003oq-3o
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 09:44:04 +0000
Received: by mail-oi1-f175.google.com with SMTP id y23so5805602oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 01:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zbwo1Voy/TDZYXcAJfit3k7umA8oVRutjv4ekO+a860=;
 b=QD6bbWxbi8wAXQCukhcKTjI7ubDRWVucMAROm/hF8rOEykMA7qA/hNqe8JePOAWAun
 yvh14kAJuMbeKBFVzvWeb0dK5OgRl0IAtqAn7SRyzCfg3CQKprfDmZ6KhJ73Ch9GZe6/
 dtCPxPtA+oxua8VDSQ7Q6e8Xp0gw734whexeJBPNSjTM16iz1eirp3RdE5M6aDnk1lqb
 RkVmocAGnvfCiTCxG5eEQF4BDlbbd5UoNxG4G9EOM6gp+SchtmbMxUZMZD85FG0gBbzN
 eq+Bhp5HiEbD/VyN1mahzZ/I17b+rPY11xQIw+bWef8gACbKoTegd/uaXefoMv3S4Jlk
 UsEQ==
X-Gm-Message-State: AJcUukeyDqMKCRjO7q9nk8+mw22NJI9ALHKVwE98XkKAaqKDJpkwgwQq
 DtjbcemH1FY46Nki/+G5Uk/+77Qpcdut/tbFCYk=
X-Google-Smtp-Source: ALg8bN5iY6Da81NiaUUra/cTcpi6K1GVqj8em5N44VvknmK3B+7hw3x146V55h/6hSGuiETNgZobZv9VRNVuS9wjBOI=
X-Received: by 2002:aca:195:: with SMTP id 143mr3247104oib.322.1547027042043; 
 Wed, 09 Jan 2019 01:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com>
In-Reply-To: <20190109015124.GO5544@atomide.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jan 2019 10:43:51 +0100
Message-ID: <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Tony Lindgren <tony@atomide.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_014403_152193_FFC325F6 
X-CRM114-Status: UNSURE (   9.97  )
X-CRM114-Notice: Please train this message.
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
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBKYW4gOSwgMjAxOSBhdCAyOjUxIEFNIFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlk
ZS5jb20+IHdyb3RlOgo+Cj4gKiBWaW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5h
cm8ub3JnPiBbMTkwMTA5IDAxOjQyXToKPiA+IExlIFR1ZXNkYXkgMDggSmFuIDIwMTkgw6AgMTM6
Mzc6NDMgKC0wODAwKSwgVG9ueSBMaW5kZ3JlbiBhIMOpY3JpdCA6Cj4gPiA+IExvd2VyaW5nIHRo
ZSBhdXRvc3VzcGVuZF9kZWxheV9tcyB0byAyMTAwIG1zIG1ha2VzIHRoaW5ncyB3b3JrIGFnYWlu
Lgo+ID4gPiBBbnl0aGluZyBoaWdoZXIgdGhhbiAyMjAwIG1zIHNlZW1zIHRvIHNvbWVob3cgdGlt
ZSBvdXQgaW1tZWRpYXRlbHkKPiA+ID4gbm93IDopCj4gPgo+ID4gVGhpcyBpcyBxdWl0ZSBjbG9z
ZSB0byB0aGUgbWF4IG5zIG9mIGFuIGludCBvbiBhcm0gMzJiaXRzCj4gPgo+ID4gQ291bGQgeW91
IHRyeSB0aGUgcGF0Y2ggYmVsb3cgPwo+Cj4gWXVwIGdyZWF0IHRoYW5rcywgdGhhdCdzIGl0Ogo+
Cj4gVGVzdGVkLWJ5OiBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPgoKQ29vbC4gIFRo
YW5rcyBmb3IgZ2V0dGluZyB0byB0aGUgYm90dG9tIG9mIHRoaXMhCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
