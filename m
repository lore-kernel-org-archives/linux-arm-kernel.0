Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B28C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:07:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B685720857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="or9vx7Id";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="USbVWc+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B685720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mS3mfiuga09CPFvMS2GRVXujscKHpXHy/Q8zfq4W7RQ=; b=or9vx7IdV0ct22jaw4f+Io1XV
	mivCKlpu9uM3Nv5PX9wh6Iqd+T+54uFbzRXBF1I7aBiqC6Jcywu3gUqA+Mfr+ziuvopnNNPoB9pV3
	actturWjaI8yh5/EiQzPr4lztS4WMjqTZRs63BHo+m/x/gs+UULj6qUwvDzlf3p3vMQouRlWaxYMJ
	J1ppS1WMm+076bGBCcpSxHbJpX25jAgnpmJ8iGZ/P3U7GIbFyY/yfwI2b6/2aYfzrYPzAc7JBgMM5
	bii+IL3bHkpcs3rQ5U+du0SgbK9A26TVo/Z/K6AlUuea47qS2AVt4bwsbt/QSvpvCUVSO+LjmJEJs
	qjR+yldAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpxp8-0003Da-9U; Sat, 02 Feb 2019 16:07:18 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpxp4-0003Cz-2S
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 16:07:16 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c55c0140000>; Sat, 02 Feb 2019 08:06:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sat, 02 Feb 2019 08:07:13 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sat, 02 Feb 2019 08:07:13 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 2 Feb
 2019 16:07:11 +0000
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
 <a24d9152-2bcd-7276-478c-63ee6923178e@nvidia.com>
 <0a5721cc-6cbf-9f1f-6282-36b7175ce9a2@gmail.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <0458731d-e245-8362-2b62-92aa5e1b7fe3@nvidia.com>
Date: Sun, 3 Feb 2019 00:07:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0a5721cc-6cbf-9f1f-6282-36b7175ce9a2@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549123604; bh=U/hgPA9gjzdAN6f2gb2IoqoLDUP0nEaBYXEHVFU8JrM=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=USbVWc+ElA+QaTA4dYfSOs56/f5V0CR7Uu5XYpacjIiQ9QeY2FBzbTtJp79D07dyI
 cmhl2WBNPhlcGAXA8ZhAOLG/vXan1CngoNS657o5UumVUwg0rGHy3rm4cVy6WFZY4v
 niLmmde35OxD2vw6C6QKF7iiWsrek4ylB7onUGYCfzTGbSOS4e7zBCRbN2Rh3wQriw
 xyJHasE+T5j/oFBXndLoi1jJHRftJB8SopLMkk9N76gxheV1jiJIjDswhgGUQSmHQI
 tpRRbawYgNxj/utC7OQ7HeTxY4i7F7l+kxBzHSqwQv2HeHZJJBug2iT/3sN1RoiX3E
 L+drCnBIgcCfw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_080714_127407_187A832E 
X-CRM114-Status: GOOD (  16.34  )
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

