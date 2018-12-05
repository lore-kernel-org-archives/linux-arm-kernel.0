Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E8FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD79206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RfD3fHsQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BG6mdKLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD79206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3dtTuUxWhjh5Hnqwxxc/RJOeLhjwcu0R4aS2cw8OvhA=; b=RfD3fHsQd1lt5bujJEMUzXVXe
	TZV5cWutUCSeFd6DSSotq1tK/fesB8S9hs6otx0O+fyu0Hdpwbl39GQQqrWdmvdGkiKCbj71aeonk
	wGVALT37tCJzsnmQ0LoTLfcRplFUFSPZYtwxEWav4hYnIFyIzGRWrN0ruxvFFAGlnMPcPLNiG+lbu
	bQxPTE/nn3u6zGx7RQ5zUDK+z72oOJWmhFxCmEN6JrQ6Kw2lmi2YMLsXELNk5NbIEUE16wAi5hfpJ
	ulIDXSdM3p30GclR4O6vmf9rXqMd/u4c7Yzf7rRcd7sB66yK22bRMDvIwNSKEL0QthZ6rZgLZxs9G
	Q32fD9J+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTW7-00045s-18; Wed, 05 Dec 2018 09:30:51 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTVz-0003zj-Jx
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:30:48 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c079ab90000>; Wed, 05 Dec 2018 01:30:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 05 Dec 2018 01:30:32 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 05 Dec 2018 01:30:32 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 09:30:30 +0000
Subject: Re: [PATCH 08/19] clk: tegra: dfll: round down voltages based on
 alignment
To: Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-9-josephl@nvidia.com>
 <20181204154618.GC26056@pdeschrijver-desktop.Nvidia.com>
 <1cbe2662-1b5e-8261-f0c1-04a760cb08c1@nvidia.com>
 <7f90eae3-42fe-e771-b2f0-421c617db11e@nvidia.com>
 <20181205091114.GF26056@pdeschrijver-desktop.Nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <19fcd20b-74b0-f784-350d-4c4d0646265c@nvidia.com>
Date: Wed, 5 Dec 2018 17:30:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205091114.GF26056@pdeschrijver-desktop.Nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544002234; bh=kokaDane0y4QplccuTpfIIlds6uE+D//VfcGEhujjF0=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=BG6mdKLhI/SH0qCXQkCJO0PKJgkcTBiuucz1+52ynVHEHS2b3zmk4RD5MH6IxMAdx
 OjLWD1IojVL6rJMi0u6zpoYjqxYJjqQN2NpQsiMorx24f5NyxQTzR+nqMtQgTEw/RW
 UWCF39m2rQejuGo93AfaW1oS3yk8Ew/01XTAo2bHwnM5IpaHQS/OSLeuESJdABD1s+
 WSWCSYeVZIuuV0ij1dKsemRDDi+yHukTVxzAsW8qEHrX+zYdpaUcrRD/bZq0pHuTT7
 CqZpsmgGBE8/K88uUi19s00Uz0FDZUhnUBzAQFA0LH8GcXSNRNtu/DtwwwnSKXeqvX
 Kn+RXiUYzjHiw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_013043_823736_9A1A9456 
