Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9BDC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:54:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413E52080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LzCbLGWS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mL9+BsfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413E52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dr4TyyBkQjMHcJ2EiJ0YHUD2kv7JB93cmvRg88q+CUg=; b=LzCbLGWSb4p5G2lcNZfffM0W3
	OKcwNRxfzcv60tGJuUL890GgeywhhoCC3UaKrkWuR/AygzPXE8XkOpAhS9SIwSoD6UMwvSnArGt0v
	R6ooB+5LGt9dNul3eSnQ6X5qVOfAp3wvsFnLDXuI0Si3PcpgE4WeoIWNRry19jum6rIVLuxJK09+Q
	S3YUGWkR0rjzZ6NKh5TBXncR3z2s8fi0TezSeR7pkZMMmDBXXqzTghqq4Vofh+ZyOSI+MMxU4E446
	FU6BnvK4mYRp+/jAlqDNQSfckqw1YFgDd3r7By7K30/iIEWzgmoJXF8Lgq92Hk72SP/s+la1jOv9u
	nELY9RcJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpidD-0001nl-Ib; Fri, 01 Feb 2019 23:53:59 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpidA-0001nR-MX
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 23:53:58 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c54dc110000>; Fri, 01 Feb 2019 15:53:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 15:53:50 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 01 Feb 2019 15:53:50 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 23:53:48 +0000
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To: Dmitry Osipenko <digetx@gmail.com>, Jon Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <9370a0e4-2c76-6e9e-9219-121f92cdb14a@gmail.com>
 <46a1a62f-29b1-caac-ba68-e1394a76b3af@gmail.com>
 <85988378-0c88-6b71-00df-0700a7b4cdf7@nvidia.com>
 <4c89fd38-eacd-4643-52d3-da4760ecb4c5@nvidia.com>
 <57549882-4d0a-64ac-da04-7e790ac2d80e@gmail.com>
 <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
 <705a0eff-cb1e-0e7d-add7-fb1a993291dc@gmail.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <a24d9152-2bcd-7276-478c-63ee6923178e@nvidia.com>
Date: Sat, 2 Feb 2019 07:53:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <705a0eff-cb1e-0e7d-add7-fb1a993291dc@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549065233; bh=AbRDpXbwp6+qYEAdxol5TgBZ8HOHYAv4/5mMKo4Zc1Q=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=mL9+BsfIbeOfk9sFcoyXJ8LMYpEivkJOW6GzjzsqBbF198aQ9HbHpaEk5G7iwVegO
 lbN1uJQTVn/jX2eYzbkA5o49UYMQ6BQ+OZeb7nBINClcF7DAp2mpJNv93X7EVOVK/o
 93pxuPIUOtorgG75BfqhLceJAh7xHOHYZZAE/4ZD611jTcSxaG1g2QD2R4xjLHhW2f
 2daPLixscu6n8rBBPH/sfwShTPSooYc6pU1pLrIoQ9dBRImcZxeFsZU8WEUhQNG5T+
 A2Q8VDYAvhKY32/KV1uIKI+zlkRnn13h6UMl/2H+/O0cjHWBNj3WLieRPY6PEC9P80
 h6gcGuIIauAWQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_155356_750933_6065552E 
