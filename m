Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CABC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:42:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7F42087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P/0LHl52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7F42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZxgJ6t3ASOgj/gZsSUbhWoMzOxPq3mHIxRe8258zVKw=; b=P/0LHl52QNy3UTL13ctR20ipk
	iaz+DNNI5HQ/mRMd+UDgiLosxTsmXZ6f6+pZxHpNGtv09rdiG1tmiebR/ALf6ZfVJIn7QJzWUkgwi
	YjhS1Jd9j+YXZkaEYZmzKtYN7OS++TknKfzcqKuwLM5sjp4no6Txv36euIM6+ZiaFNQ4plGerGFHP
	77erLY3RZLM+YnLZo2/s2tiAL3ilEYzgPnGJLApOBZxoIDLBK+8uBK4sEO2itIGoK/N/YQL0Q108y
	+p5vWB2A7eskxsctWyYfEdKD2nyaj7sk5/Ijulyn21ZADg0fsEU1XAsOUN4bGedadp1fD9j80Qjct
	n/dhxwJdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomOB-0006VY-H6; Wed, 30 Jan 2019 09:42:35 +0000
Received: from mail-sz.amlogic.com ([211.162.65.117])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomO7-0006UN-5E; Wed, 30 Jan 2019 09:42:32 +0000
Received: from [10.28.18.236] (10.28.18.236) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 30 Jan
 2019 17:43:19 +0800
Subject: Re: [PATCH][next] mtd: rawnand: meson: fix missing assignment of ret
 on a call to meson_chip_buffer_init
To: Colin Ian King <colin.king@canonical.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>
References: <20190129105757.19138-1-colin.king@canonical.com>
 <aeadd16e-ed46-28f2-15de-66d1d9f1ed11@amlogic.com>
 <20190130103250.4080a3b3@xps13>
 <25109367-14bc-90b1-f0a9-ad65aac46bf8@canonical.com>
From: Liang Yang <liang.yang@amlogic.com>
Message-ID: <30e51df9-d1ad-9066-41e0-d8ee6aa3ad4a@amlogic.com>
Date: Wed, 30 Jan 2019 17:43:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <25109367-14bc-90b1-f0a9-ad65aac46bf8@canonical.com>
Content-Language: en-US
X-Originating-IP: [10.28.18.236]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_014231_195527_A108301B 
X-CRM114-Status: GOOD (  12.76  )
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
Cc: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 linux-amlogic@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWlxdWVsLCBDb2xpbiwKCk9uIDIwMTkvMS8zMCAxNzozNCwgQ29saW4gSWFuIEtpbmcgd3Jv
dGU6Cj4gT24gMzAvMDEvMjAxOSAwOTozMiwgTWlxdWVsIFJheW5hbCB3cm90ZToKPj4gSGkgTGlh
bmcsIENvbGluLAo+Pgo+PiBMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90
ZSBvbiBXZWQsIDMwIEphbiAyMDE5IDE3OjI2OjQ5Cj4+ICswODAwOgo+Pgo+Pj4gSGkgQ29saW4s
Cj4+Pgo+Pj4gT24gMjAxOS8xLzI5IDE4OjU3LCBDb2xpbiBLaW5nIHdyb3RlOgo+Pj4+IEZyb206
IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4+Pj4KPj4+PiBUaGUg
Y2FsbCB0byBtZXNvbl9jaGlwX2J1ZmZlcl9pbml0IGlzIG5vdCBhc3NpZ25pbmcgcmV0LCBob3dl
dmVyLCByZXQKPj4+PiBpcyBiZWluZyBjaGVja2VkIGZvciBmYWlsdXJlLiBGaXggdGhpcyBieSBh
ZGRpbmcgaW4gdGhlIG1pc3NpbmcgYXNzaWdubWVudC4KPj4+Pgo+Pj4+IEZpeGVzOiAyZDU3MGIz
NGI0MWEgKCJtdGQ6IHJhd25hbmQ6IG1lc29uOiBhZGQgc3VwcG9ydCBmb3IgQW1sb2dpYyBOQU5E
IGZsYXNoIGNvbnRyb2xsZXIiKQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxj
b2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9tdGQvbmFu
ZC9yYXcvbWVzb25fbmFuZC5jIHwgMiArLQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L25hbmQvcmF3L21lc29uX25hbmQuYyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L21lc29uX25hbmQu
Ywo+Pj4+IGluZGV4IGU4NThkNThkOTdiMC4uYjljNTQzZDEwNTRjIDEwMDY0NAo+Pj4+IC0tLSBh
L2RyaXZlcnMvbXRkL25hbmQvcmF3L21lc29uX25hbmQuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbXRk
L25hbmQvcmF3L21lc29uX25hbmQuYwo+Pj4+IEBAIC0xMjA2LDcgKzEyMDYsNyBAQCBzdGF0aWMg
aW50IG1lc29uX25hbmRfYXR0YWNoX2NoaXAoc3RydWN0IG5hbmRfY2hpcCAqbmFuZCkKPj4+PiAg
ICAJCWRldl9lcnIobmZjLT5kZXYsICIxNmJpdHMgYnVzIHdpZHRoIG5vdCBzdXBwb3J0ZWQiKTsK
Pj4+PiAgICAJCXJldHVybiAtRUlOVkFMOwo+Pj4+ICAgIAl9Cj4+Pj4gLQltZXNvbl9jaGlwX2J1
ZmZlcl9pbml0KG5hbmQpOwo+Pj4+ICsJcmV0ID0gbWVzb25fY2hpcF9idWZmZXJfaW5pdChuYW5k
KTsKPj4+Cj4+PiBMb29rcyBnb29kIHRvIG1lOgo+Pj4KPj4+IEFja2VkLWJ5OiBMaWFuZyBZYW5n
IDxsaWFuZy55YW5nQGFtbG9naWMuY29tPgo+Pgo+PiBUaGlzIGlzIG5hbmQvbmV4dCBtYXRlcmlh
bCwgc28gaWYgeW91IGRvbid0IG1pbmQgSSB3b3VsZCBsaWtlIHRvIHNxdWFzaAo+PiB0aGUgdHdv
IGZpeGVzIHlvdSBzZW50IGludG8gdGhlIG9yaWdpbmFsIGNvbW1pdCBpbnNlcnRpbmcgdGhlIGRy
aXZlci4KPiAKPiBTdXJlLCBvayB3aXRoIG1lLCBzcXVhc2hpbmcgdGhlbSBtYWtlcyBzZW5zZS4K
PiAKPiBDb2xpbgoKb2suCgo+Pgo+Pgo+PiBUaGFua3MsCj4+IE1pcXXDqGwKPj4KPiAKPiAuCj4g
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
