Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD346C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:08:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2095218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tqGd+MeP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCo4l0uN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2095218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZQwH8qrP768qNHI4TBENctzZciISV88cQGAply3OMjA=; b=tqGd+MePXROD0G
	xSaVtu/jklgaOz8nljaPh9YPztaNlZwycrEuznfHZuMj2b9nNx2SOzVoaD8buRRREFxKxpDZsUuG+
	SLpyq2MUD4FHQK7TjilNwK3BbxE0Va8XKjJYSjsA/Kn5Uon3yv6ISkIrLJj+h05SoYS6hWi5ZxHSN
	8SaHDstAJRByXOEZ1drqdZ2kds+TwQ4uwmKBADOtEdmne1G968Kl5lf4Y9v6NUa/IhxeJL/OaYTd8
	ht+utOF2zGy1/K8r9Ting+9nwMqRm+tbTkRJpfYJVm45YPzTDs6LnZzLTCWQC3AzO8Habab7e11J/
	kEdbPUCBJwOvuKooaxEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpdEy-0003P0-AT; Fri, 01 Feb 2019 18:08:36 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpdEv-0003Oh-1W
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 18:08:34 +0000
Received: by mail-lj1-x244.google.com with SMTP id s5-v6so6524079ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 10:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X66VDD5j3wVMeVwL1gCe9s2UIzfODti4ltV24Ti6j84=;
 b=cCo4l0uNXwx0nEvPT5/u8epEzgK+aB/tM5PfZqq/I57qtOuEp2E+8xkTwAYG9LVnE8
 ZTw1Mvq2nIk8CKa1RigFZB6DeLe5qjGV/HHPmdFHJ7OlV1jovt49AkDhkaKHs5gSyTU4
 l9vxpjIxGP/wIkLixvMEYqpWVazjGeKZTP8qVn1NQEw/gRp6mciN2Ki0JT/9RAZ3bzu+
 3zg+3U0vhS87uik1rgtG6vcezYriCU7C0wD3MAWsW7MiPpJhyMKEAFpa5Gk7legGBhyH
 OBQHV8OkBlSOwuCyQfaj+dPS00GbbsZzxtvb6pjACSDk4mTy4rgHAN9I0xVWXsAxMKCx
 8KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X66VDD5j3wVMeVwL1gCe9s2UIzfODti4ltV24Ti6j84=;
 b=qsLUqsLR1HKVsyDD7x8h/YgqnDSFgFXgK/3z0m/+t96FNLOEuJ1ScNU9szObr3eym9
 2mvNdTGk+lMO0VwRlnIU0Ym1ZBkydZypk6tMTkDH3JEd8J/U+J9C7KltapFpKQDZkLfC
 waEJOlLYE9IfaqvDft4MaCl94XSuc2T8KPkALs+1n8HYNFCyDob9fCQMD5ZEhHT1n/ud
 NGaKDdaG/3d+dZunHSByfxApPc5oT/E6yUiBBcF4VXdAI0ruIqGRhTch95Uda9EjOnur
 3fUWpC0suJ7v8+AQkYAAR7c7VbG3TOlYbXVa17iZWv9NoPqzczuSCiUxdbmpX8hQNQCx
 FHTQ==
X-Gm-Message-State: AHQUAuYWcKeMICjElQRjlmGYFfj8zTi32FVblhAJrLVpqR/XVlyb6/gu
 IXl6hNkOcPLdZirZ801YwDo=
X-Google-Smtp-Source: AHgI3IaeU5pXv8FhbtlZYopQ8Y04gFrfrJGe6iYcDr7ly+EyjqlXX7o9Wax64/3QYVX+ajbXMcEuQw==
X-Received: by 2002:a2e:8446:: with SMTP id
 u6-v6mr20418295ljh.74.1549044510925; 
 Fri, 01 Feb 2019 10:08:30 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id u30sm1632637lfc.90.2019.02.01.10.08.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 10:08:30 -0800 (PST)
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To: Joseph Lo <josephl@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <9370a0e4-2c76-6e9e-9219-121f92cdb14a@gmail.com>
 <46a1a62f-29b1-caac-ba68-e1394a76b3af@gmail.com>
 <85988378-0c88-6b71-00df-0700a7b4cdf7@nvidia.com>
 <4c89fd38-eacd-4643-52d3-da4760ecb4c5@nvidia.com>
 <57549882-4d0a-64ac-da04-7e790ac2d80e@gmail.com>
 <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <705a0eff-cb1e-0e7d-add7-fb1a993291dc@gmail.com>
