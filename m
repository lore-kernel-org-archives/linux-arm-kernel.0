Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061EFC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:36:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8E520850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jIgsc/kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8E520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VvwUE6/kY0w0q6wm6Y1SKuF1GL4v5NczJZ9eCzfJ460=; b=jIgsc/kzJP82tP
	vE89E+SVpWp60E1S1nTGEKnaXynavcpi48HHmADDlRuRnnkLAr9LMOtYe8BW9/x8D2+pDspS3si80
	KDyeeprvd4RtxQTU44ESNrXf2R4nTW3pFwsDFBO7uL0ZjT1u4WdlHmzyED+P2fGEREvxMGD8umsSd
	f5OWukwlE+HonuY9J7OCW/SZh/SVTwWpRLPoOxpANLFbS+eur8dU6P5hqUzSW7ApNm0MyGsuPaB3C
	ODc/03oyWSeILXxUE0Lgq5xT1nyVZ6pdHBIzPKAZQ4xK/QX8elUDbiBX5Uliv4WRDx5gv6MZW+Lrg
	mGZrAzrmszspXhTFudYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnSZ-00087B-Dy; Mon, 03 Dec 2018 12:36:23 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnSQ-0007qT-FQ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:36:17 +0000
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so11199090lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=e2ZZboa0/S/88d4dippsMLvu2YeLmEySoB3OrVg1YKY=;
 b=HmXO5nkquajjNhyxr7A6acJdon6XPG4JtTkiIFzCWCzeJa8BevF7bcjPWD4YM1aFyb
 yhUdgIyuHZcDqZ/3pkT1IejbAjl31hP5HT74kUHQTsEazt46h7tPuO8Dy+RQY2RS+Uyf
 jPj6DKxkpiK1MQnMM3l+ovBHVQvUDmjbVhKKyzMxQHBOqekWbwKJYqGE15Em6EVXhPtD
 gRMaHo3lwPEa6/UJ2PFBT+05+N19swFYt+lQGSFz6yTL3DUL1C6XVJFIlG+CPD5Y99qJ
 ZaK4BruaEAnrzTfBFw1XBqRUUN0AGEeLOl0PcGMM732gM5881k7xwWVVcqy2qda2D3kg
 5Yhw==
X-Gm-Message-State: AA+aEWaxciC1YWGujOuRuMav6nkg/G5tgxn4O80W5ajg/LTUxPtdWmY1
 gH2l5fA+0jTavJRVN5WKF1c=
X-Google-Smtp-Source: AFSGD/WKno3TzxpUH7ftPXIf+DzVWej+ReIKPP9GyBzEhXJ/k3E7jhAK8oueeTkplgNWzkYjFRh8jg==
X-Received: by 2002:a2e:5dd9:: with SMTP id
 v86-v6mr10566492lje.86.1543840561860; 
 Mon, 03 Dec 2018 04:36:01 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id 4-v6sm2417282ljw.84.2018.12.03.04.36.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:36:01 -0800 (PST)
Date: Mon, 3 Dec 2018 14:35:58 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 0/9] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <20181203123558.GD15388@localhost.localdomain>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <20181203121951.GP26661@dell>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203121951.GP26661@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_043614_657095_BECF6BE0 
X-CRM114-Status: GOOD (  12.75  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 mazziesaccount@gmail.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, andrew.smirnov@gmail.com, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CkhpIGRlIEhvIExlZSwKCk9uIE1vbiwgRGVjIDAzLCAyMDE4IGF0IDEyOjE5OjUxUE0gKzAwMDAs
IExlZSBKb25lcyB3cm90ZToKPiA+IFNlcmllcyBhZGQgYmQ3MTgzNy9iZDcxODM3IFBNSUMgY2xv
Y2sgc3VwcG9ydCArIG1hbmFnZWQgaW50ZXJmYWNlcwo+IAo+IFlvdSd2ZSBzZW5kIG1lIGEgY292
ZXIgbGV0dGVyIGFuZCBubyBwYXRjaGVzLgpJIGFtIGFmcmFpZCB0aGUgcGF0Y2hlcyBtYXkgYmUg
c3RpbGwgb24gdGhlaXIgd2F5Li4uIEkgYWRkZWQgcmVjaXBpZW50cwp0byBnaXQgZm9ybWF0LXBh
dGNoIHZpYSBjb21tYW5kLWxpbmUgc28geW91IGFyZSBwcm9iYWJseSBpbmNsdWRlZCBhbHNvCmlu
IHBhdGNoIG1haWxzIDooCgo+IAo+IEkgc3VnZ2VzdCB0aGF0IEkgc2hvdWxkIG5vdCBiZSBvbiB0
aGUgYWRkcmVzc2VlIGxpc3QgYXQgYWxsIGZvciB0aGlzLgoKSSdtIHRlcnJpYmx5IHNvcnJ5IGZv
ciBzcGFtbWluZyEgSSBtdXN0J3ZlIGRvbmUgc29tZSBtaXN0YWtlIHdpdGggdGhlCmdldF9tYWlu
dGFpbmVyLnBsIGFzIEkgY29waWVkIHRoZSByZWNpcGllbnRzIGZyb20gdGhhdCBvdXRwdXQuIEkg
bWF5CmhhdmUgYWNjaWRlbnRhbGx5IGluY2x1ZGVkIHNvbWUgb2xkIHBhdGNoIHRvIG1haW50YWlu
ZXIgcXVlcnkuCgo+IAo+IC0tIAo+IExlZSBKb25lcyBb5p2O55C85pavXQo+IExpbmFybyBTZXJ2
aWNlcyBUZWNobmljYWwgTGVhZAo+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJl
IGZvciBBUk0gU29Dcwo+IEZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cK
Ci0tIApNYXR0aSBWYWl0dGluZW4KUk9ITSBTZW1pY29uZHVjdG9ycwoKfn5+ICJJIGRvbid0IHRo
aW5rIHNvLCIgc2FpZCBSZW5lIERlc2NhcnRlcy4gIEp1c3QgdGhlbiwgaGUgdmFuaXNoZWQgfn5+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
