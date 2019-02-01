Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7762C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:37:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DFC218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ma7HJsIp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WvYdfYnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DFC218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cleEGEdh2ZtfictZdvwSixkKNiCtKzGFsEGiwK8NQ3A=; b=Ma7HJsIpXa5INeJ8vBWAEOqBc
	iFL1Q+4ObIt7tykUBpgrD7ajpvA1hmm3Aazz/q+yAHg7bwEt3eutRGpoiz3IDLYmwp82gaNanXWc4
	ktRD+Jgz+7mfanARfP+m1iguxJ0v27jnoX6QN9YedpBW+MsAF/SFGdZdhiDUWwhjAftsG7y2J2JIa
	WrkOO/RpfgqqvskRAHq3dfl809j9PW6K+fd6TXViH5kVu2Fof1ZXSAK/IOpVMXN0OGryyBWkaDgEU
	oYIWVuHJF1Dgl7G/zqsfG0mTEiPRPBH4zZS0xSHd+AC/AQIvcL7gCI8myhyNyyw9Ip4IOgS9/GZDo
	zgG7CU5Sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpasS-00079K-T1; Fri, 01 Feb 2019 15:37:12 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpasP-00078t-Pk
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:37:11 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c5467870000>; Fri, 01 Feb 2019 07:36:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 07:37:08 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 07:37:08 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 15:37:06 +0000
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
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
Date: Fri, 1 Feb 2019 23:37:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <57549882-4d0a-64ac-da04-7e790ac2d80e@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549035399; bh=dcZZ3L5tO8XRb2PfNJdhsg3I3b34TUwbub/q4ZQpWto=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=WvYdfYndSGy/n6jHLURLI1YCqQXQ3j3cfIFB0lkOrM1+w9Y3/feTLTnV0u0n3gD7+
 z/va35jyr9gJkC3eHLJPjwQMdx2l1vLWhIE1jQWdFGWJ3TFfITfAxqkRw1PaxcOjan
 MmoxQUolBj6xl5TcNiNtaY4uEFKPmBngoeg77Yjn6YbCwtQWKgoLf08JF52wJi+Yc5
 sW0PCxwFp5NPaAc87h8QdzkrkazVsJjlnWUqMcXtmeb4nGmLhM0dBcs2j/vQsf889V
 m9ZPF1GqzZo3RnZS6ke2kcm0gfxH1nPFV9zeHreLJzJKbIWUiH3XqzGYlLxosAzFP7
 9e/PleT+WQ3Bw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_073709_843624_6A829D32 
X-CRM114-Status: GOOD (  12.62  )
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

