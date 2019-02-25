Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F030C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:24:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BCD213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="booUm35A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Vt0+q0xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BCD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZVZxxmeh1cOVGBXsz8rgfWbOlTZTr71wa8TFhuhWYek=; b=booUm35A10XDtDi+g+K8CDAFB
	Mb7YeJzdT/vznuEj5JleCJqbmJbfP++0+rp8Gw2luHHMz7Wm+r7HL9o43rO3Yoe6aSf8W1pcigt7B
	vznZ6OR2guw8ytyA5y0/AjgA+a/8zIx02nv70qX/2m1JAczj/2EJeNSgpZG/OnvKD6Zt/SLAvfiM4
	aKbYWRybQ73HZC9AeKJNYcp9bPg3smB2YCl+7rVk4f+LIDRcD8ayn6cJJ3pHT4NGcU8EjPeZeFrtg
	QmdZ4eUeBlk6heKJczaOLZCwll5Y5V0qdlnOJch4uB78sEbQlIiZkxbt+JG4XAmTo4UvZUOWH2YcS
	qeWYtlQRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyENL-0003Fb-VC; Mon, 25 Feb 2019 11:24:47 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyENI-0003FB-A6
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 11:24:46 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c73d07b0000>; Mon, 25 Feb 2019 03:24:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 25 Feb 2019 03:24:43 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 25 Feb 2019 03:24:43 -0800
Received: from [10.24.44.186] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 25 Feb
 2019 11:24:40 +0000
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc tree
To: Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>
References: <20190225123615.49bce7cd@canb.auug.org.au>
 <CAK8P3a3moJ12SDM3Ow-Hw3qBeTv9siswK+9pPiEA4JJ+7k4xvg@mail.gmail.com>
 <s5hr2bw2k7m.wl-tiwai@suse.de>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <e2aaed45-0fb1-c9c8-76d4-3b97b36cada6@nvidia.com>
Date: Mon, 25 Feb 2019 16:54:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <s5hr2bw2k7m.wl-tiwai@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1551093883; bh=5mJlVutZickPb3wayRQJ3tHtItZi1JOaDRP+wYvtmgE=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=Vt0+q0xeGSsM7dbrIzkZ3oCTjajyLuVh/1PNS1pa93AOgYGxZmuyGYOyovVKEPEQq
 8UOU7WaknRv0ZMjkKPLatHMkZN/wRYH/aBoxmDaV9De9mwd3EmfeJiy94j97O50D4j
 W9sBZWcnz58CB/fyCNCImN+SgRjPWZUoqTodHb56WD4qhgKB9lwP2noi3MAOkC+yfx
 YHXZwYdKDZ5YZQbWQtEqF7Z8XTkq3QN7+VWts4wZ1yk1YSynR01NCpDtMyWfT6Fkdr
 JfSdl9lGfbhGnE7djeqd9nkGY3vcq7w8TdgulGNtINf0pAR1S1cQrWoUhxKOp7z5Qw
 JqR0oGLAhOL2Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_032444_361460_A9F9D1F3 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Thierry Reding <treding@nvidia.com>,
 ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDIvMjUvMjAxOSA0OjQ0IFBNLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4gT24gTW9uLCAyNSBG