X-CRM114-Status: GOOD (  14.91  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8yLzE5IDI6MDggQU0sIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiAwMS4wMi4yMDE5IDE4
OjM3LCBKb3NlcGggTG8g0L/QuNGI0LXRgjoKPj4gT24gMi8xLzE5IDExOjEzIFBNLCBEbWl0cnkg
T3NpcGVua28gd3JvdGU6Cj4+PiAwMS4wMi4yMDE5IDE3OjEzLCBKb3NlcGggTG8g0L/QuNGI0LXR
gjoKPj4+PiBPbiAyLzEvMTkgOTo1NCBQTSwgSm9uIEh1bnRlciB3cm90ZToKPj4+Pj4KPj4+Pj4g
T24gMDEvMDIvMjAxOSAxMzoxMSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+Pj4gMDEuMDIu
MjAxOSAxNjowNiwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+Pj4+Pj4gMDEuMDIuMjAx
OSA2OjM2LCBKb3NlcGggTG8g0L/QuNGI0LXRgjoKPj4+Pj4+Pj4gQWRkIHN1cHBvcnQgZm9yIHRo
ZSBUZWdyYTIxMCB0aW1lciB0aGF0IHJ1bnMgYXQgb3NjaWxsYXRvciBjbG9jawo+Pj4+Pj4+PiAo
VE1SMTAtVE1SMTMpLiBXZSBuZWVkIHRoZXNlIHRpbWVycyB0byB3b3JrIGFzIGNsb2NrIGV2ZW50
IGRldmljZSBhbmQgdG8KPj4+Pj4+Pj4gcmVwbGFjZSB0aGUgQVJNdjggYXJjaGl0ZWN0ZWQgdGlt
ZXIgZHVlIHRvIGl0IGNhbid0IHN1cnZpdmUgYWNyb3NzIHRoZQo+Pj4+Pj4+PiBwb3dlciBjeWNs
ZSBvZiB0aGUgQ1BVIGNvcmUgb3IgQ1BVUE9SRVNFVCBzaWduYWwuIFNvIGl0IGNhbid0IGJlIGEg
d2FrZS11cAo+Pj4+Pj4+PiBzb3VyY2Ugd2hlbiBDUFUgc3VzcGVuZHMgaW4gcG93ZXIgZG93biBz
dGF0ZS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQWxzbyBjb252ZXJ0IHRoZSBvcmlnaW5hbCBkcml2ZXIg
dG8gdXNlIHRpbWVyLW9mIEFQSS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQ2M6IERhbmllbCBMZXpjYW5v
IDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgo+Pj4+Pj4+PiBDYzogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4+Pj4+Pj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnCj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBMbyA8am9zZXBobEBudmlkaWEu
Y29tPgo+Pj4+Pj4+PiBBY2tlZC1ieTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNv
bT4KPj4+Pj4+Pj4gLS0tCj4+IHNuaXAuCj4+Pj4+Pj4+ICt9Cj4+Pj4+Pj4+ICtUSU1FUl9PRl9E
RUNMQVJFKHRlZ3JhMjEwX3RpbWVyLCAibnZpZGlhLHRlZ3JhMjEwLXRpbWVyIiwgdGVncmEyMTBf
dGltZXJfaW5pdCk7Cj4+Pj4+Pj4+ICsjZWxzZSAvKiBDT05GSUdfQVJNICovCj4+Pj4+Pj4+ICtz
dGF0aWMgaW50IF9faW5pdCB0ZWdyYTIwX2luaXRfdGltZXIoc3RydWN0IGRldmljZV9ub2RlICpu
cCkKPj4+Pj4+Pj4gK3sKPj4+Pj4+PiBXaGF0IGFib3V0IFQxMzI/IElzbid0IGl0IEFSTTY0IHdo
aWNoIHVzZXMgdGVncmEyMC10aW1lciBJUD8gQXQgbGVhc3QgVDEzMiBEVCBzdWdnZXN0cyBzbyBh
bmQgc2VlbXMgdGhpcyBjaGFuZ2Ugd2lsbCBicmVhayBpdC4KPj4+Pj4+Pgo+Pj4+Pj4+IFtzbmlw
XQo+Pj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gQWgsIG5vdGljZWQgdGhlICJkZXBlbmRzIG9uIEFSTSIg
aW4gS2NvbmZpZy4uIFNlZW1zIG9rYXkgdGhlbi4KPj4+Pj4+Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IFRo
aXMgaXMgYSBnb29kIHBvaW50LCBiZWNhdXNlIGV2ZW4gdGhvdWdoIHdlIGhhZCAnZGVwZW5kcyBv
biBBUk0nLCB0aGlzCj4+Pj4+IHN0aWxsIG1lYW5zIHRoYXQgdGhlIFRlZ3JhMTMyIERUIGlzIGlu
Y29ycmVjdC4KPj4+Pj4KPj4+Pj4gSm9zZXBoLCBjYW4geW91IHRha2UgYSBxdWljayBsb29rIGF0
IFRlZ3JhMTMyPwo+Pj4+Cj4+Pj4gSGkgSm9uIGFuZCBEbWl0cnksCj4+Pj4KPj4+PiBObyB3b3Jy
eSBhYm91dCBUMTMyLCBUMTMyIHVzZXMgYXJjaCB0aW1lciAodjcpLiBUaGUgdGVncmEyMCB0aW1l
ciBkcml2ZXIgaGFzIG5ldmVyIGJlZW4gdXNlZC4gV2Ugc2hvdWxkIGZpeCB0aGUgZHRzaSBmaWxl
IGxhdGVyLgo+Pj4KPj4+IEhpIEpvc2VwaCwKPj4+Cj4+PiBTbyBpcyBUMTMyIEhXIGFjdHVhbGx5
IGluY29tcGF0aWJsZSB3aXRoIHRoZSB0ZWdyYTIwLXRpbWVyPyBJZiBpdCdzIGNvbXBhdGlibGUs
IHRoZW4gSSB0aGluayB0aGUgZHJpdmVyJ3MgY29kZSBzaG91bGQgYmUgbWFkZSBtb3JlIHVuaXZl
cnNhbCB0byBzdXBwb3J0IFQxMzIuCj4+Pgo+Pgo+PiAgRnJvbSBIVyBwb2ludCBvZiB2aWV3LCB0
aGUgVElNRVIxIH4gVElNRVI0IGlzIGNvbXBhdGlibGUgd2l0aCAibnZpZGlhLHRlZ3JhMjAtdGlt
ZXIiLiBCdXQgVGVncmExMzIgYWN0dWFsbHkgaGFzIDEwIHRpbWVycyB3aGljaCBhcmUgZXhhY3Rs
eSB0aGUgc2FtZSBhcyBUZWdyYTMwLiBTbyBpdCBzaG91bGQgYmFja3dhcmQgY29tcGF0aWJsZSB3
aXRoICJudmlkaWEsdGVncmEzMC10aW1lciIsIHdoaWNoIGlzIHRlZ3JhX3dkdCBkcml2ZXIgbm93
LiBBbmQgVGVncmExMzIgc2hvdWxkIG5ldmVyIHVzZSB0aGlzIGRyaXZlci4KPj4KPj4gVGhlIFRl
Z3JhIHRpbWVyIGRyaXZlciBzaG91bGQgb25seSBiZSB1c2VkIG9uIFRlZ3JhMjAvMzAvMjEwLCB0
aHJlZSBwbGF0Zm9ybXMgb25seS4gT3RoZXJzIHVzZSBhcmNoIHRpbWVyIGRyaXZlciBmb3Igc3lz
dGVtIHRpbWVyIGRyaXZlci4KPj4KPj4gU28gd2UgZG9uJ3QgcmVhbGx5IG5lZWQgdG8gdGFrZSBj
YXJlIHRoZSB1c2FnZSBvbiBvdGhlciBUZWdyYSBwbGF0Zm9ybXMuCj4gCj4gRG9lc24ndCBMaW51
eCBrZXJuZWwgcHV0IGluIHVzZSBhbGwgb2YgYXZhaWxhYmxlIHRpbWVycz8gSWYgeWVzLCB0aGVu
IHdlIHByb2JhYmx5IHdvdWxkIHdhbnQgdG8gZXhwb3NlIGFsbCBhdmFpbGFibGUgdGltZXJzLiBJ
dCBsb29rcyB0byBtZSB0aGF0IHJpZ2h0IG5vdyB0ZWdyYTIwLXRpbWVyIGV4cG9zZXMgb25seSBh
IHNpbmdsZS1zaGFyZWQgdGltZXIgdG8gdGhlIHN5c3RlbSBbcGxlYXNlIGNvcnJlY3QgbWUgaWYg
SSdtIHdyb25nXS4gV291bGRuJ3QgbWFrZSBzZW5zZSBhdCBsZWFzdCB0byBnaXZlIGEgdGltZXIg
cGVyIENQVSBjb3JlPwo+IAoKTm8sIG9ubHkgb25lIHRpbWVyIGRyaXZlciB3b3JrcyBhdCBhIHRp
bWUuICggc2VlIC9wcm9jL3RpbWVyX2xpc3QgdG8gCmNoZWNrIHdoaWNoIHRpbWVyIGlzIHdvcmtp
bmcuKQoKID4gSXQgbG9va3MgdG8gbWUgdGhhdCByaWdodCBub3cgdGVncmEyMC10aW1lciBleHBv
c2VzIG9ubHkgYSAKc2luZ2xlLXNoYXJlZCB0aW1lciB0byB0aGUgc3lzdGVtIFtwbGVhc2UgY29y
cmVjdCBtZSBpZiBJJ20gd3JvbmddLiAKV291bGRuJ3QgbWFrZSBzZW5zZSBhdCBsZWFzdCB0byBn
aXZlIGEgdGltZXIgcGVyIENQVSBjb3JlPwoKWWVzLCBpdCdzIGNvcnJlY3QuIHRoZSB0aW1lci10
ZWdyYTIwIG9ubHkgcHJvdmlkZXMgYSBzaW5nbGUtc2hhcmVkIAp0aW1lci4gQW5kIHllcywgLGl0
IHNob3VsZCBwcm92aWRlIGEgdGltZXIgcGVyIENQVSBjb3JlLiBCdXQgdGhhdCBpcyAKYW5vdGhl
ciB0YXNrLCB0aGlzIHBhdGNoIG9ubHkgaW50cm9kdWNlIHRoZSB0aW1lciBzdXBwb3J0IGZvciBU
ZWdyYTIxMC4gCk90aGVycyB0aGF0IG9yaWdpbmFsbHkgZnJvbSB0aW1lci10ZWdyYTIwIGRyaXZl
ciBzdGlsbCByZW1haW4gdGhlIHNhbWUuCgpUaGFua3MsCkpvc2VwaAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