Date: Fri, 1 Feb 2019 21:08:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_100833_110832_D210BCCE 
X-CRM114-Status: GOOD (  17.44  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MDEuMDIuMjAxOSAxODozNywgSm9zZXBoIExvINC/0LjRiNC10YI6Cj4gT24gMi8xLzE5IDExOjEz
IFBNLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+IDAxLjAyLjIwMTkgMTc6MTMsIEpvc2VwaCBM
byDQv9C40YjQtdGCOgo+Pj4gT24gMi8xLzE5IDk6NTQgUE0sIEpvbiBIdW50ZXIgd3JvdGU6Cj4+
Pj4KPj4+PiBPbiAwMS8wMi8yMDE5IDEzOjExLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+Pj4+
IDAxLjAyLjIwMTkgMTY6MDYsIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+Pj4+Pj4gMDEu
MDIuMjAxOSA2OjM2LCBKb3NlcGggTG8g0L/QuNGI0LXRgjoKPj4+Pj4+PiBBZGQgc3VwcG9ydCBm
b3IgdGhlIFRlZ3JhMjEwIHRpbWVyIHRoYXQgcnVucyBhdCBvc2NpbGxhdG9yIGNsb2NrCj4+Pj4+
Pj4gKFRNUjEwLVRNUjEzKS4gV2UgbmVlZCB0aGVzZSB0aW1lcnMgdG8gd29yayBhcyBjbG9jayBl
dmVudCBkZXZpY2UgYW5kIHRvCj4+Pj4+Pj4gcmVwbGFjZSB0aGUgQVJNdjggYXJjaGl0ZWN0ZWQg
dGltZXIgZHVlIHRvIGl0IGNhbid0IHN1cnZpdmUgYWNyb3NzIHRoZQo+Pj4+Pj4+IHBvd2VyIGN5
Y2xlIG9mIHRoZSBDUFUgY29yZSBvciBDUFVQT1JFU0VUIHNpZ25hbC4gU28gaXQgY2FuJ3QgYmUg
YSB3YWtlLXVwCj4+Pj4+Pj4gc291cmNlIHdoZW4gQ1BVIHN1c3BlbmRzIGluIHBvd2VyIGRvd24g
c3RhdGUuCj4+Pj4+Pj4KPj4+Pj4+PiBBbHNvIGNvbnZlcnQgdGhlIG9yaWdpbmFsIGRyaXZlciB0
byB1c2UgdGltZXItb2YgQVBJLgo+Pj4+Pj4+Cj4+Pj4+Pj4gQ2M6IERhbmllbCBMZXpjYW5vIDxk
YW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgo+Pj4+Pj4+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4KPj4+Pj4+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zwo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBMbyA8am9zZXBobEBudmlkaWEuY29tPgo+
Pj4+Pj4+IEFja2VkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+Pj4+
Pj4+IC0tLQo+IHNuaXAuCj4+Pj4+Pj4gK30KPj4+Pj4+PiArVElNRVJfT0ZfREVDTEFSRSh0ZWdy
YTIxMF90aW1lciwgIm52aWRpYSx0ZWdyYTIxMC10aW1lciIsIHRlZ3JhMjEwX3RpbWVyX2luaXQp
Owo+Pj4+Pj4+ICsjZWxzZSAvKiBDT05GSUdfQVJNICovCj4+Pj4+Pj4gK3N0YXRpYyBpbnQgX19p
bml0IHRlZ3JhMjBfaW5pdF90aW1lcihzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQo+Pj4+Pj4+ICt7
Cj4+Pj4+PiBXaGF0IGFib3V0IFQxMzI/IElzbid0IGl0IEFSTTY0IHdoaWNoIHVzZXMgdGVncmEy
MC10aW1lciBJUD8gQXQgbGVhc3QgVDEzMiBEVCBzdWdnZXN0cyBzbyBhbmQgc2VlbXMgdGhpcyBj
aGFuZ2Ugd2lsbCBicmVhayBpdC4KPj4+Pj4+Cj4+Pj4+PiBbc25pcF0KPj4+Pj4+Cj4+Pj4+Cj4+
Pj4+IEFoLCBub3RpY2VkIHRoZSAiZGVwZW5kcyBvbiBBUk0iIGluIEtjb25maWcuLiBTZWVtcyBv
a2F5IHRoZW4uCj4+Pj4+Cj4+Pj4KPj4+Pgo+Pj4+IFRoaXMgaXMgYSBnb29kIHBvaW50LCBiZWNh
dXNlIGV2ZW4gdGhvdWdoIHdlIGhhZCAnZGVwZW5kcyBvbiBBUk0nLCB0aGlzCj4+Pj4gc3RpbGwg
bWVhbnMgdGhhdCB0aGUgVGVncmExMzIgRFQgaXMgaW5jb3JyZWN0Lgo+Pj4+Cj4+Pj4gSm9zZXBo
LCBjYW4geW91IHRha2UgYSBxdWljayBsb29rIGF0IFRlZ3JhMTMyPwo+Pj4KPj4+IEhpIEpvbiBh
bmQgRG1pdHJ5LAo+Pj4KPj4+IE5vIHdvcnJ5IGFib3V0IFQxMzIsIFQxMzIgdXNlcyBhcmNoIHRp
bWVyICh2NykuIFRoZSB0ZWdyYTIwIHRpbWVyIGRyaXZlciBoYXMgbmV2ZXIgYmVlbiB1c2VkLiBX
ZSBzaG91bGQgZml4IHRoZSBkdHNpIGZpbGUgbGF0ZXIuCj4+Cj4+IEhpIEpvc2VwaCwKPj4KPj4g
U28gaXMgVDEzMiBIVyBhY3R1YWxseSBpbmNvbXBhdGlibGUgd2l0aCB0aGUgdGVncmEyMC10aW1l
cj8gSWYgaXQncyBjb21wYXRpYmxlLCB0aGVuIEkgdGhpbmsgdGhlIGRyaXZlcidzIGNvZGUgc2hv
dWxkIGJlIG1hZGUgbW9yZSB1bml2ZXJzYWwgdG8gc3VwcG9ydCBUMTMyLgo+Pgo+IAo+IEZyb20g
SFcgcG9pbnQgb2YgdmlldywgdGhlIFRJTUVSMSB+IFRJTUVSNCBpcyBjb21wYXRpYmxlIHdpdGgg
Im52aWRpYSx0ZWdyYTIwLXRpbWVyIi4gQnV0IFRlZ3JhMTMyIGFjdHVhbGx5IGhhcyAxMCB0aW1l
cnMgd2hpY2ggYXJlIGV4YWN0bHkgdGhlIHNhbWUgYXMgVGVncmEzMC4gU28gaXQgc2hvdWxkIGJh
Y2t3YXJkIGNvbXBhdGlibGUgd2l0aCAibnZpZGlhLHRlZ3JhMzAtdGltZXIiLCB3aGljaCBpcyB0
ZWdyYV93ZHQgZHJpdmVyIG5vdy4gQW5kIFRlZ3JhMTMyIHNob3VsZCBuZXZlciB1c2UgdGhpcyBk
cml2ZXIuCj4gCj4gVGhlIFRlZ3JhIHRpbWVyIGRyaXZlciBzaG91bGQgb25seSBiZSB1c2VkIG9u
IFRlZ3JhMjAvMzAvMjEwLCB0aHJlZSBwbGF0Zm9ybXMgb25seS4gT3RoZXJzIHVzZSBhcmNoIHRp
bWVyIGRyaXZlciBmb3Igc3lzdGVtIHRpbWVyIGRyaXZlci4KPiAKPiBTbyB3ZSBkb24ndCByZWFs
bHkgbmVlZCB0byB0YWtlIGNhcmUgdGhlIHVzYWdlIG9uIG90aGVyIFRlZ3JhIHBsYXRmb3Jtcy4K
CkRvZXNuJ3QgTGludXgga2VybmVsIHB1dCBpbiB1c2UgYWxsIG9mIGF2YWlsYWJsZSB0aW1lcnM/
IElmIHllcywgdGhlbiB3ZSBwcm9iYWJseSB3b3VsZCB3YW50IHRvIGV4cG9zZSBhbGwgYXZhaWxh
YmxlIHRpbWVycy4gSXQgbG9va3MgdG8gbWUgdGhhdCByaWdodCBub3cgdGVncmEyMC10aW1lciBl
eHBvc2VzIG9ubHkgYSBzaW5nbGUtc2hhcmVkIHRpbWVyIHRvIHRoZSBzeXN0ZW0gW3BsZWFzZSBj
b3JyZWN0IG1lIGlmIEknbSB3cm9uZ10uIFdvdWxkbid0IG1ha2Ugc2Vuc2UgYXQgbGVhc3QgdG8g
Z2l2ZSBhIHRpbWVyIHBlciBDUFUgY29yZT8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