ZWIgMjAxOSAxMDoxOToxNSArMDEwMCwKPiBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+PiBPbiBNb24s
IEZlYiAyNSwgMjAxOSBhdCAyOjM2IEFNIFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcu
b3JnLmF1PiB3cm90ZToKPj4+IEhpIFRha2FzaGksCj4+Pgo+Pj4gVG9kYXkncyBsaW51eC1uZXh0
IG1lcmdlIG9mIHRoZSBzb3VuZCB0cmVlIGdvdCBjb25mbGljdHMgaW46Cj4+Pgo+Pj4gICAgYXJj
aC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmExOTQtcDI5NzItMDAwMC5kdHMKPj4+ICAgIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMjEwLXAyNTk3LmR0c2kKPj4+Cj4+PiBiZXR3
ZWVuIGNvbW1pdHM6Cj4+Pgo+Pj4gICAgNWVlZjE3ZWU3NjRkICgiYXJtNjQ6IHRlZ3JhOiBwMjk3
MjogU29ydCBub2RlcyBwcm9wZXJseSIpCj4+PiAgICBiZTRmMGRkMzQ3YWQgKCJhcm02NDogdGVn
cmE6IHAyNTk3OiBTb3J0IG5vZGVzIGJ5IHVuaXQtYWRkcmVzcyIpCj4+Pgo+Pj4gZnJvbSB0aGUg
YXJtLXNvYyB0cmVlIGFuZCBjb21taXQ6Cj4+Pgo+Pj4gICAgMTFjZTQzMDgzMDdjICgiYXJtNjQ6
IHRlZ3JhOiBjdXN0b20gbmFtZSBmb3IgaGRhIHNvdW5kIGNhcmQiKQo+Pj4KPj4+IGZyb20gdGhl
IHNvdW5kIHRyZWUuCj4+Pgo+Pj4gSSBmaXhlZCBpdCB1cCAoc2VlIGJlbG93IC0gaW4gdGVncmEx
OTQtcDI5NzItMDAwMC5kdHMuIHRoZSBsaW5lIGFkZGVkCj4+PiBqdXN0IG5lZWRlZCB0byBiZSBt
b3ZlZCB1cCBhIGZldyBsaW5lcykgYW5kIGNhbiBjYXJyeSB0aGUgZml4IGFzCj4+PiBuZWNlc3Nh
cnkuIFRoaXMgaXMgbm93IGZpeGVkIGFzIGZhciBhcyBsaW51eC1uZXh0IGlzIGNvbmNlcm5lZCwg
YnV0IGFueQo+Pj4gbm9uIHRyaXZpYWwgY29uZmxpY3RzIHNob3VsZCBiZSBtZW50aW9uZWQgdG8g
eW91ciB1cHN0cmVhbSBtYWludGFpbmVyCj4+PiB3aGVuIHlvdXIgdHJlZSBpcyBzdWJtaXR0ZWQg
Zm9yIG1lcmdpbmcuICBZb3UgbWF5IGFsc28gd2FudCB0byBjb25zaWRlcgo+Pj4gY29vcGVyYXRp
bmcgd2l0aCB0aGUgbWFpbnRhaW5lciBvZiB0aGUgY29uZmxpY3RpbmcgdHJlZSB0byBtaW5pbWlz
ZSBhbnkKPj4+IHBhcnRpY3VsYXJseSBjb21wbGV4IGNvbmZsaWN0cy4KPj4gVGhlIG1lcmdlIGxv
b2tzIGZpbmUgdG8gbWUsIGJ1dCBJIHdvbmRlciBhYm91dCB0aGF0IGNvbW1pdAo+PiBpbiB0aGUg
YWxzYSB0cmVlLCB3aHkgZG9lcyB0aGUgc291bmQgY2FyZCBuZWVkIGEgYm9hcmQgc3BlY2lmaWMK
Pj4gbmFtZT8KPj4KPj4gSSBzZWUgdGhpcyBwcm9wZXJ0eSBiZWluZyB1c2VkIGluIGNvbW1pdCBj
MGJkZTAwM2EwMTMgKCJBTFNBOgo+PiBoZGEvdGVncmE6IHNvdW5kIGNhcmQgbmFtZSBmcm9tIGRl
dmljZSB0cmVlIiksIHdoaWNoIHJlbW92ZXMKPj4gYSBxdWVzdGlvbmFibGUgdXNlIG9mIHRoZSBy
b290IGNvbXBhdGlibGUgcHJvcGVydHksIHJlcGxhY2luZwo+PiBpdCB3aXRoIHRoZSBuZXcgJ252
aWRpYSxtb2RlbCcgcHJvcGVydHkuIFdlIGRvbid0IGRvIHRoaXMgZm9yIGFueQo+PiBvdGhlciBz
dWJzeXN0ZW0sIHNvIHdoeSBkb2VzIHRoZSBzb3VuZCBzdWJzeXN0ZW0gZXhwb3J0Cj4+IGluZm9y
bWF0aW9uIGFib3V0IHRoZSBib2FyZCBhcyBhIHN0cmluZyBoZXJlPwo+IFRoZSBzb3VuZCBzdWJz
eXN0ZW0gZXhwb3J0cyBtZXJlbHkgc29tZSB1bmRlcnN0YW5kYWJsZSBuYW1lIHN0cmluZwo+IGZv
ciB0aGUgZ2l2ZW4gc291bmQgY2FyZCBvYmplY3QsIGFuZCB0aGF0IHdhcyBjb21wb3NlZCBmcm9t
IHRoZQo+IGNvbXBhdGlibGUgc3RyaW5nIGluIHRoZSBwYXN0LCB3aGljaCB0dXJuZWQgb3V0IHRv
IGJlIHVzZWxlc3Mgb24gc29tZQo+IGNvbmZpZ3MuCj4KPiBCdXQgdGhpcyBraW5kIG9mIGFkZGl0
aW9uIGlzIGFuIGV4dHJlbWVseSBiYWQgbWFubmVyLCBJJ20gZmluZSB0bwo+IHJldmVydCB0aGVz
ZSAoYXQgYmVzdCB3aXRoIGEgYmV0dGVyIGFsdGVybmF0aXZlKS4gIFRoaXMgaXNuJ3QgYWJvdXQK
PiBhbnkgZnVuY3Rpb25hbGl0eSBidXQgcmF0aGVyIHNvbWUgcmVhZGFibGUgaW5mb3JtYXRpb24g
dGhhdCBpc24ndCBhCj4gcGFydCBvZiBBUEkuCj4KVGhlIG1vdGl2YXRpb24gZm9yIGFkZGluZyBj
dXN0b20gc291bmQgY2FyZCBuYW1lIGlzIGZvbGxvd2luZywKMS4gV2hlbiBmb3IgYm9hcmRzLCBt
dWx0aXBsZSBIRE1JL0RQIHBvcnRzIGFyZSBleHBvc2VkLCBpdCBpcyBzb21ldGltZXMKIMKgwqAg
bmVjZXNzYXJ5IHRvIGtub3cgdGhlIGRlZmF1bHQgcG9ydCBvciBhbnkgY3VzdG9taXphdGlvbiBm
b3IgdGhhdCBtYXR0ZXIuCiDCoMKgIEF1ZGlvIHVzZXJzcGFjZSBjYW4gZGlzdGluZ3Vpc2ggYmFz
ZWQgb24gdGhlIHNvdW5kIGNhcmQgbmFtZXMuCjIuIE11bHRpcGxlIHNvdW5kIGNhcmRzIGNhbiBj
b2V4aXN0IGZvciBhIHBsYXRmb3JtLCB0aGUgaW5kaWNhdGlvbiBvZiAKcGFydGljdWxhcgogwqDC
oCBhdWRpbyBwYXRoIGlzIHVzZWZ1bC4KMy4gSXQgY2FuIGhlbHAgdG8gY3VzdG9taXplIGF1ZGlv
IHBhdGhzLgogwqDCoCBHZW5lcmFsbHkgcGVvcGxlIHVzZSAiKixtb2RlbCIgcHJvcGVydHkgaW4g
RFQgdG8gbmFtZSB0aGUgc291bmQgY29tcGxleC4KIMKgwqAgRXg6ICJzYW1zdW5nLG1vZGVsIiBb
c291bmQvc29jL3NhbXN1bmcvc25vdy5jXQogwqDCoMKgwqDCoMKgICJyb2NrY2hpcCxtb2RlbCIg
W3NvdW5kL3NvYy9yb2NrY2hpcC9yb2NrY2hpcF9ydDU2NDUuY10KClRoYW5rcywKU2FtZWVyLgo+
IHRoYW5rcywKPgo+IFRha2FzaGkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