T24gMi8yLzE5IDk6MzggUE0sIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiAwMi4wMi4yMDE5IDI6
NTMsIEpvc2VwaCBMbyDQv9C40YjQtdGCOgo+PiBPbiAyLzIvMTkgMjowOCBBTSwgRG1pdHJ5IE9z
aXBlbmtvIHdyb3RlOgo+Pj4gMDEuMDIuMjAxOSAxODozNywgSm9zZXBoIExvINC/0LjRiNC10YI6
Cj4+Pj4gT24gMi8xLzE5IDExOjEzIFBNLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+Pj4+IDAx
LjAyLjIwMTkgMTc6MTMsIEpvc2VwaCBMbyDQv9C40YjQtdGCOgo+Pj4+Pj4gT24gMi8xLzE5IDk6
NTQgUE0sIEpvbiBIdW50ZXIgd3JvdGU6Cj4+Pj4+Pj4KPj4+Pj4+PiBPbiAwMS8wMi8yMDE5IDEz
OjExLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+Pj4+Pj4+IDAxLjAyLjIwMTkgMTY6MDYsIERt
aXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+Pj4+Pj4+Pj4gMDEuMDIuMjAxOSA2OjM2LCBKb3Nl
cGggTG8g0L/QuNGI0LXRgjoKPj4+Pj4+Pj4+PiBBZGQgc3VwcG9ydCBmb3IgdGhlIFRlZ3JhMjEw
IHRpbWVyIHRoYXQgcnVucyBhdCBvc2NpbGxhdG9yIGNsb2NrCj4+Pj4+Pj4+Pj4gKFRNUjEwLVRN
UjEzKS4gV2UgbmVlZCB0aGVzZSB0aW1lcnMgdG8gd29yayBhcyBjbG9jayBldmVudCBkZXZpY2Ug
YW5kIHRvCj4+Pj4+Pj4+Pj4gcmVwbGFjZSB0aGUgQVJNdjggYXJjaGl0ZWN0ZWQgdGltZXIgZHVl
IHRvIGl0IGNhbid0IHN1cnZpdmUgYWNyb3NzIHRoZQo+Pj4+Pj4+Pj4+IHBvd2VyIGN5Y2xlIG9m
IHRoZSBDUFUgY29yZSBvciBDUFVQT1JFU0VUIHNpZ25hbC4gU28gaXQgY2FuJ3QgYmUgYSB3YWtl
LXVwCj4+Pj4+Pj4+Pj4gc291cmNlIHdoZW4gQ1BVIHN1c3BlbmRzIGluIHBvd2VyIGRvd24gc3Rh
dGUuCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBBbHNvIGNvbnZlcnQgdGhlIG9yaWdpbmFsIGRyaXZl
ciB0byB1c2UgdGltZXItb2YgQVBJLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQ2M6IERhbmllbCBM
ZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgo+Pj4+Pj4+Pj4+IENjOiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPj4+Pj4+Pj4+PiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZwo+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBMbyA8am9z
ZXBobEBudmlkaWEuY29tPgo+Pj4+Pj4+Pj4+IEFja2VkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJl
ZGluZ0BudmlkaWEuY29tPgo+Pj4+Pj4+Pj4+IC0tLQo+Pj4+IHNuaXAuCj4+Pj4+Pj4+Pj4gK30K
Pj4+Pj4+Pj4+PiArVElNRVJfT0ZfREVDTEFSRSh0ZWdyYTIxMF90aW1lciwgIm52aWRpYSx0ZWdy
YTIxMC10aW1lciIsIHRlZ3JhMjEwX3RpbWVyX2luaXQpOwo+Pj4+Pj4+Pj4+ICsjZWxzZSAvKiBD
T05GSUdfQVJNICovCj4+Pj4+Pj4+Pj4gK3N0YXRpYyBpbnQgX19pbml0IHRlZ3JhMjBfaW5pdF90
aW1lcihzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQo+Pj4+Pj4+Pj4+ICt7Cj4+Pj4+Pj4+PiBXaGF0
IGFib3V0IFQxMzI/IElzbid0IGl0IEFSTTY0IHdoaWNoIHVzZXMgdGVncmEyMC10aW1lciBJUD8g
QXQgbGVhc3QgVDEzMiBEVCBzdWdnZXN0cyBzbyBhbmQgc2VlbXMgdGhpcyBjaGFuZ2Ugd2lsbCBi
cmVhayBpdC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBbc25pcF0KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+
Pj4+Pj4+IEFoLCBub3RpY2VkIHRoZSAiZGVwZW5kcyBvbiBBUk0iIGluIEtjb25maWcuLiBTZWVt
cyBva2F5IHRoZW4uCj4+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IFRoaXMgaXMgYSBn
b29kIHBvaW50LCBiZWNhdXNlIGV2ZW4gdGhvdWdoIHdlIGhhZCAnZGVwZW5kcyBvbiBBUk0nLCB0
aGlzCj4+Pj4+Pj4gc3RpbGwgbWVhbnMgdGhhdCB0aGUgVGVncmExMzIgRFQgaXMgaW5jb3JyZWN0
Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gSm9zZXBoLCBjYW4geW91IHRha2UgYSBxdWljayBsb29rIGF0IFRl
Z3JhMTMyPwo+Pj4+Pj4KPj4+Pj4+IEhpIEpvbiBhbmQgRG1pdHJ5LAo+Pj4+Pj4KPj4+Pj4+IE5v
IHdvcnJ5IGFib3V0IFQxMzIsIFQxMzIgdXNlcyBhcmNoIHRpbWVyICh2NykuIFRoZSB0ZWdyYTIw
IHRpbWVyIGRyaXZlciBoYXMgbmV2ZXIgYmVlbiB1c2VkLiBXZSBzaG91bGQgZml4IHRoZSBkdHNp
IGZpbGUgbGF0ZXIuCj4+Pj4+Cj4+Pj4+IEhpIEpvc2VwaCwKPj4+Pj4KPj4+Pj4gU28gaXMgVDEz
MiBIVyBhY3R1YWxseSBpbmNvbXBhdGlibGUgd2l0aCB0aGUgdGVncmEyMC10aW1lcj8gSWYgaXQn
cyBjb21wYXRpYmxlLCB0aGVuIEkgdGhpbmsgdGhlIGRyaXZlcidzIGNvZGUgc2hvdWxkIGJlIG1h
ZGUgbW9yZSB1bml2ZXJzYWwgdG8gc3VwcG9ydCBUMTMyLgo+Pj4+Pgo+Pj4+Cj4+Pj4gIMKgRnJv
bSBIVyBwb2ludCBvZiB2aWV3LCB0aGUgVElNRVIxIH4gVElNRVI0IGlzIGNvbXBhdGlibGUgd2l0
aCAibnZpZGlhLHRlZ3JhMjAtdGltZXIiLiBCdXQgVGVncmExMzIgYWN0dWFsbHkgaGFzIDEwIHRp
bWVycyB3aGljaCBhcmUgZXhhY3RseSB0aGUgc2FtZSBhcyBUZWdyYTMwLiBTbyBpdCBzaG91bGQg
YmFja3dhcmQgY29tcGF0aWJsZSB3aXRoICJudmlkaWEsdGVncmEzMC10aW1lciIsIHdoaWNoIGlz
IHRlZ3JhX3dkdCBkcml2ZXIgbm93LiBBbmQgVGVncmExMzIgc2hvdWxkIG5ldmVyIHVzZSB0aGlz
IGRyaXZlci4KPj4+Pgo+Pj4+IFRoZSBUZWdyYSB0aW1lciBkcml2ZXIgc2hvdWxkIG9ubHkgYmUg
dXNlZCBvbiBUZWdyYTIwLzMwLzIxMCwgdGhyZWUgcGxhdGZvcm1zIG9ubHkuIE90aGVycyB1c2Ug
YXJjaCB0aW1lciBkcml2ZXIgZm9yIHN5c3RlbSB0aW1lciBkcml2ZXIuCj4+Pj4KPj4+PiBTbyB3
ZSBkb24ndCByZWFsbHkgbmVlZCB0byB0YWtlIGNhcmUgdGhlIHVzYWdlIG9uIG90aGVyIFRlZ3Jh
IHBsYXRmb3Jtcy4KPj4+Cj4+PiBEb2Vzbid0IExpbnV4IGtlcm5lbCBwdXQgaW4gdXNlIGFsbCBv
ZiBhdmFpbGFibGUgdGltZXJzPyBJZiB5ZXMsIHRoZW4gd2UgcHJvYmFibHkgd291bGQgd2FudCB0
byBleHBvc2UgYWxsIGF2YWlsYWJsZSB0aW1lcnMuIEl0IGxvb2tzIHRvIG1lIHRoYXQgcmlnaHQg
bm93IHRlZ3JhMjAtdGltZXIgZXhwb3NlcyBvbmx5IGEgc2luZ2xlLXNoYXJlZCB0aW1lciB0byB0
aGUgc3lzdGVtIFtwbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmddLiBXb3VsZG4ndCBtYWtl
IHNlbnNlIGF0IGxlYXN0IHRvIGdpdmUgYSB0aW1lciBwZXIgQ1BVIGNvcmU/Cj4+Pgo+Pgo+PiBO
bywgb25seSBvbmUgdGltZXIgZHJpdmVyIHdvcmtzIGF0IGEgdGltZS4gKCBzZWUgL3Byb2MvdGlt
ZXJfbGlzdCB0byBjaGVjayB3aGljaCB0aW1lciBpcyB3b3JraW5nLikKPiAKPiBPa2F5LCB0aGFu
a3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLgo+IAo+Pj4gSXQgbG9va3MgdG8gbWUgdGhhdCByaWdo
dCBub3cgdGVncmEyMC10aW1lciBleHBvc2VzIG9ubHkgYSBzaW5nbGUtc2hhcmVkIHRpbWVyIHRv
IHRoZSBzeXN0ZW0gW3BsZWFzZSBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZ10uIFdvdWxkbid0IG1h
a2Ugc2Vuc2UgYXQgbGVhc3QgdG8gZ2l2ZSBhIHRpbWVyIHBlciBDUFUgY29yZT8KPj4KPj4gWWVz
LCBpdCdzIGNvcnJlY3QuIHRoZSB0aW1lci10ZWdyYTIwIG9ubHkgcHJvdmlkZXMgYSBzaW5nbGUt
c2hhcmVkIHRpbWVyLiBBbmQgeWVzLCAsaXQgc2hvdWxkIHByb3ZpZGUgYSB0aW1lciBwZXIgQ1BV
IGNvcmUuIEJ1dCB0aGF0IGlzIGFub3RoZXIgdGFzaywgdGhpcyBwYXRjaCBvbmx5IGludHJvZHVj
ZSB0aGUgdGltZXIgc3VwcG9ydCBmb3IgVGVncmEyMTAuIE90aGVycyB0aGF0IG9yaWdpbmFsbHkg
ZnJvbSB0aW1lci10ZWdyYTIwIGRyaXZlciBzdGlsbCByZW1haW4gdGhlIHNhbWUuCj4gCj4gSSBt
YXkgdGFrZSBhIGxvb2sgYXQgaXQuIENvdWxkIGJlIGJldHRlciBmb3Igb2xkZXIgVGVncmEncyB0
byB1c2UgdGVncmEyMC10aW1lciBmb3IgdGhlIHBlci1DUFUgdGltZXIgc2luY2UgVFdEIHRpbWVy
IGhhcyBzb21lIHRpbWUtaml0dGVyIGR1ZSB0byBEVkZTLgo+IAoKVGhhdCB3b3VsZCBiZSBncmVh
dCwgdGhhbmsgeW91LgpKb3NlcGgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