T24gMi8xLzE5IDExOjEzIFBNLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4gMDEuMDIuMjAxOSAx
NzoxMywgSm9zZXBoIExvINC/0LjRiNC10YI6Cj4+IE9uIDIvMS8xOSA5OjU0IFBNLCBKb24gSHVu
dGVyIHdyb3RlOgo+Pj4KPj4+IE9uIDAxLzAyLzIwMTkgMTM6MTEsIERtaXRyeSBPc2lwZW5rbyB3
cm90ZToKPj4+PiAwMS4wMi4yMDE5IDE2OjA2LCBEbWl0cnkgT3NpcGVua28g0L/QuNGI0LXRgjoK
Pj4+Pj4gMDEuMDIuMjAxOSA2OjM2LCBKb3NlcGggTG8g0L/QuNGI0LXRgjoKPj4+Pj4+IEFkZCBz
dXBwb3J0IGZvciB0aGUgVGVncmEyMTAgdGltZXIgdGhhdCBydW5zIGF0IG9zY2lsbGF0b3IgY2xv
Y2sKPj4+Pj4+IChUTVIxMC1UTVIxMykuIFdlIG5lZWQgdGhlc2UgdGltZXJzIHRvIHdvcmsgYXMg
Y2xvY2sgZXZlbnQgZGV2aWNlIGFuZCB0bwo+Pj4+Pj4gcmVwbGFjZSB0aGUgQVJNdjggYXJjaGl0
ZWN0ZWQgdGltZXIgZHVlIHRvIGl0IGNhbid0IHN1cnZpdmUgYWNyb3NzIHRoZQo+Pj4+Pj4gcG93
ZXIgY3ljbGUgb2YgdGhlIENQVSBjb3JlIG9yIENQVVBPUkVTRVQgc2lnbmFsLiBTbyBpdCBjYW4n
dCBiZSBhIHdha2UtdXAKPj4+Pj4+IHNvdXJjZSB3aGVuIENQVSBzdXNwZW5kcyBpbiBwb3dlciBk
b3duIHN0YXRlLgo+Pj4+Pj4KPj4+Pj4+IEFsc28gY29udmVydCB0aGUgb3JpZ2luYWwgZHJpdmVy
IHRvIHVzZSB0aW1lci1vZiBBUEkuCj4+Pj4+Pgo+Pj4+Pj4gQ2M6IERhbmllbCBMZXpjYW5vIDxk
YW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgo+Pj4+Pj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPgo+Pj4+Pj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBMbyA8am9zZXBobEBudmlkaWEuY29tPgo+Pj4+
Pj4gQWNrZWQtYnk6IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+Cj4+Pj4+PiAt
LS0Kc25pcC4KPj4+Pj4+ICt9Cj4+Pj4+PiArVElNRVJfT0ZfREVDTEFSRSh0ZWdyYTIxMF90aW1l
ciwgIm52aWRpYSx0ZWdyYTIxMC10aW1lciIsIHRlZ3JhMjEwX3RpbWVyX2luaXQpOwo+Pj4+Pj4g
KyNlbHNlIC8qIENPTkZJR19BUk0gKi8KPj4+Pj4+ICtzdGF0aWMgaW50IF9faW5pdCB0ZWdyYTIw
X2luaXRfdGltZXIoc3RydWN0IGRldmljZV9ub2RlICpucCkKPj4+Pj4+ICt7Cj4+Pj4+IFdoYXQg
YWJvdXQgVDEzMj8gSXNuJ3QgaXQgQVJNNjQgd2hpY2ggdXNlcyB0ZWdyYTIwLXRpbWVyIElQPyBB
dCBsZWFzdCBUMTMyIERUIHN1Z2dlc3RzIHNvIGFuZCBzZWVtcyB0aGlzIGNoYW5nZSB3aWxsIGJy
ZWFrIGl0Lgo+Pj4+Pgo+Pj4+PiBbc25pcF0KPj4+Pj4KPj4+Pgo+Pj4+IEFoLCBub3RpY2VkIHRo
ZSAiZGVwZW5kcyBvbiBBUk0iIGluIEtjb25maWcuLiBTZWVtcyBva2F5IHRoZW4uCj4+Pj4KPj4+
Cj4+Pgo+Pj4gVGhpcyBpcyBhIGdvb2QgcG9pbnQsIGJlY2F1c2UgZXZlbiB0aG91Z2ggd2UgaGFk
ICdkZXBlbmRzIG9uIEFSTScsIHRoaXMKPj4+IHN0aWxsIG1lYW5zIHRoYXQgdGhlIFRlZ3JhMTMy
IERUIGlzIGluY29ycmVjdC4KPj4+Cj4+PiBKb3NlcGgsIGNhbiB5b3UgdGFrZSBhIHF1aWNrIGxv
b2sgYXQgVGVncmExMzI/Cj4+Cj4+IEhpIEpvbiBhbmQgRG1pdHJ5LAo+Pgo+PiBObyB3b3JyeSBh
Ym91dCBUMTMyLCBUMTMyIHVzZXMgYXJjaCB0aW1lciAodjcpLiBUaGUgdGVncmEyMCB0aW1lciBk
cml2ZXIgaGFzIG5ldmVyIGJlZW4gdXNlZC4gV2Ugc2hvdWxkIGZpeCB0aGUgZHRzaSBmaWxlIGxh
dGVyLgo+IAo+IEhpIEpvc2VwaCwKPiAKPiBTbyBpcyBUMTMyIEhXIGFjdHVhbGx5IGluY29tcGF0
aWJsZSB3aXRoIHRoZSB0ZWdyYTIwLXRpbWVyPyBJZiBpdCdzIGNvbXBhdGlibGUsIHRoZW4gSSB0
aGluayB0aGUgZHJpdmVyJ3MgY29kZSBzaG91bGQgYmUgbWFkZSBtb3JlIHVuaXZlcnNhbCB0byBz
dXBwb3J0IFQxMzIuCj4gCgogRnJvbSBIVyBwb2ludCBvZiB2aWV3LCB0aGUgVElNRVIxIH4gVElN
RVI0IGlzIGNvbXBhdGlibGUgd2l0aCAKIm52aWRpYSx0ZWdyYTIwLXRpbWVyIi4gQnV0IFRlZ3Jh
MTMyIGFjdHVhbGx5IGhhcyAxMCB0aW1lcnMgd2hpY2ggYXJlIApleGFjdGx5IHRoZSBzYW1lIGFz
IFRlZ3JhMzAuIFNvIGl0IHNob3VsZCBiYWNrd2FyZCBjb21wYXRpYmxlIHdpdGggCiJudmlkaWEs
dGVncmEzMC10aW1lciIsIHdoaWNoIGlzIHRlZ3JhX3dkdCBkcml2ZXIgbm93LiBBbmQgVGVncmEx
MzIgCnNob3VsZCBuZXZlciB1c2UgdGhpcyBkcml2ZXIuCgpUaGUgVGVncmEgdGltZXIgZHJpdmVy
IHNob3VsZCBvbmx5IGJlIHVzZWQgb24gVGVncmEyMC8zMC8yMTAsIHRocmVlIApwbGF0Zm9ybXMg
b25seS4gT3RoZXJzIHVzZSBhcmNoIHRpbWVyIGRyaXZlciBmb3Igc3lzdGVtIHRpbWVyIGRyaXZl
ci4KClNvIHdlIGRvbid0IHJlYWxseSBuZWVkIHRvIHRha2UgY2FyZSB0aGUgdXNhZ2Ugb24gb3Ro
ZXIgVGVncmEgcGxhdGZvcm1zLgoKVGhhbmtzLApKb3NlcGgKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
