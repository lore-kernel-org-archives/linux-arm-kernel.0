Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33078C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:30:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EE720869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EK340V35";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+zGZ/p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EE720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hY2nRtkeG/ZNdklMDwfY4vWPq/k2cwdAdytFwFTUU44=; b=EK340V35cUHHY6
	6ZSYs1s9fhuC0yNaDI7fLhxTiW76YdxSZrTqLHp0bfTUWM8n4eWvxGpLvXGePH4fuO14FL8OJjpIQ
	pLgp51STyy3XJ7l4qjjA916PykYJOiG8/IKC+3piu9Rdld7hAGEO75skuaEL7yQ3LoWzxF+e22bFi
	lBlG5BWb8dMFanzGpD3TWhCNyp1XWypNszlex/eQYP6GupfAulPnp49+J/cLHb06grcg3RpTEjBf5
	RTBGGApVBFQKx9SmVP2M2J4cxppXxVeAvd1gDwM3iCW7WmTRpds4j3Gt5EczRrP2T7aclDSUUKSW5
	MUQaLkZF8QhnjF16O8Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpvNk-0008Ic-WE; Sat, 02 Feb 2019 13:30:53 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpvNh-0008IF-J3
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 13:30:51 +0000
Received: by mail-pg1-x544.google.com with SMTP id m1so4290427pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 05:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Omexow0w5skAFTQ2kjX5f7owXMLziiPh9EEZo6B8xHE=;
 b=M+zGZ/p/CVHNq4vuVsi0gIF1JVau0WlFY27DxNG6QG76M65rOTuMpzDzeA9TrO1dDb
 xQOOdOb3yYtlwkk5PZ/HIX8Gcjg6xgBFDl7JfMffaF1dcCcEj6M1CagzGDwjYn4zTK0C
 Bu4pTgRJDaNZjJMLKmfohUcRV0NEjEMyY/Pho0kgVnELy5qWK/dMo7g21h5Y7VewI88O
 4TfaK7jOouESo2nSZkz/NJ/4mROe2iXA+xkBRARCU5FXPI0g8gl6wGlC0AWLdjYJeQG0
 ghN9rYjn4csT/CfDh7770oXpaRiPzuX5lXscgwrRpJmyMkeUApBMNKTF5/rMSUwmrpvP
 /c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Omexow0w5skAFTQ2kjX5f7owXMLziiPh9EEZo6B8xHE=;
 b=i/65QSN/2f8sV/D3bC0H8vC7ZMVxnBkHOQYwsuSByiltsz9CSecWOeQwqKZgNjwdhH
 oeqfBdhaUbRwFmpoo6Q5URsZFBswFETBna3kCSDFAZ7sNv16HQqQ28D8/nz3U3EJIVut
 NWkO21bPjahhbxSkVQl6CUFpFyzjYrPyaavmrGzs3gNGH8/mEDHjgcn15TrF9ziI4sXL
 qIi0jahVV3Ut4yFbmNzhPe+divSb5nctJUBCpAkPWC1nJdfXzv/dfQ8BHu0cVp3C8GWN
 Gg0kwaPk+DagwpaobzR+ZGE5rF7sentW7xeTa7Lk1phdNdJd/CBAP55IsvKA91KNLglE
 onbQ==
X-Gm-Message-State: AJcUukdN89ZgqmJy/y4wgtAmB2rRrwapLgEhFLQ1U6G2JOLXdQKjNRtj
 avW7aTu6gRrQPbCJ11+qEC8=
X-Google-Smtp-Source: ALg8bN7w/qUHShyQDBvbmWLEC9rFOLb7zOJyzivRHWGmLm8qaMPRmFT8EW2BZxxoeIF650oj2dJFug==
X-Received: by 2002:a62:1542:: with SMTP id 63mr43852078pfv.230.1549114248555; 
 Sat, 02 Feb 2019 05:30:48 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id e16sm13015440pfn.46.2019.02.02.05.30.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 05:30:47 -0800 (PST)
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
Message-ID: <3d173ddf-46d2-165c-7886-cea685a0737d@gmail.com>
Date: Sat, 2 Feb 2019 16:30:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_053049_622931_31356467 
X-CRM114-Status: GOOD (  17.35  )
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
cml2ZXIuCgpUaGVuIHNob3VsZG4ndCBkZXZpY2UgdHJlZSBsb29rIGxpa2UgdGhpcz8gV2h5IFRN
UjctVE1SMCBhcmUgbm90IGRlZmluZWQgdGhlcmU/CgoJdGltZXJANjAwMDUwMDAgewoJCWNvbXBh
dGlibGUgPSAibnZpZGlhLHRlZ3JhMTI0LXRpbWVyIiwgIm52aWRpYSx0ZWdyYTMwLXRpbWVyIiwg
Im52aWRpYSx0ZWdyYTIwLXRpbWVyIjsKCQlyZWcgPSA8MHgwIDB4NjAwMDUwMDAgMHgwIDB4NDAw
PjsKCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKCQkJICAg
ICA8R0lDX1NQSSAxIElSUV9UWVBFX0xFVkVMX0hJR0g+LAoJCQkgICAgIDxHSUNfU1BJIDQxIElS
UV9UWVBFX0xFVkVMX0hJR0g+LAoJCQkgICAgIDxHSUNfU1BJIDQyIElSUV9UWVBFX0xFVkVMX0hJ
R0g+LAoJCQkgICAgIDxHSUNfU1BJIDEyMSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKCQkJICAgICA8
R0lDX1NQSSAxNTIgSVJRX1RZUEVfTEVWRUxfSElHSD47CgkJCSAgICAgPEdJQ19TUEkgMTUzIElS
UV9UWVBFX0xFVkVMX0hJR0g+OwoJCQkgICAgIDxHSUNfU1BJIDE1NCBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsKCQkJICAgICA8R0lDX1NQSSAxNTUgSVJRX1RZUEVfTEVWRUxfSElHSD47CgkJCSAgICAg
PEdJQ19TUEkgMTU2IElSUV9UWVBFX0xFVkVMX0hJR0g+OwoJCWNsb2NrcyA9IDwmdGVncmFfY2Fy
IFRFR1JBMTI0X0NMS19USU1FUj47CgkJY2xvY2stbmFtZXMgPSAidGltZXIiOwoJfTsKClRNUiAw
LDYsNyw4LDkgc2hvdWxkIGRlZmluZSBhIHNoYXJlZCBpbnRlcnJ1cHQgYXMgd2VsbCwgYnV0IHNl
ZW1zIHRoZSBzaGFyZWQgaW50ZXJydXB0IHByb3ZpZGVyIGlzIG5vdCBzdXBwb3J0ZWQgaW4gdXBz
dHJlYW0uCgpBbHNvIG5vdGUgdGhhdCBzZWVtcyBUMTI0LzEzMiBkZXZpY2UgdHJlZSBoYXMgYSB0
eXBvIChJJ20gbG9va2luZyBhdCBUSzEgVFJNKSwgVE1SNiBJUlEgaXMgMTUyIGFuZCBub3QgMTIy
LgoKQW5kIFQzMCBkZXZpY2UgdHJlZSBsb29rcyBpbmNvcnJlY3QsIFRSTSBzYXlzIHRoYXQgVE1S
MS1UTVI1IGhhdmUgYSAiZGVkaWNhdGVkIGludGVycnVwdCBiaXQiLCBidXQgbm90IFRNUjYuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
