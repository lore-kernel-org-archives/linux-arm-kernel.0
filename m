Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD6C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:39:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDC021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ipIcthLu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIGxdIXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDC021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zw0iPhPRZraFUa+u2cAHP0uAMl3nzng8OwvGl6fr0bU=; b=ipIcthLusGiiBn
	7sBBWLxOOAV8ptg5/3brUHJANYrae3avzn0ONm5tKiU7lSrzDjSUiQ3PXDrqZQm4viR315bOD2PZn
	pN6IU3sbpfVqMViR85fjJeEgxyPpoQySMjGsNIYU8f1j1u1Abrw6XlBLLkBnBLy6RDXr/xeA5iBcN
	qiS2adhG22eR2OWuTPjiNQAebjfAFNcS/r0nUYkxhOkwcvAFJFE1vQpHNU2gJPzZzwRmaxF6D71PD
	9D6w+knQxFceSt+1H4ZiA0lRw6eXKE6zFWG21KAAGNtjkHs3mJ1lPs7WpC7YtmfcOxb6CFi8I6tah
	8zR/P5QlU67zaGndyocA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpvVX-00025N-V9; Sat, 02 Feb 2019 13:38:55 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpvVU-000254-VE
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 13:38:54 +0000
Received: by mail-pl1-x641.google.com with SMTP id y1so4688797plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 05:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4ROYYNS4/mDWhasZjGI+Ap9TgleBkQGT1tv0LE1FECM=;
 b=MIGxdIXj89EUxrQTszFZjw/xVu0K5vNv56PTSvAsqPhkvP/9wmSZKBdSww8rKxNs/+
 18+A2IqEYKrWYxvBEgtHsXdSg1cXLAvnjuHEzGDPNAGpmPMr+W5dvm0V13MPNqBXmJwW
 g/OtfuUn8lHQg8Y9aHdlF/qsduiBXkuR+e8sVFk7+atohx4umBHdNaksG8tJTt34FHfX
 Y06pSYrVK+4/tb8M5mBQ8XjjADHNALFtg1NbtueCJysxrD8o9OSZgmpkMOmk2M5wZRA6
 3rklM7WNxL1zfF+VOj63hEv6Iq8xmTGX18Yb6N4yMbEk2AbUYRwnCJ6nMdbJW+4tfMh+
 BHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4ROYYNS4/mDWhasZjGI+Ap9TgleBkQGT1tv0LE1FECM=;
 b=Lrkp4LCMIiOgd1a/CKWdmATMOTiwHV1M6U7vwjhC1349X1omLF1MH9fj3igRaOaR8U
 8wo8PGmwM++jNDp0t/odynShdbwFRWoHXRPNw0O9mpWO8GxAd5aJQ3kcLKhbh1P0Ol/c
 oz4Y5vBJPDrtRnGhbSwklk2RkZF9T3/YUJcs1dKvCVK7vwgLATyUbsSogWVWNzYbfK3w
 3Vlo4hT87IqeTjnytD7U1v2VS0XEdwPvFBu0KJTKZHSLZyQgvv94HuBKoCVtOtCs/hHp
 s6uo3IqxDBI/L3NidtaKzIDphajiNySfzR7faGXIb15k9jM7TTUyTbN2rwGOONj8sJrD
 QDsg==
X-Gm-Message-State: AJcUukfLw2af4NySEqJtqRkqsMlF9uUxOjAJHPSuk/syVwX7rxzr9Nht
 3k0+yB2E9aaGCTjaIzSubrvHhg//
X-Google-Smtp-Source: ALg8bN59Sruj6BXcm/OCO9a9SAfN84Q8D3icdWYJ7eCSF8X7sLPh74aYAtyB0rpNTrhstEglG8wYKQ==
X-Received: by 2002:a17:902:6a4:: with SMTP id
 33mr42829855plh.99.1549114732110; 
 Sat, 02 Feb 2019 05:38:52 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id a18sm19388486pgj.30.2019.02.02.05.38.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 05:38:51 -0800 (PST)
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
 <705a0eff-cb1e-0e7d-add7-fb1a993291dc@gmail.com>
 <a24d9152-2bcd-7276-478c-63ee6923178e@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0a5721cc-6cbf-9f1f-6282-36b7175ce9a2@gmail.com>