X-CRM114-Status: GOOD (  15.39  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMi81LzE4IDU6MTEgUE0sIFBldGVyIERlIFNjaHJpanZlciB3cm90ZToKPiBPbiBXZWQs
IERlYyAwNSwgMjAxOCBhdCAwMjo1MTowN1BNICswODAwLCBKb3NlcGggTG8gd3JvdGU6Cj4+IE9u
IDEyLzUvMTggMjoyMCBQTSwgSm9zZXBoIExvIHdyb3RlOgo+Pj4gT24gMTIvNC8xOCAxMTo0NiBQ
TSwgUGV0ZXIgRGUgU2NocmlqdmVyIHdyb3RlOgo+Pj4+IE9uIFR1ZSwgRGVjIDA0LCAyMDE4IGF0
IDA1OjI1OjM3UE0gKzA4MDAsIEpvc2VwaCBMbyB3cm90ZToKPj4+Pj4gV2hlbiBnZW5lcmF0aW5n
IHRoZSBPUFAgdGFibGUsIHRoZSB2b2x0YWdlcyBhcmUgcm91bmQgZG93biB3aXRoIHRoZQo+Pj4+
PiBhbGlnbm1lbnQgZnJvbSB0aGUgcmVndWxhdG9yLiBUaGUgYWxpZ25tZW50IHNob3VsZCBiZSBh
cHBsaWVkIGZvcgo+Pj4+PiB2b2x0YWdlcyBsb29rIHVwIGFzIHdlbGwuCj4+Pj4+Cj4+Pj4+IEJh
c2VkIG9uIHRoZSB3b3JrIG9mIFBlbm55IENoaXUgPHBjaGl1QG52aWRpYS5jb20+Lgo+Pj4+Pgo+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZpZGlhLmNvbT4KPj4+Pj4g
LS0tCj4+Pj4+ICDCoCBkcml2ZXJzL2Nsay90ZWdyYS9jbGstZGZsbC5jIHwgMjYgKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0KPj4+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L3RlZ3JhL2Nsay1kZmxsLmMgYi9kcml2ZXJzL2Nsay90ZWdyYS9jbGstZGZsbC5jCj4+Pj4+IGlu
ZGV4IGMyOTRhMjk4OWYzMS4uNGE5NDNjMTM2ZDRkIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJz
L2Nsay90ZWdyYS9jbGstZGZsbC5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvY2xrL3RlZ3JhL2Nsay1k
ZmxsLmMKPj4+Pj4gQEAgLTgwNCwxNyArODA0LDE3IEBAIHN0YXRpYyB2b2lkIGRmbGxfaW5pdF9v
dXRfaWYoc3RydWN0Cj4+Pj4+IHRlZ3JhX2RmbGwgKnRkKQo+Pj4+PiAgwqAgc3RhdGljIGludCBm
aW5kX2x1dF9pbmRleF9mb3JfcmF0ZShzdHJ1Y3QgdGVncmFfZGZsbCAqdGQsCj4+Pj4+IHVuc2ln
bmVkIGxvbmcgcmF0ZSkKPj4+Pj4gIMKgIHsKPj4+Pj4gIMKgwqDCoMKgwqAgc3RydWN0IGRldl9w
bV9vcHAgKm9wcDsKPj4+Pj4gLcKgwqDCoCBpbnQgaSwgdXY7Cj4+Pj4+ICvCoMKgwqAgaW50IGks
IGFsaWduX3ZvbHQ7Cj4+Pj4+ICDCoMKgwqDCoMKgIG9wcCA9IGRldl9wbV9vcHBfZmluZF9mcmVx
X2NlaWwodGQtPnNvYy0+ZGV2LCAmcmF0ZSk7Cj4+Pj4+ICDCoMKgwqDCoMKgIGlmIChJU19FUlIo
b3BwKSkKPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihvcHApOwo+Pj4+
PiAtwqDCoMKgIHV2ID0gZGV2X3BtX29wcF9nZXRfdm9sdGFnZShvcHApOwo+Pj4+PiArwqDCoMKg
IGFsaWduX3ZvbHQgPSBkZXZfcG1fb3BwX2dldF92b2x0YWdlKG9wcCkgLwo+Pj4+PiB0ZC0+c29j
LT5hbGlnbm1lbnQuc3RlcF91djsKPj4+Pj4gIMKgwqDCoMKgwqAgZGV2X3BtX29wcF9wdXQob3Bw
KTsKPj4+Pj4gIMKgwqDCoMKgwqAgZm9yIChpID0gdGQtPmx1dF9ib3R0b207IGkgPCB0ZC0+bHV0
X3NpemU7IGkrKykgewo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHJlZ3VsYXRvcl9saXN0X3Zv
bHRhZ2UodGQtPnZkZF9yZWcsIHRkLT5sdXRbaV0pID09IHV2KQo+Pj4+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKCh0ZC0+bHV0X3V2W2ldIC8gdGQtPnNvYy0+YWxpZ25tZW50LnN0ZXBfdXYpID49IGFs
aWduX3ZvbHQpCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gaTsKPj4+
Pj4gIMKgwqDCoMKgwqAgfQo+Pj4+PiBAQCAtMTUzMiwxNSArMTUzMiwxNyBAQCBzdGF0aWMgaW50
IGRmbGxfaW5pdChzdHJ1Y3QgdGVncmFfZGZsbCAqdGQpCj4+Pj4+ICDCoMKgICovCj4+Pj4KPj4+
PiBUaGVzZSAyIGZ1bmN0aW9ucyBhcmUgb25seSB2YWxpZCBmb3IgSTJDIG1vZGUuIFdlIHNob3Vs
ZCBwcm9iYWJseSBhZGQgYQo+Pj4+IFdBUk5fT04oKSBpbiBjYXNlIHRoZXkgYXJlIGNhbGxlZCB3
aGVuIFBXTSBtb2RlIGlzIHVzZWQgYW5kIHJldHVybgo+Pj4+IC1FSU5WQUwuCj4+Pj4KPj4+Cj4+
PiBPa2F5LCB3aWxsIGFkZCB0aGF0Lgo+Pj4KPj4gUGV0ZXIsCj4+Cj4+IFNvcnJ5LCBqdXN0IGRv
dWJsZSBjaGVjayBhZ2Fpbi4gVGhlc2UgMiBmdW5jdGlvbnMgYXJlIHVzZWQgZm9yIGdlbmVyYXRp
bmcKPj4gTFVUIHRhYmxlIGZvciBERkxMLUkyQyBtb2RlLiBUaGV5IGFyZSBvbmx5IHVzZWQgaW4g
ImRmbGxfYnVpbGRfaTJjX2x1dCIKPj4gZnVuY3Rpb24uIFNvIEkgdGhpbmsgaXQncyBmaW5lLiBU
aGUgV0FSTl9PTiBmb3IgcHJvdGVjdGlvbiBmcm9tIFBXTSBtb2RlIGlzCj4+IG5vdCBuZWNlc3Nh
cnkuCj4+Cj4gCj4gVGhleSBhcmUgaW5kZWVkIG5vdCB1c2VkIHRvZGF5LCBidXQgdG8gcHJldmVu
dCB0aGVtIGZyb20gYmVpbmcgdXNlZCBpbgo+IHRoZSBmdXR1cmUgSSB3YXMgdGhpbmtpbmcgaXQg
bWFrZXMgc2Vuc2UgdG8gYWRkIHNvbWUgZm9ybSBvZiBwcm90ZWN0aW9uCj4gaGVyZS4KCk9rYXks
IHdpbGwgYWRkIG9uZSBtb3JlIHBhdGNoIGZvciB0aGF0LiBUaGFua3MuCgo+IAo+IFBldGVyLgo+
IAo+Pgo+Pj4KPj4+Pj4gIMKgIHN0YXRpYyBpbnQgZmluZF92ZGRfbWFwX2VudHJ5X2V4YWN0KHN0
cnVjdCB0ZWdyYV9kZmxsICp0ZCwgaW50IHVWKQo+Pj4+PiAgwqAgewo+Pj4+PiAtwqDCoMKgIGlu
dCBpLCBuX3ZvbHRhZ2VzLCByZWdfdVY7Cj4+Pj4+ICvCoMKgwqAgaW50IGksIG5fdm9sdGFnZXMs
IHJlZ192b2x0LCBhbGlnbl92b2x0Owo+Pj4+PiArwqDCoMKgIGFsaWduX3ZvbHQgPSB1ViAvIHRk
LT5zb2MtPmFsaWdubWVudC5zdGVwX3V2Owo+Pj4+PiAgwqDCoMKgwqDCoCBuX3ZvbHRhZ2VzID0g
cmVndWxhdG9yX2NvdW50X3ZvbHRhZ2VzKHRkLT52ZGRfcmVnKTsKPj4+Pj4gIMKgwqDCoMKgwqAg
Zm9yIChpID0gMDsgaSA8IG5fdm9sdGFnZXM7IGkrKykgewo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAg
cmVnX3VWID0gcmVndWxhdG9yX2xpc3Rfdm9sdGFnZSh0ZC0+dmRkX3JlZywgaSk7Cj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCBpZiAocmVnX3VWIDwgMCkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJlZ192
b2x0ID0gcmVndWxhdG9yX2xpc3Rfdm9sdGFnZSh0ZC0+dmRkX3JlZywgaSkgLwo+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRkLT5zb2MtPmFsaWdubWVudC5zdGVwX3V2Owo+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJlZ192b2x0IDwgMCkKPj4+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHVWID09IHJl
Z191VikKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChhbGlnbl92b2x0ID09IHJlZ192b2x0KQo+
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGk7Cj4+Pj4+ICDCoMKgwqDC
oMKgIH0KPj4+Pj4gQEAgLTE1NTQsMTUgKzE1NTYsMTcgQEAgc3RhdGljIGludAo+Pj4+PiBmaW5k
X3ZkZF9tYXBfZW50cnlfZXhhY3Qoc3RydWN0IHRlZ3JhX2RmbGwgKnRkLCBpbnQgdVYpCj4+Pj4+
ICDCoMKgICogKi8KPj4+Pj4gIMKgIHN0YXRpYyBpbnQgZmluZF92ZGRfbWFwX2VudHJ5X21pbihz
dHJ1Y3QgdGVncmFfZGZsbCAqdGQsIGludCB1VikKPj4+Pj4gIMKgIHsKPj4+Pj4gLcKgwqDCoCBp
bnQgaSwgbl92b2x0YWdlcywgcmVnX3VWOwo+Pj4+PiArwqDCoMKgIGludCBpLCBuX3ZvbHRhZ2Vz
LCByZWdfdm9sdCwgYWxpZ25fdm9sdDsKPj4+Pj4gK8KgwqDCoCBhbGlnbl92b2x0ID0gdVYgLyB0
ZC0+c29jLT5hbGlnbm1lbnQuc3RlcF91djsKPj4+Pj4gIMKgwqDCoMKgwqAgbl92b2x0YWdlcyA9
IHJlZ3VsYXRvcl9jb3VudF92b2x0YWdlcyh0ZC0+dmRkX3JlZyk7Cj4+Pj4+ICDCoMKgwqDCoMKg
IGZvciAoaSA9IDA7IGkgPCBuX3ZvbHRhZ2VzOyBpKyspIHsKPj4+Pj4gLcKgwqDCoMKgwqDCoMKg
IHJlZ191ViA9IHJlZ3VsYXRvcl9saXN0X3ZvbHRhZ2UodGQtPnZkZF9yZWcsIGkpOwo+Pj4+PiAt
wqDCoMKgwqDCoMKgwqAgaWYgKHJlZ191ViA8IDApCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZWdf
dm9sdCA9IHJlZ3VsYXRvcl9saXN0X3ZvbHRhZ2UodGQtPnZkZF9yZWcsIGkpIC8KPj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0ZC0+c29jLT5hbGlnbm1lbnQuc3RlcF91djsK
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZWdfdm9sdCA8IDApCj4+Pj4+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmICh1ViA8PSBy
ZWdfdVYpCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYWxpZ25fdm9sdCA8PSByZWdfdm9sdCkK
Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBpOwo+Pj4+PiAgwqDCoMKg
wqDCoCB9Cj4+Pj4+IC0tIAo+Pj4+PiAyLjE5LjIKPj4+Pj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