Date: Sat, 2 Feb 2019 16:38:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a24d9152-2bcd-7276-478c-63ee6923178e@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_053853_031434_17F04B11 
X-CRM114-Status: GOOD (  19.00  )
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

MDIuMDIuMjAxOSAyOjUzLCBKb3NlcGggTG8g0L/QuNGI0LXRgjoKPiBPbiAyLzIvMTkgMjowOCBB
TSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAwMS4wMi4yMDE5IDE4OjM3LCBKb3NlcGggTG8g
0L/QuNGI0LXRgjoKPj4+IE9uIDIvMS8xOSAxMToxMyBQTSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3Rl
Ogo+Pj4+IDAxLjAyLjIwMTkgMTc6MTMsIEpvc2VwaCBMbyDQv9C40YjQtdGCOgo+Pj4+PiBPbiAy
LzEvMTkgOTo1NCBQTSwgSm9uIEh1bnRlciB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBPbiAwMS8wMi8y
MDE5IDEzOjExLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+Pj4+Pj4gMDEuMDIuMjAxOSAxNjow
NiwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+Pj4+Pj4+IDAxLjAyLjIwMTkgNjozNiwg
Sm9zZXBoIExvINC/0LjRiNC10YI6Cj4+Pj4+Pj4+PiBBZGQgc3VwcG9ydCBmb3IgdGhlIFRlZ3Jh
MjEwIHRpbWVyIHRoYXQgcnVucyBhdCBvc2NpbGxhdG9yIGNsb2NrCj4+Pj4+Pj4+PiAoVE1SMTAt
VE1SMTMpLiBXZSBuZWVkIHRoZXNlIHRpbWVycyB0byB3b3JrIGFzIGNsb2NrIGV2ZW50IGRldmlj
ZSBhbmQgdG8KPj4+Pj4+Pj4+IHJlcGxhY2UgdGhlIEFSTXY4IGFyY2hpdGVjdGVkIHRpbWVyIGR1
ZSB0byBpdCBjYW4ndCBzdXJ2aXZlIGFjcm9zcyB0aGUKPj4+Pj4+Pj4+IHBvd2VyIGN5Y2xlIG9m
IHRoZSBDUFUgY29yZSBvciBDUFVQT1JFU0VUIHNpZ25hbC4gU28gaXQgY2FuJ3QgYmUgYSB3YWtl
LXVwCj4+Pj4+Pj4+PiBzb3VyY2Ugd2hlbiBDUFUgc3VzcGVuZHMgaW4gcG93ZXIgZG93biBzdGF0
ZS4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBBbHNvIGNvbnZlcnQgdGhlIG9yaWdpbmFsIGRyaXZlciB0
byB1c2UgdGltZXItb2YgQVBJLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IENjOiBEYW5pZWwgTGV6Y2Fu
byA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4KPj4+Pj4+Pj4+IENjOiBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAbGludXRyb25peC5kZT4KPj4+Pj4+Pj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnCj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZp
ZGlhLmNvbT4KPj4+Pj4+Pj4+IEFja2VkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0Budmlk
aWEuY29tPgo+Pj4+Pj4+Pj4gLS0tCj4+PiBzbmlwLgo+Pj4+Pj4+Pj4gK30KPj4+Pj4+Pj4+ICtU
SU1FUl9PRl9ERUNMQVJFKHRlZ3JhMjEwX3RpbWVyLCAibnZpZGlhLHRlZ3JhMjEwLXRpbWVyIiwg
dGVncmEyMTBfdGltZXJfaW5pdCk7Cj4+Pj4+Pj4+PiArI2Vsc2UgLyogQ09ORklHX0FSTSAqLwo+
Pj4+Pj4+Pj4gK3N0YXRpYyBpbnQgX19pbml0IHRlZ3JhMjBfaW5pdF90aW1lcihzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wKQo+Pj4+Pj4+Pj4gK3sKPj4+Pj4+Pj4gV2hhdCBhYm91dCBUMTMyPyBJc24n
dCBpdCBBUk02NCB3aGljaCB1c2VzIHRlZ3JhMjAtdGltZXIgSVA/IEF0IGxlYXN0IFQxMzIgRFQg
c3VnZ2VzdHMgc28gYW5kIHNlZW1zIHRoaXMgY2hhbmdlIHdpbGwgYnJlYWsgaXQuCj4+Pj4+Pj4+
Cj4+Pj4+Pj4+IFtzbmlwXQo+Pj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gQWgsIG5vdGljZWQgdGhl
ICJkZXBlbmRzIG9uIEFSTSIgaW4gS2NvbmZpZy4uIFNlZW1zIG9rYXkgdGhlbi4KPj4+Pj4+Pgo+
Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBUaGlzIGlzIGEgZ29vZCBwb2ludCwgYmVjYXVzZSBldmVuIHRo
b3VnaCB3ZSBoYWQgJ2RlcGVuZHMgb24gQVJNJywgdGhpcwo+Pj4+Pj4gc3RpbGwgbWVhbnMgdGhh
dCB0aGUgVGVncmExMzIgRFQgaXMgaW5jb3JyZWN0Lgo+Pj4+Pj4KPj4+Pj4+IEpvc2VwaCwgY2Fu
IHlvdSB0YWtlIGEgcXVpY2sgbG9vayBhdCBUZWdyYTEzMj8KPj4+Pj4KPj4+Pj4gSGkgSm9uIGFu
ZCBEbWl0cnksCj4+Pj4+Cj4+Pj4+IE5vIHdvcnJ5IGFib3V0IFQxMzIsIFQxMzIgdXNlcyBhcmNo
IHRpbWVyICh2NykuIFRoZSB0ZWdyYTIwIHRpbWVyIGRyaXZlciBoYXMgbmV2ZXIgYmVlbiB1c2Vk
LiBXZSBzaG91bGQgZml4IHRoZSBkdHNpIGZpbGUgbGF0ZXIuCj4+Pj4KPj4+PiBIaSBKb3NlcGgs
Cj4+Pj4KPj4+PiBTbyBpcyBUMTMyIEhXIGFjdHVhbGx5IGluY29tcGF0aWJsZSB3aXRoIHRoZSB0
ZWdyYTIwLXRpbWVyPyBJZiBpdCdzIGNvbXBhdGlibGUsIHRoZW4gSSB0aGluayB0aGUgZHJpdmVy
J3MgY29kZSBzaG91bGQgYmUgbWFkZSBtb3JlIHVuaXZlcnNhbCB0byBzdXBwb3J0IFQxMzIuCj4+
Pj4KPj4+Cj4+PiDCoEZyb20gSFcgcG9pbnQgb2YgdmlldywgdGhlIFRJTUVSMSB+IFRJTUVSNCBp
cyBjb21wYXRpYmxlIHdpdGggIm52aWRpYSx0ZWdyYTIwLXRpbWVyIi4gQnV0IFRlZ3JhMTMyIGFj
dHVhbGx5IGhhcyAxMCB0aW1lcnMgd2hpY2ggYXJlIGV4YWN0bHkgdGhlIHNhbWUgYXMgVGVncmEz
MC4gU28gaXQgc2hvdWxkIGJhY2t3YXJkIGNvbXBhdGlibGUgd2l0aCAibnZpZGlhLHRlZ3JhMzAt
dGltZXIiLCB3aGljaCBpcyB0ZWdyYV93ZHQgZHJpdmVyIG5vdy4gQW5kIFRlZ3JhMTMyIHNob3Vs
ZCBuZXZlciB1c2UgdGhpcyBkcml2ZXIuCj4+Pgo+Pj4gVGhlIFRlZ3JhIHRpbWVyIGRyaXZlciBz
aG91bGQgb25seSBiZSB1c2VkIG9uIFRlZ3JhMjAvMzAvMjEwLCB0aHJlZSBwbGF0Zm9ybXMgb25s
eS4gT3RoZXJzIHVzZSBhcmNoIHRpbWVyIGRyaXZlciBmb3Igc3lzdGVtIHRpbWVyIGRyaXZlci4K
Pj4+Cj4+PiBTbyB3ZSBkb24ndCByZWFsbHkgbmVlZCB0byB0YWtlIGNhcmUgdGhlIHVzYWdlIG9u
IG90aGVyIFRlZ3JhIHBsYXRmb3Jtcy4KPj4KPj4gRG9lc24ndCBMaW51eCBrZXJuZWwgcHV0IGlu
IHVzZSBhbGwgb2YgYXZhaWxhYmxlIHRpbWVycz8gSWYgeWVzLCB0aGVuIHdlIHByb2JhYmx5IHdv
dWxkIHdhbnQgdG8gZXhwb3NlIGFsbCBhdmFpbGFibGUgdGltZXJzLiBJdCBsb29rcyB0byBtZSB0
aGF0IHJpZ2h0IG5vdyB0ZWdyYTIwLXRpbWVyIGV4cG9zZXMgb25seSBhIHNpbmdsZS1zaGFyZWQg
dGltZXIgdG8gdGhlIHN5c3RlbSBbcGxlYXNlIGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nXS4gV291
bGRuJ3QgbWFrZSBzZW5zZSBhdCBsZWFzdCB0byBnaXZlIGEgdGltZXIgcGVyIENQVSBjb3JlPwo+
Pgo+IAo+IE5vLCBvbmx5IG9uZSB0aW1lciBkcml2ZXIgd29ya3MgYXQgYSB0aW1lLiAoIHNlZSAv
cHJvYy90aW1lcl9saXN0IHRvIGNoZWNrIHdoaWNoIHRpbWVyIGlzIHdvcmtpbmcuKQoKT2theSwg
dGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4KCj4+IEl0IGxvb2tzIHRvIG1lIHRoYXQgcmln
aHQgbm93IHRlZ3JhMjAtdGltZXIgZXhwb3NlcyBvbmx5IGEgc2luZ2xlLXNoYXJlZCB0aW1lciB0
byB0aGUgc3lzdGVtIFtwbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmddLiBXb3VsZG4ndCBt
YWtlIHNlbnNlIGF0IGxlYXN0IHRvIGdpdmUgYSB0aW1lciBwZXIgQ1BVIGNvcmU/Cj4gCj4gWWVz
LCBpdCdzIGNvcnJlY3QuIHRoZSB0aW1lci10ZWdyYTIwIG9ubHkgcHJvdmlkZXMgYSBzaW5nbGUt
c2hhcmVkIHRpbWVyLiBBbmQgeWVzLCAsaXQgc2hvdWxkIHByb3ZpZGUgYSB0aW1lciBwZXIgQ1BV
IGNvcmUuIEJ1dCB0aGF0IGlzIGFub3RoZXIgdGFzaywgdGhpcyBwYXRjaCBvbmx5IGludHJvZHVj
ZSB0aGUgdGltZXIgc3VwcG9ydCBmb3IgVGVncmEyMTAuIE90aGVycyB0aGF0IG9yaWdpbmFsbHkg
ZnJvbSB0aW1lci10ZWdyYTIwIGRyaXZlciBzdGlsbCByZW1haW4gdGhlIHNhbWUuCgpJIG1heSB0
YWtlIGEgbG9vayBhdCBpdC4gQ291bGQgYmUgYmV0dGVyIGZvciBvbGRlciBUZWdyYSdzIHRvIHVz
ZSB0ZWdyYTIwLXRpbWVyIGZvciB0aGUgcGVyLUNQVSB0aW1lciBzaW5jZSBUV0QgdGltZXIgaGFz
IHNvbWUgdGltZS1qaXR0ZXIgZHVlIHRvIERWRlMuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
